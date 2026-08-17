Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65544E678;
	Mon, 17 Aug 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984092; cv=fail; b=j+9+14dl3RseNCkx2Pn4aU2D9SZ9DYkjC1bmQjK2gmwCUYCVzgU61lnKm4yw3U9aLr6POIa+MPg+hKHJXYnoGW5qJMNr2KalrQROm45ehaiJE+LyUu9VZaurxdtj0oiYKODL+xeQWA1Cj1p4J7AaOPdXz2Kbwzd3KY+7HGW5HSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984092; c=relaxed/simple;
	bh=r5UkL3LddOL77ntrQS2VzAfABzcyQzrT19PxME6bBFY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iu+CCdHZzflo3mxxyaFzEFsSVsZVgW1iopV/HbfRg+bWG3uSdJVB1+f8KKlIPU8zRp+KlcignESbOSDPjzbYBbIrsCA7Jx9+Rm2/u7rHIa0oAuvNO/8fhKcLYeWs8RHRvRSUcEv3kE4bhuCHQDq2/ya+2sXYAGqgK7UhH+GxGO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnDqTTz6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnDqTTz6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786984090; x=1818520090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r5UkL3LddOL77ntrQS2VzAfABzcyQzrT19PxME6bBFY=;
  b=fnDqTTz6wv4xA3ih0YTZmaKcCjfMynLntNO3KHythnvrh/F6/MYEZ4GF
   ioq4wkc6iEcup3ZuCTIJxyK/PkqG7iEaObkdIFEaHEA7yv7N/6uZHVTw9
   uwQcaeXOqOuVHQ7bV3kEleft5wuXvR+AJI11rDBxR9TTPwB45c211MrKu
   ApnaXgizFuoRHreAemDQO0GtmD89IfxXimGPgSep6eV21B3+Klc6bthzU
   akudro2iwHtY/oo+PQ+LlekqLjVNpA+YUFrxfueLeC3Qb1+4CffohetUE
   xRnXEZeWUDF+FXMIrgwrM46uoom9weYn2NU9FHea/2NnaTAjZ0xTOcb+m
   w==;
X-CSE-ConnectionGUID: nM4ZOoG2R/CjeAXHx+1QKQ==
X-CSE-MsgGUID: SY+FiNRZTTqlebo9Iqi+ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91142630"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="91142630"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 09:28:08 -0700
X-CSE-ConnectionGUID: YiraRIjxQIiqT4/qpBrUXA==
X-CSE-MsgGUID: Qt8eMreoSKCXpqazt5WIyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="264997920"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 09:28:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 09:28:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 09:28:07 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 09:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWu39F0rBLYaamie0T1Nlo0qmiAVuqZVpqdYXisWMEYZXPzb/eLkm2x40k3LMmlt10UZAxK2sgMFBz1mg+n5xvJJqnlF+sJzKaDyz3ziGp5JbT044BJsHAnoBpaHr03NtJmcABSbSmpvpca1e8oHhcyYlLHpEQ07+F1hOJGwG3cc0QtW8viZLvqliQ3RvKXBUL0mV1NBdBtThhv92n3zugDj9xCRQI4KLvQ8ZTXerZ5hDBubb6VgNNlBHgiYx/K+RoRfaki+vmfiIJumyObU2QxTgFbkkKABtEERAehXJquFMcA6vnMSirSPGEwuxBsKQhGD5ovf2pliayH5Av9mxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBYrb2gK6tqh/0dzD3sZzphnV9qRaSKTN1Q/xkjyKDg=;
 b=rfThpT8hnAGHek3r/1cP6SANU7lT1WscnxrSKgQORWZCw2lKhvCPVeXybumjXU3WE0q42lbKrxYYqUOorrISd24v4p/XHl47eMe8kGuUGFwaDnku78msEmgI2yKRnhH8Eni4eHTP/vK4C2MLtB878pm3TmoeGWSHdnTFzKexfWHW12tw1RFEuoQ0+37q32LGnumhSz7lLHD8gHNMaf9t9O4h3hdxCEygKV3qDy15jPGRKnGYYh0fWlWgBHLyovxYxmSgwKDYazZH1TvZLRYMeVLiX9v7IYZ2rvpeMSBsXkelvYULdfe5K4K5G0eLV2uduUkz0lzgbJmbsu7Ey8MnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 16:28:03 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:28:02 +0000
Message-ID: <9bc46362-6b3b-48e0-b1a0-0cc7e84fd151@intel.com>
Date: Tue, 18 Aug 2026 00:27:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: x86: Apple T2 systems need early CPU offlining
To: Lukas Wunner <lukas@wunner.de>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	"Len Brown" <lenb@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andre Eikmeyer <dev@deq.rocks>
References: <20260812120326.155226-1-dev@deq.rocks>
 <aoCJGj8HixmJ9oaZ@wunner.de>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <aoCJGj8HixmJ9oaZ@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW5PR11MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e84d60a-9de9-42e3-a0e6-08defc7c81dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: jssR6X7p1oS9wd4hL4vju3hzH+XLQPeYQb2TlWhMbg8tMYzYM6RG2DSZrMK+vHYYTzWeEHFaFxxy1MxzsW5c/dp0iZvRqTzGwboYtODb05s8sGIlLpCegWJ8dUp9s+HXr9qejBEYeaHyveHSxFzHjRYQ9ZkIHTiOYJRRDBCA2aeQsePUhVJ2vw7+G0svx67rclUNcKoSlAdvHQW09J8JHTABZdKv7/6f+iXt5Fc9mYbcLeZpiZOo9TOOAfO/tNxBJa5kXup/6Q6E+O5fYW91gj64XryuGjUADSOHPO/4+rcJMhGZS3mojCPaUveqMRabQpx2myKhk1ZF15vk8Xh1gqdhErJjCRsgThPiuHEdFytUpSnFqC/IUze03AyGWc4FqFufnPTBMXLquNE8GUCQfyE16dlzJNGtEVlrcfgCShfmR8rgZINeDfzEYkktFmv6ZJ9bPDGS5SlpUxhly0HtngXtem792HYo8/UgDT84QM7t9MNiDm7xakY4LxNsOeAQn5N7rR0XsZzcSgE4Y4+6ZfGLnASl23qYmes285dSRII28yfTZFL8+wlQgOzue9kqA9vs7pkEJGbViOHc0fCz9SCGn11BgkYkKAxOrz/mvxkXwQ2hWycmTWMbETsPYdLl5V41zJYEE6FnBzCpfruKd5rN9EnuRWlXk/P33SCoZAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FmdVU1UG1WL0l4cXFqYjR3TUYyeUNBRjRiRXdZUDhPZ2UwOFhQOTFOempZ?=
 =?utf-8?B?N2VBWFczVXdIdkpWdjdDU1R6MUlTSWQvNWE2TTdxNlc5SU12UkpTem1zdzg3?=
 =?utf-8?B?aEtzNGo5bnFVdkQ3MWhwNS9SQVl2eTRHeXYyMmZsbWVZRGtTNExnbFh6ZElk?=
 =?utf-8?B?ckt4ci9IM2RYZzc5TTFzS1RPUHg5enRxMXVwSDdManZVNzFDZkhyTkJ5Rmk3?=
 =?utf-8?B?NXdZMHV2Q3BrTDR5a3Uvb3A4WmxtOGIyT3Q2d1NhOUQ0ZjZIYW1qaTFob1BQ?=
 =?utf-8?B?Q0V1bWpOeCtqdHNFekNmWmpxeWNPdUlyQWVvc3BRRlk1b3pWSzFEYjVtalZx?=
 =?utf-8?B?cWhCbXd0T3Y4Y2ovVXlMQnJNMmtKOWdiOEs2eDVkYU82akpnODJtZkFTRlMx?=
 =?utf-8?B?TjdBd2NrU25Kcm1kTm5mdk1mVXBhYXYyNklYQjB6bURoN2hpVUh6WXFXTjBS?=
 =?utf-8?B?N1grczBKSGNvTzZzWngyTCs2QVdWSXBrRkVTSEN1WWNkMmJJMnU2djEvNEdt?=
 =?utf-8?B?Z05Cd3NNQzI0a2VKa3R4dGxrbXJEdy95MWtwdnJLblNiZisrQW5mSHkwcGRF?=
 =?utf-8?B?Y01NRzFLODVIaHdERGcyRU9VODdDOTRxenVuVTRQdzkvRWxKSmpuUkRLMDZh?=
 =?utf-8?B?bnJLL0FFakdVcENpeTNEcmhqcXM4bnlBQjlVM1kvTHNLY2szZDVtSzdLSUNp?=
 =?utf-8?B?ejRwdWtTcWJFNEE5SXRoRGxVWVJnWmQxMUJOaHp0NVFUbFA2OXdMb1JQWXdC?=
 =?utf-8?B?MFdOT1VvMEl5alBUbnFZUWxZQ0l1RWpoQ2d1angwbTh0WDRESktxU25xeUVC?=
 =?utf-8?B?TVpMbHVURVY5Q3NkUHJnYU1uZWVqMXkyc09tOVRoQ3plRkdKTE83cmZJSFdL?=
 =?utf-8?B?cUJkaURMdDh5OWJPb0dwQWF6ZzRPWmhIK0gwZGZLSi9mVHRVM2tWMmRBUWZu?=
 =?utf-8?B?eFVSTndtNlc2aDU2cWV5Y1g3eUt0R0s2aUlkOUx0QTJlbWlxUWpPTUc5eHln?=
 =?utf-8?B?N3dtT3lnZXY2OEVaZEZFUXcvRlJIaFhtamVhdDVUdktsM0JraWFjdkVtVWk4?=
 =?utf-8?B?MURiL1N1bktqUi9NQ3hWeFVuSmZqamhqUUVSOHNaVzhQd2VSc0h5NGx4SHIz?=
 =?utf-8?B?bkRqN3FFOG1MTktjQUVkVXJydXNiZWJlaFJrTEJTTisxYWhHSGE0M084RGtI?=
 =?utf-8?B?RlB4YStpcjJEbVZQOVpVTWl6ZUJ6ZGVlSkR6cGk0UmUzMzRFT05FWHNzaWZt?=
 =?utf-8?B?TnhTb05UMU9IZU5lQjFxRFFLYlltSlUyK2tSRC8zbnUrWUZjSUJCT1lSWDg3?=
 =?utf-8?B?TWh0dFZtdEsrVFVWbk1YTVEwOVJwVUVMVzd4NC9odFdlNUNMOWtaVGpEdTlp?=
 =?utf-8?B?YmRKTkVHNEpDZWk1b3RhZWZjRmFGdFJ0eXovZVFDOUc1cEdzNExHMXZEUU5Z?=
 =?utf-8?B?Uk1kNG9KK3hLWXhKUU1MT2V4YUNyRFVFT2c0dWkzUi81K1VXRGZ4Wk9IaCth?=
 =?utf-8?B?UUNUK1dhcHc5RGE4K1NPK0gvRE9yZmkyb0ZpYXROY0lkbmZnckYvL29LeVgw?=
 =?utf-8?B?MDRjTGhkNjFxQlJvWXZDSUMrTEc5ZUk4UVFxZjlJTVpKaUQ2RDUxSkE5OHVN?=
 =?utf-8?B?VW1tYmVxSERBQmFSMEVFZmpkdXdENW9GQXlPRlZqNWx2TFR0Z2NtTlp4WDZa?=
 =?utf-8?B?SURpdHBzdEk5MDNrb0tCL1RkUk1iRDhGM2lUcU5NQmJscWdxd1hnOXY5cVBa?=
 =?utf-8?B?T1N3YjhQc1BtbkZPUzAwcEZvSDBjNHRtVnZLSlh3c0Z4YmhFR2xCL1M1STZI?=
 =?utf-8?B?dEx6U1pObDZiTEF5RDFaMUwzU0N3V0hHT1M3QUdDQk5DbUdSVWhmQnlEYm9y?=
 =?utf-8?B?TWxsRERIVzlVKzFEeWJjVDFFRXJCMFgxZHNvMm1NZFhiU1ZJOTlsNXd3UzMx?=
 =?utf-8?B?ckpxbjNqYXpOMjMwQmQ1cU1Edzk5ejdRY3dlditsc01Pdmk5ajBUMmtod3Q4?=
 =?utf-8?B?S2tjdENIWVdMa0xuYjRxemtKY0FXNUlIM3I3QzNNSnZnL2x0cXdNdVhwMmd3?=
 =?utf-8?B?UFlXZlMxNDF5MXJtU0RyRDZ3SlVUdHpRWGNxVGVRVWxZSGdpbEZoYXM0cS9W?=
 =?utf-8?B?bU5ocUJzUFFXMUFxRzQxL2VoVFRYWCszVkJ4QzA0OStXVGp6S21QS2YrbS9o?=
 =?utf-8?B?aHhsTTY2TzUreEJGL1VXb1RQdVIxZHdZZUQya3hZTys5YXkvRjlEd1pWYmw3?=
 =?utf-8?B?M1k5Mk5LbFZSalJwQjA0NlBlNVJMM3RRcDJnNkJqZHZyTGJRR215U2g0OEg4?=
 =?utf-8?B?aEttKzJXQXRaZmtKeURVVllHWXVJRE1DVVpwNVk2MzVPcmRtbTJCQT09?=
X-Exchange-RoutingPolicyChecked: M9Ke/Ly0NHaZ8Svzpcya5z7BJgtBdXHoCVa2eUnt7+UDm5nM4ONrdV8v0+bi3t8r8ytUdgHPoEsU7vJz6w87guA8kwO+NzbdCptItTha8tF4n+thJfbSDnzaU4w98fguKhaTYS3S9vwzFGC+Jcg5WJSO3h5ZTAcXSoQ8Zz5nYEIYjuXyPymChTtpMhuqHDqSpWVKax5Fal0Y/UD326e0cXslojYDYz8VsKJQULS4dxlv9ukgT2yea01LONw+NKkfzntYB3j6bb8cErwFBDaJav4zSaQzT16lCaXld7gvdnKd/V7qeiMs0yN8z+OKxbTPFRc2j3Jr7iJdcrhR7XNjDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e84d60a-9de9-42e3-a0e6-08defc7c81dc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:28:02.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLyyx9jS6HXiSRLMSSFiq5gURJEDLO7BUlgohZNzQB4uK+0anIglJB4rGV1tuLD9h+snhOenfRuYD5D3hWG2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com

Thanks Lukas for bringing this up,

On 8/15/2026 11:43 PM, Lukas Wunner wrote:
> [cc += Chen Yu, start of thread is here:
> https://lore.kernel.org/all/20260812120326.155226-1-dev@deq.rocks/
> ]
> 
> On Wed, Aug 12, 2026 at 02:03:26PM +0200, Andre Eikmeyer wrote:
>> Linux reports _OSI("Darwin") on x86 Apple systems. On T2 Macs, the
>> selected firmware suspend path makes secondary CPU startup during early
>> resume take several seconds per CPU.
> 
> That's not a T2-specific issue.  It occurs on older Intel Macs as well.
> 
> Back in 2018, Chen Yu root-caused it to an invalid MTRR upon resume
> from system sleep:
> 
> https://lore.kernel.org/all/20180319041843.28218-1-yu.c.chen@intel.com/
> 
> I've been using his patch for 8 years to reduce resume time on my
> MacBookPro9,1.  Unfortunately it was never applied upstream for
> reasons unknown.  It probably just slipped through the cracks.
> 
> You may want to test if his patch helps on T2 models as well.
> I think it's a more generic solution to the problem than the one
> you're proposing.
> 

Glad it helped! At that time, it seemed that the issue might have
been related to broken Mac platforms, and we were changing the
generic x86 path. Maybe we can wait for Andre's feedback, I
can try again / or assist Andre - or just keep it out-of-tree;
that's also fine.

thanks,
Chenyu
