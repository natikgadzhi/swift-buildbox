# TODO: 
# Support armv6 or aarch64 as build arg
# 
FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl


# TODO: 
# Add the Swift for ARM repository
# RUN 

# TODO: 
# Install Swift
RUN apt-get install -y swift5

# TODO:
# Define that the container expects src and output
# directories mounted and will attempt compiling
# and exporting the binaries

# TODO: 
# Write a hello world test that prints the current
# platform the app is running on.
# 
