Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE53DC4C7;
	Fri, 27 Mar 2026 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605218; cv=fail; b=J7DuXSSS0T8h9d76bu6IEDyAcvp7W7kpE0+yHZkUINEjF4OFVYEM3CYYqYTtRjPBpvPlJr2M5mV8AzeKg8+hHdcPbDzhOuYquycUBCviHZ9uQ9xSZAadqI4IlgQKfTCpYEbsW4zPjuz26o+1ILmgx/t+ZkF3lElTrlY8U13NTMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605218; c=relaxed/simple;
	bh=Dooj1ra2Jh9WpJOwXZ9NeEV5X/8IvPtgdweUw8JbDdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNPSJ0KdmsFSDn6eoZly6D9sBhRcC836hTGD7mvDGCdGR+nv6uL9TDaHo96P5f7bIO318YMRE/vIi0INzOzqZ/A7Fzki8GhIwvZ9L9vzjA0vs17fStB5IcfdXYZRYi8gaQyaeCKEljU07pQQR3vd2KLYdbmaU1PyOD8Fx1xFycg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IW8nQ5S3; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IW8nQ5S3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+ID70e85Ho5oOfjklu48iwKquMkUXkiN1fXEc22PQJBSVvYz3zfRXMXavL+FP1luLaoRyBYpx6WprnZ6Y/2x557E8bs4abr91SoGdrPtc0EXI+V3uQxfbQC0ARrb25PsGiwqrnC4KXxK/vk9wQSYi95fEX1ZLpUYjkRu9MRYgWtdh3HDvhd0FEOdU5DqvVjjZ0JrTmS/VT5CjUCespn3lvm73OBSjcpRIkXdCxlb88TlUpcP1vADfrDQmi+ATdCF47pPlf90bD9McIgX95SUFFyA/9iLCjWXlP1lXnQ+UxnWJTxwqmpJAjIAF7tZveXs0tkiSSo45KeefnpNzIr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6Rzlf1rn3IoWKQnfsveoIwHeh25e1VERjhgRMzMIqs=;
 b=BIDsVFohPI+UbJBPK+70zx/VzoCpdoQapOzMeWRgonCurmN/bE2IDS/qMaFgn7nGD1DnWXxOkPrMAxSk90xMdCj8JZE2Vtwt9a8FDYUKcwlKSYXzzlXBEx5NJnMhVEA55Bra1BhnX1i3eFbaPQaagOVMILpFA5qnMkfa2jlsZulydN4JRm+2NtP/2lr6kPgZNoONpQAI3NN0dJzP+DVlAEy+aKm15H8oFmg44vx/5d9sviQO+jnk/zLICE2E2itOO1UyMVG7IZHJSS1rY5B9yI0i2PtXpDgADL4YFfP6Byko9L4CwWOhyqFVhm2D5Fx6LngU+4aKVsvamoqk8E01qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6Rzlf1rn3IoWKQnfsveoIwHeh25e1VERjhgRMzMIqs=;
 b=IW8nQ5S3wqs5PEdhsBqbaNuR2QXXScVwWi6qfjzE04pv+x16kwbHcBSa5tyISToN1IwO6oHO1nmsVVbvWYVfO2S+iZEb8lJConRlVk8Gdbn6wDeIEUpSFhXmxa/GxS2CmE3syMThzX15Yxsy03MutYok2clkjn3ibo67hrJp93+/s7XWgL5RKnoRf/RPIPECMDTAXZE3pJKYDqqNNAuUMKUIITjvCNl+OqgViJuWW4hXUE7K1ZFxjiYEe3KgOk5C8hQ4PSGTSypFrrdd4ks+W0FF2eMu+b8Skvquyw18SE/5+mEcZzccve525hD5WefaPJ/jwknj/x5hdeeoAURklg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.8; Fri, 27 Mar 2026 09:53:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 09:53:29 +0000
Date: Fri, 27 Mar 2026 10:53:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
	dietmar.eggemann@arm.com, valentin.schneider@arm.com,
	mingo@redhat.com, rostedt@goodmis.org, segall@google.com,
	mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	kobak@nvidia.com, fabecassis@nvidia.com
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
Message-ID: <acZTkYoPmTkEdlzo@gpd4>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
 <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
 <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
 <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
 <CAKfTPtAQynr=khJk4amqR2m9bV5gnfi_RMkZj=zs0=gpUFr44w@mail.gmail.com>
 <acU4ZIiGuiDvSL1b@gpd4>
 <3a1ecb19-779a-418a-bc87-033d16905b46@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1ecb19-779a-418a-bc87-033d16905b46@arm.com>
X-ClientProxiedBy: MI1P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a9867d-f6eb-438c-0c95-08de8be6b2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LeKxPVWMzVt4XjbLbPHLvSwMfAzXoP5LTco6XRcOT4vYk96KLDTFMR0HxMyU83IV4CPKy/6VR18+5Trf0Ql/OEABLL+b2varYU/zrk0AnPiURh3PJtt93wutYYAKl6wDlb0LEpZ8A/D2JqNn3hqQXiScoG7+k1XndiHlQcws/mSvwM2V4za23gh5V3+WDq6wRCeZ6h/kNOKW1UgFSkS00Yz5t5tjlEJME2aaN4hBGjxlbMeff67Inax3qxKZalHWl2jmLXGYBp2ieE0vKqXV2ykqt19stAqWf5RmQLvBu2OMG+Q8WorUGl/0m9uRlbhzNYXDSVGp6ZM3V8A/acPaNL1UCxI3s0fM+yiAA+StLItruzff7AhreaPHY6sYoztW3uN+ILmxDuBlEJNCcv6Slu7n3Jm5jfCil715iC3BDwuzDe/Is16v1M5Ha4kANcz3J2tTdCWZW6alckdQhrzj5Bg0LHt9p/Ugn+DXoVUpwHNlShjDYEDwBIgAjnkum8Y7NAe5rNkOP0H7DLOWM2PxK7TTd5z0TgMnA9SiKJf1jemIrCl+x+3MwUNp81QxXkmh7FI/jSpl3lfsCupWB0EVJ589ujebxLfv/fV8zZF78Ls23/XgGaS4JOoeIxFrD7WTHHTHZrS28HJZRgsC8UNFWj6B4MpRpjDYUW4IottmjAcylTeeMmh2FFoPURVFkaIb2ILT5QTgW5twyRAdCOX2IipU/cQXUrXOnCpqvyqx7j8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qamCap7mFTJ24//YIiEFaO4m5MKua41Ua9Efr/jTO2YWb4dYzdkv0pEBPaNN?=
 =?us-ascii?Q?iiHoQhc9A3V57YPCgZ8NNsm9xeNZUESFlinQm4ee8V2z++uUF0D8MzkERmhW?=
 =?us-ascii?Q?VrU/8JUvIIclWTAs8QOcW70JUPlkoUqOWfdpPx6V8grfaGWeVWf/gWN3Ke24?=
 =?us-ascii?Q?hWarMuTbRWAns9+/sqedboR3EzHq7Or1FcFhToEWaoR9vYW5L7PXvTFRVhxr?=
 =?us-ascii?Q?YvKzGMJLIUBAdyNs4rSYvAYbM7NJDRuZx5wDID9/rdEqkeNLDNRboXwRa1Cd?=
 =?us-ascii?Q?qVmjIM+Fvkha/2+oj5nNN2O0AqdKPgI4I+6NUJdsz7grOQFqTe0H5+6OVG4D?=
 =?us-ascii?Q?QiEKxZJl8J5ziriAoChuRxaxLqsY5rqSo7UBe5ZsT2wv8QTMnjSrt29dfG+V?=
 =?us-ascii?Q?UKQILAZaax39CGXV7gyVZctx6QzNYi87wDWJyED95+mGmtKjyEVH2LDuyzCp?=
 =?us-ascii?Q?gnDenIxODWHyNzl06M58iYpS93PQFyHQtNhJl0CVW3Git9+1Qs31Xyo7SCK4?=
 =?us-ascii?Q?otbchHpBpORf1WGf904SfYUu/TuespnztkB/60YwKZIIz0b0toXYmi09o+C2?=
 =?us-ascii?Q?NQYYUt26ADq64qLaxOLiiVPsp5Qmukek8zVNP7IdsVMQ9UO2P7YMxGuIcrlb?=
 =?us-ascii?Q?1k6APCDvB1qwuW6XV2ttKWNAkyShOMOIFMJogMSyJRwqByoIo9tlmwLit5/U?=
 =?us-ascii?Q?FNCWiHV+NTUcI8GMhbR0aiFYmnVXvWqAe+IQjQT7tylZyY5vyVm9s2VLgAFb?=
 =?us-ascii?Q?GltjELFkwTC18sFDcA6vDQubZSScaid9YhffzOC4gADTmOKPRmifl/gUfde+?=
 =?us-ascii?Q?zpFtXOxtL4tABhzXBWbrxwM7obagPgJ024G+YF0Nhsd6DcUWuAWm3szZnnKs?=
 =?us-ascii?Q?lu93vibWXWZRaUFdqIrkknNSIWLayiICtCOdFMx7uRc/cEOA4q2GGa5BPSuT?=
 =?us-ascii?Q?SLxur7KC6FgImr33rC7yw9oCqKWuO1gjUOGUkKr1Pk3Q/C02Aard1d8fRH0b?=
 =?us-ascii?Q?ok7zXoxkhsRplqeFIpl+LiqFr7cLNute6BCo8gfb1O2HOVy4TaUehaRpK4jW?=
 =?us-ascii?Q?mSLLre14NYuHcLgRpp5/GkOEM4pIZjqEucY6BbX4/1VCpJ5NlWyp4EYvcdQp?=
 =?us-ascii?Q?AJ71/tS9U/Gr2lUBv7xXApoOLz/LFF2oVaeqLKozcA2eNZLQcuYIjx4p/kkN?=
 =?us-ascii?Q?K5q0sT8eWLLpjxXK6q0Mg0KO5XAbMnfCR87WsewSG0fVp4s5bzZOAK1ymKNi?=
 =?us-ascii?Q?j7KxKraeBuQ1XhUDb/ncs/6SGDb3l0ZdDKnFzbfefIy5T1RK8vUey+sjKHu5?=
 =?us-ascii?Q?JHGwLTgfahhui+F7RkpdP5E72JLq2rexlZfRR6HcLSl8oTRsTRzaeWXceTo0?=
 =?us-ascii?Q?KLx1xP9x7H3sObPOtuKF2RFtzvuOsqvMWLzsLCAyT35dp1b3lMAM5S+HVboc?=
 =?us-ascii?Q?22fpW8g5xLgjnq6eFIRtmzNpeALP2LD9Q/ECRBAO52XG14jY6CsWYKi75m0B?=
 =?us-ascii?Q?3HZa6Pr82evCRhcttgsmVL9/ZkvymNTVsl6NU3fwaVZ1HjOIXapSz8eFR9bq?=
 =?us-ascii?Q?Iu7pS8CXg1Coet7TSB6o6Yfotj93Yr0/7oMhauMDDfPYn3wRLBdAvzI9o+QB?=
 =?us-ascii?Q?R0FWxYr+nYVJKT/Ypizsr1kO3vu7RHJqtvhlmpl90KEK+YNlH+W9ZtMKhkaP?=
 =?us-ascii?Q?chKTFBYbKq28Jxk4FtuwaSFbwB0M7XhKNykD94QqP5LlXrvcQHNWXhw/C8I+?=
 =?us-ascii?Q?D7ZA2e4dnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a9867d-f6eb-438c-0c95-08de8be6b2ea
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:53:29.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV53tCJBo64zRbRgiMkQekbOsSgUEGRHv1VJIryifrn/4MqS8gK9nfKpZ3cL+4RtNjlgQzF/12z2UvFKvbtWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

Hi Christian,

On Thu, Mar 26, 2026 at 03:55:54PM +0000, Christian Loehle wrote:
...
> > Right, the issue I'm trying to solve is SD_ASYM_CPUCAPACITY + SMT. Removing
> > SD_ASYM_CPUCAPACITY from the equation fixes my issue, because we fall back
> > into the regular idle CPU selection policy, which avoids allocating both
> > SMT siblings when possible.
> > 
> > Thanks,
> > -Andrea
> 
> Could you also report how Grace baseline vs ASYM_PACKING works for your
> benchmark? (or Vera nosmt)
> 

I've done some tests with Vera nosmt. I don't see much difference with
ASYM_PACKING vs ASYM_CPUCAPACITY (baseline), pretty much in error range (I
see around 1-2% difference across runs, but there's not a clear bias
between the two solutions).

I'll try to find a Grace system and repeat the tests there as well.

Thanks,
-Andrea
