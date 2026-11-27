Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795758906;
	b=D0MIuyVmyk3gkcwZ9tolARmpEKBwlvVEpLVr0Pxn0oGr/Lbu8xDN0p+TOS7L0gSFSqJ2
	 FiozS6xv1aS7dYM7uUEhHyaCw1X2djFHUkpJ8j2WzAE5XeXFi18QtwgrG6cP8AIyCXAoi
	 VRjGNoY+YBXUNqNbqixxFQT/yHhdOeV9IMDTSPNeLYSDOwb65MFDnCRlhFYooIvvuc+7x
	 UcrAMTRKCTT4uwVvZ4gc87tBrzjQP6MCzLpJ2mY4YI0QxDoRPw63lnKanvzsUaIBDxy1h
	 0cMQ7ELhNr9gq1WSWJ18vMSs7yrnaqR4tQhnB+xENG/URNo35WY0jf9CrpKSxtVL9yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758906;
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
	bh=vfXHiMxrSEE85JJase3cQ+ilUn2bTn2UsNLfAznsdOI=;
	b=vnbGxlZw2LOP34bDSsp+wWHffUafprNezbgsp0G07Q5Z+uBwQ79fwpBsUuiXefA3CT1k
	 hCrUyJ3RlR/ugzo/gB0+uH1HFAd88z65+vrD4vIYEh3mcnHSrFbKnBYCPy1OULBjLms3+
	 JZhQokK0JtXpg7IozsMlCaNhvSPXlMd2oWu2iqiEcESTpG2tc2lAaLSGwWIwwCc1EJ5YF
	 dltxbGWOpEcuDupNM+i2ak6PoI4zjFsXuJoe1FwlGM1XRwXJemIRyJSejaqVXSScbPK9X
	 oDZzDHe1ORv45/P7lXo3DAEMSJibuIBwtUhLjQF5xRNuuCX6B2OsOvgwtBZzevOiYlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQd4baqa;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ThED1CtI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98218606A31C;
	Fri, 27 Nov 2026 05:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98218606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQd4baqa;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ThED1CtI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795758906; x=1827294906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vfXHiMxrSEE85JJase3cQ+ilUn2bTn2UsNLfAznsdOI=;
  b=LQd4baqapbO3gd1RxOCAheWK6NtqjiRmdHm4NaO6kfuUzH324Y+rjyAr
   7CFI+lIVXbSFSUjMzF9LNKWWGWhlcpDbrpDzwYp4vCVP9XthGwS8qYk6H
   lE0B9+FF6bLfPk2JJQMbt9CLukjT2vykUwlFjgxGRRSA8L1JFynDXu6ZS
   GhDiW81Og6SYc1Bcqoj2IdZLxUCdJvHKdvnjywW8UDl+V1wTzZ6r8LNDX
   H7iNWwgQTZsjlse7Vwx1u6Eazig22cNo/7z7zzLazubiocqoruouN6kXU
   /9kQ1mm505xIJH5KUYups77ppFFUY/SiIQ0cAw8wdhfFtwhBXhtE54UEn
   g==;
X-CSE-ConnectionGUID: xhErsGjyQ1KFOqIuz0O+5Q==
X-CSE-MsgGUID: aPwmqr2TTty8VaSdqWB7Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4575185"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4575185"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:55:05 -0800
X-CSE-ConnectionGUID: 0TeLJJ27R3it1yucLpMAcg==
X-CSE-MsgGUID: YzNVyfljRh2c3FzvrMjwXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12664790"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 21:55:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:55:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 21:55:04 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 21:55:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4ytx6oFIg55F8Xhzf8eV40x4q28t4HefC5Dx2VxznxRvHtggSCTTpkp8B6usHfCOZJifgxDJkzNr4b8qTsa5IUO1zZPPnELzrfAMTb7826mOo8k8eKE4BLC1GH7fGv3yDvc6o1wBplBz83zqXxsxwhgjr1ahW16qEcuGM1m8+bd5hQHzLr6SCzC53fUzKLJl06bIP5Jd+RC5fZ4BGt43GNWkudKDHjGnMrsqOVGOfNgS1DWM18s9gMPvH3384dcmuiBfBrurH0u6HhsGmpu2a5ifqWNdg/bS6Bw0RK/bMQfBeO5wZVZsOF+JwXtfVXt6GncoCBQ6AkXOQ3Fg7xQjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfXHiMxrSEE85JJase3cQ+ilUn2bTn2UsNLfAznsdOI=;
 b=iPT7VxRIE1g5kKKcvKZ9GSUSGvC1n+JjiYnT1LBJNEgRq57A6MW4FnUehmpmsDpzZtxVlZzMYBcIG3s2a6aLUkn63x4OIO+/0bBuv0KRc2D4mEWrJcnswvfF/7fCH64avonH8uURt5zY53s+JyE2hYk/JYneoWtS2xhAjGkis0gaejAlbKHgRI2Dpdz6xqoSgy1hy2gAZgxIFLNxInuJI7H5qisDMVvQvMTzONITAdnEnS2AB6RTLFf4CGsv97RlbCOpFD4MmsfPjjeZlvDuPL/LOq6X0Lg+fOGps1BgoJzUOpoL8ancuH3FjCnpxsaWz5lqevQyROYHrx5GIunPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfXHiMxrSEE85JJase3cQ+ilUn2bTn2UsNLfAznsdOI=;
 b=ThED1CtIW8IxDHFWVjetEBm16WKd8NV7DESxKG7J6J7dTW5z4VKHAY3J1LVAk+QikKhxjdAlEJ+0TZ0bShoFZeBjBi66vqsUzjGvMh/var7A/OJWqrHz9nRkMxc2bh5YPtLT7SAQtbCm7fw4neZg8zGTUdTUh6mPURMQwhek/3A=
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by SA3PR11MB662844.namprd11.prod.outlook.com (2603:10b6:806:538::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 05:55:02 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:55:02 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "qinyuntan@linux.alibaba.com" <qinyuntan@linux.alibaba.com>,
	"lenb@kernel.org" <lenb@kernel.org>
CC: "michael.hebenstreit@intel.com" <michael.hebenstreit@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"xlpang@linux.alibaba.com" <xlpang@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools/power turbostat: Fix --cpu summary description
Thread-Topic: [PATCH 3/3] tools/power turbostat: Fix --cpu summary description
Thread-Index: AQHdfjPYlK5BKVh/DkKlCPaVSaMZfA==
Date: Fri, 27 Nov 2026 05:55:02 +0000
Message-ID: <15912f0a1e7626fa0a663b09a2bfc62553ece360.camel@intel.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
	 <20261124032723.157254-4-qinyuntan@linux.alibaba.com>
In-Reply-To: <20261124032723.157254-4-qinyuntan@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|SA3PR11MB662844:EE_
x-ms-office365-filtering-correlation-id: a36a4f81-8a59-4c7e-6854-08df4c4afa9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|10067099003|56012099006|11063799006|5023799004|261022075727099003|261022113327099003|261026121527099003|261021121427099003|261102123227099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|6133799003|3023799007;
x-microsoft-antispam-message-info: KVNIG/llrmO5CEcg8GZxbbvnbUIK5j2xBJZCFjVQOLyIiq0+EFDHnwzHwi1R8weSX2sIIXNjEDMy3tdycGhBWjIP2+MHYXSnq2XRUt2Oi7Y4gVtcKPQcGqx52uAgAki0pkhdp++/PzlGT+vW2kyZPGJFVK6wrYczBYJB6h9rvAq3Hb2OkNWOe8NG/VPdPvM4JuhOA58aiHwgZ72zwk6BLU22DiddJfjOybb73G38a+8Po7LyqUuSZlErfZaJw5a7Mo5ub3H/n5wxyG9qK0DwFZxYWJWdg/gWWUCkCZqd+R5etvXkkRR9jLZhg2xzFc91u/T+eZZX3qQEIAGLvYcpR/d78EXGxjLXP3BBnEzHFe07W75Ehz5TaGbRf53jkPdpwqyIv+xZRqENI8NO4ctjeu8h/lY+zA2pBCP5vt9qi4UNmyMIad1OeUeMfOrHR4ZCCP1Sa79tQOOhCs6Od5As1whie810rXkO4bIla4QpTgYNUYdQ5jvqkhioOkwS/dQBwjAzbdbKO/zUPtyUYWADzbXEndon/ixWmPahDgpzQIeEZPB7WG/TnTdaKb+lt/J1H4sVwb3zra4O2yv9PbwNwGhw2Gyt0TMygSOGl7ArhpZ6h8zruUr7otDODgX+ses0hOxkshCQk6xFuiDQQZ36fj0GXggGZKo5q3G7xTmK9zVICt13vxLgBllYsPUlLjo8ow+vr0850o5yp3K509z3uFa6G7uovGhyrMxSNEqWGck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004)(261022075727099003)(261022113327099003)(261026121527099003)(261021121427099003)(261102123227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZ2MW41MG8wWFlHQkh5QldFeDRTQ3BuZjFRNW4vWXdmbUo2TUYvUUpIbW5x?=
 =?utf-8?B?cFRXV05xMjhNVC9ZVVd4YTdvZ1FLTVJKaERxcGx5RXlpRXVFdXlxK2o1U0ND?=
 =?utf-8?B?YlRnNjJiYTVnTFlBU2FySjZTSlpONVc2Qzl6OC90dUpIWTlGSW9jN2U2VnBE?=
 =?utf-8?B?VWN5REErZGN3ZURqVWVKdzhYSkxyRHhLSVVha1RUbHRzZzlEUHN0alZYRTFY?=
 =?utf-8?B?Nm80UklKVlNNZ0JSa0ltTmRpQXpsMzk0Q1gzSEVOQWtrOVBKN2I3aGJPbGJx?=
 =?utf-8?B?T1AzYyt0NXRBcTJoY01sZG5BMXQvMHNXek01cnVvbmNPdFJlSi8xNHBYNWpP?=
 =?utf-8?B?dmdHLzZjaTJVZ3hVdURBeW94SGl4VEJmRXBFQ2JUeGdDRlVXMnpPWmtGeEhm?=
 =?utf-8?B?dlUwUHhZTFpUMWxCb1lwYm5vc1RuNU1Qemg3Q0RQZ1BybWdDQm94YkkxeDRw?=
 =?utf-8?B?cjZiOE15ZW5ySUc4aXdWeFBEY2M5S1I2SXJKR1dkUWkzazZjY3V3TXVpMzVV?=
 =?utf-8?B?SlFsdDBkZUdLQmQ2UzAzcGlLSnFKZ3dCWTBUOUdNUkh3ZFFHT1ErYkNOWmd5?=
 =?utf-8?B?aDM3cXFoMkhNd1BqS0tTS2hTNkNpOHowY3JzR2I4WnpqUTBqUUtBOFVBWjlL?=
 =?utf-8?B?dVBwZms4ZjlBOWxDSlRGV085ck4xNUVOV3NWbWpSa3NjSkRTMmpmb0I3azZp?=
 =?utf-8?B?M1FRamZOZGJlZ3A3Q053U1ZWM1M3ekpyeWFPTGFVZncydXhWdEtLYkNGQjVX?=
 =?utf-8?B?ZS8zOU1XaTk0WGFzZmJvWEdLeUw3OUdVQzJFWWdTK1NPWDBXN1NkeEVQb0JU?=
 =?utf-8?B?TUNuYkRwczBsK1dnak0vV3JiNEhnM0pyVlp5Z21NN0JFWk5oVVFEWk1CaE9F?=
 =?utf-8?B?VUxMM2ZpM3VxM0JpZlZJYzVIK1J3TGtLUGg4d05wZVE3KzdnT3ozOVdJaHc1?=
 =?utf-8?B?ZC9WdndqbDFNemg3dFBxc0VVdUYrMmUzb1ptQXlTdGZ6U1BhVFNmUTF5c0Z6?=
 =?utf-8?B?UU53U3Q1b255VkdIV09Qd1IvalBJcm8xZVY2cDAwWFVYL2tpVGZESU51UC9j?=
 =?utf-8?B?blpCVGJKMmtBcXQ0TUtkR3lUVk5zaWkwckZkYUFHUnRwUXVYNFU3RVltVUxB?=
 =?utf-8?B?c1hYaTc3ZTJBd0pVUHZ4RzN3Nmt5M1lCWjg1d1Q2UXEvMjMvTXlaVUx1YjF6?=
 =?utf-8?B?azFqenBGaXNUaUtiTTlTSVdWTUZQeWszcVQ5TVFkV1VuUm51NURjWjF0ampH?=
 =?utf-8?B?Si9kR1FVUk9WUzlqZ1ArV2RPaDdJVjVOYmNBcUhkY3d1QWRtVThrQlUzcmI4?=
 =?utf-8?B?c0I4M0NBZTVxenY5cHRUaFI2WUFuQmdocUJUOHExLzhPcE9WSkZBai9FQWg2?=
 =?utf-8?B?ZGw2VDdnY1gycm5VM3Q1ZXo1UnpJVmNNa3FLcW0vZWFBR2VVMmYzd3dNTUZ5?=
 =?utf-8?B?MFJhQ3JjeC9oNGJqazFTNksvd0g2R2hmK1dLK0lYRHNRZnNoeTg5YVpCT0xa?=
 =?utf-8?B?ZTU2ZWU3OG1QemZ3OFJrU1lTaGJtNHc0TlBvczFyYktHbUZGRmkxKzlWOVkz?=
 =?utf-8?B?UXZTWHpzUlhGRGR3KzFuRVd0WEUxZmlrR1YwK3l0a1NCTEtVTUgyY2w3SkJ2?=
 =?utf-8?B?VjMzK0RXTHQ0VWZWRzh5U1Y1ZHAwcEZ6cWNTN0FUcmRHVWNHVGRSTCtuTlVt?=
 =?utf-8?B?bk9ldUtLU1ZWWldyK1h3V3AvVWd1WS90OWJweFp5TUFBRWZCTFNpY0l4WHk5?=
 =?utf-8?B?Q1dETEJ4TGdtaExPK2xKWVB6cExINnJpWEx1SmZqVFFlUWhzQXFmOVdTNjU1?=
 =?utf-8?B?cEovQmhhbTVGb3lhTmVRaHZaVWM3VjY3N1d5cDFMWlU4RStnV3AwV2U3VHc3?=
 =?utf-8?B?UlcvUG9OdGRyY2NxenZyOW45Qnc1UzNSaTRJQ1c5YzlGU2dBMGp0RGl0aDJT?=
 =?utf-8?B?ZHVPZURnOTJ0bVkvNnFrc1pJL2N2TDJZVGtoOVhDU011c1VSMXBkaTJIdExG?=
 =?utf-8?B?THpjVHo1RzJYYzVPV1ZTUk01YTZXa1pHU0VhZnlDVm1IaHpkb2ZwMEhlUkd2?=
 =?utf-8?B?WkZIT3NmN0VVVDZHREZOM244aGgxNDNnRXM5clJUTDZoN1M3bzBVUUorR0NC?=
 =?utf-8?B?Z3phRUZwNnJiUDRkeVdFNDhYQ0dIb1lWbW9oZzg4cXkxWnhOaWJzVmZBT0NW?=
 =?utf-8?B?TEhWVzVZWDh4V0ZySkpXc1dTQjFJUEdxSUp1TWhDTHNUZ3hUelBwNG5reFJJ?=
 =?utf-8?B?NisvWmttOG9xUFBqWGlQQUo4SWF4MTdVdUJNNnFSaEpQL2xBeER6RjkzNElt?=
 =?utf-8?B?SmpteDBqRUM3OUY0UXpQRU5WeTVhZTJIZExoQWFSWWdwak12RUhzQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9F1AF00FF3EF445A378D0658BB7E8E0@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: lHbAA04TD1KKUbR2pZEZYDdtlFCCc8pCs+JRjEa436ajJGAKeee3uoZNxsF4T5UW/WanGep+9EjROGnxKALOBM2c4j6LajycjJcf/Jjrb+T62ey6YothsZSe24fBb7wPUL714JsjLyA0mP4uxuBMlZuAI6yMEpKvyMUhcshsD2NuKeyILgSocRh4kUNuFsH0x5/SrAd7Dcno+OTrUVHvsaJ54PfjCNPmywXRR9wgc9buO3w9XsVTYCGkdtT10kWSTmX9w0fG/7jeXN4O2aA1GTJ6zDrh2cywnE/a5eHOgeDFa33wYCaGAuMka7HwvRzPJO7tU8BeQRvJ82yvp9A06Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36a4f81-8a59-4c7e-6854-08df4c4afa9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 05:55:02.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qiMJMXgVjCBmcnMdjHRz37+r0xGW4HptA8V6jgy/Xit1PaN4ZRZDhhXjibmTErfdpBWSuVhkaRc21vraI1NvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB662844
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTExLTI0IGF0IDExOjI3ICswODAwLCBRaW55dW4gVGFuIHdyb3RlOg0KPiBU
aGUgbWFuIHBhZ2Ugc3RhdGVzIHRoYXQgLS1jcHUgb25seSBmaWx0ZXJzIG91dHB1dCBhbmQgdGhh
dCB0aGUNCj4gc3VtbWFyeQ0KPiBhbHdheXMgaW5jbHVkZXMgYWxsIENQVXMuIE51bWVyaWMgQ1BV
IHNlbGVjdGlvbnMgYWxzbyByZXN0cmljdA0KPiBjb3VudGVyDQo+IGNvbGxlY3Rpb24gYW5kIHRo
ZSBzdW1tYXJ5LCB3aGlsZSBjb3JlIGFuZCBwYWNrYWdlIG9ubHkgZmlsdGVyDQo+IGRpc3BsYXll
ZA0KPiByb3dzLg0KPiANCj4gQ29ycmVjdCB0aGUgb3B0aW9uIGFuZCByb3cgZGVzY3JpcHRpb25z
IHRvIG1hdGNoIHRoaXMgYmVoYXZpb3IuDQo+IA0KPiBGaXhlczogMGZlMzc1MjkwMTM3ICgidG9v
bHMvcG93ZXIvdHVyYm9zdGF0OiBPYmV5IGFsbG93ZWQgQ1BVcyBmb3INCj4gc3lzdGVtIHN1bW1h
cnkiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBRaW55dW4gVGFuIDxxaW55dW50YW5AbGludXguYWxpYmFi
YS5jb20+DQoNCkFja2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCi1y
dWkNCj4gLS0tDQo+IMKgdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQuOCB8IDQg
KystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90dXJib3N0YXQu
OA0KPiBiL3Rvb2xzL3Bvd2VyL3g4Ni90dXJib3N0YXQvdHVyYm9zdGF0LjgNCj4gaW5kZXggYzkw
NTE5OGQwNTAxLi5jMmI4NmQyMGRiOTUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Bvd2VyL3g4Ni90
dXJib3N0YXQvdHVyYm9zdGF0LjgNCj4gKysrIGIvdG9vbHMvcG93ZXIveDg2L3R1cmJvc3RhdC90
dXJib3N0YXQuOA0KPiBAQCAtOTIsNyArOTIsNyBAQCBuYW1lIGFzIG5lY2Vzc2FyeSB0byBkaXNh
bWJpZ3VhdGUgaXQgZnJvbSBvdGhlcnMgaXMNCj4gbmVjZXNzYXJ5LsKgIE5vdGUgdGhhdCBvcHRp
b24NCj4gwqAJCScleCcgaGV4IGlkZW50aWZpZXIgb2YgdGhlIFBNVCBNTUlPIHJlZ2lvbi4NCj4g
wqAuZmkNCj4gwqAuUFANCj4gLVxmQi0tY3B1IGNwdS1zZXRcZlAgbGltaXQgb3V0cHV0IHRvIHN5
c3RlbSBzdW1tYXJ5IHBsdXMgdGhlDQo+IHNwZWNpZmllZCBjcHUtc2V0LsKgIElmIGNwdS1zZXQg
aXMgdGhlIHN0cmluZyAiY29yZSIsIHRoZW4gdGhlIHN5c3RlbQ0KPiBzdW1tYXJ5IHBsdXMgdGhl
IGZpcnN0IENQVSBpbiBlYWNoIGNvcmUgYXJlIHByaW50ZWQgLS0gZWcuIHN1YnNlcXVlbnQNCj4g
SFQgc2libGluZ3MgYXJlIG5vdCBwcmludGVkLsKgIE9yIGlmIGNwdS1zZXQgaXMgdGhlIHN0cmlu
ZyAicGFja2FnZSIsDQo+IHRoZW4gdGhlIHN5c3RlbSBzdW1tYXJ5IHBsdXMgdGhlIGZpcnN0IENQ
VSBpbiBlYWNoIHBhY2thZ2UgaXMNCj4gcHJpbnRlZC7CoCBPdGhlcndpc2UsIHRoZSBzeXN0ZW0g
c3VtbWFyeSBwbHVzIHRoZSBzcGVjaWZpZWQgc2V0IG9mDQo+IENQVXMgYXJlIHByaW50ZWQuwqAg
VGhlIGNwdS1zZXQgaXMgb3JkZXJlZCBmcm9tIGxvdyB0byBoaWdoLCBjb21tYQ0KPiBkZWxpbWl0
ZWQgd2l0aCAiLi4iIGFuZCAiLSIgcGVybWl0dGVkIHRvIGRlbm90ZSBhIHJhbmdlLiBlZy4NCj4g
MSwyLDgsMTQuLjE3LDIxLTQ0wqAgTXVsdGlwbGUgaW52b2NhdGlvbnMgb2YgLS1jcHUgYXJlIE9S
J2QgdG9nZXRoZXIuDQo+ICtcZkItLWNwdSBjcHUtc2V0XGZQIHNlbGVjdCBDUFVzIHRvIG1vbml0
b3Igb3IgbGltaXQgdGhlIHJvd3MNCj4gZGlzcGxheWVkLsKgIElmIGNwdS1zZXQgaXMgdGhlIHN0
cmluZyAiY29yZSIsIHRoZW4gdGhlIHN5c3RlbSBzdW1tYXJ5DQo+IHBsdXMgdGhlIGZpcnN0IENQ
VSBpbiBlYWNoIGNvcmUgYXJlIHByaW50ZWQgLS0gZWcuIHN1YnNlcXVlbnQgSFQNCj4gc2libGlu
Z3MgYXJlIG5vdCBwcmludGVkLsKgIE9yIGlmIGNwdS1zZXQgaXMgdGhlIHN0cmluZyAicGFja2Fn
ZSIsDQo+IHRoZW4gdGhlIHN5c3RlbSBzdW1tYXJ5IHBsdXMgdGhlIGZpcnN0IENQVSBpbiBlYWNo
IHBhY2thZ2UgaXMNCj4gcHJpbnRlZC7CoCBPdGhlcndpc2UsIGNvdW50ZXIgY29sbGVjdGlvbiwg
b3V0cHV0IGFuZCB0aGUgc3lzdGVtDQo+IHN1bW1hcnkgYXJlIHJlc3RyaWN0ZWQgdG8gdGhlIHNw
ZWNpZmllZCBzZXQgb2YgQ1BVcy7CoCBUaGUgY3B1LXNldCBpcw0KPiBvcmRlcmVkIGZyb20gbG93
IHRvIGhpZ2gsIGNvbW1hIGRlbGltaXRlZCB3aXRoICIuLiIgYW5kICItIiBwZXJtaXR0ZWQNCj4g
dG8gZGVub3RlIGEgcmFuZ2UuIGVnLiAxLDIsOCwxNC4uMTcsMjEtNDTCoCBNdWx0aXBsZSBpbnZv
Y2F0aW9ucyBvZiAtLQ0KPiBjcHUgYXJlIE9SJ2QgdG9nZXRoZXIuDQo+IMKgLlBQDQo+IMKgXGZC
LS1oaWRlIGNvbHVtblxmUCBkbyBub3Qgc2hvdyB0aGUgc3BlY2lmaWVkIGJ1aWx0LWluIGNvbHVt
bnMuwqAgTWF5DQo+IGJlIGludm9rZWQgbXVsdGlwbGUgdGltZXMsIG9yIHdpdGggYSBjb21tYS1z
ZXBhcmF0ZWQgbGlzdCBvZiBjb2x1bW4NCj4gbmFtZXMuDQo+IMKgLlBQDQo+IEBAIC0xMzgsNyAr
MTM4LDcgQEAgVGhlIFxmQmNvbW1hbmRcZlAgcGFyYW1ldGVyIGZvcmtzIFxmQmNvbW1hbmRcZlAs
DQo+IGFuZCB1cG9uIGl0cyBleGl0LA0KPiDCoGRpc3BsYXlzIHRoZSBzdGF0aXN0aWNzIGdhdGhl
cmVkIHNpbmNlIGl0IHdhcyBmb3JrZWQuDQo+IMKgLlBQDQo+IMKgLlNIIFJPVyBERVNDUklQVElP
TlMNCj4gLVRoZSBzeXN0ZW0gY29uZmlndXJhdGlvbiBkdW1wIChpZiAtLXF1aWV0IGlzIG5vdCB1
c2VkKSBpcyBmb2xsb3dlZA0KPiBieSBzdGF0aXN0aWNzLsKgIFRoZSBmaXJzdCByb3cgb2YgdGhl
IHN0YXRpc3RpY3MgbGFiZWxzIHRoZSBjb250ZW50IG9mDQo+IGVhY2ggY29sdW1uIChiZWxvdyku
wqAgVGhlIHNlY29uZCByb3cgb2Ygc3RhdGlzdGljcyBpcyB0aGUgc3lzdGVtDQo+IHN1bW1hcnkg
bGluZS7CoCBUaGUgc3lzdGVtIHN1bW1hcnkgbGluZSBoYXMgYSAnLScgaW4gdGhlIGNvbHVtbnMg
Zm9yDQo+IHRoZSBQYWNrYWdlLCBDb3JlLCBhbmQgQ1BVLsKgIFRoZSBjb250ZW50cyBvZiB0aGUg
c3lzdGVtIHN1bW1hcnkgbGluZQ0KPiBkZXBlbmRzIG9uIHRoZSB0eXBlIG9mIGNvbHVtbi7CoCBD
b2x1bW5zIHRoYXQgY291bnQgaXRlbXMgKGVnLiBJUlEpDQo+IHNob3cgdGhlIHN1bSBhY3Jvc3Mg
YWxsIENQVXMgaW4gdGhlIHN5c3RlbS7CoCBDb2x1bW5zIHRoYXQgc2hvdyBhDQo+IHBlcmNlbnRh
Z2Ugc2hvdyB0aGUgYXZlcmFnZSBhY3Jvc3MgYWxsIENQVXMgaW4gdGhlIHN5c3RlbS7CoCBDb2x1
bW5zDQo+IHRoYXQgZHVtcCByYXcgTVNSIHZhbHVlcyBzaW1wbHkgc2hvdyAwIGluIHRoZSBzdW1t
YXJ5LsKgIEFmdGVyIHRoZQ0KPiBzeXN0ZW0gc3VtbWFyeSByb3csIGVhY2ggcm93IGRlc2NyaWJl
cyBhIHNwZWNpZmljIFBhY2thZ2UvQ29yZS9DUFUuwqANCj4gTm90ZSB0aGF0IGlmIHRoZSAtLWNw
dSBwYXJhbWV0ZXIgaXMgdXNlZCB0byBsaW1pdCB3aGljaCBzcGVjaWZpYyBDUFVzDQo+IGFyZSBk
aXNwbGF5ZWQsIHR1cmJvc3RhdCB3aWxsIHN0aWxsIGNvbGxlY3Qgc3RhdGlzdGljcyBmb3IgYWxs
IENQVXMNCj4gaW4gdGhlIHN5c3RlbSBhbmQgd2lsbCBzdGlsbCBzaG93IHRoZSBzeXN0ZW0gc3Vt
bWFyeSBmb3IgYWxsIENQVXMgaW4NCj4gdGhlIHN5c3RlbS4NCj4gK1RoZSBzeXN0ZW0gY29uZmln
dXJhdGlvbiBkdW1wIChpZiAtLXF1aWV0IGlzIG5vdCB1c2VkKSBpcyBmb2xsb3dlZA0KPiBieSBz
dGF0aXN0aWNzLsKgIFRoZSBmaXJzdCByb3cgb2YgdGhlIHN0YXRpc3RpY3MgbGFiZWxzIHRoZSBj
b250ZW50IG9mDQo+IGVhY2ggY29sdW1uIChiZWxvdykuwqAgVGhlIHNlY29uZCByb3cgb2Ygc3Rh
dGlzdGljcyBpcyB0aGUgc3lzdGVtDQo+IHN1bW1hcnkgbGluZS7CoCBUaGUgc3lzdGVtIHN1bW1h
cnkgbGluZSBoYXMgYSAnLScgaW4gdGhlIGNvbHVtbnMgZm9yDQo+IHRoZSBQYWNrYWdlLCBDb3Jl
LCBhbmQgQ1BVLsKgIFRoZSBjb250ZW50cyBvZiB0aGUgc3lzdGVtIHN1bW1hcnkgbGluZQ0KPiBk
ZXBlbmRzIG9uIHRoZSB0eXBlIG9mIGNvbHVtbi7CoCBDb2x1bW5zIHRoYXQgY291bnQgaXRlbXMg
KGVnLiBJUlEpDQo+IHNob3cgdGhlIHN1bSBhY3Jvc3MgdGhlIG1vbml0b3JlZCBDUFVzLsKgIENv
bHVtbnMgdGhhdCBzaG93IGENCj4gcGVyY2VudGFnZSBzaG93IHRoZSBhdmVyYWdlIGFjcm9zcyB0
aGUgbW9uaXRvcmVkIENQVXMuwqAgQ29sdW1ucyB0aGF0DQo+IGR1bXAgcmF3IE1TUiB2YWx1ZXMg
c2ltcGx5IHNob3cgMCBpbiB0aGUgc3VtbWFyeS7CoCBBZnRlciB0aGUgc3lzdGVtDQo+IHN1bW1h
cnkgcm93LCBlYWNoIHJvdyBkZXNjcmliZXMgYSBzcGVjaWZpYyBQYWNrYWdlL0NvcmUvQ1BVLsKg
IFRoZQ0KPiBzeXN0ZW0gc3VtbWFyeSBjb3ZlcnMgdGhlIENQVXMgYmVpbmcgbW9uaXRvcmVkOyBz
ZWUgLS1jcHUgZm9yIENQVQ0KPiBzZWxlY3Rpb24uDQo+IMKgLlNIIENPTFVNTiBERVNDUklQVElP
TlMNCj4gwqAuUFANCj4gwqBcZkJ1c2VjXGZQIEZvciBlYWNoIENQVSwgdGhlIG51bWJlciBvZiBt
aWNyb3NlY29uZHMgZWxhcHNlZCBkdXJpbmcNCj4gY291bnRlciBjb2xsZWN0aW9uLCBpbmNsdWRp
bmcgdGhyZWFkIG1pZ3JhdGlvbiAtLSBpZiBhbnkuwqAgVGhpcw0KPiBjb3VudGVyIGlzIGRpc2Fi
bGVkIGJ5IGRlZmF1bHQsIGFuZCBpcyBlbmFibGVkIHdpdGggIi0tZW5hYmxlIHVzZWMiLA0KPiBv
ciAtLWRlYnVnLsKgIE9uIHRoZSBzdW1tYXJ5IHJvdywgdXNlYyByZWZlcnMgdG8gdGhlIHRvdGFs
IGVsYXBzZWQNCj4gdGltZSB0byBzbmFwc2hvdCB0aGUgcHJvY2ZzL3N5c2ZzIGFuZCBjb2xsZWN0
IHRoZSBjb3VudGVycyBvbiBhbGwNCj4gY3B1cy4NCg0K
