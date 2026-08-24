Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38B2931F5;
	Mon, 24 Aug 2026 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549876; cv=fail; b=WB2VnELK0kMmwrBp/fX8BBK8sAz30fM1fur+IApRKMGZZ+LkD3IUNP97FyXj5gsB+vwyYkXPJhr0gvxOhoh/+/pWJ7b3B5rBMVZ7O2qS3dGk9L7sWH3nvMSilI9D801F7Lh7WzIpOKLmCf9t4JDmcDzxs30n1J/dlZ9mqtWs0J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549876; c=relaxed/simple;
	bh=yVzOIn863SZTtjNbhO60weUFt5BV1ZTap5OyNF83te0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K6U3L293xTTLqBEIjtM31MMfDSxraxhRZMmPeCngDKHPymZxbUhqP0Qfsib+IAzO5m3N5Ly748DLlYIqZ79QxiPmYhxruUcKQe2fMjhjXEaZXaR215sKGl/y1pN4CQDRo2VFrNGMpkhO3heHjvIty4XbR6fJ146/uy7Cw3rclXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMGCN6uQ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMGCN6uQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549874; x=1819085874;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yVzOIn863SZTtjNbhO60weUFt5BV1ZTap5OyNF83te0=;
  b=PMGCN6uQ+yU8IY14cAJ4masMhk2NhFMsLJbrzjit9FRp7V9/7IfyiG2R
   pQHlLtue4eo5O+FqdGZ4wPmcz2xM3FNoXqblwN7KSHWSTy4GH/79iEkp+
   buiSSBQgOJcjEAFt5I/TJ9fo1IfFNnsE5ydk0GWKzKaju+VX6eSJMGRr2
   DOC7ISB9PZrcOTgbVjg9ajJpxXjAVk7mPPLrvVI8ONcewbHuUtryt269z
   uLud5vudQLNgSR/IKwlagabiFF5LOq9IvSqUPfLcBvvLwDCK6RHJGA+7z
   y/EiuVko6vI8w28XWTSx9URdzkJjLjhRRaNdtZ9SN5juCdvkcs3ocVy0v
   Q==;
X-CSE-ConnectionGUID: kUgdbS7wTLyUTYAQYGvgCA==
X-CSE-MsgGUID: qfhU1jo5Txqdq0BEC8LlbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87852877"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87852877"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:37:50 -0700
X-CSE-ConnectionGUID: R6pUs9ScRl27IxVLknL5TQ==
X-CSE-MsgGUID: T4MYQZQ8QZKShVrCPHlW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="260750552"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:37:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 22:37:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 22:37:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 22:37:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjJHZB3O5GlLy2vHYRE+mqtQwzn6cgGeG7yGb7IENXldRMs7705K6kLAmFphCdsLRuBp47wpNbSvNSZdiJyg3WgPKdlqIqr2B7GcldJmE9b04pTRv4iqQcqNUg0IoZF42jDvmA7Xvhe2oIzc72A/6K1oWV/fW6fmItra32asPUxxL0UbAlZodvswfHz/fEd+8dQYEbC3RyQsZ6CL1wvV1jmbSdY5DJStToqo6YP7+LvZELF0hdAwR3jWsp61dRF3NK7d6iPY1XfE2pi06Z+dop3txNhlBHIm6UTU5KI36AkRdGIuGN+r4amAEKSU4/FRCN4PjkWQPAR14HaUun/+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knW2DwdhgVlrMBevpjXZx9rCseoWk6e2Minuwic4z64=;
 b=yaiQVxuoNrNzwbb++Q1VSpEg1v31+dtCF/Sv0Nx5hfjlV9kNTitgVCzMBaboz3giJ+zo3n1bjkuTpGMmLtn1c94lIpZ70h6fPCG32YAlKFl3z2xHtKScbZxfIv+wbFHoOuKZmiDFmpDbnRyNTUIYor+sLnNutoUrNQ7NK21XhtBXOQQT99BEcHYi9T2DVClRloizYygzOoe1vkXuZIg91+72nzV1p459DixgGvFopHaSr5oXK1FchJpH/kCTpJkMxubkeGHkOZmb0rAoaV2yI/YxSH7Gb6a3qiqFzaRXTtPk+OeMb7vo9hl8JZrbOjeEWxuBcldJeA52XX6vMbqJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 05:37:39 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 05:37:39 +0000
Date: Mon, 24 Aug 2026 13:37:31 +0800
From: Philip Li <philip.li@intel.com>
To: kernel test robot <lkp@intel.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: Re: [rafael-pm:bleeding-edge] BUILD SUCCESS
 361498477a97b6060e2441f64fc29da7b1e07eac
Message-ID: <aovYmy6AKkSgM9ve@rli9-mobl>
References: <202608241339.0y44z2vK-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202608241339.0y44z2vK-lkp@intel.com>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 491e9d82-2fa7-42c2-b56e-08df01a1cfba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sxACswvJAjAuUO8WosBaZcfoFZr1XM2RQ4RT9I+szrrz2EOGPMLjRrDNg9dslt+ikawzc9oc9o9x1VXDzip+Sb8Xb8KOyFQgz0JQOR62khTbyzzx22OxLTPzNHQvomQDg1gCw++w/I+8yf7ZMYy6Hak5SrqqYZ/xOBJC/9aXI6dC/Xh+d4Tkgfjo8AXaGcpfeaA64tScIUjuFE9SMB3KrIjQtjsXGrS8ryCCc5sZK5t/S3BSU/GT/CwscGHyDDd1TabrIjFnt2qFQZonbEMJfuHaXHQx3kYSkK86c/MzFe4HQeQuYF4ITxva5XVEHhH9HIuJsvv8WJynvmsgDyza7dAWZlKgp0fr75Iq5XZT3xYIOI5I3NJ1OlIsJoWQwDGG4Z/ZMR8bsg2iG1tGe0xsKg0T6xN88DdLfWyCwnHYw8UYvKyWjsoxqAhwmieiCYK+8uwH/fxYhM9OVasZbMz2cNqDwj2sJMLYWmMCVG+4vv7vACkPvtXSYS8bU8QtFfH71NtgeMVki9IHSEM/VhJ0ijYml6arj+ZhahpEtOCUpzYhHixeuevaFhNalhzyZjXyXrIzDuHT6RrxRkQaEQYDk0hBSxE0g6/0UoxBLfur9BJtO5ODTaQks04Ai6opOubsbG7HQySf3nJBsHTB/rkW2rkWmYpzMEqOY80zJgm9n/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRgkU5BR1SLYSoCc6rjXnCdXi7Wl90/NRj2w4MfOupahENLsQ5lxm+efCGeT?=
 =?us-ascii?Q?ONgNurtvOUPpP6SdwfMKP+eF2Tki29EX5ZU95gZWOUtBA4IBGKAeeOtRv912?=
 =?us-ascii?Q?FCbD/t84pTwi+W+5CvxqhTLRFAzNYqjGM8pc2wrEBj6xyQVEZoLCXzxDBLYf?=
 =?us-ascii?Q?ZbwWBGgtultKBHqnMKdfhPbHz5jA3w+A1GtWX+Zjw1pwF3KfiHR5NWtMGjF/?=
 =?us-ascii?Q?1DIw4etgs/FCe8TG9TqnuC0jSzOcAp6Ohijb7C8ymnVAeQalt6i3PAqx9KjT?=
 =?us-ascii?Q?sottZzNU79LRS9j0xrL70h5a60vHWjNe/UjqLk9c2U/tiOMfGxw1R/kBdVAz?=
 =?us-ascii?Q?5pSnAAM7fpMuLAXKsyOpnkM6RbzLsv1xxUzddfij5k9TfkovzK+BfBuDp1EB?=
 =?us-ascii?Q?HH4174tV95gmI1KGUKIp9on9KnXgeRTH+JhN/9h5VEmFwXPOIe3biHkJ/LA3?=
 =?us-ascii?Q?AUV9ytZ4l1kOQRxKr7Ejc6d3Y1mDoYyL/hUpquaIS++/jd9z9qt3n6wWFUux?=
 =?us-ascii?Q?AczPjsmY/VRaWF7u8SGWNPp9ZRaTtYypL2nhBx3t1KVtrJIweI2oqGo46zgC?=
 =?us-ascii?Q?pVQUCQgZMaWW+BQpuKrt3OwFkO/NSM9tFxnO9qe7KxCN3csrne1XiSJhI9UK?=
 =?us-ascii?Q?8ET4GY4sW8dT8O0CjRhqyOdkVRQvjK/ZyhvE94WBgZ3Xi+8rozLq5Ei/T3dF?=
 =?us-ascii?Q?PNwNLBxsUWf9FN16BjH6ubEhOmjABIGash5GpRlyF0VK7jsmiT4GLMQygCyD?=
 =?us-ascii?Q?PE56f1dm/6uoIO6fyjMBmVH1bZKINjttQpTFBtWPXNu6gKyrcCx+IDb+Nz1m?=
 =?us-ascii?Q?Am4X1j25PGIWj/23TnMYn37fs8MX5qjMz5ddpEZNF+GHDWUa0ZP7xyuTGrjU?=
 =?us-ascii?Q?f3WBYAvjKeHcDkQHVc72hMkDafBhRurGFadN3CKWBTunP/SgmvJPpteNt2ht?=
 =?us-ascii?Q?SK/IGRMuIOGnzpgvlTccLVQAJwEEfPe7Mn9OM7Gl861WzaZLUcZOFNOPVujO?=
 =?us-ascii?Q?S9akDk6FxMOhPDzEuZVE4OlYGaWd65SRgjLKFta2C6xScKdy9X8AATnQ1xaq?=
 =?us-ascii?Q?98Q3pYkces7v9xdwh90LtmhE7h6ftmHWDorn7RHIA4FsZMG0Ord+H/Yk1KVR?=
 =?us-ascii?Q?vAYog6WlxHpCwRFFgCFknXgi3FILpymRlDtwh0qvEvvDXfxlv0IjnuDlRufT?=
 =?us-ascii?Q?H6fQQYvppE02bZwmtLe+8SP1xrhgD+8wIaHRCxaqhiu2uPnsdf7sz/sa/mVw?=
 =?us-ascii?Q?nYQ0n0zbh01sJ6l6lu+oc88pQcEfd42pM27qKoqrRUTuzvBeBcmer6sgoesP?=
 =?us-ascii?Q?+32z8AwC5Qbf1HhzdXI+fgx+HrHlETvVNrz8DnLCvabj3F6etxfXRvuD2fBa?=
 =?us-ascii?Q?2SkUN06klR+txM+mcOPAtbUfjaQhEYie4aAzBWodgP68GHvJCGFVuEkQo9FM?=
 =?us-ascii?Q?P1kPCpvp58aHNIpzWDtS/QLJZ7pFbyWIcM1k8Jpl+j7OfprbLdtOrpfqFyD/?=
 =?us-ascii?Q?FoaigjBiVUDCy9XR939gGplmh0hfqMLGruQohwZtiEX3HD0XMPst2ARQxpD6?=
 =?us-ascii?Q?GnrnnkU20hBsdiXLhw4E3E0OEaR9im/4ddBHshFAej0G/Z4H+GhCmEHng0QY?=
 =?us-ascii?Q?hB5AjAN+TGG9EGP9eCMkz5F53tZ4pSGY8UfIR9PWCQiN40xinobFZVqOC2mK?=
 =?us-ascii?Q?A5BOgsyxhw0oXi8Y0WHdu8HNt6MwnCfM4RB89O/XNG8cPWZArua7Wo2K3kBN?=
 =?us-ascii?Q?kfeI/KIrqA=3D=3D?=
X-Exchange-RoutingPolicyChecked: V9+LjR4cDhXk7VaxxnzpYphcg2amTQhASojNrgY3UkOe0Q/DCeYe462MIujuToH0p1uFpeA+mJKk0fMKcWmKCIsr8Cl9kXBYdZTOPSK14PHoydsPXxotEu2NBJF89Pwew60/vD31XbZUxYSyLNM7zHl1Nj5n615+BvHUhMtqjMUI6RtVU4KcCsfVza7lbmPHVPL9Riz0V7S0Y/YzkFnM3vRAs3R8zweqmsiV80GEmp+KzuJJaFrZ2Jxtf65Dh5WuMAzUx9zBGfvtrT0gcjE3UqfXYkmeUX2SP4iMX2hYDtqE0aYzy7+GoSzdWZlo9QuADNAWS/oIwmEwZHCVxQTOoA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 491e9d82-2fa7-42c2-b56e-08df01a1cfba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 05:37:39.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWEUazJaEvHySFu0fgTN1UACARis/xpBdDKGPk2J7rmu7i10xEYBhiKvnNhMSIzYF77hy3Rcv+0OER4NH2Tx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com

On Mon, Aug 24, 2026 at 01:09:51PM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> branch HEAD: 361498477a97b6060e2441f64fc29da7b1e07eac  Merge branch 'acpi-button' into bleeding-edge
> 
> elapsed time: 2941m
> 
> configs tested: 101
> configs skipped: 1
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.

Hi Rafael, sorry that the test coverage is still not full for various arches,
we are still working on this to avoid missing important kconfigs.

> 
> tested configs:
> alpha                            allnoconfig    gcc-16.1.0
> alpha                           allyesconfig    gcc-16.1.0
> alpha                              defconfig    gcc-16.1.0
> arc                             allmodconfig    gcc-16.1.0
> arc                             allyesconfig    gcc-16.1.0
> arc                           randconfig-001    gcc-8.5.0
> arc                  randconfig-001-20260822    gcc-14.3.0
> arc                  randconfig-002-20260822    gcc-16.1.0
> arm                  randconfig-001-20260822    gcc-16.1.0
> arm                  randconfig-002-20260822    gcc-10.5.0
> arm                  randconfig-003-20260822    gcc-12.5.0
> arm                  randconfig-004-20260822    clang-24
> arm                       spear6xx_defconfig    clang-24
> arm64                randconfig-001-20260822    gcc-10.5.0
> arm64                randconfig-002-20260822    gcc-12.5.0
> arm64                randconfig-003-20260822    clang-24
> arm64                randconfig-004-20260822    gcc-12.5.0
> csky                            allmodconfig    gcc-16.1.0
> csky                 randconfig-001-20260822    gcc-12.5.0
> csky                 randconfig-002-20260822    gcc-14.3.0
> hexagon              randconfig-001-20260823    clang-24
> hexagon              randconfig-002-20260823    clang-17
> i386                            allmodconfig    gcc-14
> i386       buildonly-randconfig-001-20260823    gcc-12
> i386       buildonly-randconfig-002-20260823    clang-22
> i386       buildonly-randconfig-003-20260823    gcc-14
> i386       buildonly-randconfig-004-20260823    gcc-14
> i386       buildonly-randconfig-005-20260823    clang-22
> i386       buildonly-randconfig-006-20260823    gcc-12
> i386                 randconfig-001-20260822    gcc-14
> i386                 randconfig-002-20260822    clang-22
> i386                 randconfig-003-20260822    clang-22
> i386                 randconfig-004-20260822    gcc-14
> i386                 randconfig-005-20260822    clang-22
> i386                 randconfig-006-20260822    clang-22
> i386                 randconfig-007-20260822    clang-22
> i386                 randconfig-011-20260822    gcc-14
> i386                 randconfig-012-20260822    clang-22
> i386                 randconfig-013-20260822    gcc-14
> i386                 randconfig-014-20260822    gcc-14
> i386                 randconfig-015-20260822    clang-22
> i386                 randconfig-016-20260822    gcc-14
> i386                 randconfig-017-20260822    gcc-12
> loongarch                          defconfig    clang-24
> loongarch            randconfig-001-20260823    clang-24
> loongarch            randconfig-002-20260823    gcc-16.1.0
> nios2                           allmodconfig    gcc-11.5.0
> nios2                            allnoconfig    gcc-11.5.0
> nios2                randconfig-001-20260823    gcc-11.5.0
> nios2                randconfig-002-20260823    gcc-8.5.0
> parisc                          allmodconfig    gcc-16.1.0
> parisc                          allyesconfig    gcc-16.1.0
> parisc                             defconfig    gcc-16.1.0
> parisc                        randconfig-001    gcc-8.5.0
> parisc               randconfig-001-20260822    gcc-15.2.0
> parisc               randconfig-002-20260822    gcc-9.5.0
> powerpc              randconfig-001-20260822    gcc-8.5.0
> powerpc              randconfig-002-20260822    clang-24
> powerpc64            randconfig-001-20260822    clang-24
> powerpc64            randconfig-002-20260822    gcc-12.5.0
> riscv                randconfig-001-20260823    gcc-8.5.0
> riscv                randconfig-002-20260823    gcc-13.4.0
> s390                 randconfig-001-20260823    gcc-10.5.0
> s390                 randconfig-002-20260823    clang-24
> sh                                 defconfig    gcc-16.1.0
> sh                   randconfig-001-20260823    gcc-16.1.0
> sh                   randconfig-002-20260823    gcc-11.5.0
> sparc                         randconfig-001    gcc-16.1.0
> sparc                randconfig-001-20260822    gcc-13.4.0
> sparc                randconfig-002-20260822    gcc-15.2.0
> sparc64              randconfig-001-20260822    gcc-8.5.0
> sparc64              randconfig-002-20260822    clang-24
> um                   randconfig-001-20260822    gcc-13
> um                   randconfig-002-20260822    clang-24
> x86_64     buildonly-randconfig-001-20260822    clang-22
> x86_64     buildonly-randconfig-002-20260822    clang-22
> x86_64     buildonly-randconfig-003-20260822    gcc-14
> x86_64     buildonly-randconfig-004-20260822    gcc-14
> x86_64     buildonly-randconfig-005-20260822    gcc-14
> x86_64     buildonly-randconfig-006-20260822    clang-22
> x86_64               randconfig-001-20260822    clang-22
> x86_64               randconfig-002-20260822    clang-22
> x86_64               randconfig-003-20260822    clang-22
> x86_64               randconfig-004-20260822    clang-22
> x86_64               randconfig-005-20260822    gcc-14
> x86_64               randconfig-006-20260822    gcc-12
> x86_64                        randconfig-011    gcc-14
> x86_64               randconfig-011-20260822    gcc-14
> x86_64               randconfig-012-20260822    clang-22
> x86_64               randconfig-013-20260822    gcc-14
> x86_64               randconfig-014-20260822    clang-22
> x86_64               randconfig-015-20260822    clang-22
> x86_64               randconfig-016-20260822    gcc-14
> x86_64               randconfig-071-20260822    gcc-14
> x86_64               randconfig-072-20260822    clang-22
> x86_64               randconfig-073-20260822    gcc-13
> x86_64               randconfig-074-20260822    clang-22
> x86_64               randconfig-075-20260822    gcc-14
> x86_64               randconfig-076-20260822    clang-22
> xtensa               randconfig-001-20260822    gcc-9.5.0
> xtensa               randconfig-002-20260822    gcc-8.5.0
> 
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
