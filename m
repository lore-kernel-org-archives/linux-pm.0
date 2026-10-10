Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C63CEB9A;
	Sat, 10 Oct 2026 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791624923; cv=fail; b=ZsKhGzUxDpTZzvnDvUDf0FwiiSeEQuesnRlUFAo8ldxe2tyxocf03zE/B6MBLPb6yh35t/bskQ5rCrJpYIf6qfEKAplJI2GPkLJr0vER/y6evzoi6iKjhCLEnjScE8pOfxJqnJRVz6j3ll0w7orjS5g0T/H1JU43tyUcmW2MPRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791624923; c=relaxed/simple;
	bh=RsTtsH1bMBfyZ6rQVMpo1L1l1CHOzzHlLc2gf3VYXdM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKjOxt4sLYGNWFB7ajZgOhoGJFZvNJCWL0UR7Bu4WG2Tstvs9juGQgsfcSCwPEaNiuY///kQ1E/hzi/WIeD1cTJz2sTUWrYsdA0JMLYD7Fw3TreN5HCYUOLQRR7hniCnzMo9fHXnab3EtZzrV89n8vpRS+zEMV5CL4bORoQXU/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eH0m18+B; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eH0m18+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791624919; x=1823160919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RsTtsH1bMBfyZ6rQVMpo1L1l1CHOzzHlLc2gf3VYXdM=;
  b=eH0m18+BzGJECaACLZUTCywmEcm1OU6GGONvvTtRhi6uhXa/a/TqLyIZ
   Fl1JXBA0NkopcXT2xYxjHogMQNrwKrbREtFzkgyO/CE/vhvmeS1Qq7CL0
   14HkwkhKCVM5SGvlIOeJdkBLZ2eS+8Y8IxyI98Q2e0QH6+h8e9tWrWl/e
   05qXIcPl7TQgVzT3GZO6FF6CFGk1QtgQWWI7Io1UUomc0av2h2TYLvDoQ
   /UbKqajVEPHfGZZvpaEtr/DSgZxn8QISBEymxpWleDoiB10tDBQ7h0kao
   ds7W6bER25h8EGXi4GnWZl/GFsPHCEjsqNnf6um1C26G39LXEqD4N80mQ
   Q==;
X-CSE-ConnectionGUID: +foi1JFcRvyWrHIKoVK4cQ==
X-CSE-MsgGUID: Q56dQjt4RG6pV/Y4pAmwkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="300571"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="300571"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 02:35:19 -0700
X-CSE-ConnectionGUID: 6vFzKeUyRbGNrxEPBdGxNQ==
X-CSE-MsgGUID: oPhZUkJhQMSmOmUDZmvYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="677980"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2026 02:35:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 02:35:18 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 02:35:18 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 02:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6ExiWSN0yT36ZOM4WWtWiqfwBzPqNW6u4rOcK8/rRGNlzCKlMBLa1ELRWNuWtMtzJ2OwDZ3b/VtfRBsmdiI1DGQ/zSahculTVOMkdwpKimirV9YnPZZzJZiTUTXUVyGWJOSWeXaJZFfMIertmmvY9y1xlryjPzGRbXT5eVKkQCpbRG2+yabNYOFpY4Bcm+ptuWq/EvDLzaUElsi8QuGcGHRIsALc5mcr7yIWwg4zgvazlwDudnHdubEWfa9XoouFAQMcOh6EYDr7rRBtze03dlFSonpEx+1AD2SbvX/FEyW8PBSN8yigQJzgRZL/ovkGlrKTdPHQ7VM6NOBSYnaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmEB59IuzIVHVVZjQX8eUYEWaJWzUwlNOgiGVS9LrM8=;
 b=NnxZfjQDVK5CtJ6yx7BNEKO1SRZCiDX+482aw012Xa6IZXJmfDKyQJsO//934HWqvZaB+A6m50J+luaAaoTG8fw+JPcugjicej10yQARFa5tUdturwL09GI3AUCMFY3dVxwgUZeKkdbUtt88xNh8Jx5TGUNCMP1iI5VXYQQO49PkxLOruE5ajNzVqOeqd4oj+Sy8d3i0d5osCxB6e22+C9U0ABt3z7K16QjLuzinUbydlctPUorM3twpyCgS6I2tFLALdnguR+20g46FssonMXer35ijV1v+K6aIKFbaP9fp29WOgkmn+r1+vtjypH+FImTKDrsw5ryn5gJvvkd1+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sat, 10 Oct
 2026 09:35:07 +0000
Received: from PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd]) by PH7PR11MB6006.namprd11.prod.outlook.com
 ([fe80::4e2d:28f0:ede9:73bd%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 09:35:05 +0000
Message-ID: <27602f4d-e6aa-47d7-9ce4-d102e14346de@intel.com>
Date: Sat, 10 Oct 2026 11:34:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] ASoC: intel: atom: Discard
 pm_runtime_put_autosuspend() return value
To: Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	<linux-kernel@vger.kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Liam Girdwood
	<liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Peter
 Ujfalusi" <peter.ujfalusi@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Takashi Iwai <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
 <20261006161337.10.Ia8792ce5d04a55522d84afc8e71cc879721a5f49@changeid>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20261006161337.10.Ia8792ce5d04a55522d84afc8e71cc879721a5f49@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0024.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34e::11) To PH7PR11MB6006.namprd11.prod.outlook.com
 (2603:10b6:510:1e1::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6006:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c728de5-6242-462b-b709-08df26b1c414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|261009221227099003|10067099003|11063799006|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: Cf2Um0lopgVtezIVNmtcq4cCOcUAwel1Mtk3xVP3Mua2zJb5hKPpW4+SsxPipVCzpRX47DWeQyEQtbAbRKji9dAlljQRbdJwdt+DEo31g6yTALFrqCjvxQ0G2PPjh1IAcHA0dO0Vj7p6se3FM8rdMnq9b95laNRVeCrbmSwu0qbx6SXnY93v2oFgKVhAm1uuIck47mtF1YT5MEhwML1USmwnOP1U3eql42lXTrYEspDKMcnadh/mn6t8PL8NFI+/Cd5M59tBGIRB8/YTzS0KoGVqiHdckx9ubsHWBw+c+iiZg0PJjUz+jFirbS2tyI9KyQwx1mVl7hZdkwwKyZ5vBKHogJUcc5UZnwrLhwUVoFwf/Nw/lTD1A77tOfmvGrE/J/oomsYcUuCZY2mCeVKJqwrlkFOlc0cOBkeqtEyLK9veKdrIp/6vF9ZXtKoeMzwIgl5PBcTYoxWT32PvIaKFhjabgaCXo6RvsrnwrsadOUph8gqUCdMF6P9Ye4exZKTajmqjOVNTCcMOuMf/WgGHq3cLnIOj9eAfcUkVxhjglaXRr6J7IgKAR/EUi1epwMVvUEsCgLu4ECDHKLUC7e4hITj6Quiwa5PjBtZxEVlYPaIk3mpf4VLJjsmRfph9TsWpeA2SKaW+qT3ddkNIk7t98uZQ9NoK+PWldYxQknqmMZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(261009221227099003)(10067099003)(11063799006)(4143699003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3dnRks4OGtQTUxCU0doTEpyUHFwbXlvM3dHRTVJVDhMWjl5VHlXTUh5YkFC?=
 =?utf-8?B?SldvSk9uZEhSNVd1MmNaUmJmSS9Zb0tYNHVFZ2tFa3hKVWdGemZsUnpnSTgy?=
 =?utf-8?B?OXd5bHN3aXNPQlVUUlV6MlVHM0k3WlRLTU0zaG9lbFNDNjRCVHo2QWFCVE5N?=
 =?utf-8?B?dUk2b1Arc3V4NTNXdW9FTGNwK0g2MDFXYzBjenJPYlFraWhoZFo0Z09qRFZx?=
 =?utf-8?B?ck1zWWpNN0Y2UnVpdjFFRUhpckJjM0U0eEpxZkpGTk1TckRNVWRETEppeHR3?=
 =?utf-8?B?ak90b3BIWmpBVk9JTjdXcENIcy9kWG4wb1lLbzhBRzdHRUxBRE4xSjJJeDdo?=
 =?utf-8?B?dDgyZGlrTFNiRkdjMno2WUVSZUJTcWpIZlplYVB4UHh4K2FiNW03cG5IZnFV?=
 =?utf-8?B?dGNzUDdFaXpmcFEvQnRzb3RxUlNycCszMllhVzZMUUI5R3NoSzNaS01ScGR0?=
 =?utf-8?B?SWFzVFMzNlg1b0VwbW9DY1NMam9yTDVGeVVaSldaWS85OEZCanJENVFubGlq?=
 =?utf-8?B?Vm9aUG9CVi9LbkRsN3lvUnBpRDFhQjhvTWNUSjl5K1FMTzErcmcvem9DejVh?=
 =?utf-8?B?cHJITm1YM0cvcTQ3ZUc3ZUZzbFpVTFNRVXEzYlZvYnlBT3NPalBpaitva2FX?=
 =?utf-8?B?U00yVlV5SkhHeXM4THpnODEvWTdiZ293N3BMWnhCQm9YUDRtQ00weitvZ0pk?=
 =?utf-8?B?cEJoYk9LZC9ES00veVE3WGFkeFNiM2J6RjlUd2RDRk9JYVd3dG40WUppNG9w?=
 =?utf-8?B?SEJLK092akdGajNvRzBYcVF3SnRha1laOGgvNzBhZ3lRU0pDQy8za3UwMTlD?=
 =?utf-8?B?dURKZDF3Rkl5UGY3SlBNUVdlVVA5enBCdC8zQldZNVErZUxnWTJmM25GajRD?=
 =?utf-8?B?Rmhnd241Y2dkSjFKT29jY0tYelVtb3RNNTRhRk5HOVVOQlV4bGlsRHZMOHlS?=
 =?utf-8?B?RG5TUEtXYjl3cnV5WEtRTkUyWUpGRG9pYzFwMldscDRmd0M1UC9hRERDeWRs?=
 =?utf-8?B?azBFQ1dwSFJ2MWZyQStqc1BESmdJRVdDeVJFbkRXOHAyOC9Ed0k1RGtVdEgw?=
 =?utf-8?B?d0FybytWZlQ2N0xnTDNLQzRncDdpN1NRNktPOW9ZM0p0MmsxN21OOWZPWTZH?=
 =?utf-8?B?YzN5SEVsWHZyamtCeTJKNSt3NEVpcW5NeXUzeEdrYkx2b200SGRWY0NhWk5z?=
 =?utf-8?B?d1plY2xaMHZBcVNxNXovTFRyZDYzNFpBeVl5WisyOWV0Y2pDYStzakp0bzhR?=
 =?utf-8?B?TnQwS0JaTWpFMDdhRUhPKzRJNUpOK3d5VFJCZWxZelcrMlF3RFVMMFEydEYw?=
 =?utf-8?B?OXBvRU5QcUpWcm82Rm1ZaWN1eTRTVnVsaUdLN1h1YThkVlMrQUdTTXQ4MVh2?=
 =?utf-8?B?a2hqNXVOQUxkSlBKSSthRzJjSWRVY2J4RFhldFpsb0VzQy9ZS2dpNnhzMzlC?=
 =?utf-8?B?blRuNHBxdnBPTDkrL29DUktiYS81QUhZOVVZNVB3SHZZWDFZcCtlTzdHRkZI?=
 =?utf-8?B?eDNTYXh2VXFmd3o3cHU1cjJVR3FUay9CbmxhWGV2Z0xEUS9Zb3JIcGRXUUFj?=
 =?utf-8?B?ZHFHcTBPRTVwVzVXUk10VlJJUDNQVUN1MW1TL3prdmVXbE1sMTExWVVpUkJt?=
 =?utf-8?B?eG9LWERGWGZ5OFVkTUFoeEkyOE1WMUoxSVcwM3F3RjdpQmY0ZDNBM09JMVRC?=
 =?utf-8?B?UlZXTWQwOTRnUFRUNDV2WFhkTCszcHpJWFNXamF3Mk9UMmZMRjJpOUlSSGNU?=
 =?utf-8?B?WVpjWGhDVm0vQSt1YmdaaTB4YXBnRVd5RWhjb2RNN29mWXNwRlRQQWZBMStl?=
 =?utf-8?B?d1pjbXhHSkpYaFJIeS9rU1VSV0l1UFZPKzRwR1o3YjdjcmZxTFR4d3d6a3Zy?=
 =?utf-8?B?RzV6akxTRjlYVlFQbmFPVEd2R3FDU3l3dU9oTXV0bHFxZHRVbXNHSG9PeExB?=
 =?utf-8?B?MzJ4d0xnbnh1cFFoVU82bU50alBMMTZNVDdXOEpVYzhlQUJwaVdqVHNsalVk?=
 =?utf-8?B?NVJJQ2YwdStEQTJST2R3L3FaMTJnRC90Y2syelhveWp0QnV5RUE0eVhLTzVw?=
 =?utf-8?B?RHE2QmxCdEJONjF6VmJSemtLZ0hMUmhVem52ell3ODRPeDBUM1Rrak9SZ2xM?=
 =?utf-8?B?cHRCZXZBaHpUdDYxTlZXZklDSWY4eTNWNW1heVR3N2tMdGI0SUFNWjFSVnFM?=
 =?utf-8?B?RDhUT3ZXVzF3YmVIOWprS1crd2NUUEhNS3QzSXFKRGtOYVBQSFFnbEl0TU0w?=
 =?utf-8?B?WXZjVlZZMXNoTmpxOXF2OGhQUWdGRUd2TVQyWExNN0pyRGdrM2pkZ3BPSVcy?=
 =?utf-8?B?MHNueGYxMCtoa1YwdUJQVS9DSUNwcXpTY2V5Z1V6eWtKY0pKWkNDQT09?=
X-Exchange-RoutingPolicyChecked: Nuyf/qBuYdHaQSUJxCRoKL8xYySjw6krUVrC/hstr9XYihECpyRYeELRfajnuFcWhuqCbWPgliCpcZsDwZSpT3oUXvJMihAEM8UdVUVuvHBD/QLDTaIFc+ZEOJNFKWQsqvo5NG+Q7WD8+Hrs9INUHiNuYgHTF5nLxb+NKuzu35O25v78skiQE3vR6eXqRlwh8g3yGryiY8GXve53o8pTQASxmAd8qPY5WOfG9nVYY5Yorx5cjG3gG2zM1HHPKr5hLId6+8RSB9ItG0oIeA+Zo1pOF/UZflpv/SYwspBpge0SQ8filAgUAq73hCieEKM8AC4JnR0cnpxyfMAw0Uz9GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c728de5-6242-462b-b709-08df26b1c414
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 09:35:05.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwIci5iCz1O2ENgwmkxfq5xgyj0XMYAHUXb4CWxFYpFMO1IjjpcqjbC1M+FaC0YhLB9ez7kTAQWwQqay/WbI5RC56YcGBY64sGB+ng5QRw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com

On 10/7/2026 1:13 AM, Brian Norris wrote:
> Propagating the pm_runtime_put_autosuspend() return value to callers is
> not particularly useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> Modify sst_pm_runtime_put() to discard the pm_runtime_put_autosuspend()
> return value, change its return type to void, and update its callers in
> sst_power_control() accordingly.
> 
> Note that in one error path for sst_power_control(), we would previously
> overwrite one error code (from "FW download fail") with the return code
> from pm_runtime_put_autosuspend(). This was probably an unexpected
> behavior, which is now changed to propagate the sst_load_fw() error
> code.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
