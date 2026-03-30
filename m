Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B38E3A7589
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857144; cv=fail; b=Dv5EegSctk7hwXXFyKjgvffi8+H0jMr+h4HYnSjrjULxA2IFxoYyhCQun/y/eaYA+2lBdT7zytpN+oSEPbVvxWWsqFHSaY5qt9LQ0WtXctToST07haFA63z/QFPbAOYzsrx6sePy5b6+O6zmxRCZgA1gAqsUF9xA0z7xJmKWNVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857144; c=relaxed/simple;
	bh=OyabyyQGhDFPL54TRzU1VPBejuuB+uTLVzzf3h6AjEg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=THO6i/BGNUowQCn/ai1Oi1Fxa9J90KQWT5sEW2QM3O4iMANUHimIKv0aIJVYyws7hWJVHlpztOsoXaiTef5Lp6kTgrVbZnPlzMrRhuuMtEzpwyCBrM8ohy8yOjHz+w/kxcG45rSTrCXiwnlDSbwVT15qyovKxIhv64Uw91Kr3Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyeIRHtT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyeIRHtT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774857142; x=1806393142;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=OyabyyQGhDFPL54TRzU1VPBejuuB+uTLVzzf3h6AjEg=;
  b=OyeIRHtTunhY6QgQKr99ZCr9BmoGgaJi6ZU2hwoq7MLO3BtjAXyA3pLi
   MjV8Mjs7zQ+rBScNha07jF8NZounWa8oh1wXhWWLM1yDq5wYYb2NsW9IX
   djrVyY7u2xybWu6d/Skf56Idkuln6uvEoIzxbZ0ucGqByP+pk4vWI7Jtu
   wADx2otVFvmGZRCUrNOwolwG9aMznCLnlxIsk2kvWOCIOwmZsPCGOv7Rr
   qOv/V43Agncxd4BmOBLcgMd6QPbnDd5lyx5voO38Yt8m81OgCuzfa8uvh
   TpnsVe/C1x2mFH/arYyF2ToQitb/OWCI2HeCwiI48pJ7p57ZMOr493RIB
   w==;
X-CSE-ConnectionGUID: eYXl4Z2RQ/OBSO+fRZA6yA==
X-CSE-MsgGUID: eCOvWDnBQQu0HC5gqxl0EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79706252"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="79706252"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:52:22 -0700
X-CSE-ConnectionGUID: /zHmGJ+cQfW7vDqUsd5nSA==
X-CSE-MsgGUID: 3ZRawfPZQyWYpdlyMHeIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="249021579"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 00:52:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:52:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 00:52:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 00:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeagRjIG9355SxxGenyDQkqLwS3a6mKUfJxEvTBQSCzN0ScQHSCUMApVdSlM7HLE3Q0jEjpVVAmeouMlXJvsr7zgi6rCDdMfe7P14wYI5xLohfv7v+DVN4JadaChRyp35pFtVkPe5fr+FeYlrwLs0kY93plnnP23ZpKUBtFZLaXPRV7lR8A4zwFHjsw883yo3pSjPvnvWLfVouh1FKu3e50/S+y+9ZddEuOVy2ceu39i5NdOpYYv4gj6brPn6EWGieOmwy55jDajynJHgi0UAzRNvs2W1IoD7co6fXgXv2GvdUwGQpdbCeh0l9BKvU7tLsgxj6bPHXxoRqcAGMJ8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT9GFxxdyFv/kZ0GdXT5mAABR+d1kON2izWAt5f3qxQ=;
 b=UnCSJUUDLyCgVa8HD9H9ullw6bt4Fy1rfzjkKAy+DXR2EIB7hJmyxDVjaSunCHAOVsUhYkMB2zDcmcpCd9oYLlNkweYhei9vjzpWzw5dOkFRVp/DzYxQQizZ63IAz1rntzdqhd7WywAHAe8q6LNcwujMPrw5DP5tGwHsejJlwqRGxUiogbaHmBtCY5V9UTv1sDf+BrQIt/HPOnaemEbfE+SwFnsVCAImPVt7wk7K8NghgWEVWaBFcEGneo77GV9/3rOcE5mAO/8u0JA4s2Jg0yPGNJGmB4Dx6PTimc/rgjTBGduZ3fTAEp5v+g00SQ/3mbeE6HWh4x67jgDE1xz53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA0PR11MB7212.namprd11.prod.outlook.com (2603:10b6:208:43e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:52:18 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 07:52:18 +0000
Date: Mon, 30 Mar 2026 15:52:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>,
	<linux-pm@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [powercap]  42dde4365f:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202603300921.b5dc709c-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0023.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::19) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA0PR11MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca68b13-945f-4249-346c-08de8e3143f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: EUAA1Nvyscasp9fMke8wtKoW5fQcejjKQ3QksU7ClxROqUI1bncpqQLDG+R2WBb6sV2dUtOJGYQoZoz8VSB4+X0UaTdMfM03vw0pxmGogGNUXYyDE/tUccLmjRApr0gIZyyXcT03OGLgKPxRCAKYJYhhaah6uR8gwksh2GsJ1wCrKwlk8M3cbhhhBRYzZbHV66A7C6D5Cz4HDCaJPakPNcAyk26kbUR5L1EinFJtQN6gOQyn1vfKuiy20fcIgUGj3Y1sTxbjDFhkLkxmKpF34qiopFGRi78B0pyHc5qlBu0l9OVDFfIRMgVnn3NNK6EiRgnfS8boan4aoE5e0AKs43wzdO4eyVCALrE98muDTwcDocxx31sf67n1ZddpWrOsmMLH7q9LBg14/iaqpol+NdKHMPJMytwr+2ndskT4OGyn5QCoDbt1a33HSFp/4GF71PzRo029ZG+bTTjcAvWqW48weufifXF1bJUFW3rdnvdd6LuLCHjNVb1FyvdkXajnrS/H2dy75wWOTtowjOwLbsuc6PeMVPNYqjKzZI4yaXa9fzSuX9bliWKEKbmjRQ7JX0Df/Q6J1S+ZTkexweDi4Qa+QcuWHpJ974hKK8M6F8AhI6DXUL+fIy+7fVTi0mE6O6fiRmOp/I+ODobyGJ9etFXRyBT2S4KPlDgeqM5FydzfCxRU8oNONQkHt7Lr1UjvfUEPrmScm7J/HvBxV4UN5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEQ3UERvVUNDSlM3SzBGVlV4SFdtRVphajNHbklvdVZscmFheGhza3N0eFJy?=
 =?utf-8?B?WllySGpFdGgrQ041dTgzZjE3SzhObGZMZnRuSWVCNUNMYW1pQ2Z2ZmxqcjMr?=
 =?utf-8?B?Ym1icHljWVZsSHZyY2ZneWUyVnZKckRpV0dRZ1c1NGVUVmZzUlVtVk5OWGpo?=
 =?utf-8?B?clZZYjNBOTcrMW5oc3NGU21EMFVjSXdOVnVINzdBZ0RQdXp6SXNtTjkyR2Ru?=
 =?utf-8?B?M1lBRnowYmFCWnQrMlVnUjdHcXF2dlRJNXhWRnlXa2lFVTUyRFJLWnZ4RlY0?=
 =?utf-8?B?RTVsRVpMckkvOTFxTnZhaG9CUjc1UlRVZHp4RUhGOExxM09NSzJGNHJJWmpG?=
 =?utf-8?B?ZEc3dGFsUTBvNkczdk43cGt2MDhOZDBXaDRpRlVEZlhUejVRaDFUTVhDY3lS?=
 =?utf-8?B?MjJFUjliSjNOeVJndXlKQjNtT0srSnVZZVBPZ0lqQ3BJdGtIc2NWakF1dGRP?=
 =?utf-8?B?OVlaeVVjV0ZDRE80bGNHeENHR3FoejQvUWxxcTE1dzBwbWFqWCtJR3dDNlM3?=
 =?utf-8?B?Zis3MEFlOUx0V3VOT1ZaVzkwd0tzV1FieCt5Wnd0dXJib3hiSEJDYzJvRmpt?=
 =?utf-8?B?Z0owSmVJR09rN0FaaGpRcklmazNBbVFOcGUrRUV4RXUwM2RsaEpQTkk4Z3Mw?=
 =?utf-8?B?QU13WUxibXhxdWV2MjB4c2FpTGlsLzBJRTFrQW1lVmMxUGVGMmFlWDZQMTZR?=
 =?utf-8?B?b2M1MElja0Nkam1JaVo4QmpNd25jemR3QTVzWjlldlI4YzBLRnh4VFUySGVE?=
 =?utf-8?B?c080SGNDMldzSzZHVmV1ZG9rdHNNMlBVd05MakNKYnZScTFJclNBRXppTkFa?=
 =?utf-8?B?LzdHU2p3d2hLd1lqQ2dmK3QwOUgvajFHS3QzT1Q3MTluNTZLbHRJNjE0WWFh?=
 =?utf-8?B?K2FVcFZSeGhRZFhwZW9ERGxKUUxUMGVCR1c5Y1lZVVJzZEJCYTlHTGZnZVhn?=
 =?utf-8?B?aGJ3aHJyQXNRbGhUOFlWbmN6K3pIUEdUbWtBUzFwb091a2tzQTFNTnNvd0Fk?=
 =?utf-8?B?NGlDUVBhTGJ1eTdzTjdkSWtpTWNwSEsrOG9SSmU5d1diSW5ha1lTVSt0aTk5?=
 =?utf-8?B?TzVYdXJiS2dHVzNiNklBS0JodDM5ZGVqajByOUduMzBMc00zS29Fb2RrWTBq?=
 =?utf-8?B?NzN5UTJXK29uRmM0TG92cU9DVGdLWTFqdmdIelEyTDFBbGovaVVHQ1VoUEJn?=
 =?utf-8?B?eEdzVCsySHB3bVZOaGlDWjZFaDM0UjU5VFNDVzR5WHl5Y3hUQ0xVRHVIR3o0?=
 =?utf-8?B?eE5hOVl3VlRvZk1xbmNYVis5clRkUWdFUVVOakZHbEZXYUZKcWdaWE5qVEd5?=
 =?utf-8?B?UkpBS2JnRVVUSHNhZndMSExYUWVpdkExMjVMZFN0WFZJR3g0QndwK1VvUFhj?=
 =?utf-8?B?Y1ZnTjdnYTRRNTdvRnJkdXo1eGJveStlV2hBT0IyK1NqTWJvQlRhdzhXSlFT?=
 =?utf-8?B?MmhieUVhQTg4LzBjMXlnY0ZGa2IwMjVrQmRRSzZmb2pVSlIvamM4WW1CM2JR?=
 =?utf-8?B?S3I3RG9CcTBVYzJUSVIwMDg3RXJlWHBwakUrcDZ3c3pZZjJBK2lmVEVPbmdC?=
 =?utf-8?B?Tk1FMDgxRUhMUUtnQm9qSkNmeGxMRS92aFRHK3RuUzdRZDhQSkEzMUdtd25w?=
 =?utf-8?B?d0NsUWs5b0U0anhNMVZCV3ZCWlBnT1ZTSUxMODBoRHdFL1o1cytCRmdqNENP?=
 =?utf-8?B?T2xJck5qd2RQeDQvV1NwSHc5UkN0d1RtZDUwTFZIOUo1MDQveG55M1NHQWpp?=
 =?utf-8?B?dmM0bWExQW96Y0NXbXNDOWRmbFU0WWR3Y2NoQzdjMVNmemdOaE1XdjdqMjBG?=
 =?utf-8?B?VmYzWEExWDVMdEV5a09tUDhCL0FVTXlqOThnak9xTU1oNzVWdmU4UytKSEIx?=
 =?utf-8?B?Qm9MTUZ0emtsMzk2K2NhTDBLQ0NmQ05hMWd1TVFCSk9MTzZnQjhBeVRjV2Uw?=
 =?utf-8?B?WU1tQnAzcFpvQklIWXhrM0J5dStmcnk4S0Z5Nkl4YnlzcFVjb2ltd1FGYmQ3?=
 =?utf-8?B?ejk1TWs2Uk9weFJLejg1TjJmRXN6a2VmZkJZNWdjakl4OUh2cFdUZHlybU1C?=
 =?utf-8?B?Rk90UWZJeDZjOEFzZ3FMYVZMdTJqMUMrckFmakN0aEJRT1FSenhuaTN5V1Zi?=
 =?utf-8?B?cFZ2TGhkSWY3MVd4WE9JWFBDaklaQ1pvWERlTVVlMTY2Rkc1b3NSTFNLazN5?=
 =?utf-8?B?RVN5eHVrOEdVTHNUVmlZcy9VOXhFSitJdTNIZE4waWE4a052ZGpKRHdidTlO?=
 =?utf-8?B?VUVCV09CRWpNeXE2SW12aitaazlkRlQ5dGs0NUJVUG9JeWVlRSs0eXBLUGl0?=
 =?utf-8?B?bXM4N0NIenM2SlVvblI3S3ZqMThJSDVlZjFJZmtHQ0l4cWZKMEFpQT09?=
X-Exchange-RoutingPolicyChecked: XtlIsTCq862sSjR2oHZrA+x+C3EL0UXvV68DJpUXmfKz4cGlx5LwU+bif4jZN9fzxWgjQqDJpJks0MiJqBkuC6/JQWAcYe0eKduhK31yrB93xMOoZW2KqE120n/w4e4wkr5fddm7tjEVyb0vqNG9tQ+CgPh2porGYtD0zXRsQU6xbROy21zH4lT2Kn+o71ti/JtswBtq6iJOjFF9mW7BvuD1XtQmWy+MkRNYHVHQP3ue/XlVjQfjlNQYB4KQPQKk5RcZJ6JUrJ1N9kH3TH5aT20qkQK5X6Br4TsH5tr9kVicSlnQwj53Nh0Ag5VqNTpo8QjDsPdxGJ8KRigmnu7WJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca68b13-945f-4249-346c-08de8e3143f8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:52:17.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CmKEDesi0bxUrDaJwhhbV5HmEW4RaxuDPnzOF7/lImFEhesPcZkgJXDzwa02cFHWvcnn4fTVS1QBJ1PFfN9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7212
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 42dde4365f89dce91bdc07fd1bca047d71dd162e ("powercap: intel_rapl: Register PM notifier only when RAPL package exists")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
with following parameters:

	group: breakpoints



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603300921.b5dc709c-lkp@intel.com



kern  :warn  : [   74.925211] [   T2261] WARNING: possible circular locking dependency detected
kern  :warn  : [   74.925213] [   T2261] 7.0.0-rc2-00011-g42dde4365f89 #1 Tainted: G S      W
kern  :err   : [   74.937766] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], got write-back
kern  :warn  : [   74.939962] [   T2261] ------------------------------------------------------
kern  :warn  : [   74.939963] [   T2261] sh/2261 is trying to acquire lock:
kern  :warn  : [   74.939964] [   T2261] ffffffff8557ed28
kern  :err   : [   74.952510] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], got write-back
kern  :warn  : [   74.959121] [   T2261]  (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_hotplug_pm_callback (kernel/cpu.c:571 kernel/cpu.c:2011)
kern  :err   : [   74.971676] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], got write-back
kern  :warn  : [   74.973877] [   T2261]
but task is already holding lock:
kern  :warn  : [   74.973878] [   T2261] ffffffff85605e30 ((pm_chain_head).rwsem
kern  :err   : [   74.986428] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], got write-back
kern  :warn  : [   74.990882] [   T2261] ){++++}-{4:4}, at: blocking_notifier_call_chain_robust (kernel/notifier.c:120 kernel/notifier.c:345 kernel/notifier.c:333)
kern  :err   : [   75.003437] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], got write-back
kern  :warn  : [   75.008321] [   T2261]
which lock already depends on the new lock.

kern  :warn  : [   75.008322] [   T2261]
the existing dependency chain (in reverse order) is:
kern  :warn  : [   75.008322] [   T2261]
-> #3
user  :notice: [   75.017865] [    T418] Created symlink '/etc/systemd/system/sockets.target.wants/uuidd.socket' → '/usr/lib/systemd/system/uuidd.socket'.

user  :notice: [   75.018570] [    T418] /usr/sbin/policy-rc.d returned 101, not running 'start uuidd.service uuidd.socket'

kern  :err   : [   75.020879] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], got write-back
kern  :warn  : [   75.023062] [   T2261]  ((pm_chain_head).rwsem){++++}-{4:4}
kern  :err   : [   75.035631] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], got write-back
kern  :warn  : [   75.042492] [   T2261] :
kern  :warn  : [   75.042494] [   T2261]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
kern  :err   : [   75.053565] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], got write-back
kern  :warn  : [   75.057172] [   T2261]        lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :err   : [   75.069731] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], got write-back
kern  :warn  : [   75.076607] [   T2261]        down_write (arch/x86/include/asm/preempt.h:80 (discriminator 10) kernel/locking/rwsem.c:1315 (discriminator 10) kernel/locking/rwsem.c:1326 (discriminator 10) kernel/locking/rwsem.c:1591 (discriminator 10))
kern  :err   : [   75.081798] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], got write-back
kern  :warn  : [   75.085380] [   T2261]        blocking_notifier_chain_register (kernel/notifier.c:264 kernel/notifier.c:282)
kern  :err   : [   75.097937] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], got write-back
kern  :warn  : [   75.106461] [   T2261] rapl_add_package_cpuslocked (drivers/powercap/intel_rapl_common.c:2267) intel_rapl_common
kern  :err   : [   75.119046] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], got write-back
kern  :warn  : [   75.126242] [   T2261] rapl_cpu_online (drivers/powercap/intel_rapl_msr.c:81) intel_rapl_msr
kern  :err   : [   75.131871] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], got write-back
kern  :warn  : [   75.144377] [   T2261]        cpuhp_invoke_callback (kernel/cpu.c:194)
kern  :err   : [   75.152251] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], got write-back
kern  :warn  : [   75.164759] [   T2261]        cpuhp_thread_fun (kernel/cpu.c:1109 (discriminator 1))
kern  :warn  : [   75.164762] [   T2261]        smpboot_thread_fn (kernel/smpboot.c:160)
kern  :err   : [   75.175063] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], got write-back
kern  :warn  : [   75.183928] [   T2261]        kthread (kernel/kthread.c:467)
kern  :err   : [   75.188770] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7bb000-0x3f7bbfff], got write-back
kern  :warn  : [   75.200932] [   T2261]        ret_from_fork (arch/x86/kernel/process.c:164)
kern  :err   : [   75.203171] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], got write-back
kern  :warn  : [   75.212468] [   T2261]        ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :err   : [   75.214715] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], got write-back
kern  :warn  : [   75.227219] [   T2261]
-> #2 (cpuhp_state-up){+.+.}-{0:0}
kern  :err   : [   75.232580] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], got write-back
kern  :warn  : [   75.245099] [   T2261] :
kern  :warn  : [   75.245100] [   T2261]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
kern  :err   : [   75.247416] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], got write-back
kern  :warn  : [   75.252473] [   T2261]        lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   75.252475] [   T2261]        cpuhp_thread_fun (kernel/cpu.c:1088)
kern  :err   : [   75.265022] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], got write-back
kern  :warn  : [   75.270422] [   T2261]        smpboot_thread_fn (kernel/smpboot.c:160)
kern  :warn  : [   75.270424] [   T2261]        kthread (kernel/kthread.c:467)
kern  :err   : [   75.282979] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], got write-back
kern  :warn  : [   75.287599] [   T2261]        ret_from_fork (arch/x86/kernel/process.c:164)
kern  :warn  : [   75.287602] [   T2261]        ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :err   : [   75.300163] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], got write-back
kern  :warn  : [   75.306600] [   T2261]
-> #1 (cpu_hotplug_lock){++++}-{0:0}
kern  :err   : [   75.319409] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x4035f000-0x40360fff], got write-back
kern  :warn  : [   75.327073] [   T2261] :
kern  :warn  : [   75.327074] [   T2261]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
kern  :warn  : [   75.327077] [   T2261]        lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :err   : [   75.343199] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], got write-back
kern  :warn  : [   75.346150] [   T2261]        percpu_down_write (kernel/locking/percpu-rwsem.c:235)
kern  :err   : [   75.358708] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], got write-back
kern  :warn  : [   75.364461] [   T2261]        _cpu_up (include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/cpumask.h:649 include/linux/cpumask.h:1246 kernel/cpu.c:1624)
kern  :warn  : [   75.364462] [   T2261]        cpu_up (kernel/cpu.c:1706)
kern  :warn  : [   75.364464] [   T2261]        cpuhp_bringup_mask (kernel/cpu.c:1772 (discriminator 1))
kern  :err   : [   75.377019] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], got write-back
kern  :warn  : [   75.382247] [   T2261]        bringup_nonboot_cpus (kernel/cpu.c:1851 kernel/cpu.c:1876)
kern  :err   : [   75.387605] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], got write-back
kern  :warn  : [   75.400124] [   T2261]        smp_init (include/linux/bitmap.h:461 include/linux/nodemask.h:244 include/linux/nodemask.h:424 kernel/smp.c:1003)
kern  :err   : [   75.404613] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], got write-back
kern  :warn  : [   75.417126] [   T2261]        kernel_init_freeable (init/main.c:1685)
kern  :err   : [   75.422136] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], got write-back
kern  :warn  : [   75.434649] [   T2261]        kernel_init (init/main.c:1584)
kern  :warn  : [   75.434652] [   T2261]        ret_from_fork (arch/x86/kernel/process.c:164)
kern  :err   : [   75.439834] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], got write-back
kern  :warn  : [   75.452350] [   T2261]        ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
kern  :warn  : [   75.452352] [   T2261]
-> #0 (
user  :err   : [   75.458360] [    T420] error: dpkg -i /opt/deb/python3_3.13.5-1_amd64.deb failed.

kern  :err   : [   75.459704] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], got write-back
kern  :warn  : [   75.472214] [   T2261] cpu_add_remove_lock){+.+.}-{4:4}:
kern  :warn  : [   75.472217] [   T2261]        check_prev_add (kernel/locking/lockdep.c:3166 (discriminator 2))
kern  :err   : [   75.474541] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7bb000-0x3f7bbfff], got write-back
kern  :warn  : [   75.479596] [   T2261]        validate_chain (kernel/locking/lockdep.c:3285 kernel/locking/lockdep.c:3908)
kern  :warn  : [   75.479598] [   T2261]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
kern  :err   : [   75.492148] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ba000-0x3f7bafff], got write-back
kern  :warn  : [   75.497554] [   T2261]        lock_acquire (include/trace/events/lock.h:24 (discriminator 15) include/trace/events/lock.h:24 (discriminator 15) kernel/locking/lockdep.c:5831 (discriminator 15))
kern  :warn  : [   75.497556] [   T2261]        __mutex_lock (arch/x86/include/asm/jump_label.h:37 include/trace/events/lock.h:95 kernel/locking/mutex.c:616 kernel/locking/mutex.c:776)
kern  :err   : [   75.502747] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7b9000-0x3f7b9fff], got write-back
kern  :warn  : [   75.515254] [   T2261]        cpu_hotplug_pm_callback (kernel/cpu.c:571 kernel/cpu.c:2011)
kern  :err   : [   75.520613] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7af000-0x3f7affff], got write-back
kern  :warn  : [   75.525062] [   T2261]        notifier_call_chain (kernel/notifier.c:87)
kern  :err   : [   75.537613] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ad000-0x3f7adfff], got write-back
kern  :warn  : [   75.542580] [   T2261]        blocking_notifier_call_chain_robust (kernel/notifier.c:121 kernel/notifier.c:345 kernel/notifier.c:333)
kern  :warn  : [   75.542583] [   T2261]        pm_notifier_call_chain_robust (include/linux/notifier.h:207 kernel/power/main.c:174)
kern  :err   : [   75.547762] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f8e5000-0x3f8e5fff], got write-back
kern  :warn  : [   75.560278] [   T2261]        enter_state (kernel/power/suspend.c:381 kernel/power/suspend.c:609)
kern  :warn  : [   75.560281] [   T2261]        pm_suspend (kernel/power/suspend.c:645 kernel/power/suspend.c:636)
kern  :err   : [   75.567809] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ac000-0x3f7acfff], got write-back
kern  :warn  : [   75.580320] [   T2261]        state_store (kernel/power/main.c:828 (discriminator 1))
kern  :warn  : [   75.580322] [   T2261]        kernfs_fop_write_iter (fs/kernfs/file.c:88 fs/kernfs/file.c:356)
kern  :err   : [   75.582645] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ab000-0x3f7abfff], got write-back
kern  :warn  : [   75.587701] [   T2261]        vfs_write (fs/read_write.c:596 (discriminator 1) fs/read_write.c:688 (discriminator 1))
kern  :warn  : [   75.587703] [   T2261]        ksys_write (fs/read_write.c:740)
kern  :err   : [   75.595073] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f880000-0x3f880fff], got write-back
kern  :warn  : [   75.605660] [   T2261]        do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
kern  :err   : [   75.610934] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f881000-0x3f881fff], got write-back
kern  :warn  : [   75.623438] [   T2261]        entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
kern  :warn  : [   75.623441] [   T2261]
other info that might help us debug this:

kern  :err   : [   75.627851] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d8000-0x3f7d8fff], got write-back
kern  :warn  : [   75.632216] [   T2261] Chain exists of:
cpu_add_remove_lock -->
kern  :err   : [   75.637575] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d7000-0x3f7d7fff], got write-back
kern  :warn  : [   75.650084] [   T2261] cpuhp_state-up --> (pm_chain_head).rwsem
kern  :err   : [   75.655616] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7d1000-0x3f7d1fff], got write-back
kern  :warn  : [   75.668127] [   T2261]

kern  :warn  : [   75.668127] [   T2261]  Possible unsafe locking scenario:

kern  :warn  : [   75.668128] [   T2261]        CPU0                    CPU1
kern  :warn  : [   75.668129] [   T2261]        ----                    ----
kern  :warn  : [   75.668130] [   T2261]   rlock(
kern  :err   : [   75.672531] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ce000-0x3f7cefff], got write-back
kern  :warn  : [   75.685039] [   T2261] (pm_chain_head).rwsem);
kern  :warn  : [   75.685041] [   T2261]                                lock(cpuhp_state-up
kern  :err   : [   75.690656] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7ca000-0x3f7cafff], got write-back
kern  :warn  : [   75.703171] [   T2261] );
kern  :warn  : [   75.703172] [   T2261]                                lock((pm_chain_head).rwsem);
kern  :err   : [   75.707918] [   T2140] x86/PAT: bmc-watchdog:2140 map pfn expected mapping type uncached-minus for [mem 0x3f7bc000-0x3f7bcfff], got write-back
kern  :warn  : [   75.712887] [   T2261]   lock(cpu_add_remove_lock);
kern  :warn  : [   75.712889] [   T2261]
*** DEADLOCK ***



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260330/202603300921.b5dc709c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

