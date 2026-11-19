Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795073094;
	b=NSK34FE5XBoPPgbU9Mjesmhl5S1frhh9EoB8BVW0Kux24ggB3EPeVzlD7wxvTnbi1FcM
	 B32i+f5fgc6sjX5/pNNkyShf8UniejBVdw/5WRVYkog8E6s5nOwUIml9yw3bWmGLBOOOF
	 ZJSueB8/lN5W6CtQj5o9WV6/f/1+vhS6RFe4vXfU57GtqmyKNC+J/9+HzeF+A/Qr6p7Kc
	 rlabN2T6zPPFVDgT0yrzk/LZeDT6DmEOuqRJOVOZ5AbdDA93srtgaBFWjDkjAF5+djmIF
	 F8pQlHjpBsZ94v1t4a4cOD16qw3+5QIJTNU74XrtC9dEgPPn1wPkJkzHvTblaTNLUdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073094;
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
	bh=ReQfNMU8dNscI+TS/Te+jOmr1Bv2PspVRt9/fYVupkY=;
	b=LVJJN+6EdFw1GehT3yUenko7+B7BtOCR9g28URUz9bqqLCK/H59HR8oHJGrKJ/bhhf4d
	 Q4aTcMkHA/KKFTN5BmiV/ClNb6uZe1c9/kmicjpxTHvalCd/XtYAzek/myC4cYXhat/JB
	 az582h4UK4RevvyOdyfNuR1qGvBEe1wJ9kSGWavOPpagaRrrAxZczyZy5/S9UOTyWdBrI
	 SlC3ZbpC80ZbhxXuQilTimmpn1shNRPkUD07UZJSWTIG7Z7xPbUBtou4wXMvg9Q2+2KmE
	 EnHp0ywe3nQyd/UdeMlqhW78cB5Rmd9cV82pbDywb6/+6h7zACtYvUXP5DZHuNsGnDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BXqrBloI;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Otf9URC2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27601606A325
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 07:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27601606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BXqrBloI;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Otf9URC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795073094; x=1826609094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sK3Evec7DuigVh/rpgHB2crE23XdCW8Mh+3z95zrUiw=;
  b=BXqrBloIyIBWIAQQoqmLc34l1tvFBir1JwG5iUFeu82hsHFQIi1YL+z+
   sTnFmBGNBzsUH356MxqxQATe7DahpTDWokjppL34fZ+YzVyNAlrUGrriC
   nWXrg13aLvWNNI8xfT91WDAmWo5i3WQvMSKqp3P6Y7Rz9KjRJzvRNQdE3
   18eNcF13V1ck+UfQXvPsjE8qCkN2wHkCpI8wHepO8sjp3qKLbNV+iYwjK
   8x9+xqWjzk3pixkRPm6ijj5Nz2HKC7onhi0o/V/MxVoANsjf4pGep3OYs
   jPKIHWCtqAp3DgDJQDTj09ZNueDunw/8PwSw/CboQ5fqSSzxF8t9V9RIG
   w==;
X-CSE-ConnectionGUID: KfUD+XgFSMaS9zWaQn4H+A==
X-CSE-MsgGUID: k+7kHNd5TiyOyFtIia5l/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3811623"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3811623"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:24:51 -0800
X-CSE-ConnectionGUID: K7yr4cQ5RTutklxyObuJIw==
X-CSE-MsgGUID: WTdfRGq/TBWk+Yv0Vyu4SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="12181073"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:24:49 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 23:24:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 23:24:48 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 23:24:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuUncsCcO3W1MnZRdJxzvSWpKkvkEDfdxDg3d04MKJTVhpIzBCyxIeY5roJ+Ap5F5vIJEPNgYUVsrKjSpQArjt3NZzAG+y6o55OuxkMOygbL0InBZ/+s9bbqDy9Tyib+PXsium8E3ckfltugnxE6BSGDPqxGR4YzjUbZrj+YYGz2cGXepKZgSk8tUR1frY2Y0Rc/+XqI/rw5pHV/o3xf4YZrwzImJNhbvySQmKM/ySORFEN0goXmXDfwdklFuWo8gAgvrFx4ezMk2Fd+tX8e6ztuWQ77koHW6V/XVPal5TpbgArmA1LpVs0ioRTLK0rlNyV4+MvShq5+IzqBQ1gflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReQfNMU8dNscI+TS/Te+jOmr1Bv2PspVRt9/fYVupkY=;
 b=idTCMPon6sul4ohqbm3cAiiOwitGl79IEs8lqtk9jmbZfQChdbgYKBNl1b3hzFGJ50TDRII3q3i7AUrSQkA8xClFpg+TkKKz8iOtzLPiFFtbHhkGrNH2K1m9PQM6slcDFDOQvuGh99H/mYnBeG5alnKU0nVyxcNKiZwg5MjyqUu7vDHdAvNklN0XNDXpDqOZEvfvi0AjswWcqHguALOsQu5eXuzx0a/T+c0Mo0Ox4ChkKluTCIIUG0wkLVLIUaeRKLplpF61p1XmdBgMVNy0OUUXdNa+012jy6ymhkyBNnlslDYHzTLJLeS3wJQTBFcwJzBvHCROW/JC5KDYdPoP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReQfNMU8dNscI+TS/Te+jOmr1Bv2PspVRt9/fYVupkY=;
 b=Otf9URC2rkqOu3+UkIJHZ4JvyL1AR4GJfDPgGQqNto7Mj8b6w/yoxT6VMu4SAljQ2AhTC3iSwj7+niw7LfRTNcPe/4LmMQ/JpJ2AJQ13OJD4XO6AsSR8VMnIPCjlDFS67y85InRy5dxHH4rqyoHDUUFF2xEueM7EXrC2KqOUPX8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by SJ0PR11MB4928.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 07:24:40 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 07:24:40 +0000
Message-ID: <3986c861-dd2f-407f-924f-06287c8b7538@intel.com>
Date: Thu, 19 Nov 2026 12:54:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION: [PATCH v2 1/3] cpufreq: Improve suspend-resume
 synchronization
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Christian Loehle <christian.loehle@arm.com>, "Doug
 Smythies" <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Mario Limonciello
	<superm1@kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, <ravitejax.veesam@intel.com>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
 <4796894.LvFx2qVVIh@rafael.j.wysocki>
 <efcb1647-46fd-442a-bbda-283560d9df53@intel.com>
 <CAJZ5v0htcKjiWbDW-Oxn1qXAYX8myfyWFxkaxnMTaS0hYC4CCQ@mail.gmail.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <CAJZ5v0htcKjiWbDW-Oxn1qXAYX8myfyWFxkaxnMTaS0hYC4CCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To LY0PR11MB357627.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|SJ0PR11MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bc3b9e-c0fb-4cd9-d513-08df460e2cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261009221227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|11063799006|56012099006|10067099003|4143699003|261102130727099003;
X-Microsoft-Antispam-Message-Info: wMp/+tDsUBFaYCnLiDWERdDzMNZw4b1OBo7zZiqphxQtSTw4J5PLs49ZqUjO6fdXRU5sV1WYbiTSXBDeHtgm7q0H46FC8XgY59Y/KiZvE56x7d2z9AcgpkmERsPwZpalyga3GDr177jMoW7Swt2fTVUHEIzLVxgYZT4oSmHhPstZxRZtsNkx51jOy3987ygew9hmQestNXOoHz5xir19z4dE+KXW9mXRWfUYXbeVBRwkewqcwvilyvftZUjUPYOKPbbHyX+in4LdWOCv30btwtL6liUW2ijsuM46CXM4YMW51fE59qbtoufKv2JXjAeTloV0MY0ShsMGAxGP5jYFv/eeUM5T2ps0pbebF//FFu1O/jtikYEYHBA9jca6/6hAJ5CdAxDnspuZ/1ovPS5ElY+sW+PZXlnsp/cVBizDsaM/2fqescVFUhZ5f7vBz7DoBUGo4tEpQNFMzwL/N80+ikLEjlZZSsjprGikLb7ZMCK5N9Ca+TxGaLSf8I8bjqXBvlUmzpNFRNnvbLeUYtxYMwSJEMqbLL3ED9aUIdzeYnD4WiQoy9evA5R80Icm1ZZRA9xxTgCDIIJ8tcrmhQFNwEb7xheoWeFl8ck1ooZgDggBwH6ey+xg7WQoYiLUSTRf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR11MB357627.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmk1SVBuNldZcTdmNWNRTjE5MExncC8ybWRMTzVYMjJOclZtV3JIQzJxZGhh?=
 =?utf-8?B?SzFGZHJIbi9WWTFvdHFHR1hVb1pvU0hUeDNqTFZaNTQ3dC9Md0o1Sno4Y29E?=
 =?utf-8?B?SUIycEEzcEpnWTJ5dm1XWFIxVFNMTTdXaERmOTNTb25VcWJremNHS1pYWmNJ?=
 =?utf-8?B?aGh2bWExb1RoSFlBVzR1cHNNY0t1cUF1eWxtc3NtVDhkQmY2OHdyRUpyYi92?=
 =?utf-8?B?ait4QWtwaFVmRHlEb1pBTUJMK3pJWllwaDNFbVJaS05YMG9SdHhHSnh5SkNY?=
 =?utf-8?B?SVp0NDZUTG92a29ZNDk4bmhaTTZwUkkvSEl2Zm5TK1BtMjZjRUNORjdRUHVu?=
 =?utf-8?B?VDFVenFCSkFmczI2MytXUUhGRitMMU8wZ1E0RDFGUEJWdFY3ellOcGQ1cHBy?=
 =?utf-8?B?b0h0MVNCcTBRVUdWQk5BUHkyaVJIbG9hVUt5dEl4OU41RzJRVzRVZjlDSjlm?=
 =?utf-8?B?ZFJwM3l4K1lsRE9MenEzV3RwREh6b0FkQmMyVHF4OHd5eEE0NGtyMVhQei90?=
 =?utf-8?B?T1g5WmlDWXUyanYzWHRKSGFNT1Jkb1pDZEUzcTk3TEZYdVVyZTJhNFA4UE02?=
 =?utf-8?B?bS9zMHFDc2dPY0xyc3RTODk3TExMYkQ4WVVIV08yMFZtZXdwL0xIMGEvSHVF?=
 =?utf-8?B?akNvRGJvRldIYWFHd0ZlWGVqbnBEVG9CY1grdTdiNjNTQUVSa0hmUlhzVHBI?=
 =?utf-8?B?TXlEZmNibU9XTTRJTjBXUThJS090bHRmWi9mcTJyckp5WW1xRm5BQ1RFeEJU?=
 =?utf-8?B?Qm5UYlRjbnZJMHRvdVFGR1Y3akNGWHcvbWdDK0ZnOVZRS3o5NjBqVXJUTkRJ?=
 =?utf-8?B?Wms1OE1kamsyTDB1YXp0Y3NOT1RVQWpkb2xwSzJlQ2oxZlBucE1BU05SUjJU?=
 =?utf-8?B?YzBNbDhUOVhKdjJnVEkyK3lDa25hV011L3VvdHpQUXg0MDhPUERPK1FZTkNr?=
 =?utf-8?B?S3lTMzEyT2hORUZDNmFVRDJMNmpxTlpnVnVnVDhEeS8valR1eFFZd3U2Zmxw?=
 =?utf-8?B?MjM0TjRJYXVLRjUwRHlBQ2YwQ21uVzNTQU5UeHRiL1dFYmszUUk5VUU0WjJ2?=
 =?utf-8?B?TDhKSnN6SUxaaTNBVUZFSzN5UXV0OWJ3OUl4eVFobXc4c2xvYkZjelFwQUxC?=
 =?utf-8?B?Y1FLMXJ3QjI2bVVQWGlmVXYyQy9XYzZwdENwaUhWK3VTUjhoZFZaM05yU2ll?=
 =?utf-8?B?b2RvVWN1QXBvdkx1Z2xMZ2hRcGdEUDBEdHZ3THBNZ1NPNnczT1ZZQzNmakVv?=
 =?utf-8?B?ejM1VzlPZEtKbVVvam1WU3NQV0FaeTVSSDNWdDBBOXhzcHZhU2RPQ0M2SUJ1?=
 =?utf-8?B?UVNHWTFWOEY2cEpsS1VyeVdPaEpyOU0xUCtNb0V0SDFmZ2hhREpaTHNvOFYz?=
 =?utf-8?B?MSs3c1BOKzRYcmZOdDU1SmJpTVJoTFMzVnV6UnVJajdQSlM2aWtsZnExOWdS?=
 =?utf-8?B?WXBZOG5uaXJqTDJHS2x1ZXk2QXNMck0wV0ZTS282ejdlb3VsSlczTlp3ME9i?=
 =?utf-8?B?RHVsMnlBcDBpR2oyZWJPMGlwYVFQMm1qZk1RWGg3YUY1YXBxaDBrczcraGhK?=
 =?utf-8?B?NEJsQmV5THZBUHRFRG0yWWZRallGcDBYLzlhWm1wdWtoQll0ajEzQ2pyVGNS?=
 =?utf-8?B?VzIwTGdVY3FvbHRmV3FuSld1cTRFSTVDUW9DaFNTUSthSHdncDlhK2ZqeWIx?=
 =?utf-8?B?dTVGN0h5UXcxN3ZJN0cvZmxOOUJXaDBENVNua21PZCsyZWRkbFFyVGNCd1Vn?=
 =?utf-8?B?K2YyUjlxMlRjcGM2RVhQeTBZQlpoZGg1WXJaTEZaUnNGVFlqL2pZc0o1WkNy?=
 =?utf-8?B?ZHNPcUU3RzRBOVhBZkVqcWgxbnhaaVJMVjFRWGJHRjRCeW5iS0JFOEdVb0hi?=
 =?utf-8?B?SnRtdW1RczFmOUxBZDI5S1cwbmdXYlhPRXNFVnBJOFhpbHp4K2VyNkJKNnFi?=
 =?utf-8?B?SlhsNnk2Y1ordElISGxQSzFPeFdDdEgyaVRucFpTUUNPWWV1NmdTa3h4TWNR?=
 =?utf-8?B?M1dSYzlqbVVwOWg5cUtidUJIakJNKzJLWmpCT01NQ0VtU2RiTGhEMWp4eGtQ?=
 =?utf-8?B?aE0wd045NXVCcFZMM2hWa2VJTkZiNGFhNjJxa08vdkFtTGlsNEF4ZDFnZXhj?=
 =?utf-8?B?ZzJ4dGZINDlsTWpXRU9uRWErc1VvaGkvdDJ1bEdVc1l5YUJNQmtZc21xM0gx?=
 =?utf-8?B?V3FMMFFEOFFMeEtkaTZYMlRPWXBDUEt1cnBuSXh1RmZyY1lTUC9FZ0NCMHdj?=
 =?utf-8?B?UjZZK1U2V25wS0xUTlI2dGpra0J6aDJHSmdMU3FCMXhTMjROVi9NdGt6Y1BW?=
 =?utf-8?B?OWpWd1FUT3dpUkJETU13cnhDYTNTRWNpVEFWVksyUmtROUw2ZTZjNUR4cy96?=
 =?utf-8?Q?HxkiHrHhl4nHWxv4NiF/TiPZA9G09VFiLA4ag?=
X-Exchange-RoutingPolicyChecked: vv+zDQihQAzAHL85d2VPQdgY+pws7KyC3odmc+lU7YuG5+d8aRAjPheQf+nB3lhfadriLOMkDLmRIf/fl9pGUUXNZQCVntHLgYUPPTBjBVsMmNAY19NzkR/mqEO57YIW8H7VfOHd5n8db6Vsip8L6hkI+AyQQr3DJaqq2Xiv8GEDyG9GhevnaXtX7eX2D3LQosGPzi8RwnskwQoZsyTCN3csd4diplGHnxKluRdBpBu8XybTDVcZnSAGnaEdjrU5e7r8Se6yGl2cWNHfnPlZ4Tj4tl6DTy+YkU0AKpVTY7VeTVOQ1wg55H3l/TsaCDMDhnmc3uoP3Hk1jDI1J1xrdQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bc3b9e-c0fb-4cd9-d513-08df460e2cca
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 07:24:40.7902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjdFDb05cWeqFFqxtmYmJ3wi9vkpMAV5hsxE/ed03CYsH6Wx0mDf6iwMzUYJ0ak1ToUKRzod51fsGG194DlELQ8hi5swE0CODdaf3aIPNOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4928
X-OriginatorOrg: intel.com



On 11/18/2026 8:32 PM, Rafael J. Wysocki (Intel) wrote:
> On Wed, Nov 18, 2026 at 2:05 PM Borah, Chaitanya Kumar
> <chaitanya.kumar.borah@intel.com> wrote:
>>
>>
>> Hello Rafael,
>>
>> On 11/4/2026 1:15 AM, Rafael J. Wysocki wrote:
>>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>>
>>> The suspend-resume synchronization in the cpufreq core is not perfect
>>> because the global cpufreq_suspended variable is set at the end of
>>> cpufreq_suspend() after stopping governors for all of the active
>>> policies, so the governor .limits() callback may run via
>>> cpufreq_governor_limits() after stopping the governor and before
>>> setting cpufreq_suspended which is questionable.  Likewise, the
>>> governor .limits() callback may run between clearing cpufreq_suspended
>>> in cpufreq_resume() and starting the governor.
>>>
>>> Address this by adding a per-policy "suspended" flag that is always
>>> read under the policy rwsem and is updated under it when the governor
>>> is stopped in cpufreq_suspend() and when the governor is restarted in
>>> cpufreq_resume().
>>>
>>> Also make cpufreq_resume() use the cpus_read_lock guard to reflect
>>> what is done in cpufreq_suspend() and call cpufreq_exit_governor() for
>>> policies that were suspended during a system suspend transition and
>>> are inactive during the subsequent system resume (to avoid leaking an
>>> inactive policy with a stopped governor that has not exited yet).
>>>
>>
>> This seems to be causing regression in our CI [1] (affecting dg1 and
>> dg2). We could not revert the patch cleanly but resetting to its parent
>> heals the issue.
>>
>> <4> [510.751891] ======================================================
>> <4> [510.751907] WARNING: possible circular locking dependency detected
>> <4> [510.751925] 7.4.0-rc3-CI_DRM_19546-gfb078d17b966+ #1 Tainted: G S
>> U       L
>> <4> [510.751946] ------------------------------------------------------
>> <4> [510.751962] rtcwake/4256 is trying to acquire lock:
>> <4> [510.751977] ffffffff83ce0f40
>> (intel_pstate_driver_lock){+.+.}-{3:3}, at: set_power_ctl_ee_state+0x1a/0x90
>> <4> [510.752022]
>> but task is already holding lock:
>> <4> [510.752038] ffffffff83886890 (cpu_hotplug_lock){++++}-{0:0}, at:
>> cpufreq_resume+0x23/0x250
>> <4> [510.752074]
>> which lock already depends on the new lock.
>> <4> [510.752094]
>> the existing dependency chain (in reverse order) is:
>> <4> [510.752112]
>> -> #1 (cpu_hotplug_lock){++++}-{0:0}:
>> <4> [510.752137]        cpus_read_lock+0x3c/0x100
>> <4> [510.752157]        cpufreq_register_driver+0xca/0x380
>> <4> [510.752175]        intel_pstate_register_driver+0x9e/0x1d0
>> <4> [510.752192]        intel_pstate_init+0x3e3/0xb30
>> <4> [510.752211]        do_one_initcall+0x59/0x3d0
>> <4> [510.752229]        kernel_init_freeable+0x3dc/0x6b0
>> <4> [510.752249]        kernel_init+0x20/0x210
>> <4> [510.752264]        ret_from_fork+0x3bf/0x470
>> <4> [510.752282]        ret_from_fork_asm+0x1a/0x30
>> <4> [510.752299]
>> -> #0 (intel_pstate_driver_lock){+.+.}-{3:3}:
>> <4> [510.752325]        __lock_acquire+0x1700/0x29c0
>> <4> [510.752341]        lock_acquire+0xd9/0x2f0
>> <4> [510.752355]        __mutex_lock+0xae/0x1030
>> <4> [510.752372]        mutex_lock_nested+0x1b/0x30
>> <4> [510.752390]        set_power_ctl_ee_state+0x1a/0x90
>> <4> [510.752409]        intel_pstate_resume+0x109/0x110
>> <4> [510.752428]        cpufreq_resume+0x153/0x250
>> <4> [510.752445]        dpm_resume+0x1f1/0x390
>> <4> [510.752459]        dpm_resume_end+0x11/0x30
>> <4> [510.752474]        suspend_devices_and_enter+0x372/0xcb0
>> <4> [510.752491]        pm_suspend+0x372/0x840
>> <4> [510.752506]        state_store+0x6e/0xe0
>> <4> [510.752523]        kobj_attr_store+0x12/0x40
>> <4> [510.752541]        sysfs_kf_write+0x4d/0x80
>> <4> [510.752559]        kernfs_fop_write_iter+0x193/0x240
>> <4> [510.752576]        vfs_write+0x285/0x530
>> <4> [510.752591]        ksys_write+0x6f/0xf0
>> <4> [510.752606]        __x64_sys_write+0x19/0x30
>> <4> [510.752622]        x64_sys_call+0x1285/0x27e0
>> <4> [510.752637]        do_syscall_64+0xec/0x680
>> <4> [510.752654]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Could you please check why the patch causes this regression and provide
>> a fix if necessary?
> 
> That's because set_power_ctl_ee_state() acquires
> intel_pstate_driver_lock which is held around cpu_hotplug_lock during
> driver mode changes, so adding cpu_hotplug_lock around
> intel_pstate_resume(), which calls set_power_ctl_ee_state(), causes
> lockdep to complain.  Note that the deadlock is not real, but
> set_power_ctl_ee_state() need not use that particular lock either
> AFAICS.
> 
> The attached patch should address this.

This works. Thank you for the patch.
I hope you would be floating it soon.

==
Chaitanya

> 
>> [1]
>> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_19546/shard-dg1-14/igt@i915_suspend@basic-s2idle-without-i915.html
>>
>> --Bisect Logs--
>> git bisect start
>> # status: waiting for both good and bad commits
>> # bad: [cfe67bbcfc37474cbb4482d750d4fba34bbc5a24] drm-tip:
>> 2026y-11m-17d-05h-12m-00s UTC integration manifest
>> git bisect bad cfe67bbcfc37474cbb4482d750d4fba34bbc5a24
>> # status: waiting for good commit(s), bad commit known
>> # good: [39e407b553ec15d4a233b651531ad431ed7542be] drm/sun4i: dw-hdmi:
>> Deinit PHY in bind error path
>> git bisect good 39e407b553ec15d4a233b651531ad431ed7542be
>> # bad: [715f145f6204363a50853eb15719dc860db0bc01] drm/i915/dsb: Realign
>> GOSUB only for QW slots 6 and 7
>> git bisect bad 715f145f6204363a50853eb15719dc860db0bc01
>> # bad: [7e1392a42ea288d70a266f6553fe06f57f8647ea] Merge tag
>> 'net-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>> git bisect bad 7e1392a42ea288d70a266f6553fe06f57f8647ea
>> # good: [0359338fd8cf1a2dc001d0cd69c331c17decee88] af_unix: Inherit
>> SO_INQ in unix_stream_connect()
>> git bisect good 0359338fd8cf1a2dc001d0cd69c331c17decee88
>> # good: [79eb6679ef6a0d5ea68da53a8321fb1dc72299b9] Merge tag
>> 'loongarch-fixes-7.4-1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
>> git bisect good 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
>> # bad: [baa6744dc939a927e2c94e5f20aff01ac538aef1] Merge tag
>> 'acpi-7.4-rc3' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
>> git bisect bad baa6744dc939a927e2c94e5f20aff01ac538aef1
>> # good: [2cca8a6f6ae690755862f5b633125119dcf6bd0c] Merge patch series
>> "ns: fixes identifier fixes"
>> git bisect good 2cca8a6f6ae690755862f5b633125119dcf6bd0c
>> # bad: [df42809bd599109660bd3f95e2e22330c80993df] Merge branches
>> 'pm-cpufreq' and 'pm-runtime'
>> git bisect bad df42809bd599109660bd3f95e2e22330c80993df
>> # bad: [6bc092a0fc4d331a4adbbb664078af149c580834] cpufreq: acpi-cpufreq:
>> fix P-state index mismatch in extract_io()
>> git bisect bad 6bc092a0fc4d331a4adbbb664078af149c580834
>> # bad: [02e77af824d5be3a94fdd885835a352f90d24c5c] cpufreq: intel_pstate:
>> Clear last written P-state value on suspend
>> git bisect bad 02e77af824d5be3a94fdd885835a352f90d24c5c
>> # bad: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq: Improve
>> suspend-resume synchronization
>> git bisect bad eee2a44e4e2b41c0699919a550d41cc38daa4f42
>> # good: [e6f50e602e373583423654ec000cad8b8d08f7bc] cpufreq: Hold the
>> policy write lock when changing boost state
>> git bisect good e6f50e602e373583423654ec000cad8b8d08f7bc
>> # first bad commit: [eee2a44e4e2b41c0699919a550d41cc38daa4f42] cpufreq:
>> Improve suspend-resume synchronization
>>
>>> Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate")
>>> Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stopping governors")
>>> Cc: All applicable <stable@vger.kernel.org>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v1 -> v2:
>>>      * Retain all of the cpufreq_suspended checks to avoid carrying out
>>>        governor operations after suspending cpufreq during system
>>>        shutdown and during hibernation resume on systems with SMT (Sashiko)
>>>
>>>      * Rearrange cpufreq_resume() to walk all cpufreq policies and call
>>>        cpufreq_resume_policy() for all of them
>>>
>>>      * Call cpufreq_exit_governor() in cpufreq_resume_policy() for
>>>        policies that were suspended during a system suspend transition and
>>>        are inactive during the subsequent system resume (Sashiko)
>>>
>>>      * Update cpufreq_suspended under cpus_read_lock in cpufreq_resume()
>>>        for more symmetry with cpufreq_suspend()
>>>
>>>      * Update changelog
>>>
>>> ---
>>>    drivers/cpufreq/cpufreq.c |   86 +++++++++++++++++++++++++++++++++-------------
>>>    include/linux/cpufreq.h   |    3 +
>>>    2 files changed, 66 insertions(+), 23 deletions(-)
>>>
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -35,6 +35,9 @@
>>>    static LIST_HEAD(cpufreq_policy_list);
>>>
>>>    /* Macros to iterate over CPU policies */
>>> +#define for_each_policy(__policy)    \
>>> +     list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
>>> +
>>>    #define for_each_suitable_policy(__policy, __active)                         \
>>>        list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
>>>                if ((__active) == !policy_is_inactive(__policy))
>>> @@ -1956,6 +1959,14 @@ int cpufreq_generic_suspend(struct cpufr
>>>    }
>>>    EXPORT_SYMBOL(cpufreq_generic_suspend);
>>>
>>> +static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
>>> +{
>>> +     guard(cpufreq_policy_write)(policy);
>>> +
>>> +     cpufreq_stop_governor(policy);
>>> +     policy->suspended = true;
>>> +}
>>> +
>>>    /**
>>>     * cpufreq_suspend() - Suspend CPUFreq governors.
>>>     *
>>> @@ -1978,11 +1989,8 @@ void cpufreq_suspend(void)
>>>        pr_debug("%s: Suspending Governors\n", __func__);
>>>
>>>        for_each_active_policy(policy) {
>>> -             if (has_target()) {
>>> -                     scoped_guard(cpufreq_policy_write, policy) {
>>> -                             cpufreq_stop_governor(policy);
>>> -                     }
>>> -             }
>>> +             if (has_target())
>>> +                     cpufreq_suspend_policy(policy);
>>>
>>>                if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
>>>                        pr_err("%s: Failed to suspend driver: %s\n", __func__,
>>> @@ -1994,6 +2002,32 @@ suspend:
>>>        cpus_read_unlock();
>>>    }
>>>
>>> +static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
>>> +{
>>> +     guard(cpufreq_policy_write)(policy);
>>> +
>>> +     if (!policy->suspended)
>>> +             return;
>>> +
>>> +     policy->suspended = false;
>>> +
>>> +     if (policy_is_inactive(policy)) {
>>> +             /*
>>> +              * The policy was active when it was suspended, so its governor
>>> +              * is still there.  Let the governor go.
>>> +              */
>>> +             cpufreq_exit_governor(policy);
>>> +             return;
>>> +     }
>>> +
>>> +     if (!start)
>>> +             return;
>>> +
>>> +     if (cpufreq_start_governor(policy))
>>> +             pr_err("%s: Failed to start governor for CPU%u's policy\n",
>>> +                    __func__, policy->cpu);
>>> +}
>>> +
>>>    /**
>>>     * cpufreq_resume() - Resume CPUFreq governors.
>>>     *
>>> @@ -2003,11 +2037,12 @@ suspend:
>>>    void cpufreq_resume(void)
>>>    {
>>>        struct cpufreq_policy *policy;
>>> -     int ret;
>>>
>>>        if (!cpufreq_driver)
>>>                return;
>>>
>>> +     guard(cpus_read_lock)();
>>> +
>>>        if (unlikely(!cpufreq_suspended))
>>>                return;
>>>
>>> @@ -2018,19 +2053,18 @@ void cpufreq_resume(void)
>>>
>>>        pr_debug("%s: Resuming Governors\n", __func__);
>>>
>>> -     for_each_active_policy(policy) {
>>> -             if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
>>> -                     pr_err("%s: Failed to resume driver: %s\n", __func__,
>>> -                             cpufreq_driver->name);
>>> -             } else if (has_target()) {
>>> -                     scoped_guard(cpufreq_policy_write, policy) {
>>> -                             ret = cpufreq_start_governor(policy);
>>> -                     }
>>> +     for_each_policy(policy) {
>>> +             int ret = 0;
>>>
>>> +             if (cpufreq_driver->resume && !policy_is_inactive(policy)) {
>>> +                     ret = cpufreq_driver->resume(policy);
>>>                        if (ret)
>>> -                             pr_err("%s: Failed to start governor for CPU%u's policy\n",
>>> -                                    __func__, policy->cpu);
>>> +                             pr_err("%s: Failed to resume driver: %s\n", __func__,
>>> +                                    cpufreq_driver->name);
>>>                }
>>> +
>>> +             if (has_target())
>>> +                     cpufreq_resume_policy(policy, ret == 0);
>>>        }
>>>    }
>>>
>>> @@ -2412,12 +2446,17 @@ __weak struct cpufreq_governor *cpufreq_
>>>        return NULL;
>>>    }
>>>
>>> +static bool cpufreq_is_suspended(struct cpufreq_policy *policy)
>>> +{
>>> +     return cpufreq_suspended || policy->suspended;
>>> +}
>>> +
>>>    static int cpufreq_init_governor(struct cpufreq_policy *policy)
>>>    {
>>>        int ret;
>>>
>>> -     /* Don't start any governor operations if we are entering suspend */
>>> -     if (cpufreq_suspended)
>>> +     /* Don't start any governor operations for suspended policies. */
>>> +     if (cpufreq_is_suspended(policy))
>>>                return 0;
>>>        /*
>>>         * Governor might not be initiated here if ACPI _PPC changed
>>> @@ -2460,7 +2499,7 @@ static int cpufreq_init_governor(struct
>>>
>>>    static void cpufreq_exit_governor(struct cpufreq_policy *policy)
>>>    {
>>> -     if (cpufreq_suspended || !policy->governor)
>>> +     if (cpufreq_is_suspended(policy) || !policy->governor)
>>>                return;
>>>
>>>        pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>>> @@ -2475,7 +2514,7 @@ int cpufreq_start_governor(struct cpufre
>>>    {
>>>        int ret;
>>>
>>> -     if (cpufreq_suspended)
>>> +     if (cpufreq_is_suspended(policy))
>>>                return 0;
>>>
>>>        if (!policy->governor)
>>> @@ -2499,7 +2538,7 @@ int cpufreq_start_governor(struct cpufre
>>>
>>>    void cpufreq_stop_governor(struct cpufreq_policy *policy)
>>>    {
>>> -     if (cpufreq_suspended || !policy->governor)
>>> +     if (cpufreq_is_suspended(policy) || !policy->governor)
>>>                return;
>>>
>>>        pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>>> @@ -2510,7 +2549,7 @@ void cpufreq_stop_governor(struct cpufre
>>>
>>>    static void cpufreq_governor_limits(struct cpufreq_policy *policy)
>>>    {
>>> -     if (cpufreq_suspended || !policy->governor)
>>> +     if (cpufreq_is_suspended(policy) || !policy->governor)
>>>                return;
>>>
>>>        pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>>> @@ -2747,7 +2786,8 @@ static void cpufreq_policy_refresh(struc
>>>         * -> ask driver for current freq and notify governors about a change
>>>         */
>>>        if (cpufreq_driver->get && has_target() &&
>>> -         (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
>>> +         (cpufreq_is_suspended(policy) ||
>>> +          WARN_ON(!cpufreq_verify_current_freq(policy, false))))
>>>                return;
>>>
>>>        refresh_frequency_limits(policy);
>>> --- a/include/linux/cpufreq.h
>>> +++ b/include/linux/cpufreq.h
>>> @@ -149,6 +149,9 @@ struct cpufreq_policy {
>>>        /* Pending policy->min/max update for the driver */
>>>        bool                    update_limits;
>>>
>>> +     /* The policy has been suspended. */
>>> +     bool                    suspended;
>>> +
>>>         /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>>>        unsigned int cached_target_freq;
>>>        unsigned int cached_resolved_idx;
>>
>>

