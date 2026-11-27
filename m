Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795758876;
	b=FkRO9fb7a1PLJfUmYAT5//+XBockMo+39dnHWjVHBOY7mC+RD4R9YL2m5zujw4+T96yj
	 /4Twotj5ubpwDpqeN9ZICxa1mRoOn3OQwFpwZe8SMtzf2h+CWw0lj0LBIwIZyTWtD2gnr
	 w3+WquDand+ct93EkrolBamCH1iN6wLXvMDFoXi2Ys+mg+qKZc+D+wlo+/8berYXyFoeu
	 MBzWsyR6mSjiS5JaS1e0bTiqajOdTLNbEO3k4TlxhtC0gTvEKNK0FEq7iY04ppybAWLbX
	 pg2z00e2mgFzI+CnBVVus2knFCR+1XfiDYciRn9fF83cAfnJl0OgLVXm4wDLzggVy1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758876;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=1shMWgkreJqfsLf0lsVmjxyi27u8Xf5A1+QH2AXj4bk=;
	b=kXI9fLJ5oPISA0uRnfGMw5TDwypPw4DUCoxPbR4kfq/RFRSz/23U770mgZnPep/3MqKR
	 FoKlN3xnk+RCvR0Ik9cMbdyEqG7Fq6zTJgZpPrft3xY1u9XKEp8oinOxPYYmEZgImLqf2
	 1w2UYy835zUnhlwHoa4IudBiDjeg/Sfuxm7uPHWlBvnIfs/i3ZKmSrT8V46gvSkikmLQ9
	 UYn+bFtFx2z8pCzTWFfdWdjOPFiQpw2hc/Al4B0nSwDTXHDhadVJxYhbYuJAHVoVInjXg
	 XXqC8XSXgWEwBewCtZ3b9QmvbEnqlPrNzSteugpZrcUSEdyFiHCudfIRCI9Es/suqbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NR3LZ4Sd;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eY2MjCC8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBC606A31C;
	Fri, 27 Nov 2026 05:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9EBC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NR3LZ4Sd;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eY2MjCC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795758876; x=1827294876;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1shMWgkreJqfsLf0lsVmjxyi27u8Xf5A1+QH2AXj4bk=;
  b=NR3LZ4Sdw/wjVMhNppQxBdoh6lMLYffeOu3MUMTWZF6tWITwzxIdxmlX
   JYangWCcXWGrf12CLGUor4pgREYr1v/VOss+pHFXT6ETWU1a8gkD54f60
   zUO8Fr/JJgS/pg0J78ffr0PajH+4OnWgtAoarcQn2hQlC155Yk5MyOcHJ
   Jh7ZZD4OpSQp08ugsdv62QpwEFDwtn8u6C7oHeTfF5UWB3OnAZSwPv/S/
   PF4ugvcuqEIU+ySXk7v1bh7vSd+1iDnPzPxn/VH+p8bFUJD1jZDBfXnP4
   r657nK6GBEq9rzfojm6Gb6bdteF7cl1tTod4/qV1rUIu8J8acUaBT7hoS
   g==;
X-CSE-ConnectionGUID: nRl+Y2RcTx2rcKNo8wAQ1Q==
X-CSE-MsgGUID: egqNb2u2THm4+SgUK0MaXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4571635"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4571635"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:54:36 -0800
X-CSE-ConnectionGUID: 0Gd0lDLKQOSYb1kVXiUFNA==
X-CSE-MsgGUID: TVVy7NkQSuGbiOJQUQLHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12471723"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:54:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:54:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 21:54:35 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPXaXirA4ItFaMO2I0zHe93aG+j10XRkG5F+0U1zaAFd9PHiaOkQhl7N0htV9ygAm9ym4S+aaEQdriS9Dk245PHc5jsBD/IMK55jsyYI5haBzvXtR6xVYkA9NgxIQeIreMqbKtDHmSukpHDFmCfgj29kKqMhJY/qrLb2ppGJ3tm2eOVOrGPAPSwkdCr33bQIU6FCieHFY+Z2TsjTJkipVaoxLAXyRewccOZGdnnXFr+dtMAMMT+6vSL5p8s5WrtklKGROjW0P/wVdFIz8IKVvck/B0SfrkepBakPFll8WGFKig36QRmjlBKCKE2oO4rf5Vzxm3visPbviX9okEGFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1shMWgkreJqfsLf0lsVmjxyi27u8Xf5A1+QH2AXj4bk=;
 b=fTrp0fqq82AvIyE9E6xXGrnmLt1qSQSmU3h79lDsE+dyp1BqSFCWs6LQhDzzkl6AhXD6ePKUck8fYm+TdD8uY/Gq+yvG2jM6RXV1JBKugtBJ54zu/kkEzXe7H4UbrMMe6TqUML9M780JndJzB3hyG9P3vfGfsMv0MN1Apg+ucCko7SXk8moJA8+XjDUv+sndKgbMqWo8jEdqO1NEO3oudzR79+J+dBMm4/X1+opdoBgjD2LQ8LdTlkkzlTaQjJjhDYL1rK4HNUBcJ/05gmKvfQ80b5UtofSmBMFTHCeyBjPdxOhHGyzrIFooyl33wJv+gqx0ECxipNZ4VquPliKDrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1shMWgkreJqfsLf0lsVmjxyi27u8Xf5A1+QH2AXj4bk=;
 b=eY2MjCC8jCqACG1hOhz4mI4LYul4xOk8ykiejcUCNYqF5STa5E1P/rnAuDJmQ50PnYW6rMpvSgT4Kt6uhUk4DC+6PhzP5NkJlQBGBlc9TH9MYIJORoIGm4ZTJ0GlL/wxCMdYIgMVPYElOjHKCMbz3P8uBFN8vczkCzd2u8iUufA=
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SA3PR11MB662844.namprd11.prod.outlook.com (2603:10b6:806:538::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 05:54:33 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:54:33 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "qinyuntan@linux.alibaba.com" <qinyuntan@linux.alibaba.com>,
	"lenb@kernel.org" <lenb@kernel.org>
CC: "michael.hebenstreit@intel.com" <michael.hebenstreit@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"xlpang@linux.alibaba.com" <xlpang@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tools/power turbostat: Restore u32 truncation for raw
 counters
Thread-Topic: [PATCH 2/3] tools/power turbostat: Restore u32 truncation for
 raw counters
Thread-Index: AQHdfjPGuyGP9YxSS0mvlGElxNtgvQ==
Date: Fri, 27 Nov 2026 05:54:33 +0000
Message-ID: <6113de4fedc012d78fc8e6f06e38f6c905d0062f.camel@intel.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
	 <20261124032723.157254-3-qinyuntan@linux.alibaba.com>
In-Reply-To: <20261124032723.157254-3-qinyuntan@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SA3PR11MB662844:EE_
x-ms-office365-filtering-correlation-id: 252afb89-7c36-4574-3cbe-08df4c4ae923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|11063799006|261026121527099003|261021121427099003|261102123227099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|6133799003;
x-microsoft-antispam-message-info: QOEZf0LHzlwp3lbquDe7kdfaOPku57JBBgnKATTVG7RoHGJP8iByqr36X2wWJz+Rd1EAi2YubAW0mrt90oR8eIe0H/4/EsvmeucGSvZ0JLTwQHMaTp/NZprsywVWW5Exg+m/Zv1/nhtL1IvTj3v7ZEaacTmUF7uQxemWzwjprxiq/7T4JSgx4Ec+23GfjPlV3RQ33VMQB12ZXT/LY+cEmaPJ08p2lqFP8Gn66y6bLRpoDCcU2760veResYa2PRcifdJt/6edmUikGixIwbGNdLHT1G2x2ym46IeUs3YtgU5Cr5I2UACpXagbaMs4jLncC4ayjEYmHCXf/Saw9kJiIA4E8Uyyaf4Y6lwA2gFFM1uSRJTBp5Q6pHgXEmkHjTrwjfq5mJkH8b+52y+KGifiR7Vsd40skntsjWGepWCX3qWOtst70hKS7L5Axm3p/KJSQ3PAtmT8qI9EzSdHmeFtc+uWfBSjy6YVL26LA8xa2zjlAVvU+wjNG74z7ksbtDSdgRNVryzkMn/VubDusHvhkO0O9EUe5TIrWBSBnqAmp/VwwYiRPXpzguCczmegJKttqskHDWBDrQ3N0CZig78Jluq3vUs0F4yfAxGDiJ4uweMuwXtopCAplaXUzs1lnF8KIoJnwS9iDRlG0P1F1O579FYu01+WHMZWoHIBxjHEv3ju904hXZupl4VtaznLgTzlY/d595qRzXaKKGgbFEEUfeWJQHw7w8BhppyzijcDWVA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGZTeDVudVJTT1RxMmxxNjBtR1FBTU1HRU5CNDZZNXlQYVhuVjRadGViblhp?=
 =?utf-8?B?eW81SktyVklrUFk4QVFERWVTWmszbGtEeENSeUZPeGdsMThKRi9iMzcvcUkw?=
 =?utf-8?B?Z2J1ME5raGR3Z2Q5MDlXTDdZUVFrMTA0dlNocHk0NDNRRzNMUjN5ZDY2aUdW?=
 =?utf-8?B?aE5HTkZjbXI5cmFySm9iWml6SFBMVU1MRks5UVlvTEttYjNoczloTlc2a1l3?=
 =?utf-8?B?YVU5dWo4RkNXRm9SY1dkMWFHeC9sVVdhbUI4RmVrQjJnUnlxUW1NaFUxejZV?=
 =?utf-8?B?c0xmZm1wZVdjM0JsRU1jYjJML25OSWozaEthd2UxVFFJQ3JuMVpTdUk1MkRV?=
 =?utf-8?B?MjhSckpZVmNtM05oRk5CaEdvLzlMNHEyNHZxeCtBcTVod1ZVeW9acDJCb1k0?=
 =?utf-8?B?dkFpV0J1YnBKalZ0RCtJRitFNGRKS1VqUU1pMnc2YzU1MTQ1M09nZlBzTCtR?=
 =?utf-8?B?a1hHTDBxRlFXK3h5NUhtSUpRRDhmRnNWSFl4cTlFVHZjMEk3NXQ0dHVRTXpo?=
 =?utf-8?B?MndFMnZWSFBxOUY1ZVB4dDhzVWExMS94U0hXZktFdUVHdDdUTGRreHhSemlS?=
 =?utf-8?B?Ulg5aTNkQi9aVVd4OWtoaTk0cnpGdFBMaWxudXhFYjdxbnRiVDR1SzJiRDFE?=
 =?utf-8?B?QmI3Rmk2NjRMYWVSSUR4azZZbUd0U3dOOEVnaEhqZlZxbjNMOS9PTEt0eXF0?=
 =?utf-8?B?aDNTaWpnaFAzSlhpd2JYS2hMQy9FYnJBeDcraHZMQ1pTaWUrNkczN0szdnpz?=
 =?utf-8?B?Myt3ajEydzVTTGxwQVNrakVMWFFBb2hCNU1XbGRpSDdqdGJVZFYwS0k2L3lk?=
 =?utf-8?B?U2RQdUZxR055dnF0b3A0Uk94djJEOWxkQ3laeVpNZ2JRWnQwVmF3NlU2L3Vv?=
 =?utf-8?B?b2ErL0lxQ1Z5QjVRa0dlUlNpTndwbzcvb1FVcFMwUUFIOE9jMHRQQ2YzbGFk?=
 =?utf-8?B?QytrWU9PbnA3WWxIMW1keDRpRlNjY1ZObFJIbloxdmxXbEdMYjVPZW16c0tQ?=
 =?utf-8?B?eTZYeC9WcGJoTnMxL1ZBVFE1SzIydVFlc3J3QXdZK0dBV01YVGk2UnVFS21O?=
 =?utf-8?B?N2FnazVUWnovQkZJSS9QTGZvVHRCOHhoSGgzR0hKNUF2SHEzYW9LL2x3MllE?=
 =?utf-8?B?QzQ3YmtOY0dqajhiMWI0MmJqQm5zbENJMHdmRnR1NDNkVUM3cWpTaHpvK2Vy?=
 =?utf-8?B?ZlFTdXRYLzhEWVBYSkRZM2QzNVVPeGcvZEozQUdnWTNvMUpkcFRUdktWWm9S?=
 =?utf-8?B?TXNLallRaTc0UWtoQW9lVHdMZGlENU9YcHhPOEZpUmo0K0diOGNaaEdrZGZ6?=
 =?utf-8?B?YjhOU1VpV1pWSHc2LzdNTFZMUEFIdThqM1g1WnRGbDlHZGJGQUtReXY3RjA0?=
 =?utf-8?B?b3hIL3pnek5NOFNDL0kzeTROenlKRmdoQnQ4Sml4UTJmeFMvNVc4bnNsaWhy?=
 =?utf-8?B?ajYyRG9kRC9rdTl0Ulk3TTMzQ0lpNkhkdDVEa3I5VWNOc1hOYWx3VVBabWpj?=
 =?utf-8?B?eXBLTmpIT1VZVk9QcGJPTFFnR3hkTmRzNU15d2hNM1hWOXMyblpiTENON3h2?=
 =?utf-8?B?QjJFVG05ZFJ5bWdDUkFSM2NhaHI2UFdyY1RkNE50M3BEYTE0dTdseElmMEpP?=
 =?utf-8?B?VnJHNjhCMGdRZWdJNGFIalVGOXQ5VXpKK3hFcjFOZGdDQ1UxV2RSNHRPQjVm?=
 =?utf-8?B?SktPd0g1MjVLVEhQUGRrb3R1ZlFFMjVUMlhLbTc2d0pqMTVCVXdqVkpncW9U?=
 =?utf-8?B?QnhPdVQ1bXBrdHlmVGwxSXVYdXR0dm9NengwNGVjZlE5NWhJUWFTSWtWYnpX?=
 =?utf-8?B?Vk9QZGt1eHVIS2ZGVDM2T1k5N2drWHl3K2o1THdtQXVnZDllZGtaNnBIVGxG?=
 =?utf-8?B?enpWY0J3V3JlTi9LYXRMMnFzSy9ZY3BPdGZra1l1STViUnMwTWhPTjBtWmRn?=
 =?utf-8?B?aitZYlhEUGZ3YzBzdG4xQUZLdXZIOVF5ZGZnNndVM2Rad1Q1S1c1dVFPZEFI?=
 =?utf-8?B?ckZEcTNOdDRxMWorU3Z5MWVzV211WUs5WXJCY21PRzdBVERDYlkrbUlXYkZK?=
 =?utf-8?B?Z2RWQllxaEk1cWZFTWZRM3ZZMWRyamoybUQ3UHF4OWdqck9SLzFySDFKcncz?=
 =?utf-8?B?UFc4Q0tqTWFublAxTXdNTGFnUjBBTVczamZUQkdyQjN6ZnVFcHcyR0hFcUVj?=
 =?utf-8?B?M0FnQkgyNVpMUllreDRTTnNBQmNBVEpuQllvYytDTi9NWFhxbWI1anFoZENH?=
 =?utf-8?B?QnZxMnRIWVJhMm53a3h3bURYS3FFS2ppdndPRWIrbWtnS1NEeTUyQTNRdm5Y?=
 =?utf-8?B?bWx5Qmpmbm9ISkwwbE1lNW9OSTdTajdIVW1CaFdmSnFGemErcGhTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A64D2AB94F1AF74FB1AEBD34E33EA609@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TWaF9tk2SSHWwPEvrHh7AXUrYTxfRgCfot7a4j2rso86A98ZXmy0B3V1wzrX34b2ryqIDKDRoP31lbnZqqbt+kQ9DgfKKt3YwN6nvTgHuuMozrZyzElyIEkkUncMicXUMCxfsarxLkO54ehvmq0GYpE1KCc0K/F8nYGqbxIaz6gRrKFxk6uvtmDK7uQqYlmvh2R4heMu9C3IFTP0Mi4OyvA5w1GtpKDqVASw1r0y7mZ5VHYZpSGxBh8esOBigkdDIzGUmRHMk/m7LFG/HHyHUVxyl1viqoKsDmd8gLkEF4qYC31dOYN5zfI+5fJmOJFXCdP0X9qI6GF5KlY5KQQWoA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252afb89-7c36-4574-3cbe-08df4c4ae923
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 05:54:33.2140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVOMhotHdNjF1+k+z1lIMkbl9iB7m3WOPhYuHPoFkuJn5h9YR1F/I9KYJ91Ue5SdAh2Wa9Os/JOYCezb3cnXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB662844
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTI0IGF0IDExOjI3ICswODAwLCBRaW55dW4gVGFuIHdyb3RlOg0KPiBU
aGUgdTMyIHNpemUgb3B0aW9uIHRydW5jYXRlcyByYXcgY291bnRlciB2YWx1ZXMgdG8gMzIgYml0
cyBmb3INCj4gZGlzcGxheS4NCj4gSG93ZXZlciwgcHJpbnRfaGV4X3ZhbHVlKCkgbm93IHByaW50
cyB0aGUgZnVsbCB2YWx1ZSBldmVuIHdoZW4gdGhlDQo+IHdpZHRoDQo+IGlzIDMyIGJpdHMuIEZv
ciBleGFtcGxlLCAweDAwMDAwMGVkYzk5NGJhMGQgaXMgcHJpbnRlZCBhcyBlZGM5OTRiYTBkDQo+
IGluc3RlYWQgb2YgYzk5NGJhMGQuDQo+IA0KPiBUaGUgcHJpbnQgaGVscGVyIGNsZWFudXAgcmVw
bGFjZWQgJTA4eCBhbmQgdGhlIHVuc2lnbmVkIGludCBjYXN0IHdpdGgNCj4gJTA4bGx4LiBUaGUg
ZmllbGQgd2lkdGggaXMgYSBtaW5pbXVtLCBzbyBpdCBkb2VzIG5vdCB0cnVuY2F0ZSB2YWx1ZXMN
Cj4gdGhhdCBuZWVkIG1vcmUgdGhhbiBlaWdodCBoZXhhZGVjaW1hbCBkaWdpdHMuIFRoZSBjYXN0
IHdhcyBuZWVkZWQgdG8NCj4gZGlzY2FyZCB0aGUgdXBwZXIgMzIgYml0cy4NCj4gDQo+IFJlc3Rv
cmUgdGhlIGNhc3QgYW5kICUwOHggZm9yIHJhdyBjb3VudGVycyB1cCB0byAzMiBiaXRzIHdpZGUu
IExlYXZlDQo+IDY0LWJpdCByYXcgdmFsdWVzIGFuZCBkZWNpbWFsIGNvdW50ZXIgZm9ybWF0dGlu
ZyB1bmNoYW5nZWQuDQo+IA0KPiBGaXhlczogMDkyYjc2YTMyNTNmICgidG9vbHMvcG93ZXIgdHVy
Ym9zdGF0OiBDbGVhbnVwIHByaW50IGhlbHBlcg0KPiBmdW5jdGlvbnMiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBRaW55dW4gVGFuIDxxaW55dW50YW5AbGludXguYWxpYmFiYS5jb20+DQoNCkFja2VkLWJ5
OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCi1ydWkNCj4gLS0tDQo+IMKgdG9v
bHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90
b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+IGIvdG9vbHMvcG93ZXIveDg2
L3R1cmJvc3RhdC90dXJib3N0YXQuYw0KPiBpbmRleCA0ZTdlYmE4ZDg3NTIuLmQwZjBiNGFmNjA5
NCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuYw0K
PiArKysgYi90b29scy9wb3dlci94ODYvdHVyYm9zdGF0L3R1cmJvc3RhdC5jDQo+IEBAIC0yOTA2
LDcgKzI5MDYsNyBAQCBzdGF0aWMgaW5saW5lIGludCBwcmludF9oZXhfdmFsdWUoaW50IHdpZHRo
LA0KPiBpbnQgKnByaW50ZWQsIGNoYXIgKmRlbGltLCB1bnNpZ25lZA0KPiDCoAljaGFyICpzZXAg
PSAoKnByaW50ZWQpKysgPyBkZWxpbSA6ICIiOw0KPiDCoA0KPiDCoAlpZiAod2lkdGggPD0gMzIp
DQo+IC0JCXJldHVybiBzcHJpbnRmKG91dHAsICIlcyUwOGxseCIsIHNlcCwgdmFsdWUpOw0KPiAr
CQlyZXR1cm4gc3ByaW50ZihvdXRwLCAiJXMlMDh4Iiwgc2VwLCAodW5zaWduZWQNCj4gaW50KXZh
bHVlKTsNCj4gwqAJZWxzZQ0KPiDCoAkJcmV0dXJuIHNwcmludGYob3V0cCwgIiVzJTAxNmxseCIs
IHNlcCwgdmFsdWUpOw0KPiDCoH0NCg0K
