Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681573AA1A8;
	Fri, 17 Jul 2026 06:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269434; cv=fail; b=WyTIKsGMfpr/s51A8eDd34z8zI2RCRDvPsRTFIRjwkY/bGM67y0jG0hSLD7f5RMatEvhCWMPpDcVb+L+tl4flQ1CVS5KAcD+cPoD9sAL+d4O2BFXD5THK+txeYe+U7N0OXHpbX6Cwst8YI3q9v830CbGIcrntMqFcLYiuCY2gi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269434; c=relaxed/simple;
	bh=DebmiLomxLz6/teVsDM6tuNqLgMURh1WMYyxmhdxV28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIEQhRrlOesimTojXISdg/+5CwngvBKT9Hw33RlDPCSVsfnpRlF0oPAqFJSeyEBU51Jih06QFQxt/nMDWTrWsKH9ask3g8xV46YASB9LOkRaDSGHlh6Ie0MvNd2OyDyU6GMQ/gMoksfiQnrwcPnYPqhwVsqg35sVf/Sf6vRaW9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com; spf=pass smtp.mailfrom=cn.bosch.com; dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b=V4lIqNxj; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b="V4lIqNxj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgELIbOTunkRlET57qIt4e7vtL+1Nm0l6u/pf2//tDEfIJF2on2+dBJTAu7Faw9AIQjZ7h4J3QQSHdQ21H5j0VcIEL04+YUHq3RQmty8bktChRgufmcAO+Xe6nqLUO/zTnv55sXJ9a7ncf03fm3laDoayUon/hDoLiSugHHFonbVvX67o+UqBkPlJ2ORuzlg5oA258nkPLw2oEIHctieIKTM1Il326JCy9eDnuZZSCWed0Op65lRqmrjlve2Ck8Hkd3ysVGSpcKSp4VrIBpiMlphyJUTYdTPAKGWb5G5h9J6NuSmC1lxSJDclAs1kUwwaH46ZxU2QGwTuIxNSl8hOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DebmiLomxLz6/teVsDM6tuNqLgMURh1WMYyxmhdxV28=;
 b=hT7chhn81ZJbRo4fMUnY/O2TLFIz7IwJlAsYauaGm+jdA+oKREZsUvku2NpkSzd+skM/FW8FUiqzRq+f8+bo2UtSaocpm2CYqhj1TAcyaU7M60HslNDC1MqxXMoDZ4BCGDRoDmYWHb6JQkLMthqiBwdSuag0c/8ezQpCgbo7GG+t/R0fFq/WEK/ZwxL1VkKzm2i5IwB96XeolzwdONLz8sXiY2vGfN0pYhUkEqEyOWNzMHXcG3RoYEgqxYn1pONQrRn+h7/hZP2t/aZDxZb+7ObyMJndcwLCMxZ3+204j3cOJzNPnjcXChEIm9bVGOHHbG/DPKapRjP1zyQ4X8XrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.bosch.com; dmarc=pass action=none header.from=cn.bosch.com;
 dkim=pass header.d=cn.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DebmiLomxLz6/teVsDM6tuNqLgMURh1WMYyxmhdxV28=;
 b=V4lIqNxjQ6EEHxoDI1r8yZvT7arDITmNPbLzoxMs1fkpfO6eN2u5UiPOU7Tw8w3t4O8wXhLjCHkXpKxeglMSxROZuqLknv1QBwopBocR9RXu4LEhtEqqx3ZXlXwD8EVESo6lB8YAfZEhhCbC0NdxhDgKCeySnPOex15yqXsQkOYsCZOSGJEEjcLVHXq1Ls6r5kfz2XZQlv2lct1ICUJxw9NDKWsfF8OVh1n+agB4fWw3cIdpvs9TqWdnCrROXYTh+S/vhsvk+UD0sDCQ7fQVji1hcAL3INaoMBUFBc1/IJJejP9dXS7VxlMLPVyQGrY0XKwnkp/N8+HAndVrsxY9Mg==
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::8)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Fri, 17 Jul
 2026 06:23:44 +0000
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b]) by PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 06:23:44 +0000
From: "CHENG Haoning (BCSC/ENG1)" <Haoning.CHENG@cn.bosch.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
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
Subject: Re: [PATCH v8 3/3] thermal/drivers/imx: Add calibration offset
 support
Thread-Topic: [PATCH v8 3/3] thermal/drivers/imx: Add calibration offset
 support
Thread-Index: AQHdE3uQOwhGQ7gvREa8/JzAX/2zpLZuS2CAgAL3SOA=
Date: Fri, 17 Jul 2026 06:23:44 +0000
Message-ID:
 <PAWPR10MB741520A95E4822E935A0B7C0C2C62@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
References:
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
 <5a000235-5e17-4d54-8bbe-42fda0b59db0@kontron.de>
In-Reply-To: <5a000235-5e17-4d54-8bbe-42fda0b59db0@kontron.de>
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
x-ms-traffictypediagnostic: PAWPR10MB7415:EE_|PAXPR10MB5518:EE_
x-ms-office365-filtering-correlation-id: 66550a3c-b158-4ed3-6b8e-08dee3cbf3dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|4143699003|11063799006|56012099006|6133799003|18002099003|22082099003|10067099003|38070700021;
x-microsoft-antispam-message-info:
 BJ2gxnHH42QnwmQTiFB0Ca69aAU+TJlVEJp1wnZizYCEMYMICytB7qTVoSNLXProZ7mOdpOAOFgw8bfxNGdJBooDgTdFVBNpvbbnOwn+qrGOTtt4UlcGc3gfPpevO0R1Dve4eto/tgBaUl50AuBafhwDl98JH+PmrKDJREMHqORX1IFiqlnSYstil8El5R1r7PELz31ASsvkpk6ZajT58du0kl3bA+4n587Q1XT7MKfTpM0MQ6KangdWVLu2iHA4YspxgOH+cAovryDPi131cJpqEnzhzNhWkPVmtVTZatVFuRViJZ2OT7J2/C0KojdovpnrTQqHLKj7CNqLDcdqgB9M7D71+2sSero5KUWoRD3ZLNaCXuNPybKdzAX++FJx/G0NUXk+Z2Q6S1N2Uvg+vF44Cc38tmWF1rUCWCh22DrXpsF0Q/Mvojz2B4r0RSKJHXxJnmufIN551sGSx3olqcNFzosGabrSEnU9BjhVDPISMUD7UVHebkxzh1i4mDtmS75S31tC6rx3sd8UG238HuN9MrsEcCapLwdCBeWSdB0j8T3syJvMRmJbKcbWRoAFz6y0JpNq4dzoIi/xC4vzuqic86aBRnpoft0gc7Kafu+nLGbVLXR6ZYJD8Z2eVCXOVuBTXJFKXZ3H/7e5knu671a8U1/ojQjM2W7wVr3Ksii1Brn1bIxZScMiqCKWROQOrEctgiK/Rt4sE6dfgi0bMKeL7Eu8jQWZqtS8SHKGPVY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zz0I4JwLe7ydhOnflQUQZlmE9KixLXiUf8gJfPx1KKcGoFSw/bT7sXQprV3f?=
 =?us-ascii?Q?SL5JzapHNMCmF5Lw4ys5ICEyuVSxjg0vGS5dKLgHlR2taUtGDktIEkyU7Y5S?=
 =?us-ascii?Q?c3uiEOWcg5cjHU5TYtZS6gMEHChzQJtSEdorwQII6P4WfxbgO0QM7lzPz/yQ?=
 =?us-ascii?Q?qgKqH1MD01wPAIc8gUdxD/iueQtieiUxr3flLzS0kDDUOlNVMb7kpQ8oQdgr?=
 =?us-ascii?Q?ZY85eS7tyuz9HN2gndm/hjrasRBCCOLN5tggdzbp3IQIzLHzznwbFSWFNqaJ?=
 =?us-ascii?Q?OylDQOi5uVDbF6gknJ2k5swU3rDImJPYYeW7lhNnkxEB/j9LkJiNw0uhsKG9?=
 =?us-ascii?Q?rFxM7m4WZmpYd2lmdcfCluax01nhWdGZI+f/HX0KZBnmqRur+7fhqWBQeHwb?=
 =?us-ascii?Q?RM5RtfLvAGY1OjRwqKkLtQoCEsXy6RLvvtaT7uomckkogJzvdU2Pq5aXwqcP?=
 =?us-ascii?Q?x58DbHe1alV8Cgjt7PKZDHqzdGnJKmG8vNPvyDiWEl7xHtisnFPbrJf0QWy/?=
 =?us-ascii?Q?RMsbii3XTweEVTxmIU4uQxy6UBoXhaJsmFt+l3wTDg44q553RvlExu/z/Ncj?=
 =?us-ascii?Q?Yr3YG7YFq9BhfZWmV2NjAwdTGBFDnJxc7Zf8eaKsvmntSLrV8z0vJlP8rVSd?=
 =?us-ascii?Q?SM1jm7HfFckdUWZ8w5whyDgx/QnPwg/8Fh8bYU23mu4yv2BEAjd6tNvzcj4B?=
 =?us-ascii?Q?4Gu2R5OcHiv2Hi0gGwARUmAY3v5JRxEX9TcefLDlBSSado9ofRM0QhZ3DMmC?=
 =?us-ascii?Q?K9l6kGm22lHKLO7biQrNe1eqW6U2cZkg8bmfAGZ63h/RljuQ+WDXN5fEagQO?=
 =?us-ascii?Q?f9hx1xIt64E2s3mkm4oF/FSdLZk7FQu9pnEkQlyCJfsKo873SklbCBNnu47I?=
 =?us-ascii?Q?MqI6wH666gqDNQQFX2FwDB1bWDrYgyqxdLsVjxJq5FEK+PjQsCWSBHAnWjxu?=
 =?us-ascii?Q?PTnI5aJwftUQo4Cpjaz0DRkT3VqCf9GAtSy9kY53Vf/GcJqMjTPaNG5+qdpg?=
 =?us-ascii?Q?QkG+/E/xY4Hw3DnCFvtXoxk2ttvOgWvgf76Lg6cDGMqGh+zRQWHb4bQDGPwA?=
 =?us-ascii?Q?NGPr4WPZ94jMpyrkle2zsbxKKpOoiBYGmpxX4Aui556ii8rOQasYyfharLfJ?=
 =?us-ascii?Q?5AQoXzGFu0H7tKTcU9oSOqvTmScKv2x5SUopHkHqD8jyUc0NZVi59R3fGTyA?=
 =?us-ascii?Q?ezvo1WdhTF4bh6I5GRSqk5iEQcltfw03PyISwQ7DAw7QS3gXOJwgs7hiaF0N?=
 =?us-ascii?Q?xqooP0rZTae6tLn6mVEKr1hGZLLps76E8xIQDEBAdzpcMSmBk8o8LvNFpjqp?=
 =?us-ascii?Q?Kv2giGTmjM7W51y5isQoQY7fdU+9sURHo2y9Ll/qga/lrb4uFdoQPJysIMVm?=
 =?us-ascii?Q?t7XgQiSnK0HlGkoBGOdFxPKiuwGyvP0tPWETLRcKhARzpnEjIN/MBLhJm8Aw?=
 =?us-ascii?Q?VRlQx00btKCZz/oxdyywv+2Rl1KwT05TDEJoniK5uwt913ihucTU+oC+LgJ+?=
 =?us-ascii?Q?5mQqp3WttpoAbPf6b2VGkLsHzxef7JaFK0O1y7fzlrz/Ih3jHrCFS5DupwhS?=
 =?us-ascii?Q?FSngAup1bvNU0h6APkrbXZDYyr7X/2uPEcZx3s+w+2lRi3gsjRcjmj4+9Uqz?=
 =?us-ascii?Q?ESyLR7coNcVRym3CqqfQPTkirsgmsoiXxqyrm0zgfZJnMT6AS0EIUfKNvxbG?=
 =?us-ascii?Q?Y3qSu7wCjXzHtqeSHtRYNin+Y677oZhv7lS2jdUT3jZ8DCMt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66550a3c-b158-4ed3-6b8e-08dee3cbf3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 06:23:44.1939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoaH1azldp64nML26sHt+5Oo9OYlxDJJnszYNSYnrbDGdSef2Hdl+TRkggpJTx47nmBHrjmSvq2C8N8T8x5pUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518

On Wed, Jul 15, 2026 at 11:06:07AM +0200, Frieder Schrempf wrote:
> On 14.07.26 12:28, Haoning CHENG via B4 Relay wrote:
> > Some boards need a small per-design correction to align the reported CP=
U
> > temperature with board-level measurements. Read the optional
> > fsl,temp-calibration-offset-millicelsius property from DT and apply it
> > uniformly to the i.MX6/6SX/7D calibration formulas.
>
> Sorry to chime in so late. I just want to understand what this
> calibration offset is about. Why would there be a need of a
> board-specific offset? The sensor is in the SoC and if you add a
> board-specific offset, you no longer measure the SoC core temperature,
> right?
>
> How would you determine the offset in the first place? How would I know
> what fsl,temp-calibration-offset-millicelsius should be set to? I could
> put a sensor on the SoC case and use the delta as offset, but then I
> would just account for the thermal resistance of the casing and not
> measure the SoC core temperature anymore, right?

Hi Frieder,

Thanks for pointing this out. Your understanding is correct: after
applying the offset, the reported value no longer represents the raw
SoC die or junction temperature.

For this board, the required "SoC temperature" is the package-surface
temperature. The offset was derived by comparing the TEMPMON reading
against a calibrated external sensor placed near the SoC package
surface under steady-state thermal conditions, and is used to
approximate the package-surface temperature from the internal TEMPMON
reading.

The Linux thermal framework does not require a thermal zone to use a
specific temperature reference. It only requires the reported
temperature and trip points to use the same temperature domain.

In this driver, the offset is added in get_temp() and subtracted in
set_alarm() and set_panic() when programming the hardware thresholds.
This keeps the reported temperature and trip points in the same
package-surface temperature domain. Doing this in the driver is
necessary because the hardware alarm thresholds must also be offset-
corrected; applying the offset only in userspace would cause the
TEMPMON IRQ to fire at the wrong die temperature.

I agree that "calibration offset" is misleading, since this does not
calibrate TEMPMON to a more accurate junction temperature. In the next
revision, the commit messages and DT binding have been updated to
describe this as a board-specific conversion offset from the internal
sensor reading to an estimated package-surface temperature.

Thanks,
Haoning
