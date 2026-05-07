Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F12DF136;
	Thu,  7 May 2026 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163669; cv=fail; b=PpLzo6oUcMHoQIYodRWigl7wR3i7V/aWoDTwY9ULo/WkcdxI0aBZzDtroIVUZ99OPAyVJwe31a/Buz7dmz5aOp0hunmqYX7zq/SXl0bOrrApVRiLrTbnGMyJfn/rAZB7A2aRCSYrVnBW+tHMUpEb73wwl14Ke9kQl/ynOj+Fg3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163669; c=relaxed/simple;
	bh=R06daNP9YSnJFrAzmFGW6mtt3m18uyCh6R8cL4NatDI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vi0sMTTojrHwIdK6z0gOaIQ/nI4tJl+uDN1eNFi+jaNxmU8noqVqvqVlTl5I9ddczb75uTX9P5J4Xu2ycwWEEbWLdpJ+8Zb+vsuqvWPq7h41Xpwov1KzpggwMnS+Mmj75mYyf7PcI+SyKwCPsqIm9CByrJlig2fJBbX9KJIxr/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/xJblet; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/xJblet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778163668; x=1809699668;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R06daNP9YSnJFrAzmFGW6mtt3m18uyCh6R8cL4NatDI=;
  b=L/xJbletcUFddSmIyaFhxKWMlMdbo4h469r6/lRKja3FA8OhnA9JztZ8
   JvoviI6xZHb0HJfy5kTyPWoxCyuwiBgpnrQg5X1bbzh/59CJQxYnhOTtN
   jPCy9Ae4Lv8h/kwimpcryjB+wWZUupMfMMF+HeAyZ2XOCIV/OQ3bdf/+D
   DEie0YT2x6WljbWzZDgL4vExO+i5RmxLWArEF6QnItZufYKqB8sO4do9l
   Axa/q6inA9iTqcs+I0rCI51mKZ8+bRBotAjNNM4o7xWFKgsSHz3JB0HUk
   sgUAf3KCemsQO1IYeGmi3FI/YUUYTSQgmw3SB3tqaIC2CMkjBI8n+GcVr
   w==;
X-CSE-ConnectionGUID: J+i1LN06S9OJGslwq4FfCA==
X-CSE-MsgGUID: hqpBWgeOSzKVUYZMCU7w/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81684072"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="81684072"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:21:07 -0700
X-CSE-ConnectionGUID: ed72vs0+TFWaSKe80qMoFg==
X-CSE-MsgGUID: L8Do5d7QS8CzqEfEAhFYlw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 07:21:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 07:21:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 07:21:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 07:21:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkkWPPrPwrdanfSHhu/DivP1GPEnqIbAIS9ZRmTXxb0rGMJEHoqztmZ45cXim+sBGZpj+MnuVQl5HRG7kcdb+AkIsMcgvuy7KODU0xUXJD44mtYcaoQawBmYeRV1Zdf+z14q2brP75FDzvWmbAny82K5p2HP33AigrelKfB0nNbJnQtJSqW5WFKxgJMbaFpA1wVMNobz7s7A7kQf5bZkTQnaFY9n7/uYQIyZGByaobrE7ZmbGe4CH0T5pzJ2jklyOhbRcTpVXqoNieuyuxFlja4mXx8SFO8uUPjGLWkHGe3pWA4XW1nwxY1xXeZsj80UtT0pnhmIQq8aUoWTDdURow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXKLUZY49d1P/Y1YfGW3aVuqN+2H5vizDBXbSMW1DQk=;
 b=nvlPf7Q2rVf5L25hHzw6rLx8BDUPV4JSXlUT7NyPRHCyUOXuVbhHludmwnKdt5OZgmsZ7j0vJQ4Wm4djI9vqJqFi1Pbd+fqPFH0x6BUnYfSijMuy0a7LQLxTM5G9h7/ep0lNjl7ysUgfLWNGexdnFqxOd23fPcPZRraXn0YbwOpt4jbo9qbAUVZ8fp/WHUVNTrQjqCe63ohVFmuwQWIACRyJNck4vibyyUcNGGx7FnF26ldGMUflzc+wvS1TTozCenD6MWjhrepyz51fT8NA3Uliz8IrhckXCJVKvUx3MtSpARL6YvYp92/LSpsYIH/caK+9P38X+nB8vcvYHguv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH3PPFA3FE8A23F.namprd11.prod.outlook.com (2603:10b6:518:1::d3f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:21:04 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%6]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:21:04 +0000
Message-ID: <615dfcf8-31da-4e65-8964-c39022b5a1b2@intel.com>
Date: Thu, 7 May 2026 22:20:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
To: Qais Yousef <qyousef@layalina.io>, Tim Chen <tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, John Stultz
	<jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Thomas
 Gleixner" <tglx@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, Vern Hao <vernhao@tencent.com>, Vern Hao
	<haoxing990@gmail.com>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-9-qyousef@layalina.io>
 <2b9fd875df1f71d2c12c21938784a6c1fd38c04a.camel@linux.intel.com>
 <20260507095516.vv7blulzskkyezin@airbuntu>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20260507095516.vv7blulzskkyezin@airbuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::7)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH3PPFA3FE8A23F:EE_
X-MS-Office365-Filtering-Correlation-Id: 03eba2be-eadd-44b2-0b2d-08deac43df5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 14hw1zfjrxKRriHLi6mDAZKbbFK4Wi11xnZk1epHdLawaQMPNuThzG2sMMU90GxYvCU5HykHbVrd6ex1b/zC/8Q5wieHwjkPFR3q2cXZattPWnr6wVr9ReCzFnHPumgZLaoMdkbp98FxvklvBZDgKrAMY+0Sgo1OkEwhBXCNZrFFU03awmNhA+EubsMGT8P0tb9eOapr0JH0qHmAmRYwD/fyjmUz9tOZr3LWves6EHu5ki74zCxuL2aJ2uWrNBZwdJqWvJMpg2QT7+gRf56I3KGINDU1C7e1FPw1ADS6ELpGYdTQ1KCxt1C7iMmbYuGawwNMcFtI7DjnxJiOwNG86UDgLvWsjADeLtHsgxi/AZQhuhB0XXri1e3jw3yaXU2vUrUtzXdWfUW8WeKTwUvExFTPVL9VzOI0q154zmdegEnpGwqULj6BupqvuU8cLpBrYW/TGrLhUFuSychj75oLNt3Yi7urz701NjYLManWoy0YXh7IPGASi2ZPXw2aE2FTZhA9wAWuG6k5V/k6jWEPVejNoVt2eHO0WVK6L9ec5vOnLMT34OhJxHBOiQGXWczqBSWDBsM+z0DvfVMgMaV9et2UXBX6BflR4O1sHVNoynFeMTRhrWOLjddSHi50cBswUdgEwFa1Vo/ybdc+66fWnFwv7xU+DrT9dhq/ye/iy5pO+b73q5y+kEfmLv9OdppF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW1HVkM0S014OVdhV0lnYnNPQ1VJcVR4UkxHbENncU4wWUJnQ1ZlclRNWEU1?=
 =?utf-8?B?Ymp4ckVSSU1wQzVwRXhGMG5nenFjMUpic1pvaWdJZHk1VFA2di9nczloWGM5?=
 =?utf-8?B?OFlzZ1I0NWFwc3l5OU42OGRoMS9BZUhmNm4xTG5aOGVlRFlFRjI0SElVNi84?=
 =?utf-8?B?dWlIYlg2MmlpN2xnYnBMZkJQK0JPMmxLQlM0QncxVXBYcHJlb0k3ay8wVGp1?=
 =?utf-8?B?ODU1aXA2MUJvU3Fhc1QyZ2Uwb0ZTazQ1bmNoM2J0YzUwU1RFRDJ0WUVlb0xp?=
 =?utf-8?B?bGVJL1pOMUFVQnpsNlZpbTlQTmMyYWNOR2NoNWdrL0o4NWprcWMvNmtwVGpN?=
 =?utf-8?B?UWFlTVl3N0VQN1NvSE9XUVVGbmVtb3R2RWxjQ25HM24xeHBzNEx3TGg5R3Zs?=
 =?utf-8?B?VjhoYXVzenNzME5kekNPSksyQmhnUXFRbkprSmdMZk1HUnUrazlSVTQyM2Vl?=
 =?utf-8?B?dkJTeUJFWWtQbWlqTzFUdzA3bUxuK0gyVE05bGQ0cHBHR0prMVBsSVlyZHRB?=
 =?utf-8?B?eEk5NXJ3U3Yza1RhNm9lVGpHYTNHM0FhbDViUi9JN0FrbzFxcVZ2Wnd3dmR0?=
 =?utf-8?B?UllFVlJ1VHQ2RFZvYll5Q2Zmck15YWwwN25LWk5wOFUvUjhhcUJSenVHL09i?=
 =?utf-8?B?Zm1ySmtHeFhubFFNQ2Y1MmM2cnEvZ0o0VVRwWlRkVnBhalc1UTRCbVdGVVd1?=
 =?utf-8?B?NWQxd0xKa1dUNUNsbWtqbTEzdXY5V3cwdzFkQ3FHZjFEVkYvM1RjdHRRT0py?=
 =?utf-8?B?NDJFSytXY0JGT2ZBdWpPWXB1dmExVk1kVk8vRjFZVDRvZjNYakxWZUNBNUV4?=
 =?utf-8?B?MVpicXpneEQ0NWhZZkFudEJYNXN5d0xnZEQ3RlVCMFo4UU1nNm5HVm4xTXVO?=
 =?utf-8?B?Yi8wTFV5U2VPYmdaV0hFZHdPTVk2S01PWGdxaExISmtVWEdhMytTNG42WS81?=
 =?utf-8?B?UkJHempVR3lYWnRRQnVkbnhIa2JZS3dBQ1dvdDdsU1R3V2U0RnduSlNiNlhl?=
 =?utf-8?B?dHVOT0FIUEphb0QvMlc5dGM5dUZ4ZS9EaUF0MHdJUFZIdG5DV0xGUUI2c3FG?=
 =?utf-8?B?ZThUZjBaODdsdGxTNU8vR0xFVnN6UFk0N0p1SFZJT1h4Um9TdTlsWXdjTEVS?=
 =?utf-8?B?YUYvamRRdlBQTGdoR1hjeUg3QnhnbVAyS0RlZU9oTDhkUlFUTkVsWEtTNWM0?=
 =?utf-8?B?ZHBGZ09HZHhpR3p4YWxPUkJyTVpJUjFvT1ZWNVpPTzlXUVNXcWU2MHFTcVNL?=
 =?utf-8?B?ME1wSVp6alFvcmJYWmtRZ1BEMjJ4VUxSWGdQaXYzSHBjdUNuWWZDNVhraHB2?=
 =?utf-8?B?UFM1ek5ESGkvYm5UNFNoUEVKenZVbm5sNUs2Qy9zb0tka2I3T0VRNUY0SG5i?=
 =?utf-8?B?VGJ3K1JkRkpkYUdoN0NodVErT3ZheHlNRGJwOEozVThQaXN1c0pEQ0FyTTVq?=
 =?utf-8?B?ZHhTL3JUMjgxa2FXMzRhTHdEL2M2UkYrVi9DYm1mYklOSnRuSmx3c1ptNThE?=
 =?utf-8?B?RUZHczFFUFlSV3RjTlFOdmdLYURnNUxmUWs2TXRvRmlZL3lveE94bjZpS05D?=
 =?utf-8?B?R3FQbmpCN1psODlNVHVvelBtdjdGbksvTTlSak53Q0hvZXo1bVQwd2lQSlp4?=
 =?utf-8?B?Q3hYdEpZV0xYK3lJaW1rb2ltRkpOQXdzemNrSStJVUNLbkFsTFQ0WExkU2xK?=
 =?utf-8?B?dy91YjV0NU1XalN5SGRzSmlJcTArbGZUZDE4ZHV3QzRQMVVNemxUWkFTa3Fp?=
 =?utf-8?B?cTg1eGI3U2ZHaCtUN05VVnVBOVlPNVBqaFlMY3BKSnF1RjdvTWl6aWxjUWJz?=
 =?utf-8?B?cXJadllNaVZFU0pjbFN4UVhZRTVZWTFBa2FRVFhlbkpYSmpUSmNCaHovYW5N?=
 =?utf-8?B?Yjkrb3Y1a0o5eTlrVHlaZ0pIc05xaEowdmJwaVhzMEhvM2lFYmdPQVlwOExr?=
 =?utf-8?B?d0ZRRmNGVnFvMUREVWhpV3ZyUTd4cVV3dWwwWS9sMGFZbE5KY0FkcU5KbmRp?=
 =?utf-8?B?K09XbUQ2Ykx1amZLMldLNlpzMkNWUlVBNUI5UEtoZzVTN3h4S0xVZEJSTEpU?=
 =?utf-8?B?elhrdS9HNVdTSkltb3RvcXhBck53Mnl0Q09kNzZjZklXR3lHZENTL3JBMWo4?=
 =?utf-8?B?aklIUGZ2TjFreU1adWFCOVp6YXFIWldqL1VCaVU1cVNPVmFYeGxYZmVZemQx?=
 =?utf-8?B?QnAyOFg1WE5tYXpKUFQ0QmMzdFR1R2tBOVRKNTVWTEFDODZlR1l1cjBnVFVL?=
 =?utf-8?B?ZWY5THRvdGg5ZDdiMElIZmo0cmx3TWtlcmpjM0N5RU1jQ0VYOCt3SU84a3Y2?=
 =?utf-8?B?LzZtVW9tM1NtWnRSZ0NkOTA5aGZDaHJXUEJxYlVoTGpHT3pHOFZ0dz09?=
X-Exchange-RoutingPolicyChecked: Y6PgKE5sRkpLAHqJzHsKkRDrDNJUKUE4WjVj7aP9Ybf31gxMB/Pdab0OAVmLGezCSTvTziVcFmVwsUvN3KftjQO8B7/TSsj6X7oDN087m7rECFXV/glHYXwKWVeNO3NI9hV5O8fghoLp0Jo74mslsu4nvicrhASGdp50hZwumT+bpY0lXANjP4mMrzsCv34+LnuhZHwWW5AHjyJIpdpKoR+ewisfEVBwCjBy+nIdn3w5SEIs0n5GahHV8OZRP7WIIhuR5ATBUCrKPhn7OtBOAp7wu+RJrU0jzXUhy56iyhkogirJpLGvp1MXxF7LIBubCI/vszEUim5mTKIltv8ydQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03eba2be-eadd-44b2-0b2d-08deac43df5e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:21:04.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BObgDw2iLjIqKStGlt/KdWDY3F/CsH2c6sU4fJR+jGvUAPktLuXMqcdjPpg8fhhiDDW8mOj+LSvGXhasN8P5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFA3FE8A23F
X-OriginatorOrg: intel.com

On 5/7/2026 5:55 PM, Qais Yousef wrote:
> On 05/06/26 13:38, Tim Chen wrote:
>> On Mon, 2026-05-04 at 02:59 +0100, Qais Yousef wrote:

[ ... ]

> The idea is that the cookie is per QOS per process. So QOS_TYPE_A would have
> its unique cookie range, and QOS_TYPE_B would have its independent unique
> cookie range. To allow flexibility and extensibilty to describe independent
> behavior that requires independent grouping.
> 

 From a user point of view, I can think of the following use cases for 
fine-grained
cache-aware scheduling:

u1. A user wants to enable or disable cache-aware scheduling for all
     threads of a process. (No extra tagging is needed.)
u2. A user wants to enable or disable cache-aware scheduling for all
     tasks within a cgroup. (No extra tagging is needed.) Vern from
     Tencent was advocating for this model.
u3. A user wants to enable or disable cache-aware scheduling for an
     arbitrary set of tasks. (Userspace tagging is required.)

If I understand correctly, u3 is exactly the use case where schedqos
cookie can help. Under your design, we cannot tag an arbitrary set of
tasks with the same cookie; we are only allowed to assign the same cookie
to threads within the same process and under the same QoS type. So
this might eliminate the case where different processes share data
with each other that we want to aggregate(NUMA balancing's numa_group
is an indicator of tasks sharing data)

>>
>> We probably need a sched_qos_cookie structure defined analogous to
>> the sched_core_cookie to anchor the tasks.  And sched_qos_cookie could be a ptr value
>> to sched_qos_cookie, as in sched_core_cookie instead of it being a __u32
>> as in the patch below.
> 
> As part of the API or internal implementation detail? I think we do need
> a cookie structure that stores the sched_qos_type and sched_qos_cookie tuple
> internally as implementation detail. But not expose it as an interface.
> 

Yes, I think Tim was referring to the internal implementation. We need
a pointer to link tasks to their shared sched_qos_cookie.

> I think the cookie values should be userspace managed. From experience, this
> has to be done in a centralized way via a service otherwise you'd end up with
> a mess. There has to be an all knowledgeable entity managing things, which is
> what I am proposing in schedqos service. That's why the whole QOS now is
> protected with CAP_NICE capability - which I forgot to mention this change from
> v1.
> 

Not sure why we do not leverage the OS to allocate and manage cookies.
The OS has full visibility of system-wide information and can maintain 
globally
unique cookies. Users only need to request the OS to allocate, attach, 
or detach
tasks to an existing group without supplying an explicit cookie value.
One possible reason I can think of: since the schedqos cookie is defined 
per QoS
type and per process,it may be more convenient to manage it entirely 
within the
schedqos service？

thanks,
Chenyu
