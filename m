Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271125C804;
	Mon, 13 Jul 2026 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921540; cv=fail; b=s7TK4tN1BsJEMirYodUcmvOr3Oc+0jWaISa3caKGT+jVRg9KJvv4Kmjz28e+3kBf6eTJ91igRFZ/nBe7rQ6NrJR50xwkcAHXps0ODQjLRL9/QN4JfZDpQ9EoYAWXkO4cEO2x5fArQn3sQ4zM1EmiQQREaJMtd4lOKBQr4mIdm+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921540; c=relaxed/simple;
	bh=ztlhZEHqiUjkDZ/S9xU4HhrE9nKoudLVyrcs2rUj+RU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FL1gCZLfL005NzD7vBVGBQK1vPKRS0nkc6jCvwQdeFaFvBeAq+2tjtvuyfOPF4uAcfG0By1TdASsXdjXOKIHifOCBoN/QbpoBvDzn2eP416v7WCZot61TQ3uR6G1jZXLkwb5Gmh5y45E+IekaBZfGz4Da0fUobAoMkU4cDCt80I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com; spf=pass smtp.mailfrom=cn.bosch.com; dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b=KMW7UKBa; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b="KMW7UKBa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/Qr3mYF2IpWxpwLRXaQOXFA3rHO7HI8brNtE3D9JtryNb+3V7rRZ45zMQvcV6kX+ulvLvz0VzbJk7hzWG7MNhP1Q5w+Z6kRuOMT/q4daqp8igcH2JGVFq9zWt68/S5jBnz4awJDkiIbbCvnCq8muTUeMyE+gp8/bYzObruB/XeKAhAem2pRJN4/Nkj82hd/9H22LkFPwBn+3bqkf0vtktFjTzOW0+fsXeTDqWcciSqmpW0bg9Ee1t7LKY5Ql+b7hfp0Y8+l+zVdJ+AhfIDBl49TeUW0H7aA34nRk03SK67iGs4v1imWXDaYPT3mmJwTHXhSdD93hspmOIbn7DijHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztlhZEHqiUjkDZ/S9xU4HhrE9nKoudLVyrcs2rUj+RU=;
 b=uNr8OsvdklBVjuU8JggIIeE5oqakBBRlLzuHwo4PppbFUuxhLKefhJyL+nED/3snSl3qzsDOb9oWKWzSP/fs9U2Zf9baV6bZrul0tSY0X3kajqjX5GPfrAaAbhAG5PoMHDHWAX4ML7kM1PsI7j2U48nZPUz0f98AX9XlbqzWVifmOi29Ig/V2tVYzVl3jOxCUlQQVJfAtcLNm2i0+lvdsrnlFdOKxGfKs611qwhdgaJL/7hhTvgseZK2sATzB6yX10pYJRsWjsuBnNOZdoFOup8NanCO0wLkkRRdRW0xGqJEW7/MtncqRmULUNxU/MPgDsSxZcPqiUV8zDDcinceYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.bosch.com; dmarc=pass action=none header.from=cn.bosch.com;
 dkim=pass header.d=cn.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztlhZEHqiUjkDZ/S9xU4HhrE9nKoudLVyrcs2rUj+RU=;
 b=KMW7UKBape+z4laIdRmGDARIOyytkbk5wPcchTAOMxTWMx1DAyYx/Ao1gyJdiJFXxU0EaFBRnnXLUWFbyiRIq/qwgzoxBCV1ryMKE5/TJMCn6fvWvFtStL7qDxVIuRJSK425216ZSdxZztbfc5HNzndRyIveUR89LNw93c+UrMU/CRNmhUIe5BiIAZxkPXNjeB9YB1t8aJXLRFmqSIik3jRG5CQrNTXFfPdrmYJ/8RwuH/3ccGtyuSNsjXQ2971H+LEDtxPj8P10IezgaTX8bMuLIqXQ/1+rJb161R445hhyzCvDI+yk3mfBspWRJ3GhQzZusvenimFsgpYsyCh4Rg==
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::8)
 by AMBPR10MB9320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 05:45:31 +0000
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b]) by PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 05:45:31 +0000
From: "CHENG Haoning (BCSC/ENG1)" <Haoning.CHENG@cn.bosch.com>
To: Frank Li <Frank.li@oss.nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: imx: Document calibration
 offset property
Thread-Topic: Re: [PATCH v4 1/2] dt-bindings: thermal: imx: Document
 calibration offset property
Thread-Index: Ad0Sinn1TRfqx6a+SJe5IVWQWjcRsw==
Date: Mon, 13 Jul 2026 05:45:31 +0000
Message-ID:
 <PAWPR10MB741597F96913C53E71700976C2FA2@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.11.3.81
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cn.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR10MB7415:EE_|AMBPR10MB9320:EE_
x-ms-office365-filtering-correlation-id: d17cf721-ecb1-43fd-c121-08dee0a1f371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 2lFiMNYJCCtHgvdVBaMNfStaM+PuKU4w/hrhlkMDZKScicwdOAtOIkveDO4r8gusJsHHJqDBH22zftk9k8AVO15inpoQDvUFqSoY6uEi+1YLEocW/o2wGZz3xAIOjRklxtKCxsVQ5NDv/fD6dSSaoxIfqscnGWnM0g86TkGi8MFc4qDzuxgKh6bPZoKnc97b6YxIu1JjZVLnSUKWTn5Y0jHVPJjA1NaKh4sjmftxYnN7GC8QoOlHcFr8vIMmfyFvXaQ04crtHqj25GhJUOlD9PVojbqBgiI7wOkRrM6r+7UqPMhrhosnF0nVm3/l2wvY3kvniZ88yUke0oZtb8PqT8hWWt1XdTXLvctVUfnkZEQqHK/aphEUY22xb0Lpw1DHYnWV9Y3xNzpY8QZvtdeYI6Lvs+sc3rF22PmODGuZKAh7D40HGASNbGK/VZNGxgN8gLWa3HwzsV2HKdInRztd9nBX6o3gPQRWq6wb0c3QBcCrMiuaU4jHEGtQlNZsA2qJjO662Mcthhms/UNeJ3xwAfrDfqiXF5J8loxRDbtZjuiT5zSeYbob42OCVkLObToVE5Hwv63EOzSCkX4GaTflEMcjZ0L+RqodA76i7SCYWpMvVBW5XWf/xLj4a0LWOf7+xUh2xbzjOLHrPVq1t2dnZsnhuprSLKySpdDJTyXCrdowN0EctuaMXFJEQEGAkze73cIOV98Gw+bMxZUgxWEMwkqYZWZfTfoZic2KTi/KT/0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1bYLstn8k2y/XW6tnc3eCUUHSxTDgQwTQVUqfCWI2vdazG3kbb+MTPjiS81O?=
 =?us-ascii?Q?DRpWFo5twJ0WyA6taMzZHnHpgzVxAZv4DzTMZFJN6MBfTxft+9oHUXOfM5Xw?=
 =?us-ascii?Q?LFnSnN/pSPoO/wzHi4JEybOLQkdN71dN/c+tn6NiV82DkzRzyttbcW9SWCjt?=
 =?us-ascii?Q?oGyTwnVyfKGhO+pmYAJC9y6Bnp2OhC39MTl+ubI1ZyHnE97RgGTQCKSvT5CZ?=
 =?us-ascii?Q?EYgGLvGHGDlVEtC9+cPgn4ehPBvj7QAbnLNDhIZKRSqeKlVeiMuIWP4H9QhN?=
 =?us-ascii?Q?gK999b3w+xaOJeQ2dXkku/XLPmQHJIiPzHoL/x2sUWwbMr1NPf1uGif8EO6D?=
 =?us-ascii?Q?Z8HIGcBGKUQjYQQV5AWl9N5F2lIySGXa6lnxR5CouB2p/+BHgV35GsWY0+JI?=
 =?us-ascii?Q?XhQoERHUuQ6vOPAohoOWB2n9/J200qetLVot48hmZhbowcmJSw7OdBPPdGU0?=
 =?us-ascii?Q?3M9pJtWsDh3p2NVNz9a3Gz+RZnsCiQ1se8GQIMWFmWrV6aX3PMsm59rr8UZW?=
 =?us-ascii?Q?szkLhhvizYHhkkztnFiZIaO8rl9lZtK/OjJIiorCxJetZ9x9NI0y8kbJB/Jv?=
 =?us-ascii?Q?aRPyuGHYSBCaAMAqmtSaGok/8OzwqfDqEB1iTPcffev0hb+cKBWlv5oK7JQ0?=
 =?us-ascii?Q?8zgAihPjnihJTEIre/0q3/siZ8tTaYbX+sYVPhfakMRQtB2038eLyag5umjc?=
 =?us-ascii?Q?WDqtQqiaj+OqiRodL8hqX57kIEPSO0EVXGZXM8LfS+uS8GLva0KZQLFfoyVP?=
 =?us-ascii?Q?m0fO0lj5xOJig1XaaBRsmOPiwmiYHZA3eynRBewXPlCFWxGIfbayKNkVSpZY?=
 =?us-ascii?Q?nWXD98rdSTcjk4veuZqtSfbSTtyIMIYYTgJdFgKdmDeI3Nu/BS1pa1+ILnYZ?=
 =?us-ascii?Q?nUmaIEDaWUNbeUkbiPlxNZFIJoJtgVA1TzrPC6kN7rozJ0HLXBgfUDDICFXv?=
 =?us-ascii?Q?65KB+w77pHWbfCpYRxmDjrg/+oAAqnwQ2AXCViDRpjTNPcAGAkaBXixYTyfk?=
 =?us-ascii?Q?VQX4a8vKK6V4Yo28WK+tHIcfAjetMBenTlqwAwhdwli+jsEDT88lg5slNqLW?=
 =?us-ascii?Q?xoSO5TbVurGBBhURD8ze/Bl1aLjNSW+w5broLjIbtJnHaMXWAhPuKV/7R7XX?=
 =?us-ascii?Q?bfuUVgVNkS0Ut1ivDDshva4gjYZcgvodcMaaGFjpw/7avQtgpiHIciep1AMX?=
 =?us-ascii?Q?jfVU4vbn4ClvGRr7cOjwmqU6nOd3jCyfYSWEroK7YzdI0z8RFyV22JP0RWli?=
 =?us-ascii?Q?nixZUyGp9AmMkZtQqgYFkXEIxoOzbiG1cODGUSyPvn7nk4figxlD3kNtLGJL?=
 =?us-ascii?Q?qEl2x+1qedgbt2BXepcrlLbQyu7+IblOM+9niZLJempJqi+Hntcwt+57+YPR?=
 =?us-ascii?Q?0mERHHN9giwlcXqPzoZXb8JbaEz0/KGWTynpsy2sYBbZ+R08aQap9hh5HQFN?=
 =?us-ascii?Q?B04BeHeeZTwHigpsAB/1PdWm7mT+xkqXoMENvllslQ886IfcRwGB919ikJln?=
 =?us-ascii?Q?GsKvuxE3+0sKjoiTZ17Tu1P+axaLb2HN7vWINB+rHmPt26IXHJJ22qWw8u6Z?=
 =?us-ascii?Q?jXOtMcM1ir03ZnxFrUuehHoQBtk8iTvE7egq0OG6FKd1KiIuCwxqP/61KcN3?=
 =?us-ascii?Q?JCojUrN0zk1CcNvwA9EuZh/0N8bsFXWMPNHiHhiArQPmLWFAnJx3M0C0b/sd?=
 =?us-ascii?Q?g0kmcYkkH0IyLBjAfFCg3ftIcTZDbLYdaJMsOoxJ7cJh45WM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cn.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d17cf721-ecb1-43fd-c121-08dee0a1f371
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 05:45:31.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxY+gEfxUgPoWzSH4vA35XBfT/LVVe/Zl1EcpxMwWFbMV794+1vz9F7/59syzIoOGSz0UMRYFBSAIQMlKqKhng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9320

>
> Thanks you for patch, but you have not answer my previous question yet.
>
> "why board difference cause such offset, I suppose it is cause by SoC=20
> variance. The offset may difference if you change to another chip.=20
> another words, if you have 1000 boards, Is this offset the same?"
>
> Or did you tune this value for each boards?
>
> Frank

Hi Frank,

Sorry for missing your question.

The offset is defined per board design, not per individual chip. All boards
with the same PCB, thermal solution, and enclosure use the same value.
Per-chip variation is already handled by the existing OCOTP calibration
data.

Regards,
Haoning
