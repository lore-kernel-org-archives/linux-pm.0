Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795766097;
	b=zDMQvjIHmelKzK246P/YK6AMJp9fm/RYeFHDc4Nr4TA6/eE67FMbv54G/jjxk5Ox2IB+
	 NEjJiN6MlES1o2ZCeuPzFnnjeJvLYwWLIwId8C27QF5nX+gqIXDWJesqvyPityrDo4WX7
	 LXbR3fTQFn6haKA46Um+npFMO+siASlQwi9WglbBLN5RpN/Xme8rAahSoOsqo3N2OgOtP
	 rvE8qShe3oAPC17v9xuvJ+yDwUdQXWsOwJtimictLIuHQMWQnEo7TyqPpIAwM7TNAXVbp
	 9QVqvawyVmfigP1fLpPQYYCEllMGDowZxdop2xzWHj4xj/z2OKJ/N2JlytYRbz3pKXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766097;
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
	bh=I1V22qaasXlAnIY81VIc3xF4QI3Avl86ww5TGNBLQaQ=;
	b=jvfC7yTVy0Um/rmzNw5QiJdg0uw41xhbciefx8c0qHP9MF7wY9ORRnSJ1z1WShSbWakh
	 3p55kJKZA8cmbVrxo+99S3rVAT0gDHvI1ZPkUBSQtL8ISlkNvGThfV8mT+xn/yXpA/zNU
	 SQlYC3U6cVy67iMjG2nv1DVt1MW/TFq5A9p9IUa9d7MLghsPmc5sYWuKOH2CmEfYXG8Hu
	 V8qsIU3VIEIANCfPUMHSOGFpEPAsA6C4Eh8UjWwFubMg3tfPLCFeg2/FG9uhKV0kCo7jj
	 INg9hBIriEMYUWGFK9xk/l7EDQ2Ofs6kzBbwRSqXAytOw8XGATLDNZydoiDXQUPccpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZpbIO0UA;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VZTq6lm2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADD606A31C;
	Fri, 27 Nov 2026 07:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6ADD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZpbIO0UA;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=VZTq6lm2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795766097; x=1827302097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I1V22qaasXlAnIY81VIc3xF4QI3Avl86ww5TGNBLQaQ=;
  b=ZpbIO0UAiHdMvJPp//mrp5HFND09P3JrvFbKrh0qEWZKAW73J57fzXwz
   cBUkECIH/FaFso2wGTkMhlEvZ/PqaqBf3q/42rv323K5dctm3UabCLr/X
   iHeYKJi37oGRkGGjHAwjMU7k5OREPFdOMsJmZwaJoQk3b1oqk+PoWz++w
   WJp3m3sV8KcZTyu1vnwKy/Y9y7psoD62ht6YhpNRF4VYUvkNTK+SNFv+q
   pWZ5azN8T1e+jMbRB/xwC9zAIDRHx2DI8Yt1bllAcRSad01fkj4mJopFA
   U0yxrDTMGZwRhMv4Gu4xMP64XfzQ1hcjKQMnH4vzBnxXA3kNBRLnPhRRT
   A==;
X-CSE-ConnectionGUID: 0S+6RpnRRXaQmi+fvVwsww==
X-CSE-MsgGUID: DTQlU11YSAahIkE2AYMjtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4577273"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577273"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:54:56 -0800
X-CSE-ConnectionGUID: XhaC1SBqRA2/cXgtkt38gg==
X-CSE-MsgGUID: kihn+RknRcW4hl68vX6ToQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12689759"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 23:54:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:54:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 23:54:55 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 23:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSygKgBZw0Ee2MULRvyW3eO70uGoJHIYM35w+A9vhPxPbZr2qbmqodhgLOcunLG8ZcJkk2+PIeeWWZgMGTodVeR1aQsgD5x0Bpel6L7sHkeChXSoX9qL+Osg1P5upzl3p1cgVkWK/lKhjxBnG0I9JSx9e+HBadW1dmc2E5zSinQJqb9IuEo40fP5Zs3ZmY3WBauNW3wz44b2Fq4/4wkXzQ8krRNjJS38KUfmNO/Fax9tmRFSFBGhDPEqP5viHvrL5GEQu+lBrFKr62KUnz45xu8QjIma1MnY7Snuwy3vQQ0sOMRNoJi0UPLrvU4mWP0XaLeD8p2KZ4v9qpPKqFYCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1V22qaasXlAnIY81VIc3xF4QI3Avl86ww5TGNBLQaQ=;
 b=aMEd79XRgVvD40Tvoy5DHdJqd3f32UQh5fGw5Mn2g8yuJG+GA/tAx9YEMCaKWYRmxDx0/j0iI/JzHUdHc4Sg59s5H0F6t9vmg9s4lFWhj1k2O6W8j9TMuYhWN9L/XCITNVXh2RL3G/WRHghmqMK+vBhjVnprq83z/HYS6KfoQlODvs3TXQkgnayN43/BLIFDMyzzlFCKCDifSB98OzC7t5fMJtsfJnZbyfzspQ3c5jMaZLPal1KrpD0XREW3jGXsT+L6RpXjqOeJUkbxWipueOMTy4xeV+Jr5KQxDX1PQbCttUnOOOcwLtvqlhaBOsfbabpTfjl9LyY+Tva2y8h2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1V22qaasXlAnIY81VIc3xF4QI3Avl86ww5TGNBLQaQ=;
 b=VZTq6lm28XETLOCNObrTKBt7AU/yGpGShLhgocGw5cLTfm4dDABLNSgE/IlwtrmB2hqY9S2FxqzntE7Wh7dNa3X2wKvqEFBvVNSxAlD7RKOPXjrmuLrscX0w8OL2EHmWVIVTwM2z3rYPe+623XVVvTKnPWIsCRrrOkI43jIEVKQ=
Received: from PH0PR11MB7493.namprd11.prod.outlook.com (2603:10b6:510:284::15)
 by MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 07:54:52 +0000
Received: from PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e]) by PH0PR11MB7493.namprd11.prod.outlook.com
 ([fe80::8734:39db:ce8:f20e%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 07:54:52 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>
CC: "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to
 ACPI _LPI
Thread-Topic: [PATCH v1 3/3] intel_idle: Allow ACPI _CST to be preferred to
 ACPI _LPI
Thread-Index: AQHdfOhImcO8VCU7QEObrPEDscDPqbdBjnwA
Date: Fri, 27 Nov 2026 07:54:52 +0000
Message-ID: <596e4a76811209f68f1e756e5171fe0d37fb2f8c.camel@intel.com>
References: <3986546.kQq0lBPeGt@rafael.j.wysocki>
	 <2080993.usQuhbGJ8B@rafael.j.wysocki>
In-Reply-To: <2080993.usQuhbGJ8B@rafael.j.wysocki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7493:EE_|MW4PR11MB6570:EE_
x-ms-office365-filtering-correlation-id: 3ffb73aa-f523-42e4-86a3-08df4c5bb7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261022105027099003|261102123227099003|38070700021|261022075727099003|10067099003|56012099006|5023799004|261026140227099003|11063799006|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|6133799003|3023799007;
x-microsoft-antispam-message-info: /TjeBvpU0uOUY/4NZn10PmT7nL4qWT2NVKfSa19OXLa0LUa6M+9ZnEHjPsDaez01RVZ8C+4DDngVvp2o7IgL/+BRujDhWU7WYkSdi7zET6yQRstsvyghrSy7h4fn+OKmpdz+8O3ckAM/8gZNFApJ+1uwh87ioz1SYP+Dlr4oCkCXQqg2OnwThlX3tYTqB5KrG9ysLUun70ksnRt/DzygI3iw83uh+mVrO8TLzbh1cML8b63d5x5XsHmen40aqvzB8ef1tAPfZJCa1n5y8CqGFnaiOSdGwcoTUyq9qTrgnypEeEMfpomxfwwZGv3Qo6UMd3Y1ulNrgX21AwBG+s935EUJmgL/Ata2l2QiMMirz7iOW7UJN1Cnwn+p0XlHLoCW6QHmmwlk9ph9qctR0XuQvOp6h1PqnQyQy0RfJwsst5Fnve4M5mc154kimnsivoKzHYSto7X/FqT++pQsDMX2Z52QSfNZmAzOgnID6g2QIdzVZ1j6uOsEALCfXAiraFq0r0YvgrhyAb4Nu6SRFnlsRnvYtGK7PGEXjIpxGcDZdx88HarKLXXd2vKdtdTdwLoaHbpb9VPMb8iqnpRdYtoenCg23yjFBlDjAUZ8GPdfVArOrH8YlIyjbT0WmlCQsYIo1B1clA79aLz9Uzj8bTLOQcLL2OSXW8uRUSfmUnFtraPHOG4369fKl/sTChja+K744WVoY0f6wgQeYJ3VnpxIcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7493.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261022105027099003)(261102123227099003)(38070700021)(261022075727099003)(10067099003)(56012099006)(5023799004)(261026140227099003)(11063799006)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjJGdFkyMDVDTjJDRXROMFpWRlBOY2FwV2NIbFAxMUsxeGpLaTRrRHAzVlJH?=
 =?utf-8?B?QXFqN3J1UVpUMUNIVEJ3Y1NBLzBkVEYyNmNUUnFtUTlMVm1NQUE2blR4SzZH?=
 =?utf-8?B?WDdsdG12a1ZSbXc4RWtkdkxINjZQaWlHK1M3akRBSDl2WUVESGdyR1lNK2Q5?=
 =?utf-8?B?RVorcWVCR0NRRlRqRGpQRTJBZC8xODZ2aVoxMnRmd0NUY29ad3MvTXpOSEJn?=
 =?utf-8?B?d3lGUUN1RjJ5UlV4Qit5T0Q1YlNObzk0OWpUejhjR2hmdXBGZitGOGtBMUNr?=
 =?utf-8?B?Rkl1c3p0Y3kvTEFIS1ZWL3N4VTFnZWlTT2h2eEc5dTFIWFFnbTdkOXdpdTNX?=
 =?utf-8?B?bitDbzZBcjB2eG1PZlFuV1VKb2wvb0ljbFBUeEZLSFE3cmhHeGsyNzJhcFVG?=
 =?utf-8?B?Y1lGcy9xRHBub0diR2NsbCtoQTl1SEQzcGtaZXVMR2p0S2hWcHIrVHV6UElr?=
 =?utf-8?B?MisvUHdaL2VtcTBVd0UwVnkycmN4Ui9iRTZ0Wkp5K211ZUN2YVVrOFB4TFVw?=
 =?utf-8?B?UmVVZ0lIVFN6YW4rbEIyK1lYdGRJaHZUbHMzQkZ1eS9FcGsvcm9xTHcxYlFU?=
 =?utf-8?B?akRiSURWdjlDNnlYOVFMVER2cjNPT2pKdHFVck9XbVZGZ3JLWURBbjNYdUZq?=
 =?utf-8?B?Z1l0am9KLytiUkxVVUtQdWlMQzlTSUNVNGRocVJva29sUmh2SDd3YmpsYmlC?=
 =?utf-8?B?Y2hhcWhrY3Rvd2J5T1ZjaU9jK05jMzRFdjdNajZYeGRGUmZUQjQ2VHZFdnA3?=
 =?utf-8?B?RWFhT2FNL0xEMGJUS2MrQTI3dFVWTTJCQ2lSeUpvdlJhb2ovcUp0aDVrMDl6?=
 =?utf-8?B?eFZ4NGUybE1qMVJlT3lFR3NpVDBHaTFmNE85SVNXTzlQak54WjRaTEVoODFp?=
 =?utf-8?B?NCtsRStha2Z0di9VbmtDdTBrUFpxVTgvb2QyTmZsNEt1SXRFTVVnQkw4MDdP?=
 =?utf-8?B?QTVrSkF1RThlbDRFa2VuNng4VnJYb1BRU0FSeUQ0UlE1NDFlNlRiNHJPcXli?=
 =?utf-8?B?M1BBQWYwTTREOWtpL1d5MXNGa2dWWHpsL21MN2tvM0hmcTcrMU1VY1RGbnVw?=
 =?utf-8?B?elg3QzhKcTYveW9TdVh4WkdPWi9QRjVkWGs5d00rYmNwUlhXSmJRTkJCaFVF?=
 =?utf-8?B?SmtKR1FCTnU1MTBQNmdsWUloeEVMRGRWYTlrZjJjcDNFTzl2alliWTBTRXQ4?=
 =?utf-8?B?WjN0d0RSWTV5QkpSWFJOaWVzdjBWN1dYM21rdDhoQTdZZThVSW1QM2FubE9I?=
 =?utf-8?B?RUZXZE96QVhaZGJ5Z0plTm50blpaMHFQdUExV1BJTmE0VmlJV21RdDVnL2N0?=
 =?utf-8?B?bGlINEhSQW5GQjkzUk84STA5OWE5aWxkcmo3R0tIUytKU0NEM2JhOGpXVTRu?=
 =?utf-8?B?U3pvRDFsUWpiRndHRXU4YTZyS0t2eDYyY1pTbUQvME1seGtTc2ZWWURkTVI1?=
 =?utf-8?B?WlBoRUFVKy9mT05UOFpVdjNMUU9waGgyWmtkaVEwK1FzVWt4ZjljS0JmVVds?=
 =?utf-8?B?WnNnOHJjMXFjN0FsRmMwZEVOK2lhU0tjQUQwalJUODExL2xPS1VvTGpGUm4x?=
 =?utf-8?B?cnJ6eUtnRTU0UU9Eb2NEb0VZVExvd2dsaFpCSHNCYVBFYWRNdHdHNklTbjc4?=
 =?utf-8?B?Z3NFb1ZxWHdSV1RzVnNhcEprdDFtSXNnSmxNWVhvRFgrMnNZUHlpd0hnSXhX?=
 =?utf-8?B?VXdMSnJlNlZpa0VkQytvK2l6V1hXNms3V1h4czJJeUMweEUvYkJhT3pNT0Ny?=
 =?utf-8?B?eXg5VmRlWjRJaFpsNWI2RWJBd210Wk9QNUNpa3NyNmR6MTJKa05MUXZMT2tN?=
 =?utf-8?B?RXQ0TGsxZFNlVFV0K0ZXdDZZZU45VFhaNDBYekI0dXZGUU1WL2lWVVlGMlJ3?=
 =?utf-8?B?eDZRK0E1b1ZTUmt1ekpjRmR5TFErbUNJQTBXUm50eDBiTnI0OWNucWJVditJ?=
 =?utf-8?B?cEFkZ0xkT1lGTG9yNTBPR1ltajdGZkVLVWphTFNaVVE5ZXg1K3hNMDRveTBP?=
 =?utf-8?B?cnRraUhmbWF1TGNjOGE5QUEwUjVXOW14dXdoQmJrR1FkektPWHgxTC9IVW5s?=
 =?utf-8?B?YzEydGNKSGI5V0gyd0hhZkllaEo3a1o2dUptOElBdEpSVlo5RFNINExZMDZn?=
 =?utf-8?B?eWhoVlFnTjhGQSs2NlhQWVYwbjR1bTlEM3p2ak9LSCs3UmxkU0RjdWpiWW84?=
 =?utf-8?B?NE8ydlVRZ1pJM00rejY3QlAwd0dvanQ2MlhIUzZnZjhMWFU1d0RWandWWmli?=
 =?utf-8?B?azJZbFNOUlVxVW45WGNqeHV1UG1LK1UyUlJIU2lxdkhZbEh1NlhJZzB6Vk5M?=
 =?utf-8?B?WURNOWN5M05OcERlNGdRNVI5aEwwWVplaGl4T0UvaFZPS2VKMUQwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48D2DC8E0355094AB504C69F3FFE8BA7@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: TjzlAtL31bbgmW7XGANbgXxvS87HMnWJhksXd7MPPrV8DRviB+14xfaiH4GisxGZw35lxLeB+w0NDZZ+bW/7BLZ9L5JnX4AFE/tS9TjIxXwYgqMk5/CGc6wRAYlzEcmTe4+aK2XzIGkwJ4lCDTv5mJ3nPIyp96x9UXoH+O3YW0Gn9i/jb+WZXYoDYCjwhxc6pPVIEWafkEqYQ+93Ucs/FEqDb91IvHTrDYMnY7hvYgOG4FA0SxLYGT88t+TrjEmiuiTL9ehWoXVIjZVdH0aMix25MQPA+bTcmKa/LwGn8YShgci9A8zYrm87/Cj8ZY3yQh7fx96qfT3R6c5+Juxesg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7493.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffb73aa-f523-42e4-86a3-08df4c5bb7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 07:54:52.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVD+f5LPfPUdFdrs6z4JvT+Xi2uiDJ4bWFrbL5fGrMC7ciIret1meB2NL4xtUIUks46Gl0E0+rOUZNMqSLYROg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTI1IGF0IDE1OjIwICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5j
b20+DQo+IA0KPiBBZGQgYSBuZXcgbW9kdWxlIHBhcmFtZXRlciBjYWxsZWQgInByZWZlcl9jc3Qi
IHRvIGludGVsX2lkbGUgZm9yDQo+IG1ha2luZw0KPiBpdCBwcmVmZXIgX0NTVCBmb3IgYnVpbGRp
bmcgdGhlIGlkbGUgc3RhdGUgbGlzdCB3aGVuIHVzaW5nIEFDUEksIGV2ZW4NCj4gaWYgX0xQSSAo
cHJlZmVycmVkIGJ5IGRlZmF1bHQpIGlzIGF2YWlsYWJsZS4NCj4gDQo+IFRoaXMgbWF5IGJlIHVz
ZWZ1bCBmb3IgZGlhZ25vc3RpY3MgZHVyaW5nIHBsYXRmb3JtIGJyaW5ndXAgYW5kIGFzIGENCj4g
ZmFsbGJhY2sgbWVjaGFuaXNtIG9uIHBsYXRmb3JtcyB3aXRoIGJyb2tlbiBBQ1BJIF9MUEkgYW5k
IGZ1bmN0aW9uYWwNCj4gQUNQSSBfQ1NULg0KPiANCj4gVXBkYXRlIHRoZSBkb2N1bWVudGF0aW9u
IGFjY29yZGluZ2x5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJh
ZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KDQpUZXN0ZWQgdGhlIGZ1bGwgc2VyaWVzIG9uIHRv
cCBvZiB2Ny40LXJjMiBvbiBhIF9MUEkgY2FwYWJsZSBwbGF0Zm9ybSwNCmFuZCBpdCB3b3JrcyBh
cyBleHBlY3RlZCBib3RoIHdpdGggYW5kIHdpdGhvdXQgdGhlIHByZWZlcl9jc3QNCnBhcmFtZXRl
ci4NCg0KVGVzdGVkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQoNCnRoYW5r
cywNCnJ1aQ0KDQo+IC0tLQ0KPiDCoERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcG0vaW50ZWxf
aWRsZS5yc3QgfCAxNSArKysrKysrKysrLS0tLS0NCj4gwqBkcml2ZXJzL2lkbGUvaW50ZWxfaWRs
ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTUgKysrKysrKysrLS0t
LS0tDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BtL2ludGVs
X2lkbGUucnN0DQo+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9pbnRlbF9pZGxlLnJz
dA0KPiBpbmRleCBkMWE2MjUxNzkwYjguLjgwOTI4MDdkNDQ2YiAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9pbnRlbF9pZGxlLnJzdA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2FkbWluLWd1aWRlL3BtL2ludGVsX2lkbGUucnN0DQo+IEBAIC05NCw3ICs5NCw5IEBA
IG9iamVjdHMgcmVwcmVzZW50aW5nIHRoZSBDUFVzIGluIHRoZSBzeXN0ZW0gYW5kDQo+IGBgX0xQ
SWBgIHByb2Nlc3NpbmcgcHJvZHVjZXMgYQ0KPiDCoG5vbi1lbXB0eSBsaXN0IG9mIHZhbGlkIGlk
bGUgc3RhdGVzLCBpdCB3aWxsIGJlIHVzZWQuwqAgT3RoZXJ3aXNlLA0KPiBgYF9DU1RgYCB3aWxs
DQo+IMKgYmUgdXNlZCBzbyBsb25nIGFzIGl0IGlzIHByZXNlbnQgdW5kZXIgYXQgbGVhc3Qgb25l
IG9mIHRoZSBBQ1BJDQo+IG9iamVjdHMNCj4gwqByZXByZXNlbnRpbmcgdGhlIENQVXMgaW4gdGhl
IHN5c3RlbSBhbmQgaXQgcmV0dXJucyBhIG5vbi1lbXB0eSBsaXN0DQo+IG9mIHZhbGlkDQo+IC1p
ZGxlIHN0YXRlcy7CoCBJbiBlaXRoZXIgY2FzZSwgc2luY2UgdGhlIGBgQ1BVSWRsZWBgIHN1YnN5
c3RlbQ0KPiBleHBlY3RzIHRoYXQgdGhlDQo+ICtpZGxlIHN0YXRlcy7CoCBbVGhlcmUgaXMgYSBt
b2R1bGUgcGFyYW1ldGVyIHRoYXQgY2FuIGJlIHVzZWQgdG8gdGVsbA0KPiB0aGUgZHJpdmVyDQo+
ICt0byBwcmVmZXIgYGBfQ1NUYGAgdG8gYGBfTFBJYGAgYW5kIHJldmVyc2UgdGhlIG9yZGVyIGlu
IHdoaWNoIHRoZXkNCj4gYXJlIHRyaWVkLl0NCj4gK0luIGVpdGhlciBjYXNlLCBzaW5jZSB0aGUg
YGBDUFVJZGxlYGAgc3Vic3lzdGVtIGV4cGVjdHMgdGhhdCB0aGUNCj4gwqBsaXN0IG9mIGlkbGUg
c3RhdGVzIHN1cHBsaWVkIGJ5IHRoZSBkcml2ZXIgd2lsbCBiZSBzdWl0YWJsZSBmb3IgYWxsDQo+
IG9mIHRoZSBDUFVzDQo+IMKgaGFuZGxlZCBieSBpdCBhbmQgYGBpbnRlbF9pZGxlYGAgaXMgcmVn
aXN0ZXJlZCBhcyB0aGUgYGBDUFVJZGxlYGANCj4gZHJpdmVyIGZvciBhbGwNCj4gwqBvZiB0aGUg
Q1BVcyBpbiB0aGUgc3lzdGVtLCBgYGludGVsX2lkbGVgYCBsb29rcyBmb3IgdGhlIGZpcnN0IENQ
VQ0KPiB3aGVyZSB0aGUNCj4gQEAgLTIyMywxMCArMjI1LDEwIEBAIGV2ZW4gaWYgdGhleSBoYXZl
IGJlZW4gZW51bWVyYXRlZCAoc2VlDQo+IDpyZWY6YGNwdS1wbS1xb3NgIGluDQo+IMKgRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9wbS9jcHVpZGxlLnJzdCkuDQo+IMKgU2V0dGluZyBgYG1heF9j
c3RhdGVgYCB0byAwIGNhdXNlcyB0aGUgYGBpbnRlbF9pZGxlYGAgaW5pdGlhbGl6YXRpb24NCj4g
dG8gZmFpbC4NCj4gwqANCj4gLVRoZSBgYG5vX2FjcGlgYCwgYGB1c2VfYWNwaWBgIGFuZCBgYG5v
X25hdGl2ZWBgIG1vZHVsZSBwYXJhbWV0ZXJzDQo+IGFyZQ0KPiAtcmVjb2duaXplZCBieSBgYGlu
dGVsX2lkbGVgYCBpZiB0aGUga2VybmVsIGhhcyBiZWVuIGNvbmZpZ3VyZWQgd2l0aA0KPiBBQ1BJ
DQo+IC1zdXBwb3J0LsKgIEluIHRoZSBjYXNlIHRoYXQgQUNQSSBpcyBub3QgY29uZmlndXJlZCB0
aGVzZSBmbGFncyBoYXZlDQo+IG5vIGltcGFjdA0KPiAtb24gZnVuY3Rpb25hbGl0eS4NCj4gK1Ro
ZSBgYG5vX2FjcGlgYCwgYGB1c2VfYWNwaWBgLCBgYG5vX25hdGl2ZWBgLCBhbmQgYGBwcmVmZXJf
Y3N0YGANCj4gbW9kdWxlDQo+ICtwYXJhbWV0ZXJzIGFyZSByZWNvZ25pemVkIGJ5IGBgaW50ZWxf
aWRsZWBgIGlmIHRoZSBrZXJuZWwgaGFzIGJlZW4NCj4gY29uZmlndXJlZA0KPiArd2l0aCBBQ1BJ
IHN1cHBvcnQuwqAgSWYgQUNQSSBpcyBub3QgY29uZmlndXJlZCwgdGhlc2UgZmxhZ3MgaGF2ZSBu
bw0KPiBpbXBhY3Qgb24NCj4gK2Z1bmN0aW9uYWxpdHkuDQo+IMKgDQo+IMKgYGBub19hY3BpYGAg
LSBEbyBub3QgdXNlIEFDUEkgYXQgYWxsLsKgIE9ubHkgbmF0aXZlIG1vZGUgaXMNCj4gYXZhaWxh
YmxlLCBubw0KPiDCoEFDUEkgbW9kZS4NCj4gQEAgLTIzNyw2ICsyMzksOSBAQCBDLXN0YXRlcyBv
bi9vZmYgc3RhdHVzIGluIG5hdGl2ZSBtb2RlLg0KPiDCoGBgbm9fbmF0aXZlYGAgLSBXb3JrIG9u
bHkgaW4gQUNQSSBtb2RlLCBubyBuYXRpdmUgbW9kZSBhdmFpbGFibGUNCj4gKGlnbm9yZQ0KPiDC
oGFsbCBjdXN0b20gdGFibGVzKS4NCj4gwqANCj4gK2BgcHJlZmVyX2NzdGBgIC0gV2hlbiB1c2lu
ZyBBQ1BJLCBwcmVmZXIgaWRsZSBzdGF0ZXMgY29taW5nIGZyb20NCj4gYGBfQ1NUYGAgdG8NCj4g
K2lkbGUgc3RhdGVzIGNvbWluZyBmcm9tIGBgX0xQSWBgICh3aGljaCBpcyBwcmVmZXJyZWQgYnkg
ZGVmYXVsdCkuDQo+ICsNCj4gwqBUaGUgdmFsdWUgb2YgdGhlIGBgc3RhdGVzX29mZmBgIG1vZHVs
ZSBwYXJhbWV0ZXIgKDAgYnkgZGVmYXVsdCkNCj4gcmVwcmVzZW50cyBhDQo+IMKgbGlzdCBvZiBp
ZGxlIHN0YXRlcyB0byBiZSBkaXNhYmxlZCBieSBkZWZhdWx0IGluIHRoZSBmb3JtIG9mIGENCj4g
Yml0bWFzay4NCj4gwqANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMg
Yi9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+IGluZGV4IGZjMGFlYTI2ZGI1MC4uM2MwNzQ2
OTU4NmY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jDQo+ICsrKyBi
L2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCj4gQEAgLTE3NzksNiArMTc3OSwxMCBAQCBzdGF0
aWMgYm9vbCBub19uYXRpdmUgX19yZWFkX21vc3RseTsgLyogTm8NCj4gZWZmZWN0IGlmIG5vX2Fj
cGkgaXMgc2V0LiAqLw0KPiDCoG1vZHVsZV9wYXJhbV9uYW1lZChub19uYXRpdmUsIG5vX25hdGl2
ZSwgYm9vbCwgMDQ0NCk7DQo+IMKgTU9EVUxFX1BBUk1fREVTQyhub19uYXRpdmUsICJJZ25vcmUg
Y3B1IHNwZWNpZmljIChuYXRpdmUpIGlkbGUNCj4gc3RhdGVzIGluIGxpZXUgb2YgQUNQSSBpZGxl
IHN0YXRlcyIpOw0KPiDCoA0KPiArc3RhdGljIGJvb2wgcHJlZmVyX2NzdCBfX3JlYWRfbW9zdGx5
OyAvKiBObyBlZmZlY3QgaWYgbm9fYWNwaSBpcw0KPiBzZXQuICovDQo+ICttb2R1bGVfcGFyYW0o
cHJlZmVyX2NzdCwgYm9vbCwgMDQ0NCk7DQo+ICtNT0RVTEVfUEFSTV9ERVNDKHByZWZlcl9jc3Qs
ICJQcmVmZXIgQUNQSSBfQ1NUIGlkbGUgc3RhdGVzIHRvIEFDUEkNCj4gX0xQSSBpZGxlIHN0YXRl
cyIpOw0KPiArDQo+IMKgc3RhdGljIHN0cnVjdCBhY3BpX3Byb2Nlc3Nvcl9wb3dlciBhY3BpX3N0
YXRlX3RhYmxlIF9faW5pdGRhdGE7DQo+IMKgc3RhdGljIGJvb2wgYWNwaV9scGlfYXZhaWxhYmxl
IF9faW5pdGRhdGE7DQo+IMKgDQo+IEBAIC0xODU1LDEzICsxODU5LDEyIEBAIHN0YXRpYyBib29s
IF9faW5pdA0KPiBpbnRlbF9pZGxlX2FjcGlfZXh0cmFjdF9jc3RfY3N0YXRlcyh2b2lkKQ0KPiDC
oA0KPiDCoHN0YXRpYyBib29sIF9faW5pdCBpbnRlbF9pZGxlX2FjcGlfZXh0cmFjdF9jc3RhdGVz
KHZvaWQpDQo+IMKgew0KPiAtCWlmIChpbnRlbF9pZGxlX2FjcGlfZXh0cmFjdF9scGlfY3N0YXRl
cygpKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gKwlpZiAocHJlZmVyX2NzdCkNCj4gKwkJcmV0dXJu
IGludGVsX2lkbGVfYWNwaV9leHRyYWN0X2NzdF9jc3RhdGVzKCkgfHwNCj4gKwkJCWludGVsX2lk
bGVfYWNwaV9leHRyYWN0X2xwaV9jc3RhdGVzKCk7DQo+IMKgDQo+IC0JaWYgKGludGVsX2lkbGVf
YWNwaV9leHRyYWN0X2NzdF9jc3RhdGVzKCkpDQo+IC0JCXJldHVybiB0cnVlOw0KPiAtDQo+IC0J
cmV0dXJuIGZhbHNlOw0KPiArCXJldHVybiBpbnRlbF9pZGxlX2FjcGlfZXh0cmFjdF9scGlfY3N0
YXRlcygpIHx8DQo+ICsJCWludGVsX2lkbGVfYWNwaV9leHRyYWN0X2NzdF9jc3RhdGVzKCk7DQo+
IMKgfQ0KPiDCoA0KPiDCoHN0YXRpYyBib29sIF9faW5pdCBpbnRlbF9pZGxlX2FjcGlfcHJvYmUo
dm9pZCkNCg0K
