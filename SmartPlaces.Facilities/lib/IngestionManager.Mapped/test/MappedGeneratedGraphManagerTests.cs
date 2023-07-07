// -----------------------------------------------------------------------
// <copyright file="MappedGraphIngestionProcessorTests.cs" company="Microsoft">
// Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

namespace Microsoft.SmartPlaces.Facilities.IngestionManager.Mapped.Test
{
    using System.Net.Http;
    using Microsoft.Extensions.Logging;
    using Microsoft.Extensions.Options;
    using Microsoft.SmartPlaces.Facilities.IngestionManager.Mapped;
    using Moq;
    using Xunit;
    using Xunit.Abstractions;

    public class MappedGeneratedGraphManagerTests
    {
#pragma warning disable IDE0052 // Remove unread private members
        private readonly ITestOutputHelper output;
#pragma warning restore IDE0052 // Remove unread private members

        public MappedGeneratedGraphManagerTests(ITestOutputHelper output)
        {
            this.output = output;
        }

        [Fact]
        public void GetOrganizationQuery_ReturnsString()
        {
            var mockLogger = new Mock<ILogger<MappedGeneratedGraphManager>>();
            var mockClientFactory = new Mock<IHttpClientFactory>();
            var someOptions = Options.Create(new MappedIngestionManagerOptions());

            var manager = new MappedGeneratedGraphManager(mockLogger.Object, mockClientFactory.Object, someOptions);

            var result = manager.GetOrganizationQuery();

            Assert.False(string.IsNullOrEmpty(result));

            output.WriteLine(result);
        }

        [Fact]
        public void GetBuildingsForSiteQuery_ReturnsString()
        {
            var mockLogger = new Mock<ILogger<MappedGeneratedGraphManager>>();
            var mockClientFactory = new Mock<IHttpClientFactory>();
            var someOptions = Options.Create(new MappedIngestionManagerOptions());

            var manager = new MappedGeneratedGraphManager(mockLogger.Object, mockClientFactory.Object, someOptions);

            var result = manager.GetBuildingsForSiteQuery("1234");

            Assert.False(string.IsNullOrEmpty(result));

            output.WriteLine(result);
        }

        [Fact]
        public void GetBuildingsThingsQuery_ReturnsString()
        {
            var mockLogger = new Mock<ILogger<MappedGeneratedGraphManager>>();
            var mockClientFactory = new Mock<IHttpClientFactory>();
            var someOptions = Options.Create(new MappedIngestionManagerOptions());

            var manager = new MappedGeneratedGraphManager(mockLogger.Object, mockClientFactory.Object, someOptions);

            var result = manager.GetBuildingThingsQuery("1234");

            Assert.False(string.IsNullOrEmpty(result));

            output.WriteLine(result);
        }

        [Fact]
        public void GetPointsForThingQuery_ReturnsString()
        {
            var mockLogger = new Mock<ILogger<MappedGeneratedGraphManager>>();
            var mockClientFactory = new Mock<IHttpClientFactory>();
            var someOptions = Options.Create(new MappedIngestionManagerOptions());

            var manager = new MappedGeneratedGraphManager(mockLogger.Object, mockClientFactory.Object, someOptions);

            var result = manager.GetPointsForThingQuery("1234");

            Assert.False(string.IsNullOrEmpty(result));

            output.WriteLine(result);
        }

        [Fact]
        public void GetFloorQuery_ReturnsString()
        {
            var mockLogger = new Mock<ILogger<MappedGeneratedGraphManager>>();
            var mockClientFactory = new Mock<IHttpClientFactory>();
            var someOptions = Options.Create(new MappedIngestionManagerOptions());

            var manager = new MappedGeneratedGraphManager(mockLogger.Object, mockClientFactory.Object, someOptions);

            var result = manager.GetFloorQuery("1234");

            Assert.False(string.IsNullOrEmpty(result));

            output.WriteLine(result);
        }
    }
}