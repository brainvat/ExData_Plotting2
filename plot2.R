###########
# Exploratory Data Analysis
# -------
# Course Project 2: plot2.R
#
# Assignment Info:
# https://class.coursera.org/exdata-005/human_grading
# 
# Data File:
#   https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# 
# Question:
#   Have total emissions from PM2.5 decreased in the Baltimore City, 
#   Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
#   system to make a plot answering this question.
#
# Work by: Allen Hammock
#  Github: brainvat
# Project: https://github.com/brainvat/ExData_Plotting2/
#
# Usage:
#
# 1. Use setcwd() to the folder on your system where you have downloaded
#    and decompressed the data file indicated above.  If your directory
#    does not contain the following two files, the script will abort with
#    a warning.
#
#    Source_Classification_Code.rds
#    summarySCC_PM25.rds
#
# 2. Source plot2.R into your R environment. The main() function will be
#    called automatically.  A file, plot2.png will be created in the working
#    directory, overwriting any previous version that may exist.
#
# 3. The data frame used to create the plot will be returned in the global
#    variable res
#
#######

if (!exists("NEI")) NEI <<- NULL
if (!exists("SCC")) SCC <<- NULL

main <- function(destfile = "plot2.png") {

    # input files
    file.NEI <- "summarySCC_PM25.rds"
    file.SCC <- "Source_Classification_Code.rds"
    
    # initialize results data frame
    res <- NULL
    
    # fetch emissions data and classification table
    # looks for global scope variable to save time building data frame
    # on repeat function calls
    if (!sum(dim(NEI) == c(6497651, 6)) == 2) {
        if (file.exists(file.NEI)) {
            cat(paste("Loading ", file.NEI, " please be patient.\n", sep = ""))
            NEI <<- readRDS(file.NEI)                     
        } else {
            stop(paste("ABORT. ", file.NEI, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.NEI, " previously loaded into memory.\n", sep = ""))        
    }
    
    if (!sum(dim(SCC) == c(11717, 15)) == 2) {
        if (file.exists(file.SCC)) {
            cat(paste("Loading ", file.SCC, ".\n", sep = ""))
            SCC <<- readRDS(file.SCC)                   
        } else {
            stop(paste("ABORT. ", file.SCC, " file is missing.  Check your current working directory.", sep = ""))
        }
    } else {
        cat(paste("Using ", file.SCC, " previously loaded into memory.\n", sep = ""))        
    }    
    
    # aggregate PM2.5 emissions by year and plot
    cat(paste("Generating plot, this may take a few seconds.\n", sep = ""))
    
    png(filename = destfile, height = 480, width = 480)
    res <- aggregate(Emissions ~ year, NEI[(NEI$fips == "24510") & (NEI$year %in% c(1999, 2008)),], sum)
    barplot(res$Emissions, names.arg=res$year, main = "Total Emissions From PM2.5 Have Decreased\nin Baltimore City, Maryland From 1999 to 2008", horiz = FALSE, xlab = "All SCC Sources", ylab = "PM2.5 Emitted (Tons)")
            
    dev.off()
    cat(paste("Created file ", destfile, " in current working directory.\n", sep = ""))
    
    return(res)
}

res <- main()

