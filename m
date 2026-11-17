Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.171.82
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794911244;
	b=Sq3dix/Slll1LiIk006taYKBTZgm1urrsxGrTH9uzO1qABTHR5YdmBk2LUiEyTtJyI8E
	 7ZDhvr2u8Il+FbVKKV7YIY8NfdizcSBdmlavGuebgjweIXR8cNkaOWJ8NVyCjXVkio1xi
	 ZzJBRHvdBG5NwKkWKbR4B5H4bsh6eQjjGYEXp71iAKk21AZmngcSjngjVT3HxGjluAP84
	 z+CBn8qE75xoLlmXkYCPZbfZQZjTLJIeX9A/TE/IjB28+5Sp5YE402KMWc1RWCnjOnxyE
	 5zuZZKslUldVQwW4XhHkC44U3IBre1TS1apXf3QqGvR91t66t2zf9F7ziz1/+MuMf6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4dNydoDOrzAHVcXhbabDKrCKS97Tt0zNp0k+Y14k8QM=;
	b=c1GgzhOLTGF8KUdaxaLNXuWuAQQ6X1Cv6YXSvnJrw5zR+h9R8umX1tQRvVqcdpAjiOW5
	 VywcDJLUx9UHrdrxd1kAx9vRE5qCTxL+ypYqAU7yT1g4tzo0FmAMM71jCOFhQ7x9QI6Bd
	 XmxFDPYA+Ka/3IsHlwXLpjOlDE0WFQCqBn9kB95GK8OIf3Jh0WzlDmtj2h3zAAxPY8+34
	 xXKCMeRtZmTbYQn+9fmPraf066YHwOZAx1F3eRtdnwb35BsFNlXiAEsHtJN/F3Rn/BXp4
	 fzOrH2XHkuDOLjwF3Dqj+AJ7jUE/zBfV+dE04LU7YvzuVUabioWdfWMCQK/FX7M2new==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schellhasconsulting.de;
	spf=pass smtp.mailfrom=schellhasconsulting.de;
	dkim=pass header.d=schellhasconsulting.de header.i=@schellhasconsulting.de header.a=rsa-sha256 header.s=selector1 header.b=UBQ1uXko;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.171.82
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020082.outbound.protection.outlook.com [52.101.171.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47144606A337
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 10:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47144606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schellhasconsulting.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schellhasconsulting.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=schellhasconsulting.de header.i=@schellhasconsulting.de header.a=rsa-sha256 header.s=selector1 header.b=UBQ1uXko
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxMhsYkZHTKYH1JBjDBRn9t/FyJ+u5JSyyvXPIPyx22qWMEt5nk2zrDv+kXCH12Ax2PuJQIdZjuf+evNnwufHx0lt0j59FQj+MMqpLGXqOxHSuyiUJI5mY0pdHISqneP9Ws5oVzkV1rqgLN0tDEfllOc3hjBqvDJUF+1QV7jY7MoC1Cb40O8bIHfiz5itvZ9FqNMA0O+2VkErsmgrQJREpIyR7zR/Js0afvwPyVDq8ngatAbNSDAQr0v7h2BCLIF0K5EYdy07f2HBDU+SRGe61SmD6aUS1k9vDRL0sFZPMQnol0OJYH66lZN5y6P6WHoQVpATspGmpeOkl/YasrNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dNydoDOrzAHVcXhbabDKrCKS97Tt0zNp0k+Y14k8QM=;
 b=SIjLIWEas3wkmc43C1S88oBJQ9QjhvM6Xb0EP984F6HPOKgxSexeYslwtnNPa574G23+J5n/QmAOjmof+d+fuI/ef1VpMpa79lN3pWeHNKvyyMDGjW+3F/llDgzxOSMbN/sGOUTgCpe+JujYYlExX/c3hSEvjWi4uj9yoQGO8bb994A2A0E8e4QYwWLyDGGPTfz2XHESk8vNVXBctdruwtmdJ6tVxwNtUPBKe0MOgEWpu08Ov6vNgPt78PpnZGCOLifEVgZ8QXppVwbyRrhu0U+ssE2wZAgTBSsNTZTkrlB4OVRxX4IFvqX5REkvIRgum6J/nmF9KhBjvHxmFnvDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schellhasconsulting.de; dmarc=pass action=none
 header.from=schellhasconsulting.de; dkim=pass
 header.d=schellhasconsulting.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schellhasconsulting.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dNydoDOrzAHVcXhbabDKrCKS97Tt0zNp0k+Y14k8QM=;
 b=UBQ1uXkoRU78RM5MNmFrB/TdrPkVByVTuZsZpiyG908aAh6GHjif/2OhQTGNJ16DlcL3gRobybL1Sbh7h2TDh5CSEGi/DGm7E9qRPPivfT2GK5RpynQPRFSvOU9U9PTj1KsAUKJbBAp6y4OPrgf57RJsXEk5HEHQoL/Egt80JY+uGH4jVGfVavPQS0TGkPRLEZChSY/21Okc85Y9hWujdqwsl+d99p2crMKRgcas/J8imKT6TgzddYqxyVlJw0LF9Ds+esteM6ClfmVaJ+1je2+5sTgi+JSZuRKzutHjU2UG2UOVYcOVein20He/mXDx8JyxK9JOIRJ02PesUOPFAQ==
Received: from BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:29::7) by
 BENP281MB6268.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:10c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 10:27:19 +0000
Received: from BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
 ([fe80::58a9:6dd5:d6a6:4264]) by BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
 ([fe80::58a9:6dd5:d6a6:4264%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 10:27:19 +0000
From: Lars Schellhas van Kisfeld
	<lars.schellhas-van-kisfeld@schellhasconsulting.de>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through
 powercap?
Thread-Topic: [RFC] intel_rapl: exposing PL3 / PsysPL3 (MSR 0x615) through
 powercap?
Thread-Index: AQHddn2/TzZJReQw8kKuDI7YP3MdDg==
Date: Tue, 17 Nov 2026 10:27:18 +0000
Message-ID:
 <BEZSPRMB000259539D5BE9BD203C5455E87B2@BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schellhasconsulting.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZSPRMB0002:EE_|BENP281MB6268:EE_
x-ms-office365-filtering-correlation-id: 2a8181bc-6b83-4f2d-d350-08df44955bb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|10070799003|1800799024|376014|38070700021|7055299009|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 Etkecls0zRdkmD3NW1AWo6RQMxCnIXTFtj3HT8ue0L82hEDRFeGh6hlWPJsB5dauQd5b5h4sz59jyqr5SDv4Dgq54kBoZQzKxORZoIBW+puw/8FLHAZOv2+rDfRyYj6jbjD1nm0W9NzdNIrVpA4Hl2Q8RS6RWnN0P5atl5I7aw63NV6dwHSulvBTbYRW9sXqTTT31eEcVlM2XZQFlEPiVp7I+jcM1QEr3bHrwSFZ+2/F3aJj8Y9b60X4i6p/4/JtagwBh4EsTvEocIi5ie+jYl2BiS+9LQda73R6E+Yb3Oe1ktJoCm5pZZl0lz6EdnACVdmLddNerCfc03qOE9iIFoXOTP8njUv58KNNuZINmQ7EXL6UC47Eqng3onkXCKfEDsKGnJvbWx7+/ui0QrsNMEDe2XLxacK+TLQbgoy6JNJMe0vsioqkHCg51mNML2ra2PprERrITkZFh0FnIE1XiHKCmVaTBCs09odvpcsnRzEocnt9m6NEfbP/RE1FxnVOFd3TR2CnqYzNUizaF8TKBgaQDTo2VHPb+SF+uZh8g5np9eATOqEcofjXImUcbTG7H66QNwsQi3v23TtLpCFQxRVwxCwYSnubhX0jYaHvWyl6wEKJxZPYDS7F8Sn3o0sLCUoDiKMpiueo2PkBJGYj1SopWJ4EaNST/68MqBauS/y9RLCq0qbwhsgX9OmfTOYN/EOTdQ4RLeD4v4Z828hAAv1eOt44v6bSUgLnawk1R+LL+pRKk1WpaxKcxrLN63AL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(38070700021)(7055299009)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?SjECPDzmqVcmXr/G5P2sn4l8VmJ9Q+uJ6bN/D4LKZCYEFcxY+IBSiXgAZj?=
 =?iso-8859-1?Q?RgfNnGbEqx2DqGU5e4YWtKox5GvEo8afm3dn0Vt24Hqz/mrT2HTLgLrPzd?=
 =?iso-8859-1?Q?coXZlaCoCRqBgGOh+ALSZSrXs61qDI10bhA3vHLHGuOJGx6kxtTnrmHaYv?=
 =?iso-8859-1?Q?f/3iv5WhrjuYssYmZEMe7N8IvU3zpI+sFnOOMV/l6Tf5hRaqULmHeqxlma?=
 =?iso-8859-1?Q?mhZRdKX7tFHBxuDyidLItzaA3UKYcUj3jRYt44cX9Y7DCFiy9ifqQHIZ4p?=
 =?iso-8859-1?Q?cNCt3tf1L2cLXKta/uQzgtthSV7+082JLpdkR2usXOhFc2ESvEZyUudXe4?=
 =?iso-8859-1?Q?zUM2EzNkbEtiakcY39lazHHevoELk9FucntNDuaiR+zXb9RXNjjsUllMkA?=
 =?iso-8859-1?Q?QM+ABdxxPcBfL8lspe0MyxX2fABMFBLyr4VnpbEWC6Ziq+PTuqJHoqeSo1?=
 =?iso-8859-1?Q?BnQKLwaa8FGo/uUog6HXNmDuS9OAEwtgF+nCN+HtUelxszQNKtJ/yZeAu6?=
 =?iso-8859-1?Q?HCJABksYaeTIyDaA1kfUQWGACMkPpw4+7qcH4BSKGvf5ptT28lxuW+CJYT?=
 =?iso-8859-1?Q?wK3agCWYAMhCaaZZYNtL+7n6zMR4YKV/z1/zDnLw+YHY7XwQgp0Ppk247l?=
 =?iso-8859-1?Q?sSnil1aSjjGBeDmgpPP3exGlk/y9dJYBd8QOnYbzn2R9MhAP8dPOuy8oZT?=
 =?iso-8859-1?Q?wbXpMMSn+YTHMM4wZCQWvcF2VR/BEpPNby1S/IF0IcJ3b2Rtoyci2cr5WT?=
 =?iso-8859-1?Q?SrO0HMuBAMT882auTep/Q5KfMYcOFyvOGOagNFE04yIvNwCGoHVFxuYqDJ?=
 =?iso-8859-1?Q?z/svzab5EZJk/FRwP1NnxsF3KiW0mbZn87dtuibh4c39HLzebXF9BjEEvZ?=
 =?iso-8859-1?Q?YPqC+q9w8b2MHsI7GIh45090zQAmNZXgm+Qb1XFkNJvCPx3Rma44JZekE3?=
 =?iso-8859-1?Q?WyEIH1Vs242sNfAKslVCwWF+wfUe2YkK8VY2Fm86S50SN6dsI+x72W4Ez/?=
 =?iso-8859-1?Q?TpRuJdERH+i6Yktm0XMNrBGG0RVefDK2RprpUiPhVsSkWZg6z8j4C27Jj/?=
 =?iso-8859-1?Q?FoXZ81eSpczuXAQiI0x06Xiw3eTMoImuFfVYGn0SpuKUqfRs9IW8nLf3FV?=
 =?iso-8859-1?Q?A+1avjcByRKFBbXd8ma3FCDzNU2HbnuZhrpvXQgYlvjDVLPovea/irW0Cl?=
 =?iso-8859-1?Q?7SfQDAmV2U1YCqaptrz2kRh6apOLcv9XQTft41mOCKx+d+qdyvvchqSbpA?=
 =?iso-8859-1?Q?QHAuayqI3XouvUpwlMNFwiwTK3J2UErRWioid1rcKqwFcnP7AyjgdGAXCu?=
 =?iso-8859-1?Q?SX+gNk8pNKbDMYXo87746jjOJjK8WXijV4vRfaGcEu4tto2MIXrXF3mQ9Z?=
 =?iso-8859-1?Q?874TqcjfTNBWSMWCeij01N53k4z5TxDwYSAclaR9Rwm44hQINyJ7pG7n8M?=
 =?iso-8859-1?Q?RW4OlRPLaCFabtHrJZlGFRAcywJOIAPbmly3imGdeQ6BtAjKX0sdtQYjDz?=
 =?iso-8859-1?Q?3ylUzOhv7ROZtyBgnXGhXDsQkLuK5n3zQcG9iR/VenmKA9kv3j70Gejo3M?=
 =?iso-8859-1?Q?xTbIoc1tpsV/5s7gsDMVHKFW50mW5aJ8KQ5+2lQaHw5CLlHNPcW5v8CQQB?=
 =?iso-8859-1?Q?GLp8b3gtJYnkO3OeYaL/LU8aOZLr9Sv1IhuWjhUipiSp+73fs39FxXxRx9?=
 =?iso-8859-1?Q?BwaNosHgFjN4j/6GRIUZg4M3Aa26t5G0Zb+x/RtBm7Zg++LKUBx0tGKUY4?=
 =?iso-8859-1?Q?t33AjMKARsQLJHSxGqTz8uyxGHJzw4x/SZ3nEg53aI5z0ugmff3qhUvnev?=
 =?iso-8859-1?Q?dSI4VVV+yIc7IppDZa2sIxkFmYV+t67fikHSO+XhIB2lgvULmJAMHVcfC2?=
 =?iso-8859-1?Q?RI?=
x-ms-exchange-antispam-messagedata-1:
 V/5VaD/KOCMlyS/8HHWeWwNanFMP5nJpCR2YjUUD3aKUWxyWmySfyFXQdtUKmhZKRSTE6PQchxmTwg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: schellhasconsulting.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZSPRMB0002.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8181bc-6b83-4f2d-d350-08df44955bb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 10:27:18.8740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2749c6d-a11c-4d42-b10b-9f24df02f86b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TWAg1SA4OOBBxwjLMzhtv+CM/nJLXYxhioburfuBDEaqqf2mbX4vsXO550uXU4FJwujYPY80RWRy79l8hkD4lr68hA51ufGptbgOLOti0tCd9eXVg7ndMzsHCxxXfTdrcEN5D4uiAtwnKvDPAWeApwxHt3vVc/n72bdKD81iKik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BENP281MB6268

Hi,=0A=
before writing a patch I'd like to ask whether this would be welcome.=0A=
=0A=
Background: I'm working on a user-space daemon that applies the Windows=0A=
power configuration of Microsoft Surface devices on Linux [1]. On Windows,=
=0A=
Intel DTT writes MSR 0x615 dynamically as a platform peak limit. On a=0A=
Surface Book 3 (Ice Lake) the firmware sets it to 65 W (enabled); Windows=
=0A=
raises it to 100 W on AC. powercap has no constraint for it, so the daemon=
=0A=
writes 0x615 through /dev/cpu//msr, which needs CAP_SYS_RAWIO, fails under=
=0A=
lockdown and triggers the "unrecognized MSR" warning.=0A=
=0A=
What I measured: on the SB3, 0x615 binds on platform (psys) power, not on=
=0A=
package power. With 20 W in bits 14:0 and the enable bit as found, psys=0A=
power under all-core load drops from ~35 W to ~18 W. Restoring the original=
=0A=
value works. A tester saw the same write, bind and restore on an Alder Lake=
=0A=
Surface Pro 9. coreboot also treats 0x615 as PsysPL3, next to 0x65C.=0A=
=0A=
Questions:=0A=
1. Is 0x615 PsysPL3 (platform domain) on all client parts that have it, and=
=0A=
    is its layout documented publicly (time window, duty cycle in bits=0A=
    30:24, lock bit 31)? I couldn't find 615H in the public SDM.=0A=
2. Would you accept a third constraint on the psys domain for it, opt-in=0A=
    per CPU model like msr_pl4_support? Duty cycle would stay untouched.=0A=
3. Any preference for the constraint name? "peak_power" is taken by PL4.=0A=
=0A=
If this sounds reasonable, I'd send a patch for the models I can verify,=0A=
and only those.=0A=
Thanks,=0A=
Lars=0A=
=0A=
[1] https://github.com/larsschellhas/linux-surface-power=
