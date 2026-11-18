Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007149;
	b=GVT8/Px6TlGiiiJZ/MQvMMBSCWyztCY9cD4kyaY+OcK9b+FGYQ37uqWOIUfTEVqKvamM
	 XVmh/6rhQFR0J2OswJSQ03HlwcZq/bkiqamtY/cHYQk9axH5Alb5KtB0qp5dNnARs171B
	 oGBuILoTAm+lR1170KwE1ip/gRwx7STOwysFYIY8tourySDUCtZBPd4nslJvG7ggN1Ouj
	 yAHjSHqVlYEewduGXSLPR1Q6qEy1EGsyzziLCIkiHg8SJE/1RKvj5/RY/nxjUxmg8X0tv
	 tOn2dBr6nYfuX79rMW5NhGZvuyIInMigIwzlbKSex/Oe+lc4m3hdRbMho2v0ruGy1eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007149;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=+oe3fVl8HngIUZw94yK6xCDWatO9+i6y5nSrlW7nvxo=;
	b=0x/FNQTyulsbxa1MuLQYK0syyGRDOalAhpeRFtYGGmnveCh+SAjWkQQrH67m9kddAWDO
	 P9mNgF/xTH/qILwEtT9MetESIXgckWjkd81TJbmAymurjebgcprOyqrsmRfipBa6h1FgE
	 J492H9N2nzpD3xCGb1YwJl101tWR9KonTyKszqjxHzau0IM/1CbCRSLaXIkHyP9Oi37AD
	 7HfE19QI+0Ko+tGz0k8Z1sxptEqX5JVzl7nbrxD/7hC3CaPn2dScg7XJDPC0zunqTUai+
	 uAwT3RLu4Gw05XJNTAxk8UrjLct/teUFVMCapcDsslVOcuVdM9jcZpRtfccs5Ieskew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+jAqwED;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=SgLl0STL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0860A380B
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E0860A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+jAqwED;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=SgLl0STL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795007148; x=1826543148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YtvNc+PM6e9ZMRA0f1nUR3pFzlp1sp175Ybi1ieqVpo=;
  b=F+jAqwEDZajR42YlOHFNcYq7QPsK/P1RPUSOWMZFfwyHQOeft5Ic5gQk
   BmoCUpBU+wELEQ3OnikvM0D1cZ5XObpTOUQco0xpZlq4Qc7Wwc6aWRq4L
   3VgIxLK1g8Mw7J/yb+uqBpFnCiTSMdtQ3oTNI0cq0Hk+aE13bm+jFm693
   Nq7WPl2MvB/uzLO5IBh/xnLpT5/EqNqNQ2Ca9asyUHA2kjnqzL8p1h/CW
   UUqn8H7XdM8mIhq2rqPy+IWMprLC7V8PqkjdKV8CQgaiwbgtGGBV0w67L
   NmiJr18cR10YrQkHL/dOQ5tR4T6fvISxtnvhMpu/GxuJ/Z4wWzaIgIVJK
   A==;
X-CSE-ConnectionGUID: UYgVTOTIR2SBYSCD0pp1Qw==
X-CSE-MsgGUID: fw8D9+wsTxyp8ohUzDaCrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3736504"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3736504"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:05:47 -0800
X-CSE-ConnectionGUID: AlIvqCyhRBSQoejvJ2QIcQ==
X-CSE-MsgGUID: 3V7OqGIQSdenOtZ1KzfySQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="12071438"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 05:05:47 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 05:05:47 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 05:05:47 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 05:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBdcSxw5Fq+twGnbTFnJ1JQL9FQL7v7bQ4qflxp4scZSImgFzpDMjA0g+nZ5BlPkTM92tcKKVEdx7+1rHjKNwfsvJODmHo3dVYl1vXkFkH9VD2AGjvU0FuzUsQMuPc6L9uFkXnbtURmFF6pC+6sbHyNafjc/ThBhPPBeUT1NHHHUE7GNRo7eZr/oKL4y7onVWP5r4SsQzeQ5LutXeD/Opu3zaxdv2jKeqoVAvAQYLga9lWQhcupDBlYhkkncxhNwKnh3o3J7dSPUtsYbD+j8cisrrJigxr3UqM4JjAXDid4YABYMkfH3UR7E1rfoy8JIcgvuXMxVXqp55DRC3l+cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oe3fVl8HngIUZw94yK6xCDWatO9+i6y5nSrlW7nvxo=;
 b=ZiBHUdvXIwyl7uf97W6uNnaaXO6Z0h5eTrPg8XnfSZfblNSTAmS5sVtplphZ59HE2nr97ozKtAFljKYBEDOx4vo8yLjFXuZ798hXyCHIbMubHdXR6+Qb3p2df5TG034jTqY3BK/dNGzbxS7N+T4BBXn6KQmEtGd5YYfkFRLdJUEpy4UybU88dx9/8pYaUw7hljh8jNZpoCYLW7TGZqXlymxCsedZweCR5tYLTxJAK36F/bqx6HiWcwRC6pEzDDfgVbAyCAQoVt0qzcA0YGwbY4m3ZoQZ+Gn34dAsN4Xa7kUtfvPxl+hBuh3aPRAumq6AdN+yVvM4u+I/1x1MOWxnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oe3fVl8HngIUZw94yK6xCDWatO9+i6y5nSrlW7nvxo=;
 b=SgLl0STLPLZDU1RK6C0zVvxRNhjvk7+l+2wcBXhhB0efb3tZBN/78ipRHF6issm8nWMG5DmOfPNS/kScyfx7U33PSe+lzgrGiW4xWvPC/kOGOHkE9jDm4P5W+zQKozqdPu4z/6wm8pT3eguh7DfvLlHJTZHhVcA6i76Tmtvaup8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by MW4PR11MB6812.namprd11.prod.outlook.com
 (2603:10b6:303:1ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:03:32 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:03:29 +0000
Message-ID: <efcb1647-46fd-442a-bbda-283560d9df53@intel.com>
Date: Wed, 18 Nov 2026 18:33:11 +0530
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION: [PATCH v2 1/3] cpufreq: Improve suspend-resume
 synchronization
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, Christian Loehle
	<christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, Zak
	<zakbrightonknight@gmail.com>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mario Limonciello
	<superm1@kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, <ravitejax.veesam@intel.com>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
 <4796894.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <4796894.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0277.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::18) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|MW4PR11MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: c2287d40-ab04-4dca-99f9-08df45745711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|261021121427099003|261102130727099003|261102123227099003|261021123027099003|261009223027099003|261009221227099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kWtSNB7GNCd/BqyfIrMKeKlGf4ZJUkiSCnq40GgNxinu7lqHtwXkGzIRrGiUvgx8YmUC5Yh5nYjDEnJ1KYy1YWG+4BwLUEyNjtgg8V2tIAIesvsChGVk0AVTGiuV85kAcParFLJ6e/syHZp1u3fFdq1a4sOHTEw5r/cy85lwPCztokV7R19DVOXEgPl63NG11W9sH/Sv/dQ7SwHcT8w6WejphLbAamp+YoRrV9bn/fsax6gNAswOqIpWsP+hpnu4DPqKhCYnnxJf3kV+6kSQYGMptTBe3AmU/N7XX9a5sTlW5LMbYoUo6tOWO4QLkwa9uORZXw099Ccmw3Zwe8WqlarwoiFBbaCezwI936KyAtLKmnxhwBNPeVrit7Tyxze2qC/iUYT474OAb5Xuzn6xavHYO82owncfh7L4hAAolC2Cl1mtBUHpLYwHvqIqeUZgfJiZ3Ryk+PFdTulzaQsHrigxmhWuRM6ekPfCj2mk6QS6I9FuVBP33SkPI84xd1ojLe5FDlT5U6M2dDXE7yhplXFmWOsLrSx69ZEOF0OYt4Ed82ByeccRHGiyEfj8VcNSup6iRqFSUfZYJ2GacShIz3e5GlOavvsSMqC52Jk8et7BBDRWz0hsHRQ9maAuO4ga
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR11MB357627.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(261021121427099003)(261102130727099003)(261102123227099003)(261021123027099003)(261009223027099003)(261009221227099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJQeE5zUkdRbEhUNGtrRCtkNC9vYjJGSlQwM21JYWxIMXkwam9WazZtRlFV?=
 =?utf-8?B?emIxa240SkxUV0pXTzN6WTVzZGR3TkhaU2VKeXhwMnNNSGttNG9KMk9EY09I?=
 =?utf-8?B?Si80SXc5cFhCWktHc2tRaXVrdmZCVXpqaVdnREJZcUpGOFV4Um52VnMvQUlJ?=
 =?utf-8?B?NDAvc0E1Uk1iKzkxM2RtVDlYV0tja1hLNUQ1QkxPUjN1bVRjcUl1aHpDcEJZ?=
 =?utf-8?B?OGVUVTRPcUNoTFJQamQ2Z2l5M0NWZkk2bVV6djJkNk42WEFTMEZXYmRvcWl5?=
 =?utf-8?B?SUhYZXpYQTloTkFuOXNBN1M4S1VwQVZ3dnBkaHl0WDVzT3hVbG5SQ2J4QnNS?=
 =?utf-8?B?YXVrZnZyODZJdmpTNFVvS2hLRDV6V0wyQTNIbXFydmVZUzRwcmY2bXdZWTcx?=
 =?utf-8?B?VzZzM2IrYXJqWGF3NTl6UVpyS2pvV0VsSUVDUE1YVjJXY0toSUxpdTQ5MGcv?=
 =?utf-8?B?WkRJeVk2bkphbEdoL0RXRGZ6UFNVVE1qRzZ3dkF3WjdhYTdNS0hBNW5CaXAr?=
 =?utf-8?B?OTA0UmhkeHo2WkJ1cnBvcmNSSWJyS0wzcmpDcjdrVWZOaDlpbjFhQkNFQXV0?=
 =?utf-8?B?VklFdEp4WWowSWU5NThWOU1tKys4b01iSENHYWJPaFZITzZBVEFOeXhNdFkr?=
 =?utf-8?B?UWh2MHl1UnlFTDA3QUdDQURaaldHb3BRRUMveVo5aDBpWlF6ZHRIWlh0VTVy?=
 =?utf-8?B?b2wzTUFqcUZ4NDIvbGVNUVg2VE5pQkF4dHZmdVVKZ1ZxS2lBZk54SVExNkdC?=
 =?utf-8?B?NFBxN0p4c3kvTGMzM2VrOHlPM2tBMmdIdVNLYWg5Q1pNMDdwV1dOVXV4VVZU?=
 =?utf-8?B?SU44OUpSTXdRZUZLNFNMYml0bXZ3OXRYVGp2d3dIb0ZwckRMK0FFUjQ3SWJM?=
 =?utf-8?B?aDNRcnM1d0lOeHZTOUZCUmFvUVNKYzNSUmsrYkpmcGlmN1lqNTVZK0ZteGdJ?=
 =?utf-8?B?SHVwSEtSZm0rNVV4ZnEwaVZCNjZlL1hKaWtSK2oxcDRkaVE0cit5RVhPd2hu?=
 =?utf-8?B?Ykk3b0N5U1F2SlEya1MvSGxDMXh6VGdZamg0Smxidk9RbTVoK1hYcTNhRFJp?=
 =?utf-8?B?eVI5L3c4Q3BKMDR4U3M5TWp3VXBtYVBIdFV6QkhzQ3BaYnB1YU1KVmkvaUtC?=
 =?utf-8?B?TFljWi9JeVNhR0l1YllDMjJTRGxwR0UrNVh4dFJFV3BWKzRhWXNQSWZSd1hC?=
 =?utf-8?B?UDBVSVEwTUhhTUp1MnBVcnRkaFNIZndkUlh1RHJnMGkxRjF3WWZGWWJmZDdi?=
 =?utf-8?B?ZGxLMWVRbFZ4d2RTZkJJZ3ZJM01tS1BvRG1pWnpFeGsyUkpBOXR2dDQ4M1ZH?=
 =?utf-8?B?ZS94Yjc4bXdEQmFTV0ducjJWb29iNG1kV2JkbVMrcGdhcGN3UEFXaDRGL2VT?=
 =?utf-8?B?MHp4eWhmVVAxQ0NrbFRLZlcxNGgrYzZXNkVBYlVEc1p2V1NCY2hQVzZYeEV4?=
 =?utf-8?B?KzhJdkc5Z2FYOU5zTmJtL3Y5cWg1UnpkbFRYM0svUEUvUU9haEk2Wng2UmRD?=
 =?utf-8?B?VVdGWUtuc0pPY2t4a3NlZEhoL245bEgvRWcxKzk2cURXeDNLd2FrSWd4L21x?=
 =?utf-8?B?bVBOR1ZJRUVlVUdMQVlRTkVFc0dRZFU3L25NWU9wL0dtVDA1anBlbTlEYzJo?=
 =?utf-8?B?QTcrb2p3R3Nzd1ZDbDgvYWZnMzlUTjVjU255bDNlTEFKU3dXMXlzTGhvSmpC?=
 =?utf-8?B?WE5WUTI1Tkh6Sm1LUVhWbG84NjBjajVXMGh0ZUhSRmFKM1liS0pyZXUwbFA5?=
 =?utf-8?B?bWRGTUgwVDcvTGNkN2RXeWhMRGR6eTRPa29CSldYNmJaaFVFR0tmcVNKaDR0?=
 =?utf-8?B?TVF3UHNrZnJBZlF5RVRxWXgzOFVQV0crNmZZaHp5cEF6aEdkQVMyY0YrNnd6?=
 =?utf-8?B?bHd4Z0h5Y3h5MUJQUFhTZjFNL0JKTGlOMGdISFJncklwSnlzVW02R29HZFhB?=
 =?utf-8?B?UHlkNk9lZlQ2cmRKV250MDRZVC9ZcHNwSmh2V3ArZ2NiZ3JXVWlhaktWN3J1?=
 =?utf-8?B?TWMwVTFDdXRraVVMUXVYS2lDUEIzd05zd3hRY2JXblU1em9VUVhtUGRJdmVB?=
 =?utf-8?B?NzBSWmZYaHhEcWlIb3p4dmUzOHRWbU1XNTJHZlNFUVIrSTlQN3Fzb01jNGFs?=
 =?utf-8?B?ZWRPWkI4UEIwVk51YTloc3ZFeGw2UnVlcTN1c3puRFdYOFNWb0N1L3dyZ3d2?=
 =?utf-8?B?MDhWWGJkaUlwRzUwUFQrdDk4NHczbkZ5N1EwMW9jMFdrVnB6TU5tTGFSTGUy?=
 =?utf-8?B?M0VCVDJPRmtzdnhVZkg2T3dyMkhNYlVzTENFcU0yMUxQOUIxQ3dBSDdtaSsr?=
 =?utf-8?B?MU9hSlZ4MFFYTVg2NjIxOWY3Z285RjlWRk9aR1g4RlJMYi9qS093Y0t6clFI?=
 =?utf-8?Q?onO7k2zVwIuIcU9c=3D?=
X-Exchange-RoutingPolicyChecked: UFNee5JuKB7/+J5Fl+RhduR1fKOCXkUO9+N5UlMJHgtCmR49WPq9YOmJRloahhjsMpSaxPI9PfRP6eE/1/sO1t09IpGH+V5+UOtyesGnctMRnl6dnUp27lWwZ78eCE+KjuYABZ70WgQbnVvMcYUZzRfvAEfBrkXmknExj4Uz14zR1squq4EZ2kLlh/IJIecqARW55UyPe+IpeiW8dnCvkUzGWKDalSit0B+0M4CDy9TpQayUby/kfAnu/1QVI3oCIxw0ww2ENsax3mWNQN3qx/PB1lRdVouVJmeFaNUJJt9wXQaULEiW/fDyQvoaLc7MQoXYdEFZRd5lLBE769uAxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2287d40-ab04-4dca-99f9-08df45745711
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:03:29.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5fHRZIhHKWPmECciVafTViSGdRd+HmZO6nOEVuYx9hIlVD2D8N7jtRqakVMCpGarhepIul8jgTKjuIRTsj0PpQjsmCEkKOoFVXQuqqJAA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6812
X-OriginatorOrg: intel.com


Hello Rafael,

On 11/4/2026 1:15 AM, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The suspend-resume synchronization in the cpufreq core is not perfect
> because the global cpufreq_suspended variable is set at the end of
> cpufreq_suspend() after stopping governors for all of the active
> policies, so the governor .limits() callback may run via
> cpufreq_governor_limits() after stopping the governor and before
> setting cpufreq_suspended which is questionable.  Likewise, the
> governor .limits() callback may run between clearing cpufreq_suspended
> in cpufreq_resume() and starting the governor.
> 
> Address this by adding a per-policy "suspended" flag that is always
> read under the policy rwsem and is updated under it when the governor
> is stopped in cpufreq_suspend() and when the governor is restarted in
> cpufreq_resume().
> 
> Also make cpufreq_resume() use the cpus_read_lock guard to reflect
> what is done in cpufreq_suspend() and call cpufreq_exit_governor() for
> policies that were suspended during a system suspend transition and
> are inactive during the subsequent system resume (to avoid leaking an
> inactive policy with a stopped governor that has not exited yet).
> 

This seems to be causing regression in our CI [1] (affecting dg1 and 
dg2). We could not revert the patch cleanly but resetting to its parent 
heals the issue.

<4> [510.751891] ======================================================
<4> [510.751907] WARNING: possible circular locking dependency detected
<4> [510.751925] 7.4.0-rc3-CI_DRM_19546-gfb078d17b966+ #1 Tainted: G S 
U       L
<4> [510.751946] ------------------------------------------------------
<4> [510.751962] rtcwake/4256 is trying to acquire lock:
<4> [510.751977] ffffffff83ce0f40 
(intel_pstate_driver_lock){+.+.}-{3:3}, at: set_power_ctl_ee_state+0x1a/0x90
<4> [510.752022]
but task is already holding lock:
<4> [510.752038] ffffffff83886890 (cpu_hotplug_lock){++++}-{0:0}, at: 
cpufreq_resume+0x23/0x250
<4> [510.752074]
which lock already depends on the new lock.
<4> [510.752094]
the existing dependency chain (in reverse order) is:
<4> [510.752112]
-> #1 (cpu_hotplug_lock){++++}-{0:0}:
<4> [510.752137]        cpus_read_lock+0x3c/0x100
<4> [510.752157]        cpufreq_register_driver+0xca/0x380
<4> [510.752175]        intel_pstate_register_driver+0x9e/0x1d0
<4> [510.752192]        intel_pstate_init+0x3e3/0xb30
<4> [510.752211]        do_one_initcall+0x59/0x3d0
<4> [510.752229]        kernel_init_freeable+0x3dc/0x6b0
<4> [510.752249]        kernel_init+0x20/0x210
<4> [510.752264]        ret_from_fork+0x3bf/0x470
<4> [510.752282]        ret_from_fork_asm+0x1a/0x30
<4> [510.752299]
-> #0 (intel_pstate_driver_lock){+.+.}-{3:3}:
<4> [510.752325]        __lock_acquire+0x1700/0x29c0
<4> [510.752341]        lock_acquire+0xd9/0x2f0
<4> [510.752355]        __mutex_lock+0xae/0x1030
<4> [510.752372]        mutex_lock_nested+0x1b/0x30
<4> [510.752390]        set_power_ctl_ee_state+0x1a/0x90
<4> [510.752409]        intel_pstate_resume+0x109/0x110
<4> [510.752428]        cpufreq_resume+0x153/0x250
<4> [510.752445]        dpm_resume+0x1f1/0x390
<4> [510.752459]        dpm_resume_end+0x11/0x30
<4> [510.752474]        suspend_devices_and_enter+0x372/0xcb0
<4> [510.752491]        pm_suspend+0x372/0x840
<4> [510.752506]        state_store+0x6e/0xe0
<4> [510.752523]        kobj_attr_store+0x12/0x40
<4> [510.752541]        sysfs_kf_write+0x4d/0x80
<4> [510.752559]        kernfs_fop_write_iter+0x193/0x240
<4> [510.752576]        vfs_write+0x285/0x530
<4> [510.752591]        ksys_write+0x6f/0xf0
<4> [510.752606]        __x64_sys_write+0x19/0x30
<4> [510.752622]        x64_sys_call+0x1285/0x27e0
<4> [510.752637]        do_syscall_64+0xec/0x680
<4> [510.752654]        entry_SYSCALL_64_after_hwframe+0x76/0x7e

Could you please check why the patch causes this regression and provide
a fix if necessary?

Regards
Chaitanya

[1] 
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_19546/shard-dg1-14/igt@i915_suspend@basic-s2idle-without-i915.html

--Bisect Logs--
git bisect start
# status: waiting for both good and bad commits
# bad: [cfe67bbcfc37474cbb4482d750d4fba34bbc5a24] drm-tip: 
2026y-11m-17d-05h-12m-00s UTC integration manifest
git bisect bad cfe67bbcfc37474cbb4482d750d4fba34bbc5a24
# status: waiting for good commit(s), bad commit known
# good: [39e407b553ec15d4a233b651531ad431ed7542be] drm/sun4i: dw-hdmi: 
Deinit PHY in bind error path
git bisect good 39e407b553ec15d4a233b651531ad431ed7542be
# bad: [715f145f6204363a50853eb15719dc860db0bc01] drm/i915/dsb: Realign 
GOSUB only for QW slots 6 and 7
git bisect bad 715f145f6204363a50853eb15719dc860db0bc01
# bad: [7e1392a42ea288d70a266f6553fe06f57f8647ea] Merge tag 
'net-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad 7e1392a42ea288d70a266f6553fe06f57f8647ea
# good: [0359338fd8cf1a2dc001d0cd69c331c17decee88] af_unix: Inherit 
SO_INQ in unix_stream_connect()
git bisect good 0359338fd8cf1a2dc001d0cd69c331c17decee88
# good: [79eb6679ef6a0d5ea68da53a8321fb1dc72299b9] Merge tag 
'loongarch-fixes-7.4-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
git bisect good 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
# bad: [baa6744dc939a927e2c94e5f20aff01ac538aef1] Merge tag 
'acpi-7.4-rc3' of 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad baa6744dc939a927e2c94e5f20aff01ac538aef1
# good: [2cca8a6f6ae690755862f5b633125119dcf6bd0c] Merge patch series 
"ns: fixes identifier fixes"
git bisect good 2cca8a6f6ae690755862f5b633125119dcf6bd0c
# bad: [df42809bd599109660bd3f95e2e22330c80993df] Merge branches 
'pm-cpufreq' and 'pm-runtime'
git bisect bad df42809bd599109660bd3f95e2e22330c80993df
# bad: [6bc092a0fc4d331a4adbbb664078af149c580834] cpufreq: acpi-cpufreq: 
fix P-state index mismatch in extract_io()
git bisect bad 6bc092a0fc4d331a4adbbb664078af149c580834
# bad: [02e77af824d5be3a94fdd885835a352f90d24c5c] cpufreq: intel_pstate: 
Clear last written P-state value on suspend
git bisect bad 02e77af824d5be3a94fdd885835a352f90d24c5c
# bad: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq: Improve 
suspend-resume synchronization
git bisect bad eee2a44e4e2b41c0699919a550d41cc38daa4f42
# good: [e6f50e602e373583423654ec000cad8b8d08f7bc] cpufreq: Hold the 
policy write lock when changing boost state
git bisect good e6f50e602e373583423654ec000cad8b8d08f7bc
# first bad commit: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq: 
Improve suspend-resume synchronization

> Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate")
> Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stopping governors")
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2:
>     * Retain all of the cpufreq_suspended checks to avoid carrying out
>       governor operations after suspending cpufreq during system
>       shutdown and during hibernation resume on systems with SMT (Sashiko)
> 
>     * Rearrange cpufreq_resume() to walk all cpufreq policies and call
>       cpufreq_resume_policy() for all of them
> 
>     * Call cpufreq_exit_governor() in cpufreq_resume_policy() for
>       policies that were suspended during a system suspend transition and
>       are inactive during the subsequent system resume (Sashiko)
> 
>     * Update cpufreq_suspended under cpus_read_lock in cpufreq_resume()
>       for more symmetry with cpufreq_suspend()
> 
>     * Update changelog
> 
> ---
>   drivers/cpufreq/cpufreq.c |   86 +++++++++++++++++++++++++++++++++-------------
>   include/linux/cpufreq.h   |    3 +
>   2 files changed, 66 insertions(+), 23 deletions(-)
> 
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -35,6 +35,9 @@
>   static LIST_HEAD(cpufreq_policy_list);
>   
>   /* Macros to iterate over CPU policies */
> +#define for_each_policy(__policy)	\
> +	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
> +
>   #define for_each_suitable_policy(__policy, __active)			 \
>   	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
>   		if ((__active) == !policy_is_inactive(__policy))
> @@ -1956,6 +1959,14 @@ int cpufreq_generic_suspend(struct cpufr
>   }
>   EXPORT_SYMBOL(cpufreq_generic_suspend);
>   
> +static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
> +{
> +	guard(cpufreq_policy_write)(policy);
> +
> +	cpufreq_stop_governor(policy);
> +	policy->suspended = true;
> +}
> +
>   /**
>    * cpufreq_suspend() - Suspend CPUFreq governors.
>    *
> @@ -1978,11 +1989,8 @@ void cpufreq_suspend(void)
>   	pr_debug("%s: Suspending Governors\n", __func__);
>   
>   	for_each_active_policy(policy) {
> -		if (has_target()) {
> -			scoped_guard(cpufreq_policy_write, policy) {
> -				cpufreq_stop_governor(policy);
> -			}
> -		}
> +		if (has_target())
> +			cpufreq_suspend_policy(policy);
>   
>   		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
>   			pr_err("%s: Failed to suspend driver: %s\n", __func__,
> @@ -1994,6 +2002,32 @@ suspend:
>   	cpus_read_unlock();
>   }
>   
> +static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
> +{
> +	guard(cpufreq_policy_write)(policy);
> +
> +	if (!policy->suspended)
> +		return;
> +
> +	policy->suspended = false;
> +
> +	if (policy_is_inactive(policy)) {
> +		/*
> +		 * The policy was active when it was suspended, so its governor
> +		 * is still there.  Let the governor go.
> +		 */
> +		cpufreq_exit_governor(policy);
> +		return;
> +	}
> +
> +	if (!start)
> +		return;
> +
> +	if (cpufreq_start_governor(policy))
> +		pr_err("%s: Failed to start governor for CPU%u's policy\n",
> +		       __func__, policy->cpu);
> +}
> +
>   /**
>    * cpufreq_resume() - Resume CPUFreq governors.
>    *
> @@ -2003,11 +2037,12 @@ suspend:
>   void cpufreq_resume(void)
>   {
>   	struct cpufreq_policy *policy;
> -	int ret;
>   
>   	if (!cpufreq_driver)
>   		return;
>   
> +	guard(cpus_read_lock)();
> +
>   	if (unlikely(!cpufreq_suspended))
>   		return;
>   
> @@ -2018,19 +2053,18 @@ void cpufreq_resume(void)
>   
>   	pr_debug("%s: Resuming Governors\n", __func__);
>   
> -	for_each_active_policy(policy) {
> -		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
> -			pr_err("%s: Failed to resume driver: %s\n", __func__,
> -				cpufreq_driver->name);
> -		} else if (has_target()) {
> -			scoped_guard(cpufreq_policy_write, policy) {
> -				ret = cpufreq_start_governor(policy);
> -			}
> +	for_each_policy(policy) {
> +		int ret = 0;
>   
> +		if (cpufreq_driver->resume && !policy_is_inactive(policy)) {
> +			ret = cpufreq_driver->resume(policy);
>   			if (ret)
> -				pr_err("%s: Failed to start governor for CPU%u's policy\n",
> -				       __func__, policy->cpu);
> +				pr_err("%s: Failed to resume driver: %s\n", __func__,
> +				       cpufreq_driver->name);
>   		}
> +
> +		if (has_target())
> +			cpufreq_resume_policy(policy, ret == 0);
>   	}
>   }
>   
> @@ -2412,12 +2446,17 @@ __weak struct cpufreq_governor *cpufreq_
>   	return NULL;
>   }
>   
> +static bool cpufreq_is_suspended(struct cpufreq_policy *policy)
> +{
> +	return cpufreq_suspended || policy->suspended;
> +}
> +
>   static int cpufreq_init_governor(struct cpufreq_policy *policy)
>   {
>   	int ret;
>   
> -	/* Don't start any governor operations if we are entering suspend */
> -	if (cpufreq_suspended)
> +	/* Don't start any governor operations for suspended policies. */
> +	if (cpufreq_is_suspended(policy))
>   		return 0;
>   	/*
>   	 * Governor might not be initiated here if ACPI _PPC changed
> @@ -2460,7 +2499,7 @@ static int cpufreq_init_governor(struct
>   
>   static void cpufreq_exit_governor(struct cpufreq_policy *policy)
>   {
> -	if (cpufreq_suspended || !policy->governor)
> +	if (cpufreq_is_suspended(policy) || !policy->governor)
>   		return;
>   
>   	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> @@ -2475,7 +2514,7 @@ int cpufreq_start_governor(struct cpufre
>   {
>   	int ret;
>   
> -	if (cpufreq_suspended)
> +	if (cpufreq_is_suspended(policy))
>   		return 0;
>   
>   	if (!policy->governor)
> @@ -2499,7 +2538,7 @@ int cpufreq_start_governor(struct cpufre
>   
>   void cpufreq_stop_governor(struct cpufreq_policy *policy)
>   {
> -	if (cpufreq_suspended || !policy->governor)
> +	if (cpufreq_is_suspended(policy) || !policy->governor)
>   		return;
>   
>   	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> @@ -2510,7 +2549,7 @@ void cpufreq_stop_governor(struct cpufre
>   
>   static void cpufreq_governor_limits(struct cpufreq_policy *policy)
>   {
> -	if (cpufreq_suspended || !policy->governor)
> +	if (cpufreq_is_suspended(policy) || !policy->governor)
>   		return;
>   
>   	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
> @@ -2747,7 +2786,8 @@ static void cpufreq_policy_refresh(struc
>   	 * -> ask driver for current freq and notify governors about a change
>   	 */
>   	if (cpufreq_driver->get && has_target() &&
> -	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
> +	    (cpufreq_is_suspended(policy) ||
> +	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
>   		return;
>   
>   	refresh_frequency_limits(policy);
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -149,6 +149,9 @@ struct cpufreq_policy {
>   	/* Pending policy->min/max update for the driver */
>   	bool			update_limits;
>   
> +	/* The policy has been suspended. */
> +	bool			suspended;
> +
>   	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>   	unsigned int cached_target_freq;
>   	unsigned int cached_resolved_idx;

