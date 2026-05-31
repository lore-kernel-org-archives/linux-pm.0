Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759334028B;
	Sun, 31 May 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220549; cv=fail; b=L6Dv0B0aG2hdhSiqSilZ/rESrZIqbc/YikHE2GRzT3bWynLP9aiDMBuVofdAtlFRvoiw+ekl00sPIWo/xAijFuAqwOS7V9PzXtQmtqQXmKY32l6vCQ1mDN1yxpUsaQmmsBH+dp7UmxvB6+EbbAXVRyw2QmoWKlAM9Xdxf96YxZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220549; c=relaxed/simple;
	bh=Yd/UntexQWd7vrxmPzLnm3zIws+qDCy9apQxyEg+8V8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PpEczUpBlIkboIGa1ELvZK6ECaTy3IDJZyNR2G50YgHHU3khL4FbuTuCeTRnFYl60dimu+ghHM/pjSXQZwE6B/yden9qxvQpv6AnZGbseMQj+rSRUgVe08R0GyKEIHfk6WvOBP1mZu20ei8+3Xen74xCoYqYG2fjLe5m17RHTG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rrs6HioP; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rrs6HioP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780220547; x=1811756547;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Yd/UntexQWd7vrxmPzLnm3zIws+qDCy9apQxyEg+8V8=;
  b=Rrs6HioPcsrONBb0hxH3paKEmYnwWpwPvzYCq/njrmSm6q3mHdu+tFLz
   MJejVfUl0f+d4XLA4LGCbXyybdl4wy2UshdX+iTdmXPA2xw7k/JZqdxQ9
   adqj/s1ybIjf/mQftH9ZDDcYVEvqGzmPNYCE04DQNvdtb8v9fkNgAh8XN
   QiNH9+zuqjDU/4zUjZje6nOWyS9qDUJZGlZXz4B1s/EQwfVLR257oGt1V
   PRarNJXeCdqrxHgr9YyJSIIBtnhmkuO7slFm36brTrzqAqFRTFzmJkJZq
   +3x8GRq2iA0b/npSnleX8AnQwHVGTtmApd9/mAb0zlVig+6GVbsCQnRhv
   g==;
X-CSE-ConnectionGUID: xMcEiqD3SyeGYLkx2szqag==
X-CSE-MsgGUID: aBGVAojfQPmWw4gFEf375A==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="106454159"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="106454159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 02:42:27 -0700
X-CSE-ConnectionGUID: 9knD9llWRFGAY+a8ewVy5w==
X-CSE-MsgGUID: RgHeKRC6R1GZUD2eXJS1Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="247277110"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 02:42:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 02:42:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 02:42:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 02:42:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXpV1cwX7a/SybXXPlYhfM8GhBZQzFSwyCXfgPwj49N4PK25B9C+U9IGqrMxkCkglqSnYyd/J+bgGPDs36r0OmEjy+DsDNNS0+b2IiSf0aaYaOIjaboYqskUalWv+Ows+ByzMNKcWaKN2qAjFUSKc9loCYxTB54UJBkNtnHu/VodyNbVgc//pBQIs7b2S+SIKJXay3tjLpTtKDpcnR6n/i0V+4ZGnLPTnVRDHW7bYTUHWSiq2meEiiiLi77S2qZxBjNa1smpK0JaP3PtBDHxN3V0C/yPOz8rwScSdcAWdLZqf48vsAlaUesXsShRTkXnAdOACmmggBJp0QQdlzXZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAYq+M4qCDNburgzO/7h07u2e8yuZ0WW4j5qxk1Wf3s=;
 b=DYyZLFn7yWmYIyYgSYmBVvs+/YRj1lAPfsNdmlGeB2pNXK+c/N5uCNSLcdHY9KPeRsLviaHFMNw4CZq2jNY2YGfamWhydwTZ62qOHtViAGTBdJ97MO0w7W54bi9AIm8uyRXnCmUTvt872zN0pIUG46yWahk9lSDgUoSlvLckPgaYJphJd9oj26h2OoB60kay+8Ngaqllv5WoQUfPe9TflxsxaESRjHhT3Enk1PRRQ4Y/AZA/Qe+qULPtHP1CcqkhfQqhYnYr+g+nML34JFKufy0Glt2gm9jqhK3E0Yiqe5BguKifR7OXbwPhlT8tskwc2yndBHRU6lvlUefJ/zwpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:42:18 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 09:42:17 +0000
Date: Sun, 31 May 2026 17:42:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-pm@vger.kernel.org>,
	<rafael@kernel.org>, <daniel.lezcano@kernel.org>, <rui.zhang@intel.com>,
	<lukasz.luba@arm.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] thermal/core: Fix double device initialization
Message-ID: <202605311744.299c79b6-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260525151609.2826121-2-daniel.lezcano@kernel.org>
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 46886348-2288-4565-b986-08debef8e766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|3023799007|5023799004|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: T041Bnflnh/aK3Dj00FTiiICziShg2UoxpM9HbuKf758eGzY9sX//rQ/087Zr6iN+9GQcbgXoy3inVnrNsI45u2cLCX0UzieT5bisbjZHIQDvoGev/p51WZWxTEgVUjU+zXi80SQBimS77Ian1lcKm8WHWoHildO2xk3SpnjkPA9Z1fjV/06goRVGvGwX7b69wqdUFwrEoXWyRhSl8i3LOJ2NlM/Q7QJPTbMbHU69rW5qUmzdaf5Z/x/ancpzr7nesMUh6uG0tn+slPN20u4fUr/ZxTMIf41/lXRgHsQQtKxUIqgoIOH8otiWLxbKQlymqab8iMysoBRZ6VxgE0KrclZu6wPKPhx+s9PzmuZpIJfCWTgQ+4XYaXPuEdZ8abAxMJ7n3mJoBWstgZXaZ6TP094vvopI3TLFe7VMLkmvHVb+seMKns5zSKJp/a017eB0my1NNXR/O/W/zBR4D+bBngAtV69rdajG19dg7+WNmzWH0i5HWchLlNTToYSgxTXko8OV2sg1RQiVtT4EStkxdwdr1wSGJ2n49QEQOqB6kwarrKSyOr+acf0BViuYiVzIVvMAQFEawHR6MA0jmNmEJJmAI8TsuCgNG3l76EEOqnkkpxBkh/mjDdzr7gBdqvpb8Hy7S7B4hXTMWGY+iPujA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(3023799007)(5023799004)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CIIH27a+5z/sHTuJzICIsxQCGRvPQNgfjjfygjtO77zajIuKkp+nCZGu+Rk7?=
 =?us-ascii?Q?sEnfYA5pF8DthEgWSbzGqfJk29KOkeUtYR3dneMUqDEjjhAHTBmRGGh6PbQ4?=
 =?us-ascii?Q?lOJxolxo1bbVLJZz3yw88cw/30kmyQ6jMoPjzjVVn9OknICyO6prt9rU6LEv?=
 =?us-ascii?Q?5ekX1Zym1nPq4E/54TidO7pDTX0UH4ZvTakRJvAyla3NuWo7kScxR7IQ9ywM?=
 =?us-ascii?Q?fIYweTnTCri7OQgY4EBSEn6U4bO8VrdVqnpsmfKgp1wnUy/n8atOG7QXcVuq?=
 =?us-ascii?Q?8K6SbP7a6VDmEynt7+5alXuMyswhlsFIky0H7XPBUEZp7FINYgcS8/Rj8/ed?=
 =?us-ascii?Q?iAy5b7s5U+CqAfS08X5UNhmh9qXV990DAPQL6UBtHDdR5LtLz95rkqKGOr1e?=
 =?us-ascii?Q?4TcZMCxYFw+hjX+J/NSxfZLEWiS6z23k7kyCJolErD4NJRV33XFfIIxlJmYU?=
 =?us-ascii?Q?qGGdR6U8wzY0ReVs9OxLqVoir2HbCxumvnEbhjy6w4Lp2DJcnAogoHmc0E5J?=
 =?us-ascii?Q?fM3BJLg+NGN0QyCVta2lGNR7gFsRz0UVhw/h8BguZBdOPu9NPZCFkCjanL2Y?=
 =?us-ascii?Q?I0Or9EwCuWbdVKm3amy0Wqw2sJbAle/bn/Fc+rsIvjI5u8idQiQWOfdrSTwN?=
 =?us-ascii?Q?CJe8ZM0hG+hiT3ou36zD7RRDCc+fT0pTjuCyVyFzSFgsQn97Z3E2Wk7+mnc6?=
 =?us-ascii?Q?AAc7sqmT4u+wSG7MNGiEqokwLVnBnUfvA/XD0HuZVZugq1iagPXa+4uDWWWL?=
 =?us-ascii?Q?LgLh5x3KkHUXQ1b06fWDZ7vE06NP1xuxoNF5XmH/2pBt03601uAOu9B8k8GQ?=
 =?us-ascii?Q?pWITFk6aCGyUngh04R11Rc/XtHnN0CHfvLbOFv49A7xpFvHFmpsdkbK8mV/2?=
 =?us-ascii?Q?AMPUqrxpxSJL0XPHopYibXN9bJk+0mcbfl5GpFxgaMkKoyniU599DFlAucmx?=
 =?us-ascii?Q?tPFv0IcGQo6ji6MPcYYnPl3DhI8h9qii/eZoyQav7LO/veD58ddYQNidG9MI?=
 =?us-ascii?Q?Tt+rMQkE3zasUQW1vrTNWHS73cz/GCo+pWDnwgQEefVwDsbQg21aX9d2mD/q?=
 =?us-ascii?Q?HseKqRAs8xPsb8owaxqTp6onhdY/g396gNn3PUyYYKOuQ/dYalBai1HeghQ/?=
 =?us-ascii?Q?G37Y2o7HbYPJO9MZzegAhtrmpQ6JbLt5jGawZmELTDPuyPcW3Wj5O/kag7rt?=
 =?us-ascii?Q?irYUrChroVlC1rD5I4h5d/Jz8+ZGQcWwLLzkWORc/EuPiQ2TQDVm8QNz4cdE?=
 =?us-ascii?Q?yeD1K+OCK4P92OOSYfqUYn1A5X1gv9bzJj7CG7zGu1kOXjPoUZkmLX1BVCti?=
 =?us-ascii?Q?zBXcgeIIV0AhTOdjuUYp8ReEAeY8gm2T6iYVO5wiFsonEkMZO6ACmww4xLUd?=
 =?us-ascii?Q?tkJ8emEJQoGL60MoQjf43m3agmRtzkbPbONXlmA+0QCpmba7hx+Bf/2+OXh0?=
 =?us-ascii?Q?bwoMLwcMHpRHosMs1F7wUmKaAe56wzqWAxMxmXRqjheimCuVL4//Z0BURT6Y?=
 =?us-ascii?Q?F5QSYlCSgT0/6i34rmsNCwHLowfgWXMRcXwdXLgg4bTbXC9ZTopxJEZKZ/PI?=
 =?us-ascii?Q?5IySICTn+2UDD5LOL93E6DNJNR8o+OVdySLRnqkRevAuWsCmpUQ910nAHtHy?=
 =?us-ascii?Q?gHttBxEskzP9A/Lw3M9XrvfAjguo9Qjc094X5gC7slypIslFgmnwTx/Lgwkj?=
 =?us-ascii?Q?DPcYSzCb9qXQj0Q6R+fE25Bkp1aPslTOmgwx3+8Wcy6Tsfij4SlVAe3umfUC?=
 =?us-ascii?Q?0a/2QIoP7A=3D=3D?=
X-Exchange-RoutingPolicyChecked: ERVMhM+nVsK5y8fIn3jOuRrkHr7QXNjg8DgYS7fyCwinJ4VGQVW4MIt952NMZxP9lBrw/Vud/CFfZcUwm4fuBQ1kNG4lWSu6soVHR6dUGHkbcNGHOFaF00e6hL68WE1zfNZ7PuDGzdq//ttl0ePNhuTdUDX3348z2O+nbNC26CGJert8ww1uAZKLFT0BdrV7CkpC/Bu71A6cvYMJIc8gkHKJ9LvtqRtvYeYTdfPqEZLKdV0vB9EDri4/2QZIDsWPqGm2Q1gA/ZNF4aH/NpcYzuliVaSwRwF9XI85dzrszOpPcm80V8buk03nVLyK8GMRov7uZ8QHcX3ZVfhck8v0KQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46886348-2288-4565-b986-08debef8e766
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:42:17.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIdWRTFYN9Zv01v7UBQAJWXyJKYCAiXr6PrExToel3inx5MzeAbRRqHOIHjBuMa1Yj/XR7N7fTeTqjpqueG1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:kobject_get" on:

commit: 01e1401d1389f3fe2815a3f391cb22224ff1bfb5 ("[PATCH] thermal/core: Fix double device initialization")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Lezcano/thermal-core-Fix-double-device-initialization/20260525-231836
patch link: https://lore.kernel.org/all/20260525151609.2826121-2-daniel.lezcano@kernel.org/
patch subject: [PATCH] thermal/core: Fix double device initialization

in testcase: boot

config: x86_64-rhel-9.4-rust
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605311744.299c79b6-lkp@intel.com



[    0.943552][   T21] ------------[ cut here ]------------
[    0.945364][   T21] kobject: 'cooling_device0' ((____ptrval____)): is not initialized, yet kobject_get() is being called.
[    0.949812][   T21] WARNING: lib/kobject.c:642 at kobject_get+0x16/0x80, CPU#0: cpuhp/0/21
[    0.952015][   T21] Modules linked in:
[    0.953029][   T21] CPU: 0 UID: 0 PID: 21 Comm: cpuhp/0 Not tainted 7.1.0-rc4-next-20260522+ #1 PREEMPT(lazy)
[    0.955559][   T21] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.958092][   T21] RIP: 0010:kobject_get (kobject.c:640)
[    0.959340][   T21] Code: 66 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 85 ff 74 3a 53 f6 40 3c 01 75 18 48 8d 3d ca c9 26 01 48 8b 30 48 89 c2 48 89 c3 <67> 48 0f b9 3a 48 89 d8 be 01 00 00 00 b9 01 00 00 00 f0 0f c1 48
All code
========
   0:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   7:	00 00 00 00 
   b:	48 89 f8             	mov    %rdi,%rax
   e:	48 85 ff             	test   %rdi,%rdi
  11:	74 3a                	je     0x4d
  13:	53                   	push   %rbx
  14:	f6 40 3c 01          	testb  $0x1,0x3c(%rax)
  18:	75 18                	jne    0x32
  1a:	48 8d 3d ca c9 26 01 	lea    0x126c9ca(%rip),%rdi        # 0x126c9eb
  21:	48 8b 30             	mov    (%rax),%rsi
  24:	48 89 c2             	mov    %rax,%rdx
  27:	48 89 c3             	mov    %rax,%rbx
  2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
  2f:	48 89 d8             	mov    %rbx,%rax
  32:	be 01 00 00 00       	mov    $0x1,%esi
  37:	b9 01 00 00 00       	mov    $0x1,%ecx
  3c:	f0                   	lock
  3d:	0f                   	.byte 0xf
  3e:	c1                   	.byte 0xc1
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   5:	48 89 d8             	mov    %rbx,%rax
   8:	be 01 00 00 00       	mov    $0x1,%esi
   d:	b9 01 00 00 00       	mov    $0x1,%ecx
  12:	f0                   	lock
  13:	0f                   	.byte 0xf
  14:	c1                   	.byte 0xc1
  15:	48                   	rex.W
[    0.964083][   T21] RSP: 0000:ffffcbf2000bbd80 EFLAGS: 00010246
[    0.965592][   T21] RAX: ffff8bdb41ce3018 RBX: ffff8bdb41ce3018 RCX: 0000000000000000
[    0.967573][   T21] RDX: ffff8bdb41ce3018 RSI: ffff8bdb40aba8e0 RDI: ffffffffbe2b18e0
[    0.969551][   T21] RBP: 00000000ffffffea R08: 0000000000000000 R09: ffffffffbd0448fd
[    0.971541][   T21] R10: ffff8bdb41ce3001 R11: ffffffffbc95ce40 R12: ffff8bdb41ce3000
[    0.973500][   T21] R13: ffffffffbd3207d0 R14: ffff8bdb41ce3018 R15: ffff8bdb4180b000
[    0.975475][   T21] FS:  0000000000000000(0000) GS:ffff8be2a1119000(0000) knlGS:0000000000000000
[    0.977684][   T21] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.979292][   T21] CR2: ffff8be27ffff000 CR3: 00000001f3220000 CR4: 00000000000406f0
[    0.981267][   T21] Call Trace:
[    0.982115][   T21]  <TASK>
[    0.982879][   T21]  device_add (base/core.c:3798 base/core.c:3578)
[    0.983946][   T21]  __thermal_cooling_device_register (thermal/thermal_core.c:1039)
[    0.985496][   T21]  acpi_processor_thermal_init (acpi/processor_thermal.c:316)
[    0.986903][   T21]  acpi_soft_cpu_online (acpi/processor_driver.c:167)
[    0.988178][   T21]  cpuhp_invoke_callback (cpu.c:194)
[    0.989488][   T21]  ? smpboot_thread_fn (smpboot.c:?)
[    0.990732][   T21]  cpuhp_thread_fun (cpu.c:1109)
[    0.991912][   T21]  smpboot_thread_fn (smpboot.c:160)
[    0.993138][   T21]  ? smpboot_unregister_percpu_thread (smpboot.c:320)
[    0.994663][   T21]  kthread (kthread.c:436)
[    0.995688][   T21]  ? kthread_blkcg (kthread.c:1737)
[    0.996817][   T21]  ret_from_fork (x86/kernel/process.c:158)
[    0.997947][   T21]  ? kthread_blkcg (kthread.c:1737)
[    0.999098][   T21]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[    1.000269][   T21]  </TASK>
[    1.001042][   T21] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260531/202605311744.299c79b6-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

