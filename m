Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141652C326F;
	Thu, 26 Mar 2026 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516566; cv=fail; b=q4MC83+L2PDSIrOeVFmISMZw6V0PvJE4CL3fs8wRFxnCsRpZWIHhmRwDa+CVC0ni+zmLSB6b+Y6QTpFZlr3IHCyHFTXH0fsfLoWVbSE0cPfmZSeHRwOd5gdRnYKHm1p9io9i8SJCHr5wf1xaUk2SmISBAMlkeFu0wRtz3r6QvQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516566; c=relaxed/simple;
	bh=kgu5U1Vxw4LU1XP6UAb9ogHia1T/OIvE8F54Ii0HS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SfZJ8oG9tu68DrzmBjLjsKNtz3Cfpcl8OHdwD0+OiIWVEsjQUyQuWNt1unGRL6pMyQ1Ixl/WWo3G6hvk61OEWEF8k8/v0Cm8d3vt9bjdWqRsys5MFKX/RA5FyI7ogRMJDQ5ugORi+yeI8UlMHFz16Qz8pBPpTTMAPNtre28YHXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbX7NKmh; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbX7NKmh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8/PzrFvvJ+J76YHCZnm9SNmfg7872Vn2n58QMDoLDIDOCGZwOzqL8tzbe6z4AQ60WYXKfCbwhzDXv43PM66rz28bHOJyT8YlwIV/xbkwD1F4Q0K96/Sf/0s53AzIkBJZRBTJ3/1QOIZ85UDEb6ljURFO7a8fQP3Tyey3w9kuV6R2mF37yWvFJZKieQ7cxU8rbnHQiTeKfPjjgz5vybzMZnMUuCbo1sgrDE8n4riFlt7U0+GKoGNQgQV6vvrXxe7pXxYgNEohLCdpTu8dNQO74iotF7nQlnW7bnh5Yqniiu4ssphn6pD3x39sVZw0jga3vhPt+7KfabjJ/jVPZOcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVV5BLE+T2K0IEj5egoo0GN1kGa646oCCtZqKN1f1iU=;
 b=aXPDiOzyz/2lbgkGNRR3AvJymOr1yQFcFtdzZZUvzSJildSwoWptX8AdAkMXLuystzpTcwL0makPDrbtvlGWU2hmJBaJvaYjErk/Kmq8x1lpmXSSx8R6fzCz5UpDOu+z54jgvG/gPNNwizJn0wnSu/IXrhflVxPvesGgSbWhsV0fjctLn84p33156MRfRW0gmfMixOgJzpsjYQd135km1I2diyr/n+V2QVwstn2+8CfCgbCBk6KdCkb0fxzt/xHBcQ7liAVChB3Iite7P6NNid/C+tQPO9yYbCwheYO3i3k2dIxCIJHUN0vn5A5DEw/KtggNjD92cgViB46MR68qsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVV5BLE+T2K0IEj5egoo0GN1kGa646oCCtZqKN1f1iU=;
 b=pbX7NKmhtX2m2kTjLRurVXR5snkOaccrdLfB/UNmWjNMW0f5GEGzzlB1ugC1lCACq9CGqsj0rbXHI5z4zHLZdq0krLjnDu6wO5Jkl4r/W51e2auDki/0gGL0cRPW6G478o21fDvrtaum2kIt+JDxcGCbnpFoc1NzABpo1grDNpqeT3nWT9MCd6ICxwKk39rPFmgtW0TzVfhgHsR5ZqlPIi6wgbEMEQTNKzX2j9hg3gP7ifAr0jVnZ8YmaJyysfxlM+L9ueMbgMcZ7AdmhXMBYrlGM3CXd6uEbVVyNyJUEdehww2DtlOQcidRaDhPcfBeb9O+d1x4hc9PtiF4bdxdQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 09:16:01 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 09:16:01 +0000
Date: Thu, 26 Mar 2026 10:15:50 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>, peterz@infradead.org,
	dietmar.eggemann@arm.com, valentin.schneider@arm.com,
	mingo@redhat.com, rostedt@goodmis.org, segall@google.com,
	mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	kobak@nvidia.com, fabecassis@nvidia.com
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC
 asymmetry
Message-ID: <acT5RjFefzQrkxHW@gpd4>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <acTqSVd-FhywPQ6t@gpd4>
 <CAKfTPtDmnnGONJhrQPNh2rhe3-KvMkX1nW8-JYN+otNLQYSU-w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDmnnGONJhrQPNh2rhe3-KvMkX1nW8-JYN+otNLQYSU-w@mail.gmail.com>
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a8d713-71e7-48a5-3a06-08de8b184bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FMWSij0GAV4Kox5W1Pq/4QAj4bNWdSf2xf2Slzvg3Ig4U0S4HeX/9fdyMxGp7Q1PB0Ny1runrG5p2caVtaEHRUb23aZe+IXq4f0n64SbmC8xz4o74+YG7njKJ1uv9kzm6B39LmlVrXfZWKLYF0UOjQ518MXrRYF9J5IT1xg1+tIN1n9xRjDOKLgq2YnqZi0mN6nmJRgcg/BI9S2MT052s0Q/cXebP6CSo6+zswhCtZa6weAnVftzA0jQN2KTFZPOjn761cFW5X0tT53dx3gWX6rhXoKzrK6glm/BFRwh0xtwgfdY7hg02llq9wpO/l5LPu636i54D5opLiMQr3WozU04VegMQ015srKqRrZ4JDaI2R+AAWNHKDQu711yvUvBDrm4pBrW82JE4y4oCTsxBnlfXWY/r1UOsg1cJCmlFRfkjTmZTRYNuHwWqzkRZyWLWe56bCLyNLsDLnb4q+0lGW4qd33RSrGS3LenzJRiYjLdmCAmgGozwHL+rfbi65kVpuXCJ/C6CnuDkcjHlUitbL9qQDC5rvrFXKxuqFKYfCItMLuGXGGF2JVE88VZJU5ri6wSq1CWaadvFdScMQo3u20A8AyrZUK9s+LMRCt8h/q3Cco7FTC/Wlxcw6+vDAnX50zr5sgyyjKDWC9GalqNvGaJc4zbGgWrGPaNgOMeSdVM1jR84jwjxbmoLVuarJQ8u7aqjcDP2jgZvlGG0xVf6M5hBs+Nw3Vx2e/gGkoVOyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pj/R/LLr8VrACBoJYWW1Cx3cE8b375GJK/qljzPhVk9pyFslzVxHrHJIy74+?=
 =?us-ascii?Q?syusXt5tykmqjbX2+K8mj0xzLB8wOMHTjCyqrMgLyT8ZonrH0Ux4cCoMsWqg?=
 =?us-ascii?Q?9XHnW2qFp8jmrbZhJFOjtnIfFz+7cOM5pDzq71mUPxHc8PyGC6G90wAYtPjE?=
 =?us-ascii?Q?GXhcbGsk4SRKs7/ZpuBjYKTFM8R7ssNODIJmbxmhxE6P7h8Dyyod0I3rCamw?=
 =?us-ascii?Q?/m2RE28C6JDEX+/GuDiplnh+jVA+H1OvFnWmWnLpKBv419sRIzXqUjluJD22?=
 =?us-ascii?Q?kiiFNez9qtBLz7kywqNQrcTXZeT0HKbkCoLRhZ/td3ZhMbuV15GsH3Gv53qA?=
 =?us-ascii?Q?Z5anXPDigWhv9TwYvUAgOPt94WBgR6rUtKsSiyFozN+Bzp9wCon3vVVo+7wq?=
 =?us-ascii?Q?dFPiZmy8DiPwd17TJIcikC/Dz2Z+wJtiLTbDeS1CUSI5Fu+cSGDZa3f0pi2Q?=
 =?us-ascii?Q?eEK+Mcf4/E5+AAIcZrHnjg6gmQiF9aBNeDu+XLegfhOoO2BhD7sh1YcFT587?=
 =?us-ascii?Q?EqH3jolWGQ9/aELzCrFfT592HB5nMs7GPeabVfyYqa9f8T0s04TbEcuZUC8l?=
 =?us-ascii?Q?XTGlzatnt0X6x53Usvcpu3XeQx2wSAQVZpYAWBnGKJZjwzXnvJb8s7mdV0cZ?=
 =?us-ascii?Q?wkHhliT//GaURKI2hyty4fTcG81RMboV9BK/NBWcbDh9qnxZ82c94jeWqFFC?=
 =?us-ascii?Q?9Ahpsx5/GFh5KwWqj4g7CSavMlDXzS60xn/NobitQVBUPgol5+WQJwDW997p?=
 =?us-ascii?Q?zRUSFPKiy9MfVA1qxmp7C3chP9ce8W1YeX8rs3x0r5oQlJGN8OsbFbiqIF7Y?=
 =?us-ascii?Q?N27PJIf+UBNLi4blb/gT8t/LzxzL19ccT0j8CbilpL3r+pNajDtyhTYMLEYP?=
 =?us-ascii?Q?EYTXmsxsaHgESSAAlXwc4lDrlO/ltEY9zVCCo4E21srOTZfx8Pvsq9d2Wt2c?=
 =?us-ascii?Q?Pwc2GDq3U7uLDON3bKMeC3nJU19LRkakVRwb/+FG8cAFX8zO6clsNcr8GXjZ?=
 =?us-ascii?Q?oOsTrr1Vo4zYPS1UW6cmt9J4+BvO+GxFB8FWYRcMeu4h1B55PHJ11f6b/aMN?=
 =?us-ascii?Q?xrQBEfwHvEKlf0DBssdWhhFeBsgtowVUUOfWiKbEI7h4ECcAJHsU1/mq/tCQ?=
 =?us-ascii?Q?q8HGBDHOYGf5GMlq2HSZp18Ikdl/VsGSnZwX3sRJ4hHwzXvs+3WjCECi3LPz?=
 =?us-ascii?Q?gPjhnBewKs0Zi+okhxAidF38Jv5rljrY6kNijxRfwp+pzMGQY8MU1lJAerGY?=
 =?us-ascii?Q?2u2R2m31TgjImF7djixxsiqA8T8g8qHEG4uo5epSHfS0QbspEtXYROygAbdQ?=
 =?us-ascii?Q?PBc4rxj5xlvT3xhLHvC1SS5S61C8p7Kv1/IutMSKOnVBHyb6bjn0EEjnatZT?=
 =?us-ascii?Q?wbpNNSatkqLAUNCwbPKwbsCirBpwqopPX9tQiyABmPiOhuUJvJUuKTONXglU?=
 =?us-ascii?Q?0WuCpS6LTv8QmNTr9wZsF2Ard2On7Xy60J7KvhFPX9/4I/r6/qe2VVj+GSDq?=
 =?us-ascii?Q?Ww7MILfKHBEIWJrBofH5ofPE6Fukjoz+My5Yz4EWd94EwTpemp1U7QcC5BXz?=
 =?us-ascii?Q?s+UZcC6jRxLrbY3HNhq0YY34W/PuK0QXcWtF8Zn0TNKPZ+KyCHA/YfiWhW/A?=
 =?us-ascii?Q?jE53UdmvJGWaYzUoz+L64mj9GWJQyvEqk4ELiSRGNJh06RspUlk4fi4yZd6Y?=
 =?us-ascii?Q?mpcQWDj9A1IqS8KEMrPs1R2r7p8dbRxaeu+y3MReXwXiIgJgo+bBBYcwOJ09?=
 =?us-ascii?Q?SvDSbofwrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a8d713-71e7-48a5-3a06-08de8b184bf0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:16:00.8979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YVFUR0AW1gA83/cEdNbatZfkN/pA4Z1CsN/ZSbwaOGKf0WhEqiG690orc6ygpByhIuHwrZMwi3jwHul2eW8Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380

On Thu, Mar 26, 2026 at 09:20:45AM +0100, Vincent Guittot wrote:
> On Thu, 26 Mar 2026 at 09:12, Andrea Righi <arighi@nvidia.com> wrote:
> >
> > Hi Christian,
> >
> > On Wed, Mar 25, 2026 at 06:13:11PM +0000, Christian Loehle wrote:
> > ...
> > > RFT:
> > > Andrea, please give this a try. This should perform better in particular
> > > for single-threaded workloads and workloads that do not utilize all
> > > cores (all the time anyway).
> > > Capacity-aware scheduling wakeup works very different to the SMP path
> > > used now, some workloads will benefit, some regress, it would be nice
> > > to get some test results for these.
> > > We already discussed DCPerf MediaWiki seems to benefit from
> > > capacity-aware scheduling wakeup behavior, but others (most?) should
> > > benefit from this series.
> > >
> > > I don't know if we can also be clever about ordering amongst SMT siblings.
> > > That would be dependent on the uarch and I don't have a platform to
> > > experiment with this though, so consider this series orthogonal to the
> > > idle-core SMT considerations.
> > > On platforms with SMT though asympacking makes a lot more sense than
> > > capacity-aware scheduling, because arguing about capacity without
> > > considering utilization of the sibling(s) (and the resulting potential
> > > 'stolen' capacity we perceive) isn't theoretically sound.
> >
> > I did some early testing with this patch set. On Vera I'm getting much
> > better performance that SD_ASYM_CPUCAPACITY of course (~1.5x avg speedup),
> > mostly because we avoid using both SMT siblings. It's still not the same
> > improvement that I get equalizing the capacity using the 5% threshold
> > (~1.8x speedup).
> 
> IIRC the tests that you shared in your patch, you get an additonal
> improvement when adding some SMT awarness to SD_ASYM_CPUCAPACITY
> compared to equalizing the capacity

Yes, adding SMT awareness to SD_ASYM_CPUCAPACITY is still the apparoach
that gives me the best performance so far on Vera (~1.9x avg speedup),
among all those that I've tested.

I'll post the updated patch set that I'm using, so we can also elaborate
more on that approach as well.

Thanks,
-Andrea
