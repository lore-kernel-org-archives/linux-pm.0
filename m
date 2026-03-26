Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE921146C;
	Thu, 26 Mar 2026 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532737; cv=fail; b=p5rO9FqLNoPHF2bYI4DZuasy5XPu25SqFLQTNBaJ6OPEHLZw0anin/dvZrlwTZIDW4XjqH4n/O1JjuHZ4TVOngyYQSPuBKCHCct0osrPMsiYuz6wgLnFw2N90PG0ocF6FklBAB8fj51XcTTxVoEXC6IFwh6MH+2oTYktsmf6+vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532737; c=relaxed/simple;
	bh=S1LQQJPxGRJq6Cmh/Eg9HjRKAYYp7wfREJODQwDVGdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GlTdiujrH9mz9g6OWyp0MHFD5RxwU6DWrIFkdYGjV/RXzJClB0EGIiakg2brYHT/eJjBVN2Z3G/VJnMIYd5FJepIRe5VTLtqrdwyy37o8TlsBPzuWmaI+nEzJrqMF62LT8mDLWQ19LRJSNOomIqZ4JmhPT0Mpyod+JFnF1Lt7ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bh6Hc+/N; arc=fail smtp.client-ip=52.101.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bh6Hc+/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW2U6J/zYuEnNUcI2nf4J8yWVe7egZ5uXwIuZ8LWHDkCLC84B9MxSHlgtVRT+MxIl4/nEWDs7z7ZCmqzgarKWJG1RknBqEl5kyBC5C9oJ0BFSJ0mbdf1KvpYw8HIAWp7M78WyBElkw0JMSjPyHUYQIBwI+1TftrBJ5muuV8kIO0Y5BMO8qlpzdI6I+f942GB3GLBc4hHdT4tGCJ2iCfmuLv05x7k2fFFMx3wK4aYGpY1ub/j+6yFhh6SVk6T9yaOQIu1JEz4ncPjVZG84ptP5UGE2AZ1pTYt0u9qRY3Ya4qWm5DyWRDMy5FHkgdCSmAMfR6xvv9tDOkdOYgFBwHbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqxpskORH69W73Dqx9RFRf8x5jik5a2gcOBYGt/40+s=;
 b=D/pQ9xUb9oM8mo2mCuOQKDRtmoCU97sOllc31jE4+A0wjn4vtujsgcLiQ+64PM+sXVRCocH443rJ6ofjM162WsMAYqgjUOTtA5t8ZSTk8rBXvuT/BnTUm6PopnEJ7a2rmPlGQcus4lWdCA26wCtUj7AYGbwZUu1gUMbomdArjM3UPbjN1K5jTdm7SJnI/sACRK0jZa2afyWTuDmftKVsNBxTu1A9dhjW/ypNOTVGXXyb1etZDbHMz/fYy83Nc8TAblEZfzvyutiIuK39j565TiTHV5K/YIvFWfab1tdnGMqHezmPt9rTu6iHTeI1m0LJx+8l5P1s1Ox3TWKYz5GSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqxpskORH69W73Dqx9RFRf8x5jik5a2gcOBYGt/40+s=;
 b=bh6Hc+/NuG4e3+P+sSGu+n/eZnqRLSYyjv97dG8sUxNou52y5lB1MXxahCRhHAWNLY7HIAqEKeXCURrmw4yqTMve2p7SCfwLxis0cnUQ9weEPu86bA8tT4O2zA6tbJgq8wsrSEx4PvO/GRG5HRNw0ppouWlujCriKrveARaj/OqSdMuh77sBsHvVWupweT2LVx5B+FkcNJK6mwLeXi4hwSqHcOt1QMXAsBpEgTywxUAyshMlUw9aRUgGHwOnShUlpC0qm9h/jjqr82Igy33uD5vLQyr//tR9UdWlOryv543DZsW0rsP9iW64gVJSM8jBB/VAEAsvmjlvLrCZ1eqlsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 13:45:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 13:45:21 +0000
Date: Thu, 26 Mar 2026 14:45:08 +0100
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
Message-ID: <acU4ZIiGuiDvSL1b@gpd4>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
 <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com>
 <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
 <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
 <CAKfTPtAQynr=khJk4amqR2m9bV5gnfi_RMkZj=zs0=gpUFr44w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAQynr=khJk4amqR2m9bV5gnfi_RMkZj=zs0=gpUFr44w@mail.gmail.com>
X-ClientProxiedBy: MI2PEPF00000B80.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::417) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e67798-0858-4635-e800-08de8b3dec17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	msIB74S5TRgalnvnl6nHt9NzbHCwLRu0abh4DAtkX2n3BzBOAlX+s9hwZHg2bIV5uvvZKu0aDngqWCCDg3gKDhk161NMM3ZjScYTDFUEtPvV0XPT/5J+omp2J5ZNLySyY+U+StdWRiCNzJv9jhr94QxanwgNmCtOLb8wkx6HTtV0r1KZadE+u3BFA/jeUP7+MU9nzJimcjtrrzIL93RT6Sew2XWdRkSHsZvOC/X5mAR2t3GydNMAfLE8ryRQ8q/fHjArxmB9KmS3JJwqyZAK1fNAB/9ksRp2lAxqxObb5kbMUc2QTzOlhjEBZmotZ2TmMJPZ1xi3NcsJ0V5o0ridjXtPSVIB4lhID1XkrqybP4iAq3lUjYW3CFvsDU1nMADRD+iFC5z22b8r5dXBXwucnZQPT/CmOG9Eb3ZhCiqbJBfg+N+yGw8bH9Ps69Zwo5EKH+b/aU3MrRu+OSxznQxXjKjxJhO+gj29vNDU1pNEp2jYUHKKwVmMCN2SwxtJ+iM8OWUxdG58hTHYxYu0WOKVOrK4hqwmcLNL+MaFq02gxcH+AU7U9ey4o5bDi3ZkvPxUkIY7xG9khBPclTBm6aljheWQdF8TKA3gKRpRMbBvoAX8+L0cnZGGVNC0LZTatJouieupl6RaNCMlSl6Dln4RFSfvqnuassVq0el5Ry1HJDZbnkjnGu5EfuuH6prrBPkQPc2mFJ+4IbyP+W2XyHW6LPZNDo6gLw14yuBnxkIyxkv8D9YGgdiBBGumO56Zr6V+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pk/K8fxIOiAuNT2JZ3lUnV55fKQloVzhpHMsCLp6fkOiHnYYBqTpGhveBo/M?=
 =?us-ascii?Q?8tNy+bnvqRY0UwUOxmYFrJGfqx5Z6YAreKBO6dIxg8UxjRy5xvrxdB+7rHet?=
 =?us-ascii?Q?fa6t+AASsakqpYnY4TnjBxsmX/VzfLL1kfdVmpGm7SnhVts/xw6ZJo3QvdNq?=
 =?us-ascii?Q?nJBYv51TB+wFiBS6ooT0IUv3oIw4LSdmPVfLiIwamr1Vog6viHwmOTHyl5BV?=
 =?us-ascii?Q?t16Q99TXXY0bULcYRB6aOqD/Du+REPFJ7lao03t5WWneLWXulYIbkMNeUFQb?=
 =?us-ascii?Q?UFft4bK+AYlnXaak53+YBhPVTA55/0fpY7wm8CDsBbnDz2pM52bYuKtuYW9f?=
 =?us-ascii?Q?weWm16cBji7Y5jflzd0LdLHG5SJPiNGTZtDK4jGdJo35N7j85mPKv/bmgBiE?=
 =?us-ascii?Q?SAphnTLDID+meSDBX0C0rbdPvx2d5m1TTDjSZj1nNszN+NpKfnuabDWGVUn5?=
 =?us-ascii?Q?QfCpankAUEqx66OtzT/aTe8VNVpWR0KQuv9ForAvfygIunCzQ+UDr4HjI1aP?=
 =?us-ascii?Q?dPkBSZcf9CK7akBF6nIl9un2bdUemWqSOMNRvdeZ4y5/yJ/8/e0MOrc3h+FC?=
 =?us-ascii?Q?QvKbRAlLGMUGquptd+2N+CmeQMvNJBrTkzk7wp0vvbeKxORSP9ir5rDl/N7x?=
 =?us-ascii?Q?iNIbTbNWzSoSDORzydb/DhmJBrqe3uUprwQsp14U4Rn2FmUzZlb1z7ZKoCAr?=
 =?us-ascii?Q?qwgwC2BsMm4pb9xGxGtOiNssfuLiD+uQ5a8lXn+KiaPuXj1IBW/JgEF6Ybuv?=
 =?us-ascii?Q?CSHOXpE+01Pf+yhnsipyxNo3PtJFEjWiiwPViyrtA1M55Y63FYbGgovjPS8Q?=
 =?us-ascii?Q?r441zbu0JNLm7J1cEJgfeJPLaK9uOg5YVCGNddFfmkQ1y3Vip6Aevr5G6Mzk?=
 =?us-ascii?Q?aFlOlVZE4yWbN/Tb6v8gnUbB66w/TR0yrtX3TswmZR0yJfhe9nZNY2rFMFtj?=
 =?us-ascii?Q?7XdRDSnlWbwcPLB28h6u6J6/u8P9Lp3LceM68kS/SZjTr6qo3oa8EjWgf2fA?=
 =?us-ascii?Q?czTFlKeBuNx4vA4TPevcEIIOIayufwUntE0n6A9mDjvulsGmNuySXRXB5v/4?=
 =?us-ascii?Q?eGKOIy4TJ+1EvaHMNPhmriosef7kAYJPCoxsXimLDul5AyypO3grK7GcSv+1?=
 =?us-ascii?Q?WEG7ic+tn77ZlGplp8eGMFOCqtQ0sWckqdgm7Ww5CgCGUdRQ2jtXd6p+m/j3?=
 =?us-ascii?Q?FNZWWr9QdhZO1ZgkzwXxXicBrtfrS/vEXdEkcTO/kPoILRs6ZG1WjH7JM575?=
 =?us-ascii?Q?U3vvEkilzHiR5Ma2rtWzKth95+EndqhPR8lcHTjmMlP6WoR0qu6TXd+yhGTJ?=
 =?us-ascii?Q?HFCWmYXV8wwajiOCBPEDxyeeYcky4ex7Q0lOElE6VGu/KqP5qMNbW7vUZVV1?=
 =?us-ascii?Q?DORroAEXFda8q9l/aiXsE2c4D56G6ky2BmNv2GYvsAz2jdG9DIQZUEsWjypo?=
 =?us-ascii?Q?aFUv6LkDGIUsqshEkKLF522siS8ESErxcCdERrwUYIxGVUzTqe6r5xtBcEW1?=
 =?us-ascii?Q?MFTGlmLwMcTnxSPYDxr4WRKm8biIdhJJOcZnbtSmZyqDhgK+ROEjVl7ApNZG?=
 =?us-ascii?Q?8q3vNgmHu9SotgGxlVTAJ8cK3Sdw+ihV/LmWMxAjH7exrr8vnnXewssQDUXR?=
 =?us-ascii?Q?p44D9d+doMdpbhPbnlIrhMpu9Awim6Welu+kDHqm1ozm0HeXVL/vYAvNeBfe?=
 =?us-ascii?Q?ipsoV4mv8wFrZNymoxhiBoI5QGd3gwwCUs8Vb1fRTOLo6hSFqn63i/5Z01Um?=
 =?us-ascii?Q?OxbNaFh5hg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e67798-0858-4635-e800-08de8b3dec17
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:45:21.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLI4bwv5IH891UBeblXIBR/dfdZQtYZmaukqN2QPGoigkC1TiSEL25BNbvZmjpM3NG/mvawCCWLDA59LcD0jTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

On Thu, Mar 26, 2026 at 02:04:42PM +0100, Vincent Guittot wrote:
> On Thu, 26 Mar 2026 at 10:24, Christian Loehle <christian.loehle@arm.com> wrote:
> >
> > On 3/26/26 08:24, Vincent Guittot wrote:
> > > On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
> > >>
> > >> On 3/26/26 07:53, Vincent Guittot wrote:
> > >>> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
> > >>>>
> > >>>> The scheduler currently handles CPU performance asymmetry via either:
> > >>>>
> > >>>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
> > >>>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
> > >>>>
> > >>>> On arm64, capacity-aware scheduling is used for any detected capacity
> > >>>> differences.
> > >>>>
> > >>>> Some systems expose small per-CPU performance differences via CPPC
> > >>>> highest_perf (e.g. due to chip binning), resulting in slightly different
> > >>>> capacities (<~5%). These differences are sufficient to trigger
> > >>>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
> > >>>> symmetric.
> > >>>>
> > >>>> For such small deltas, capacity-aware scheduling is unnecessarily
> > >>>> complex. A simpler priority-based approach, similar to x86 ITMT, is
> > >>>> sufficient.
> > >>>
> > >>> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> > >>> move forward.
> > >>> t
> > >>> 1st of all, do you target all kind of system or only SMT? It's not
> > >>> clear in your cover letter
> > >>
> > >> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
> > >> I haven't done any tests on such a system (as the cover-letter mentions
> > >> under RFT section).
> > >>
> > >>>
> > >>> Moving on asym pack for !SMT doesn't make sense to me. If you don't
> > >>> want EAS enabled, you can disable it with
> > >>> /proc/sys/kernel/sched_energy_aware
> > >>
> > >> Sorry, what's EAS got to do with it? The system I care about here
> > >> (primarily nvidia grace) has no EM.
> > >
> > > I tried to understand the end goal of this patch
> > >
> > > SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
> > > SD_ASYM_PACKING for <5% diff ?
> > >
> > > That doesn't make sense to me
> > I don't know if "works fine" describes the situation accurately.
> > I guess I should've included the context in the cover letter, but you
> > are aware of them (you've replied to them anyway):
> > https://lore.kernel.org/lkml/20260324005509.1134981-1-arighi@nvidia.com/
> > https://lore.kernel.org/lkml/20260318092214.130908-1-arighi@nvidia.com/
> >
> > Andrea sees an improvement even when force-equalizing CPUs to remove
> > SD_ASYM_CPUCAPACITY, so I'd argue it doesn't "work fine" on these platforms.
> 
> IIUC this was for SMT systems not for !SMT ones but I might have
> missed some emails in the thread.

Right, the issue I'm trying to solve is SD_ASYM_CPUCAPACITY + SMT. Removing
SD_ASYM_CPUCAPACITY from the equation fixes my issue, because we fall back
into the regular idle CPU selection policy, which avoids allocating both
SMT siblings when possible.

Thanks,
-Andrea
