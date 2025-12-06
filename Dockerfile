FROM rocker/tidyverse:4.5

# Install pandoc
RUN apt-get update && apt-get install -y pandoc

# Create project directory
RUN mkdir /project
WORKDIR /project

# Create directories
RUN mkdir code output raw_data renv

# Copy renv files
COPY .Rprofile .
COPY renv.lock .
COPY renv/activate.R renv/
COPY renv/settings.json renv/

# Restore R packages
RUN Rscript -e "renv::restore(prompt=FALSE)"

# Copy project files
COPY code code/
COPY Makefile .
COPY report.Rmd .
COPY raw_data raw_data/

# Run make to generate report, then move to /report for mounting
CMD make && cp report.html /report/