Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793636868;
	b=jUe79kJkekRW1Yx1m76JHvj2L3E7crW6bHRVIflTN8RYueFdpnGt5rWbfl/GdEc6ikA0
	 e+V9q5M8waevh5jGQs/LTOYwEAJRxGhRHDBwsrHsI4WQfgOTNi7rshudDuPcI8G7N62oL
	 CSbc31tavTCugMHo3khFz8UwxHJZucbpK+/BO5HZxBmHCQsY84Spfx7H/iROTVMrGEXRK
	 vlTCJ7sYnmhqX25quXCedS7s2o0+w66Pfl9DfGDlYIaonVwjXkxeS/ihyQ1BdUSnE3hg+
	 TeSlr+IXrhFDMOj+c2kVOAjDl5DhZGI/jJFKmCkOw6Ax+2tYiTHa0f7/kNi1uswXfbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636868;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=wJ2fvxZw0p+XRdKtTfYYKGeOCV8aVvOsUbzHs+v0LOo=;
	b=wk1dUJzbLKQOqfQWUE7HYkbmokq13x87/f5aF1WdbiYtO0G/TlrbjOK0J+CNPFWKwkFL
	 UcXgpzxu3va98LQY7jMjBCa+ilQ1miw3/glnWL36JzKYDNDkxhKGTH38N1XMhlhKJWvCD
	 37F4aqIbEjJ9V0ak4eP7vX/ssoQbZ5N6a0Zepq+1Gq541ff4MmiDMryk2EqOd79XWKQwo
	 EipO5k1GoX7Cf7N8y5ZFF/1XdAt3EabV9Fl1QEGlZV+xRytoUMFItX7XToWAQzTn7FKmb
	 HLHylDSAyb37pJexh9at5l0sOQtBysmjjnjw/a0jalUt3s3FD5+XzHjjuyOhZTP1jPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b3KY4vNI;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F6609EE4A;
	Mon,  2 Nov 2026 16:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8F6609EE4A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b3KY4vNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793636869; x=1825172869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mnVbN+KOlrhxDD+pH+3qkNwwsfu9dsWzOX1Lsh47Y4o=;
  b=b3KY4vNIelVYw0P+q+OQMcihEg7i2GpiW3qudnC4lCRXtFyp0DckrwLU
   NQgIzoz7klIgLPReqrdtUYp/tSQUUBRlv7bvENlEI8QFORiF3Xj0tO/UE
   bWtwrmOJ70Xsubpdj1vbvfvZzQLrycecgopLq2oY6WQj9orVS1gEUXQqY
   6KFG/Nhbb/0/nX3jMustBFxo6zdi2PwceFuXr7guueIdbNa8hBChay+/K
   2H9SMYmVznPuXaB/gieqqak4MfC5rtvBay+qfQlVeWtWV/lKw+l40Z6Nt
   13RQMHlSVB/pAltaS6Zvh3oH8BsK9zSa/etLwoXDQx1KuAp/MZpLvW90U
   g==;
X-CSE-ConnectionGUID: Hjffgn0+T3iy0AfMJMAbLQ==
X-CSE-MsgGUID: pZLcSBMGTVWgZJ2ZHfAYcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2236156"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2236156"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:27:47 -0800
X-CSE-ConnectionGUID: AGwILKGSRBOMttwhfW1+ew==
X-CSE-MsgGUID: PnSTsKfFSECMHZFWJzbajg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6287408"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:27:46 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:27:46 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 08:27:46 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 08:27:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFDPkI/OJe740twb/3r8ENzAYvGoirHIPEqwJ4FgdNjFo2y5wwcP7VMs7ZbyyGHY/QlnP2Zyq0aIZLmMY8LcpK7ZV2/FtZoUzGDHfQ0zF4almnycP/iIpckQbCFW+aec0+NEjaGRAIJ+g3gHcF0KVBfmO2/nVhsmcKjLFyzjA9qHRikqyHLSFB7yJswerODuf73IvecxAPUpnBu2LXwaTvMVjqG4R1ONLuhOOqOlCJdAWuecCg8xfnt+KtbXQ4iEq+9ir/jtuYKLbl96C/Ay9NuquVuaE1UCxt2EUIjvwl7eSUc7VUIhhOYW3rlYv11r1TGDMfld6SEQgrttY2ZSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ2fvxZw0p+XRdKtTfYYKGeOCV8aVvOsUbzHs+v0LOo=;
 b=gTtXiFOYXwL0Z2n8GeidgHwrEG7xtl6d4WQWzxZ7OV5WrK1fHtG9dH2PKeArt4ZePafEWYpcuPpowBM3gODjkMIA7lUXPZZg9+r2vfAvnttQpyB0svtHwtHL5a2eZLUshZ6di2+1zYhPrnu0g5JUz/+9Q1w464w2wyZiedDx6zkdnSfFyYLqaJ/5VK3e0AACmI148tYWG/vhaks9A+EFKV4vRkNC0ws3ycY7hNmUIfN7QiWJMC/QWfACG3V0Y9PYOjqkIAI0HShnFI1tOIg8MWPzASwjb4buwNZUvmmMBeui+gtv4FXUjpDfX8AAQldQ7KeRb1PDoLOCJ3GPGczEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB7165.namprd11.prod.outlook.com (2603:10b6:510:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:27:38 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 16:27:37 +0000
Message-ID: <a2108322-0c88-48e0-a10f-77ae2556bcae@intel.com>
Date: Mon, 2 Nov 2026 18:27:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf/x86/intel/pt: Stop tracing at syscore shutdown
To: Andi Kleen <ak@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	"Thomas Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Danilo
 Krummrich" <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jiayuan Chen <jiayuan.chen@linux.dev>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Frederic Weisbecker <frederic@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-4-adrian.hunter@intel.com> <aui3L0ppW-cBBo1W@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <aui3L0ppW-cBBo1W@tassilo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0276.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::11) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: e55942b6-f8f3-4452-ec8e-08df38fe354e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|11063799006|5023799004|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: 6UUKXeZbSAmQ/FYxY835aPdR3cIgiDA8deNf10Ibyoa+V5UUycrpVPuPP6osmRTZtH6pYBYz8MbPoduIifeL+0Dk9S1P2/IXTaSAUGfs1KzC44wZSgwsvD93QvrGJysGoC3qvgPC1gZJ/1hvMDWpFt0ws1MyWDF82AumAoRwLyxOu1pXxNTCIZeDHE5eD/8xU1sJLWNX05lrDeUdqQC+46PTeJn2fMZfayXCPVBVFhRoVMHKSsBfQx6p34xCwj0ygXlumAAD9axtdwycKqSpUfj7haQp/S3MKxiKH9lLMa9OMK+KBTwALWfVxNmn1K0w0OW7Y/ri/fr1WlseKgDNif0Fadkgvlb2LRc+1StzC2Ug/SrSgcqxkAXFl4uCovsw64RxeFBYEU0o5Q/rlt5u7cxna7pYBJFFCCgBmn06M0usCIjJ5btCeF4iGofoSLxJzhOapZxmCNjpt8gwhCezKvjVx8v6YFAduzPLfoQb0bXDbrXM/670wDCGIHckqc+IbrKtyZ9CCvMwkGVNjzOuMLEhBokqGEPQw0AtP/9OMpWPKzO4oytqommv6Jx/jVhb9eqlXtGCcP3iR0jsF5xhe1TICx8/NccQXy4841ozhX51fIrCajruNgChCMUh8k5FDR9vZqRlQY6HYc0aJ81AcBJHjG2yD/JA+PaJcF5WVX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(11063799006)(5023799004)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG12SThlQVRhZEtaKzBCc3lCUHRLNE5CMG9NVDRId0c4YSthSktUSk9UNnpr?=
 =?utf-8?B?YWNjL0doWFcvbGRKaXhKM0lLU2dvU1JBNTEvd2hjMjlKSmFTa0VvbEFBcDN1?=
 =?utf-8?B?OTEwajJ6TEtCMXhBT082ZDZ3OHlkY3pQOUFXK3pSckwrTWxkSzRLY2hpYzh5?=
 =?utf-8?B?QWhrblY5L0RzZ2J4UVJEUk5CSjgxaGJxV0tPM1I5N0FQU0pibXB5aW5CdW02?=
 =?utf-8?B?eXZ3WlRVTjg2VlZuTHhYMVgvQ3N4R0NJQ2Q5WStieFF3a2V4dW5FT01MeGpT?=
 =?utf-8?B?QVkzTnpzdHRtb1kxTkNrRnUwZU4xRGlZT1hkM2paSm9Jb0RvZ05CMHRMQThj?=
 =?utf-8?B?OEQzblA5L0VYSUUxS1dDZHVvczRqRERFSFBOWGNvZkpzWEYxRmtJK09zUmsx?=
 =?utf-8?B?Y1ZlanhzZXZmNGNYaFBYRjJLdWpuTHgwTE91UTd3d1I1YzBURkloV3RubHo1?=
 =?utf-8?B?aDdyNmJLZE5SZkRTVlF6YmFocUJNSk93N0p3eTJVblB1YnRFNUhMRldkTy8z?=
 =?utf-8?B?U2xyRC9tb0M2T3ZzZDdvQmkvTFJJbWpuZWRKZEphZGtLbEdUdDhJU2V6K2h5?=
 =?utf-8?B?NG1PT0laQk0rNnczZ0pZVnFxWk9xeWJSK2lMckJKcmxnL0tQNWYwUDJ6U09R?=
 =?utf-8?B?TzIzVDg1ak5kVXBoS0I2ejB4dVJPeHFES0xMcXZxQWFCRFo5TE4rMUNrUDNY?=
 =?utf-8?B?ZUJkRlFLYlVlLzdYamNWeUtpeXFXaHZxOFEwSDRqNWhQTGtqQklLc1h2N0xQ?=
 =?utf-8?B?dGpKYzVjUGVpRURIR0Z5OGhWUEc0RG5yWEllVUh0YnFyK3dQNUd3Wkt0dkZS?=
 =?utf-8?B?WWJMRTk1ckcxZ3F5SzhyWGRpVTRSeFNrbHVJbFF5R28rR0thR3IzVVI1NWNF?=
 =?utf-8?B?NEtzaXFuV3FIWWFMdE51a29vdnh3VStaWGJURVVGTzIwazByajR4NVp1S1U1?=
 =?utf-8?B?NURZRmJVdDBWbTBMS0lyUlJDTGNlRTdKQm1KN3IvbVlkeWxaK3MzbXQ2ekNk?=
 =?utf-8?B?K2dvcTZnK2wyejlvVklTczRUYzBsaDhQNUQ1M0lFMllDR0FhVE0vWTNtd1c4?=
 =?utf-8?B?bnZvQUdDWHFoS0JCT1M4QUtad20wbjdDQ1k3dTdMSXlxUDlHdk43aG8vRmNt?=
 =?utf-8?B?Vnp6NUgyc25raG1oQkNsNTBDS2QyRzFjTG5kYjB2YTQyUGc5aTJWR2Z5Szdw?=
 =?utf-8?B?Z3c3YlBMM21mcnNpQXVUUktZeURncGdWeG1ZUGJncWMyNFlPYnFkS1FZVDVE?=
 =?utf-8?B?ZzFJaHBldGsxN3JZOTEwbHc4dzM1UUU0Y1RnZ1hVRGJUQ1BVNFRGaktXZ3Bk?=
 =?utf-8?B?WWovWFZRR2xVWVVQSDV6M1BHczVNaUgyRjNSa3NWQXN2amZPQzM4TDNhbEFi?=
 =?utf-8?B?N1lXQ01DQXZ2Q3duNlFNNFhFUkEyYmpkcFNMbW43TmFML3RUdkJUVVJZRWgv?=
 =?utf-8?B?a0dZQUV2cG01VDVFeVQ0K1ZuUTlNbXJNK0VhMXgzWGpmOUF3d2U4dWl4TVJT?=
 =?utf-8?B?WmNDenV5cHp4Rk1SOXk2OFFqbGFvcXZFTTcwd1VzS2ZuN1oybC9iTkVpUG5T?=
 =?utf-8?B?VE1nNmZ0aWM5TjQxSEl5aVRSeGZIWko0OHBueStlWFZ4YSsrVHAveGlScW5W?=
 =?utf-8?B?WHovTStnaUVwR0ZGVmZoc2J6dmpVTUJpMC9lbktPU05zeVZjd1dyZ1gwZy9K?=
 =?utf-8?B?QlNFbWorWkU0UGFpRVpBRXFnSU1xckU3YXpjZEVwSU54WEtkSmFEQXRwaStW?=
 =?utf-8?B?ZlhORGJYejFmY3FyUWNmSmZhRWI0SGt4VzliMTdaNjF1WndjdTM3VGtYaVhz?=
 =?utf-8?B?NlNQc3l4QXJ3L2pFS0loRENGMXptS2pQNzJEeWR2SmY1MjFXeC81MHhmTFVp?=
 =?utf-8?B?SGprbmUrOVRMTm1iTVo3cWV2Q2NFMTVJT0FiZW9TVVF6QjFuaGFwYlBJaVUw?=
 =?utf-8?B?TnRvZ3Y4OUx1bmI1bDl0MHkxT2w2YjU3RU95aTczYkpzWm9WS2tRRGJPTUNG?=
 =?utf-8?B?WHFPZkoxYmJnc0FFZlpDdWk2cWlMZG9OLy9mQ0RGR2h4UnlXTWZ0NmFQUGhX?=
 =?utf-8?B?ZUxPU2w3RkI5ZzVCR1EvZzNiV3M3SWdJUVY0cTlycnJnZUJhUlJNenBMTm9R?=
 =?utf-8?B?YzQ5cFRPK2pKUld6OHZkZmpnSTRGcC8vV050ZDhDeXg2ZWlZTjFMSWtDNlZ4?=
 =?utf-8?B?YUtiMEhtWEs3L0F6OXBFa0hTRG45VDl0NjZNcmNlK0hRbWxNOTU4MW5GWU5h?=
 =?utf-8?B?bXpjNWVLYi9ObVlDZ2JuTnZZSks0TXZ1RmVzTUI3aTlvNjJlVlNsaVNDTEFi?=
 =?utf-8?B?ZTMyNW4zT1lhR2lYd2FjQmhPSmNSNGNqODVxV0JodlpXMFo1SVpIVWl6ajlo?=
 =?utf-8?Q?Zm33LbKhfyx5Kz/E=3D?=
X-Exchange-RoutingPolicyChecked: hbtxgwQQybnugv5C9maxZcqPAU/hWDjZKZFQbSDq5srp/ogk0RNp/Xx/xb97l6KpCvwPJnuGy9+H6Ek/wgu9kQfrY7WdhulioCOPJ+S/lpgBtAjnAaZfFSAdgcKi8lNaRwkac05PnM7tRtKkbkTgPjO+AGwKEkV4udEL8MmySLw2HmLv4oNB1EiyB498PnmffZCcZqVd2BdRLilImtJkVKYEvectZLfER0O0Nsmto7OXIZ13XmeZikFi55sv7T9rFxc4mRNBJ+rcLKcjUrQPf2sbb3hmZ5PQRDndjRqNXu51RF+2/XDAReC5TFIfJxG1HVlksjO/n5MaFlFA77r+oQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e55942b6-f8f3-4452-ec8e-08df38fe354e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:27:37.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7hUMnsT6aB3oS+rhaFEHhVxCcDFvr/ormtRaVqnPzFmITvXLMGp42EhHXiv0Cm1N+NiHhYjSrWJRBzK+HQ0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7165
X-OriginatorOrg: intel.com

On 02/11/2026 18:15, Andi Kleen wrote:
>> +
>> +/*
>> + * Tracing must not continue into a kexec'ed kernel, which may reuse the
>> + * trace buffer memory, so stop tracing on all CPUs and prevent it from
>> + * being started again. Events are left in place, but record nothing more.
>> + */
>> +static void pt_syscore_shutdown(void *data)
>> +{
>> +	WRITE_ONCE(pt_shutdown, true);
>> +	on_each_cpu(pt_shutdown_cpu, NULL, 1);
> 
> I don't think adding more and more broadcast NMIs to the panic path 
> is a good idea. It's always a very big hammer and a risky operation
> that risks breaking the actual dump. panic reallhy needs to be
> simple and reliable, and this is the total opposite.

Is pt_syscore_shutdown() called on a panic path?  I can't find a way.

> 
> KVM already does one at least (which I never liked either). At a
> minimum please find a way to consolidate those into a single
> one (as in have a notifier chain that is called on the target CPU).
> 
> But better would be to not do this and find some other way.
> 
> How about just passing the PT region as reserved and maybe free
> it later after the target kernel had a chance to reinitialize all CPUs?

Intel PT has cpu_emergency_stop_pt().

