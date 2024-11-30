# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY *.csproj ./

# Restore dependencies
RUN dotnet restore

# Copy the rest of the application files
COPY . ./

# Build the application in release mode
RUN dotnet publish -c Release -o /publish

# Use the official runtime image for .NET 8 to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory inside the runtime image
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /publish .

# Expose the port your app listens on (optional, but common for web apps)
EXPOSE 80
EXPOSE 443

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "WebAppOC.dll"]
