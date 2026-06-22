Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F836BCC0;
	Mon, 22 Jun 2026 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141414; cv=fail; b=PbkSfaC6IJ+jIaEpaiabiu4yYLPxBUBTVcFmSfG4s+PR7qsyLdCZxPIWwQ3Zmpfnds9E3ryYcDy1r7weozWUYRFXZC/PtmZIt/sCBT+9wuNuH5v0ARJCFVWnGbBOLHlF1gT/rvO7nCRUlc4SjdnutIntFKJ1nu2RKK30slGtFUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141414; c=relaxed/simple;
	bh=oXFy7XOt+Lu9sS4ohsvS/EyBr7Q/w2HfrmMCEo0v01U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ni5/KetiTFQIVjqOQBfydLCQNpTUkl8QeUKHK1Kisqe8DKlEq4XpohBTCMsPQBIdwuBr3nyCqHiHAey5Z5hjVJVY4UuHxkTa8pg9HGAyrr6k16Etea6rJtjuyihI6HDbc/Yu/PtX0/nGkzxtk57ePCALH6X3G/WsX1n5QkJhaHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1ACJ3kb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1ACJ3kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782141413; x=1813677413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oXFy7XOt+Lu9sS4ohsvS/EyBr7Q/w2HfrmMCEo0v01U=;
  b=P1ACJ3kbyPUhn6Zq7NBkRdpPkyG0O8J0SgUSd3mpfaBgM8HOcoza06F+
   d2FUi3yglXuZnz6wIouPO59OpSvTNGTh5xwbYgc/NXVcAN00TJEojXe9J
   U6dkFP9ngV7lu/VjWI1xx4udH8D2UVVkgJEVwtUzH+wxXkoupSaev04Mj
   Ns1KlK6Ol2O8gOaSgPGLYM3RCKogRWOIP7oHjgqnyS6wuPYS/lt2lIS4i
   MVfhGPnBvvBdpQd/TdIeA68nqAC8QXF2G5jRanpYGYyeXkJITiKby6AIo
   Xt7qNy1sJmE3bJsBkTay8qB5+TXSZU1mL+Jk3/8xk1wPJ6W5hDcpBhKiH
   g==;
X-CSE-ConnectionGUID: X8CvMZvBQfqT/wEI5f7SNA==
X-CSE-MsgGUID: ywD/KwP5RDa26VjvQQIZLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="70390256"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="70390256"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:16:52 -0700
X-CSE-ConnectionGUID: iLaZKV59TF+Vxd5NPA3e1g==
X-CSE-MsgGUID: 2cnGSIeZQiugcOZgpjUFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="246327123"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:16:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:16:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 08:16:51 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 08:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKhaL311bKu/a0bq7/a8yy4myYNcyBUPrxynQaW7I4HH7VlpxITmHBJJEaIfBc9ss7J9D1i2cSO1j7qpine0mCqV/Hh1hYtEvcasMGgcuKVG94BWS5NUh0mdefSp+Sj+YZkltMaYRtFdXnSf1NF+LtyKZMjCfThTFcdhdr6GijRClrSFQxqqzJ6gnIV3bk8bZ+8pLC8CxJKs59FSsUFyKtK/nfoIx4WDB9ktZfSyheMMbkBsACN4GmVb0gpEYWG4tuelgCUmuut6Xi+WwTzm9WjxqoSI2cjWtqDwdMz4AZNcCZfdPIjZRnYnTX+4cz8HSAFpJfN7DlkXzNR/MLn8Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2EWXSRlFWwHJg4y/OXl2T+ksHMYN3HXEuNlGF4Mx3g=;
 b=IY20cvygFj5vzZDBJbRe9WSnUqKVJYAzPaSYDkDO7zFA6CbBeBrrx6FRlHOPoZxcweWbF5GUrM0VgJdiZDs02GWM1TmtXzXapAxg1GeGH+YXfuzRVvt6wI8iZOZLeoWMfk6y/RdtrLXZAp2ndHtggSHFavy50qg9LKOIqV/Jev7uS5RkvzmzuL4E1+DQ11CNHviRunqB5DU3D49iExbesO/Pz/tKn1mEHvvmDne5cFQYQMi7Ensve6QbpipQjZnYkSCzwNgyRO6GdeCdtmnfv8PS6Oktq3FE3YVeZ3Kruhc7chbQRkR8b4ZEft/7jOdK/nb58LmQyd4NDsUz8/CGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA2PR11MB5113.namprd11.prod.outlook.com (2603:10b6:806:113::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Mon, 22 Jun 2026 15:16:49 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 15:16:49 +0000
Message-ID: <1372adf9-2356-4d0c-915d-3660efd99988@intel.com>
Date: Mon, 22 Jun 2026 23:16:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Skip HWP_CAP reads in Broadwell
 mode
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML
	<linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>
References: <12920597.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <12920597.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA2PR11MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe19b6b-c305-477b-e330-08ded07147e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: rCgpgn4w206IdW71wi5E/vhqN1LMYJpo3wLQhNjXjMdNqqZT8/kkNRWv+v6atADNypzcqBYXUha3U0XjnKkG2we/XP8Mn+S+of5fehTs04UXw9ze1b7KGHh+jtMYRKIlT9OTTay28jk1bqNuMV/TsFYlgraPzGPB5R/oOVwa6VaFVmuz3eyJCd0ZVtjsEl+8a7VyFOAWVtqBgUTmVGaafEz5yHVPIjTEIFfYaH8BZZsddZXQuuKTW3LzKSjBKi/1rK32R50TP+k6KV6qs+oYBmY008LpyOxZJUvw8RGOzzYNzfDTW8eB08OnPvXq+gFR+2548UudV2P1FTce9ctmwpYFFlW7PToxM76ycTtDBncr1PbGC8Rt1DNFbqq4wif9G/AH8uTPxw9EOe8ey0VqTRn0IBtFSTdmImINH6CITMMMvXnJ/RaJuj49g/nu10tw5odr/uuKJqUVOMA0U6moesLWMrYawZgP+j1aQPQc2AL6EkLDwpp9nhHMmZP+yDQm7X+7nChV72e8E3jHRU2O3ie8bHZLCGcYZEZWXKmDvdCijtQt6tBmsCnUs3V+xuaYZMWEkXBuub6jOVC39IB1HGiXyjWnc1GO5Nh3kpOBims=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVMyOFBHMDBkK2t4TVNhMktkREhUSFNyeGFlY05IK2RmUEM3bFRBUlpWTVB0?=
 =?utf-8?B?Zk8xU2trUVpRV29ud0hJNUkxVVNka283ck0yT3JFUnFBNHlhT3ZzQ00ram5O?=
 =?utf-8?B?blBLZWEweGQ3U0Y4WUNtZk95bkM4QldCQml4UjRoSFR4c3cxSko2NS9qRkhZ?=
 =?utf-8?B?cU9HRGlaOEZ3Q2dlejRNVGVNc0JaQnNXcVhaTlFmY2JGbUJETWZoVG1JaW1Z?=
 =?utf-8?B?NXNZV1BrV2puelo3azBXWnZYSFZ3MjlWNnZTa0NCMEdrS0thVGpBQkpsTyt1?=
 =?utf-8?B?b3ZIZ0V0Q2ZSem1temdvWUFzNSs1NE1NUjFNSVFadEJzUVBWclZHSVVSZlZJ?=
 =?utf-8?B?bHBtWG1BaGh5REd6RG5DdE5MS2tmREJ0SE1SRnJtbWRCbzl0NnVwWDNKV0tF?=
 =?utf-8?B?UElCYTBSenVFeDhmeWkxbit4QXZwOW4xREo1Y1NCL2E0TTNLejFHMG1ONm4x?=
 =?utf-8?B?TEViUStiakF3QlpKMFFISDZhTWFvUHlmUFIxbUV1SkVZQnFFd254KzlCczVT?=
 =?utf-8?B?NytKb2QxZmxCV1FVRU1Ibm54YXJWR3pxekxvQU1BcHpYRWFBZ01sc0VhSXBz?=
 =?utf-8?B?YlBnK3Vxb0FUSkRhaTM3eDZiUGJZb045S29qaE42RVJURm5sK1JIbFhzMTVZ?=
 =?utf-8?B?SVVkMFZubnZGa1FERjZiaWNpR2NXYzRZeXZPMllSVDRrd2dJQXNiNVpDQndl?=
 =?utf-8?B?RnIvSXVQRUdlcnI5MDRnQ2tjRTJ2WlNQeTQ5WVJJRTl1V3NIdE1yR2hVUFYr?=
 =?utf-8?B?Z0FOYWxWRTRERVJ6N2hPY3Y2cU9uSmN0OXhRZll2V0dDSXVNdWR3SlZxNnZO?=
 =?utf-8?B?OG5zeXByNmlLMThMQWpYWWw0cjU3ZGQ4ZUR4SEFvMkd1OEdtbnZ1MXEwNGs2?=
 =?utf-8?B?RklyU0V6Z1pzQTBHMzlxSWxFbWRydm0yY2F6Q29RT1RKaWZvZWdWMldyWFps?=
 =?utf-8?B?WFQvVVBBRURuZGY5dGVNMEhSMHQyVWQrL1BOUzlLajVvcmxiMkdmRzhpUjFh?=
 =?utf-8?B?TDJKczBocDhNd3g0NUFjRW14bXB6QnMrU3dLajVCWExjU1hZdnp0Vk05bWFw?=
 =?utf-8?B?YU04VnR1Q0VpN3E4TFlobnl2b0xyQUNFdVk1RjZDM3dPR2NaSjhoeFNseGZV?=
 =?utf-8?B?UHNBbWozdnpzN3p3UXBZODBhcytBU0tGWHppd1dSWGM2QnpOcFdxaFAxRzRJ?=
 =?utf-8?B?UkdteGNYNUU5NlIwNk9tdDBUQVdCU0kwNzdiWVZRZ2psVmgxNm9UOEZqdFd5?=
 =?utf-8?B?WUFaRCtLdXNVMnkwN1ZmR04xdmNPVmRudURDdzVxRjhrb2NzblR4N2wrZFI1?=
 =?utf-8?B?SFp4MHJ2djVPVGZvM2JDdCtTV0JvSVI2OUhuME0vYS9yc2JEU1NZdGI3Q0hQ?=
 =?utf-8?B?bEcvTmtFTjRLVTFnS0wzMDNkS3JUNVF1NWlTcS8wYmJXZmx1anBxbis2OGFZ?=
 =?utf-8?B?N24xa2ZKTzBxaVFCY3N6S0svUzFndHhFZG1TMXVuOU5CblBtcnNGclFMNHE2?=
 =?utf-8?B?OEthUHpNMEJNcWJzMEd0Y2RLM0NOd1hTa3ptOGdmbG5uOHA3QW9YK3k4MnZF?=
 =?utf-8?B?MFJZVWpFRDdrVlJLLzkyZXZKNUZSMEdYMVIvRjNpdTZxVm9Gam1ETTNzWFkz?=
 =?utf-8?B?alcrSEt4RjltaExEYVI3eUdBMkl5RWZzb2EvSEhrWm5jNWNGUkFXUGlvVUQ4?=
 =?utf-8?B?YlpReDNidGhrZTdjdVlZWCtHakNKT2phYkdZMitoei9vSk1MSHlLN1B5TW43?=
 =?utf-8?B?blBLVm9JSTJjMlN4dVIrTVB3L1cvT1doMlJCVDZtdFRkVnFyNzg3OTZjVTlv?=
 =?utf-8?B?N1l4bUovVkwxc1hjcVJwcGQ3WWJxNjEvKzRUall0OE9ZbG1SdFlwczVTZG1Z?=
 =?utf-8?B?Ni9LeWN3ZkFwVy9rdU94eHl3aDlsUWJhZ2crOHljQ1NGSzkyQXlaMjdTSitK?=
 =?utf-8?B?cEVZMDlsZTZ4ZDJXb0UrWVFFd2JKcVhYZ3kvRUVrSXZrUlhqRDBHNEljK0tj?=
 =?utf-8?B?S0o0d0gxaThTZHZxZW5JVUdyUmswd2R6WHlnNkRRZ1VxVVNvQTBFRVJ0dWp2?=
 =?utf-8?B?NG8xRHVJVFAzeDZLeDBjVUFPbWxReGtueVZTSVRuSGZiMTRyQ25ZcDAzUlJm?=
 =?utf-8?B?TEVFREd1eGpDcXVGd2U5cjdpbUh4VTJvd2xYelpxTTR3a1M4NzM3WTV4SGQ4?=
 =?utf-8?B?YVpGRWFDQVJRQ05LMGhoaWpLNnBDMDZmNlRWQXZMQ2hsbkw4UDBrZWZQK0tz?=
 =?utf-8?B?WTV4UUdjSjBMV3VabDlkR0k1aGdTL0lzbHZlQTJKSk5LUEg0ODl4SnovdW1h?=
 =?utf-8?B?d3NWSG5JZHVGTG16Qll2c1V6SldBcHRZSU0wN1hSQ251cUFyaHhvUT09?=
X-Exchange-RoutingPolicyChecked: pAWnL+XIfSXTPKgnhXAqRS3Bia0Mj+0G2taALRcqQHHaMe0cNtc1isAlD8lFLKd40gVnju23ME8S1aRQmjEz3CtiFL5+B/zI1pm3IlHL9hhhXlqkg9MNDba1addwcNI45mD2nQywcieim3CjcuKa53NI6K3WvTZQPoFk4LWLARVzDO/labft+9AVHcJ8ItdsLaj/F3fKuAYiqCi8xGvBfCetViiQVhcraH/O0JhuDld0rTThcYowYYdEwpIT1tXxUvpL7XoXnOA9yxm7DC6FCoS5FTW5xt8rRHJx1wi/c7+m/B3RqEBgFa0vttTfyrr0rn5oGPNB/80godKyTZJrmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe19b6b-c305-477b-e330-08ded07147e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 15:16:49.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/UakljSVCq8pfAPs6MlNarALcJLcMe1g5PG9oX/OXVWqiv++xlDIbq9lz9r/JLt79c6fb2lqo4BjK2/oxsjTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5113
X-OriginatorOrg: intel.com

Hi Rafael,

On 6/20/2026 3:24 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When running in the Broadwell HWP mode, the turbo, max and min
> P-state values are retrieved from MSR_PLATFORM_INFO, so reading
> MSR_HWP_CAPABILITIES in that mode in order to update those values
> is pointless.  Moreover, using the MSR_HWP_CAPABILITIES value for
> updating them in the Broadwell mode may be harmful, so avoid doing
> that altogether.
> 
> Fixes: de5bcf404ace ("cpufreq: intel_pstate: Clean up frequency computations")

sashiko[1] reports an issue that hwp_cap_cached remains 0.
Maybe still use the value from MSR_HWP_CAPABILITIES for cached value,
which was what we did before commit de5bcf404ace? I fed this
to AI and was given the following:

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5a0eeb84d382..a373a199c9c6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1189,6 +1189,8 @@ static void __intel_pstate_get_hwp_cap(struct 
cpudata *cpu)

      rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
      WRITE_ONCE(cpu->hwp_cap_cached, cap);
+	if (hwp_mode_bdw)
+		return;
      cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
      cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
  }
@@ -1199,6 +1201,9 @@ static void intel_pstate_get_hwp_cap(struct 
cpudata *cpu)

      __intel_pstate_get_hwp_cap(cpu);

+	if (hwp_mode_bdw)
+		return;
+
      cpu->pstate.max_freq = cpu->pstate.max_pstate * scaling;
      cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * scaling;
      if (scaling != cpu->pstate.perf_ctl_scaling) {


[1] https://sashiko.dev/#/patchset/12920597.O9o76ZdvQC%40rafael.j.wysocki

thanks,
Chenyu
