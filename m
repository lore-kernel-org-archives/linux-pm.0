Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77B223DFF
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012290; cv=fail; b=Z71tJBUdOhUNu+nNTG/kA3ElSEfDE+Q6ikkT0g9GSGfHrqanlhCCOoGAuqdxRzVnyXE0BfPH11GGfwzmwp+W6cSp1BbA7WXeSydN04MUaCFyKkRB5mGGJfQo/qnWN4h9CJVBZpZcZcmfFmaAjdLwP0voRNJPQ9JZH61PHMeiXmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012290; c=relaxed/simple;
	bh=XHaxpbKE6cG57K5waLuzKW6VJXLNkodJb0HfI3UcrVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nn9WSnBTOGqr6qU2xxNQK4yLYxubcXHrdQzdn8ubquJ6d8PpbAgVYuabFLcpdUopKFmHVq5qxHFjC1lOqOwdZhylFV2qimNuCtBcNpXkd4BPXtKmvvdUWEyYavTvl6HOVOEKkuxOv7b71Ub0+sJ1rqAZMXDjo6nLmekFSQQoPwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkiUGBZx; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkiUGBZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775012288; x=1806548288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XHaxpbKE6cG57K5waLuzKW6VJXLNkodJb0HfI3UcrVY=;
  b=IkiUGBZxg27AflCY/OuMlLRr2Ydzs4KiZG+u71eUwoT3wPNJ0OluWzAh
   bCVfOxjU+v4vKhlqMLQ+ko2eBOd+kFd0IZWRxjeJH9GI7sW0UJsk/Ur+1
   Bt1STjKViSzjFPMTT0Jy3Dh/fZm3x0CGeNIf0kAL6agu6Noa09WRkd9KS
   Ej6NwxuD4YC2LddkuNzt6n9bYqvqlRmjWkXGOgakF1vO/mTASfC09Y5zf
   +SsmgSmhM41rkp4pza2vpV/ORsVdYwD9yqzEwHDxXvRjVRCPrudJjUFwd
   ZG5N7U5i5g5cLbTKqDJcsZujH0hkUjdRFed4z3zucqX5TLdZ2qHfCNofz
   Q==;
X-CSE-ConnectionGUID: vvBPrKtARfSUSn6d/DYNvg==
X-CSE-MsgGUID: y5eES2EjQV+fuLDQIwINVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78634866"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78634866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:58:06 -0700
X-CSE-ConnectionGUID: BmaCZua3QZOE5ZV1v32JBg==
X-CSE-MsgGUID: 1cdKzM3bTcyrTSoexi+K3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="264476661"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 19:58:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:58:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 19:58:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 19:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXByYR5EkPSH0S/tFMqwiLXTXZ+7r46K3PtHisbXRQDh5/KtpEvcrwI8gdZmmCy9Git/5bsrj/a0OCCM23zPX0evvxK53G5p3AxRSZYAnU5gL87mgoEv4wZ+QOwRs4uVj4NQLFKC9P15ejJw5Xh97CVmPDVvX2Ci8QItuM+3egtB/k7jlno66CLIAalyeXkiBjCbx+htrtmBh/V3+nZhYNnQJ6HAjslwWi0gLR6GB9RFCWM7cviKMiFKzPFIVZ1Qrxtaj2lPg4rPQfkyZsO5hoC7JjjzlgmROyE2k8mfPZjPkCqZcDA9bEqRk5ANwOyDGPhYDATpYAXDHSCLfa2U0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHaxpbKE6cG57K5waLuzKW6VJXLNkodJb0HfI3UcrVY=;
 b=oP7d+lfsebRqQzbgbswOs347gd93Fc6/lOOhLyE0Ihu/R+015ehafNrWzZPGxgJEw4TfwjXiiKuFWjKqhfIARN/NfURogYiwHiDoeGtU8k08idSFgMzzlDrXFRhQgdMYg8c0Dr2r0tYhC5UkRxGelXjybflunIfAA6WQXNRmc2sQSWNkF18DmvS7zmdKTkNw1M1XJ/BPgvucETZEmrfsAFWavHMkRL6720ztFX5u6PdEWkAGTLJZ78+HeMk9cW1/zSfLH6j1+zg7MUSiy9ZxbGxpYcVcMPSTcQo5VzODJ/SwD7Gw0I53IXQsNjXA00V1PsxEpq0u5pXdAuWt1uvlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by LV8PR11MB8772.namprd11.prod.outlook.com (2603:10b6:408:200::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 02:57:56 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 02:57:56 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "jwyatt@redhat.com" <jwyatt@redhat.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] cpupower: replace atoi() with validated parse_int_range()
 helper
Thread-Topic: [PATCH] cpupower: replace atoi() with validated
 parse_int_range() helper
Thread-Index: AQHcwWmSXuZJ+MCXOkmQFTcVSM1hZLXJgu2g
Date: Wed, 1 Apr 2026 02:57:55 +0000
Message-ID: <LV3PR11MB876851AB8BD22392350BA7A9F550A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260331042859.1920369-1-kaushlendra.kumar@intel.com>
 <42aaa8e5-509f-4d98-88da-9df10588e348@linuxfoundation.org>
In-Reply-To: <42aaa8e5-509f-4d98-88da-9df10588e348@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|LV8PR11MB8772:EE_
x-ms-office365-filtering-correlation-id: 93c963a1-ebb5-4532-19fe-08de8f9a798a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: FRU2yaD82cTFGKYh8S9AyUF7bSB16ynGT08V+kJ8u1MofTyejT3NyNmyvMlMIpCDeyqnj6xWU/FMVuAB8RnIqukBpxucKRq9c2K4A+X/N1DJ69mtVUDhtSiQG6+zKHbY1fIsoUR38WOXDXwP1jTSPUomxdTLi86EvAPDalmhIgZVmuUhwUrUcWLaW88Zepai3FhGhPjp77sSJsRjaE3L0MKu+NhFu9e+hWtUwt7rVadTKkRTVoJfhZ8v496GP8PMfd2hk2vvzgisVkQN17AX+kIWUbg9NdAIFmibp9wHUNNAV9oSzAXS3CQV7N4zUFbDm44NwsR4B6TKMqZT9IxtUHdIYs7lTodoC8oYYbj+B/8fyD5VxRvovYgvNonFD44XKy7jgMOtqgP9KDh5nk8hLsLNxlLWr//eZF0OiayCl1HarwzRjQHZzznxciSZIiXW5UG7fV+gaxbNaGwHMQl8ccjsj5f8A/mNuMzbdKOULhEpHQNvs0xhMpS5TndJ/z7qT6YwKx6b74EHC9+Tnn6jdugzrsuXIhEp+1BbnDjsuINsnOVgSOUqQqJ62myRR2IqlSAaDoqZaN6s8QSIt1/OXCRGk6x9mspKWusjqmrRObXt79JKivDBs40MMHshrv2vuFQtGdOIbkBnXNyxQJ43AtsZvHCvlRuj686JUbAdfR0fs1kNVlAJOlpuWeFYtV20Trt9Ej6UZ6cQXwPYQ+hvoQcO3pTJW0wnIvywwyYor4Pxo8fjWbWUEPE7udIuJlXlOfSvJZHxtUojDemcoQG/Bk6lNLFS+owcvQBXYoFW8Qg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFpzSlNVcXZBbXh4UEoyeERKblhkTG9oQkxtVmppbTREekdDQStjTFl3UE1S?=
 =?utf-8?B?WXFNbzNhNnUxenhDWmllUXlua3BtSjMvY2FZTU4xZU1EZW1CWXVNU054ZFJK?=
 =?utf-8?B?TWRsbDJlS2g1dUtVRTJvUDJEeDl6TWNTQXZtQUZqdWhXdC9YT2xWUmpvK2hF?=
 =?utf-8?B?WGZIcFBQS3pycy9pL2wydkE2LzRQZVQvdTZOWEhVdC9hY3ZSdEt2OTVVbGF5?=
 =?utf-8?B?ak12c0h4L1hqbUdGUGQ2VzFSWlVudWpCMDV2aE9EZkk5Q0JYRXRrTHFmbWFX?=
 =?utf-8?B?bXNQb2p2QXJqV000bDkvVFFxNWdRRE95YW9jYUhNYWZBQS9sNGl6akxUZ0VN?=
 =?utf-8?B?NlZyYjJVYzJJdmUxN0ZrUkc1UzROUUptRzAxVFo3VHdrRmZSRklKdk1adDJs?=
 =?utf-8?B?eFIrcEFvOS9pU0hNbFFUeGcxNC8wbjNRejljUm9hVllZRWZUNzRnRExJN0x5?=
 =?utf-8?B?VTZ2M3VGZ2w0UmFPU2xZWHhtVFN5OXlKQ1Z0RUE4a0ZNcEw5VUhlTXdNVXRF?=
 =?utf-8?B?RGdnajhoOHBNUHNxeit1VkdKN1l0SnduVjdOSFlrWTZLTHB6VzlKV3k5R3Ux?=
 =?utf-8?B?NlRRazJVZlRsSGtPN0lqT3lCTWJlTGh0anJ6cHZmUU9qY3BrV04xN0pjVHZ3?=
 =?utf-8?B?aTllUzJteTQ5K2JONEwrUGsydGdzK29kN3p1dkhzTzJrWGoxMWYxeDJwVDN0?=
 =?utf-8?B?Z1liVnFnVlkxOG02MWl4eDdRVnBacnZOWEpqUlVtemJab3dkb0RBaVJjZEMz?=
 =?utf-8?B?azMxVEw5ZmZSZnVtK3YyVnFFRy9ZOFM4UklmL1VFUjVqd296YTNIMFBOK1Bz?=
 =?utf-8?B?VVBtWE02blkrOXB5R0wzaXBtNUpnOG1ZUi81bWpYRW9iZUs2R3lZak1DZDBn?=
 =?utf-8?B?RXV0SmVoTEVML3dqRUtyN3FFL3lXWVNPMFJvYzdFTnplbmg4d3l1bGo4WTUx?=
 =?utf-8?B?R2FpNUxweXdWbitUOWNMa0pIVUpySk5Bd3JNVjAwUEhBZ2ZFTHNjK3VkVDNK?=
 =?utf-8?B?dU10c2ZkMkNURHRHcU1OcDRHaTBPdjI4c0Z0Zml1SmxqSVJESzVrcTYvNm1s?=
 =?utf-8?B?emJDN3pSRys5MEJxWHNJV0VIWVlkcC8yeUJaM1dib05oNjh5MVllcXJjOU1q?=
 =?utf-8?B?YWd3dHowL21JUGNhR3plaDZLTXpDMExVRUtINXRHanVicElwRmNFRWdxdHAy?=
 =?utf-8?B?RWdYK1FLaDJ0ak9sWUhUOEhxdkZMWDVDK0JPZmdqY2RpWE5KcnU4b1VGdFMw?=
 =?utf-8?B?akJhUE5ROE5EQnJCRTVMSGp1dFdUK0V4RmI0bDBIK1FDbXNjVS9yajhNL0Nr?=
 =?utf-8?B?SHEwT2NYUmpiRDJTenM3SFdHdVFWYjJ0ZjBBZ2FGQVE4djdteHYwNkp1bW9K?=
 =?utf-8?B?UWlUY1dhOWNKN25EcVQyTjZwSjUzRzJRdnVnUWhublBLWjJ4YW10RDJYL3RM?=
 =?utf-8?B?UHZLdjJXL09ZRWx4bjNhVXgvazVrSUlhRUVoWE5RQS9KeHNtV21Ibi83R2Yx?=
 =?utf-8?B?YkZFTGx2RGZzMjBFYWI1NGJEREN0TDNib0dySm9QdW9CNC9HQ2xJL1RMNjhM?=
 =?utf-8?B?OWFoOTdZZUpVSFNXcW5WM0M1dHFjcGtqWHVESXZTdDVxTDZIeFlMWVRVY0gz?=
 =?utf-8?B?bjlSQ2lHRitOOTZ6cVdYVnhFYmJIclNLWVUxQWdyY2VMMlNwcm1PZXFOVzNJ?=
 =?utf-8?B?ZmIvZjI0TmhlLzYva09BVHJncy9NSEh2QmVPWnJiZC9GZTJ4RzNBQkZBRTNY?=
 =?utf-8?B?cVEzWERTMkJrYjNVSEIwdnpwTkVFenVRUGVuaFBucVM0WmE1UytIak1VSjJm?=
 =?utf-8?B?bVQyd3NSNkpnWjZia3AwYStPd2xZdmE2a3paajdRZDJzbUdLOGtDU3NFdGZi?=
 =?utf-8?B?ZGl5V09mMGd3VHdEczBGbmtlTlZybis0WFVRSlpBZGZ0cUxqKzRrbmZwNG9Z?=
 =?utf-8?B?RHYvM21iQ0kwZ1RsazRoa1c5V08rMG9VbjNlUjZ2N2k4d2ZlSWQxaU56eUox?=
 =?utf-8?B?N2lvRXBqMjFvYVFaSWlvQUJmT3R6dzVvTFp4dTcrdEZnMGt4ano3dWFBb3VM?=
 =?utf-8?B?V28wMWt5SXRzcEhhMThjNjh5Q0JPNEFCSW9LVlJBU2NYaTVaUUZLOHZaM3cy?=
 =?utf-8?B?MlUrOGFwMFp6OHZMVmdkVTcyQ3NJTDNlSENJLzR1L0NWUTR4WHViUFVBUk5X?=
 =?utf-8?B?STUyemZWZ3p1eFVpRVpsSllDdHJ5bjRZRUZCTWs4V2NnY1BKRkVxQUlSMzNz?=
 =?utf-8?B?cHRaei9ESktMQ2dFUG5na1hsanRsSDZmcy90ZE1Lc0U5TmdGZGJLTmptSGhI?=
 =?utf-8?B?TDZiQ2ppNElKeUU3c3F1NkVmK3hCMzBveGR2WTVJaVpaUG5Mb0QyUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PjTp8Sa6o+Zkj539GZH+P+kxRLx2g/UVvL7w6NKZq4YGGq5icl5OS/QWNezDWHK+ysoniWXDveMCTzHoUFOl/4NarViZbFTCvyjAI4McYBpC2tFhRhnhEPGANcwlDLSemTBtsJv0G8Z9iDvybKMlkdDoEn7Qd4WHp5JCSmbI+3MUB54X9PrMMRgFTf6GTAUR/JIJ2is/Ki12xErKH4wRliisrywCjE6Kw7Ts/nws5ux+WCaHmeGPN5KDoVf4m2JySQYhMXzEh4MMQrxrv20dWxUCtxtq3LEvtut5ucamkO+ptg819nSAUx25qaffr00WdTeRbMSS9tfjPa8+rBiH9w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c963a1-ebb5-4532-19fe-08de8f9a798a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 02:57:55.9457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6n3pjJRmkZrjyTcGO3/2gYyUBKOHf31p6z+JMlgqHNmmx3eO4fv4U2rdODKD1C7VEg7s5RotQkVjhzJwrdUW25pFPSYRUTR/zh1i9RKPBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
X-OriginatorOrg: intel.com

T24gMy8zMC8yNiAyMjoyOCwgU2h1YWggS2hhbiB3cm90ZToNCj4gQWRkaW5nIGEgcm91dGluZSBs
aWtlIHRoaXMgaXMgbm90IHRoZSByaWdodCBkaXJlY3Rpb24gYmVjYXVzZSBpdCBhZGRzDQo+IGNv
ZGUgdGhhdCBuZWVkcyB0byBiZSBtYWludGFpbmVkLg0KDQo+IEkgYW0gbm90IGNvbnZpbmNlZCB0
aGVyZSBpcyBuZWVkIGZvciBhIG5ldyByb3V0aW5lIHRvIGRvIHRoZSBjaGVja3MuDQoNCkFncmVl
ZC4NCg0KPiBUaGUgYWJvdmUgbG9naWMgcmFuZ2UgY2hlY2tzIG9uIHBlcmZfYmlhcyAtIElzIHRo
ZXJlIGEgcHJvYmxlbSBpbg0KPiB0aGlzIGxvZ2ljPw0KDQpObywgdGhlcmUgaXMgbm8gcHJvYmxl
bSB3aXRoIHRoZSBleGlzdGluZyByYW5nZSBjaGVjayBsb2dpYy4gDQpXZSB3aWxsIHJldmVydCB0
byB0aGUgb3JpZ2luYWwgYXBwcm9hY2guDQoNClRoYW5rcywNCkthdXNobGVuZHJhIEt1bWFyDQo=
