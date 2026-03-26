Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B70408248;
	Thu, 26 Mar 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540876; cv=fail; b=QXH9LMWS7qXiEEjW3AKkOIGRkPHft2TlwN9yww98DhudIUCwo3vEEEwHIIaepEgEYvTkv0yA9sW51/UuH2RnrJelZe9Ai53apTINDi47xHxDVVJEIbj5D3Md71mdKtWdV78/rAddQRpcgM2ePe3kBJO4kxJ09GyGUZgnYr9CoWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540876; c=relaxed/simple;
	bh=2XFSw7w0+rFV3KncM2tzGVSndoDnGBYE+UJHaejBKng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uLc/cjgGf5QPEcFQdZeyauWDm8/iMlIE+O7KO/pDKPT1YUKlnUbPcrxNrlTFBOJdan6afwNb7VTUFqiZVXrCoeCEu3L0p2/avmYzuoUMRW4TH8Ww3FWgmCj2soeM05ftgeLxTlgB+iSz/p8xqD/fhRcxKpkKOx+MNOEeRTK27JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4VmDOky; arc=fail smtp.client-ip=52.101.62.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4VmDOky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gU1Cp4A/zS9DjCXRL86hSkZM2WLWP8exIwqQ5uJPwoPgDpTWSK+mlHQ0BRQVd1J7Q9GXtB4B5XBLMNnFpJmfu8SJ2e09267EqRVP2C8qGmwvyDyb7moe2fFFZeAIVsh15fBkluSSFSBWQaKDzdecBdtwnY8OXIn03ZaS2/K15N4ucQtGVdh3BovtTjtZJWdqY4rq2AX2Eb4LhpbYdvYi5IHiCEZo2cZ4yI60/Nfe7rEcc8gwNwAZ5O8s7r3oqN//m4DC3r4aZHOMg1TEVFgWAJffGlVFMADl7KN3mNGkMvGzHHCrg8Tu50qJbAC0MnRxnZzRoVpK3Az8Eung6k0slA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiSPhMKW8wF6CAyIf1tvDZcmEqZhMaQEQF7iwt4Te28=;
 b=XYSi3cnadksLKo2NM+qgfYTBHq7cLMv5zVB49h3lRk9ManwNnFNRxWNQw0BjvnItkC4gsgwrevPaBWKpdqUroEa1vFJ2U9r9pE60XZ48S03BRCgZvPbHmmvMQDmDF60cKsCukwdkl7a0u46CDWeNN/Zn6/mvobC/zRbnMkLtw/CpeiEjb8qmlZCttohjsQBdCUR5J6saIe9NaDJCM7UVeus8G1FswcHd7VXZbPZmltImCTRUt/pK1YS3alo8Vi9BVRa0HvapjYHqqpOgXIlBcsCKTEGqMzJNnA7sTAo8IOrl4b6WtNQDpE6Yy2vl4OsgSnNPWk02akJZgkP2JXOL2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiSPhMKW8wF6CAyIf1tvDZcmEqZhMaQEQF7iwt4Te28=;
 b=C4VmDOkyWFtcht4Sq/1psSuHgrntFdua37F2wECP7P4GcOgpnUwRwTLbgMqSYHBVf4WvQBUiqsC9CIFTkMnEXs9ah6l11+XeRLal5Aumf7KIOJ1qL07+2Vvrp9iDg+0X6uKkHYh1Ig88AW5yFk1khVw+yqjfd2AJaEBrizMr1jSFHrMFUMkcyJ/7W3z2Z6DbZn3UYMQPli6zxHN3c2UKbwLErP/ULPktJ8leMKf6m6wRh3V9p5X8tw+UGo2LsCxv5at3su0ix2H9DAL7L0UTqgVYEwnqKuDXofKW2W1p+t1Ei35OTEyP3Pe7COLN/SIEfq14JP/2d/F7AfS/5xvktA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 16:01:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 16:01:06 +0000
Date: Thu, 26 Mar 2026 17:00:58 +0100
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
Message-ID: <acVYOtmJOfY_CyOy@gpd4>
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
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a729ea-ffff-4d0c-55ec-08de8b50e350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZYaJ4vfJpLdKd9jZ4n+78k1ZGFHYfcJA5ZPA1mJQv2e2HNLNv5CzJR+LfhPVxR3IdOJXuKelluXXmSCreEbCUNHP8EaKtKKL1pcuDIoC/Hc1k9Hc/z1H4GpMZtau5zow6S5Po+tYedDr+vQj/ImxS7in5K2K92e25y9PkQ2KDrx4JIVqpYycak5B5KsPOUBJFLjJeZn5lelGI2erZBo+tejyaZVDJ0Oync8QXmHNUqNbkn/MyzGPj7SWEYunw0C2m7o5rb093Gkc3gN6gNZvWMIrDGPXz7SUYbXJrpK30nIx59lW7tmzSHfS1Babf7JoUXwSZpk2hdN340xhBMfJImnIYTVQpfyRdV8/AKnNjd+NfiXtUzP1GHFY1U3SQAa1prz/dkvjBFNOTnwLEunRncqr++bkceiFmJJPVOrIGN6X1vAoEfs1Phuf8W81pJfG91LJFYMqzIqqT9wHNdIZUZuFsI+3F3wfc3SuCGQTlyv2SIAv0ZrFYyypS5EB4odhok36inuBKCe9xspLvnCSl9/Xb7GQE1yKq79qdQymiobtpBFdj/EobgKKZ5lx+eTrIAEqbucOdJVq9HTcIuf25lfR9EB4LmreWIQxt8e4EmTggnu1gtsropizyV8gdpvcg719UqP5pF3YtyRLzSE3gUn21VwzYwBloxXOb+8vlbQO+2ub3tYJmy093nwqk1oMWPCyKBv6gCX2WJELANr0xCgaRrVP/aD8VaHwieTyO4aOaZ4rdyY3+8V2ZcaD6xwD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nlGfW40KYBRjlm8zMlWYgauNxQ1rmfa7HsIAJrQEDfOsZwpwQxNGilWrVUsw?=
 =?us-ascii?Q?YRgyNcya67n24MChOPvCY8bhXoPj+3SFCpNDx9fjVE1ZuIXD7CHOpwPqyPOM?=
 =?us-ascii?Q?0pnuaxvOozb2rX5WnxH0sAT3p9XgWQBezVQzBh2oDllb1xe13VIjYBJFM4wf?=
 =?us-ascii?Q?sCioWlN5/sCcq1CRvGTIeNDJ+lb4oV2IK8OLfLaCt25ccPVEVy520nYI+ozE?=
 =?us-ascii?Q?v+wvsRCjmZTfmHu7nBEgVgnuE5BePf+2VP4oDlIHIHhXN0IoGtK2ae/ATEN5?=
 =?us-ascii?Q?d8erTA9jIJ+6n+NRG5Jvo61XlfPBXFFHosznnXJHkgchxQDT8xE1reqzrkCe?=
 =?us-ascii?Q?uv0n7/FfHS5YvcJANlRogFMqnpA2fbg9BTxgmfIcKPjBoGpJ9wwCLrOn0Yb2?=
 =?us-ascii?Q?hLZfkGbnLHh3HsmIxyVQnC5WTdx31Y4pZzcSKvE/LPE06M0JuCro+bsa+6Fy?=
 =?us-ascii?Q?+NyvRyJ/kYTb3JaxMXFFRsBf3/98G+z/ZRMwwPzfLA9p180WoXoKosFISiCE?=
 =?us-ascii?Q?Mz08lFlb/tNyec8O1soFh6CXHxm5DncS9Ut1ufbEIGYTFdi9qMrjeZpDLb9U?=
 =?us-ascii?Q?PA5ojZm4A+JtHvOKwhM8Yqm8qqLZ6cXK/ON92a7pMf14/SIGfn50cUGXapgU?=
 =?us-ascii?Q?KJ5yqdYaEKDk9Se/QENE6XjKjT+mLBF3uLAOSXo1L/1OusN9fwvX6pI1eF6z?=
 =?us-ascii?Q?zh6LgAOM5g5ZEVdFbOdVyuWeqwxAa2myjXr5GyxxKi74RzQXQzNQNb8xgWLZ?=
 =?us-ascii?Q?FJAd2KftmLi+VcM3UOKQL6X6eP0C88+d9LI83hqVBC5+/15DZ/yGJX78omHx?=
 =?us-ascii?Q?xLVLRyEUkMO6nhMknqE1Wqp1ScEMep8NQjpwfiMAOgY5szK7IXbRUR/pfwl0?=
 =?us-ascii?Q?OXnZGeXfFUNRsqEhmJYkOiBQLZKepCp7asjfatxCyBhh4LE0X2XBq6Q8ar3o?=
 =?us-ascii?Q?tKopjpSNOoWUtzBsxiMq520bNk5EmWN7CkinulicSHCu5oQTeTdegifZXDMh?=
 =?us-ascii?Q?R3IRyzvj1I1PEJhB/ByJWEKL8q/z0QsNOKTDfmwKY5ubnR1FLGcQTxK6ubOh?=
 =?us-ascii?Q?2N8mAuNGzLqjJxu/4D0OMmpwJxu3v+faUXWEWp+JSMqB6ymE/Sb7PB0cWvsL?=
 =?us-ascii?Q?dn6uLZNyUsjYPHToTJwiHnp0kSZgsy6hN2DGaYdAAvDj2tDbr6MhgGGi4AgR?=
 =?us-ascii?Q?090M0nxVktcd6f4q+X5Ww810kzZe5mxMrxVoPS+l1hYMP2CpvMo8bDmog8Oo?=
 =?us-ascii?Q?ib+degtH4PpFl1m/ZydcxzBJuAsGg3o7dNtJvs6fi3Oy8lT/B0UB9x2IqNyE?=
 =?us-ascii?Q?35MeZJR9p083DXfrv6oGC7rz1VhKHQtfR2KD/LJOo12zOHemaog7krtCkNoc?=
 =?us-ascii?Q?3ZwuyWVKcCCSUwO/tZqNsREz49smjgys7rtTslk7B33BwV/XwPF6rMbysbbj?=
 =?us-ascii?Q?c9Ya+3tu/vL5isiR7IVCih/d6kG8xdMIGlEh2ffZdUJTxWa48+qnjRktJA4I?=
 =?us-ascii?Q?jNBuTpaILZ8iyEOWlBf6gXKug3F5IhlYLOqZ7DcY5RhMGbJKMa+0B542HUU+?=
 =?us-ascii?Q?RToc4EOYoXcJpbtcFrX2Pxjjji3kyMbtTenry4U6vytNqkoTR/O/ep5Zxtjw?=
 =?us-ascii?Q?F5C3AySkg1z0mBsl/dhfxJBwoS1vxa6SgsDLebKFCl0dl4HrqaNpnWohJCNl?=
 =?us-ascii?Q?QSgxLk2kKpadfaKu4Ah6I0qktZuaALF9BOVtO8VHpm4fMUojv4cAIUrYKFx+?=
 =?us-ascii?Q?jlylOPGgzw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a729ea-ffff-4d0c-55ec-08de8b50e350
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 16:01:06.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI5GYxtt326y+tuN7qZBGGttAgur+ttfpkBkdQv1WvxoltDdF3RQyDUfnOXHqi/cinz3l9Hyb2g6jVqbiyNg5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710

On Thu, Mar 26, 2026 at 03:55:54PM +0000, Christian Loehle wrote:
> On 3/26/26 13:45, Andrea Righi wrote:
> > On Thu, Mar 26, 2026 at 02:04:42PM +0100, Vincent Guittot wrote:
> >> On Thu, 26 Mar 2026 at 10:24, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>
> >>> On 3/26/26 08:24, Vincent Guittot wrote:
> >>>> On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>>>
> >>>>> On 3/26/26 07:53, Vincent Guittot wrote:
> >>>>>> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>>>>>
> >>>>>>> The scheduler currently handles CPU performance asymmetry via either:
> >>>>>>>
> >>>>>>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
> >>>>>>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
> >>>>>>>
> >>>>>>> On arm64, capacity-aware scheduling is used for any detected capacity
> >>>>>>> differences.
> >>>>>>>
> >>>>>>> Some systems expose small per-CPU performance differences via CPPC
> >>>>>>> highest_perf (e.g. due to chip binning), resulting in slightly different
> >>>>>>> capacities (<~5%). These differences are sufficient to trigger
> >>>>>>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
> >>>>>>> symmetric.
> >>>>>>>
> >>>>>>> For such small deltas, capacity-aware scheduling is unnecessarily
> >>>>>>> complex. A simpler priority-based approach, similar to x86 ITMT, is
> >>>>>>> sufficient.
> >>>>>>
> >>>>>> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> >>>>>> move forward.
> >>>>>> t
> >>>>>> 1st of all, do you target all kind of system or only SMT? It's not
> >>>>>> clear in your cover letter
> >>>>>
> >>>>> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
> >>>>> I haven't done any tests on such a system (as the cover-letter mentions
> >>>>> under RFT section).
> >>>>>
> >>>>>>
> >>>>>> Moving on asym pack for !SMT doesn't make sense to me. If you don't
> >>>>>> want EAS enabled, you can disable it with
> >>>>>> /proc/sys/kernel/sched_energy_aware
> >>>>>
> >>>>> Sorry, what's EAS got to do with it? The system I care about here
> >>>>> (primarily nvidia grace) has no EM.
> >>>>
> >>>> I tried to understand the end goal of this patch
> >>>>
> >>>> SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
> >>>> SD_ASYM_PACKING for <5% diff ?
> >>>>
> >>>> That doesn't make sense to me
> >>> I don't know if "works fine" describes the situation accurately.
> >>> I guess I should've included the context in the cover letter, but you
> >>> are aware of them (you've replied to them anyway):
> >>> https://lore.kernel.org/lkml/20260324005509.1134981-1-arighi@nvidia.com/
> >>> https://lore.kernel.org/lkml/20260318092214.130908-1-arighi@nvidia.com/
> >>>
> >>> Andrea sees an improvement even when force-equalizing CPUs to remove
> >>> SD_ASYM_CPUCAPACITY, so I'd argue it doesn't "work fine" on these platforms.
> >>
> >> IIUC this was for SMT systems not for !SMT ones but I might have
> >> missed some emails in the thread.
> > 
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

Sure, I'll try testing both and report back.

-Andrea
