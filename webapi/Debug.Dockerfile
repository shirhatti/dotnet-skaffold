FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app
EXPOSE 80

# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# copy everything else and build app
COPY . .
RUN dotnet publish -c Debug -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Install the dependencies for Visual Studio Remote Debugger
RUN apt-get update && apt-get install -y --no-install-recommends unzip procps

# Install Visual Studio Remote Debugger
RUN curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l ~/vsdbg  

ENTRYPOINT ["dotnet", "webapi.dll"]