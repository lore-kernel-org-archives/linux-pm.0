Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010051.outbound.protection.outlook.com [52.101.229.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB52D238F;
	Sat, 25 Jul 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983438; cv=fail; b=UIvWb3sRYpiuyEVZSeYQkFgwUOX5Wtu0CUEN2cE3nv6ebrOBIVj3WDcJ55wxiYMTWCTAk6Bhi4fGVHyhjst9qiXGiw6Ow542Yo4BKeKDoOkPS+JuXLwz3NmkCT0QshO3iYdEEqJG950fQJrqGndKSkNkdqWjeCAW3KMY+uXvxY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983438; c=relaxed/simple;
	bh=do8O66kjGQmdfX+mgM1KY53VQGP7ylFNVBXk+wCKgLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YSFP/g5sxB+iVquw2XRVgT8up+9w0ral5Vv+B8YmxPDMSd8tykHPgIUttSxc6njn5czhSWT0M74Lmm6gTMzoBMeItd+MWOps9At1ExlQCktgMSkGq/eEAiNVfN+9sQb+y8Vq5YMS6njF0rVee97DBYpFFP+wpOQmvscOn8sZ7o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=dPwRHMxa; arc=fail smtp.client-ip=52.101.229.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="dPwRHMxa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l++XImb+AzhIGBByPCRkgUatr75p6yaUue6Hkcg2mvOrG2b5WCMt2L2FQEINKD1par6SEQHIidvoZdIzbTEO11WNyRbsVwqVW9j8AKcsBrOYiG6hQW2xAlcihCTZH94S+/yGl2UKVevXMNeIxMjhIuHp3Hv06JRPVvmTE9PvIgX/eSSVSnamSFO3H1Zi+tTWYALW94voUf2fqQ89yydksFqpiNewbwNZr9e1odzhmk/bUxElz7zrq5tvR7IwS4Fpnwu9Q0twgc4fVZMrwxNVps09lqmu7lxtbwavZvFkx20RocVAaLCPbZ0U5W+1Yt0HVKWPhBp2HPQAuau8kQVM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBOVcyX1AUbwDrGCkPVLTpaMoviQTSzROcMUkPdyb/E=;
 b=oM3punJ992wY7/TjZ3GhVYMnsBzMdW8YRz+61WugqN9MRRcEQvCE9eCtCr89KTC7CuZxeSW+PfPMMWc2obHhfDLyioAcgXmO2oQ016FwC5+0PCSiRegAWLKyeHPr6f7ly2pfatnjBMR+zChmCenvadtLLvkXqx9VCpZnY38Ng/Q51sTKucmJ1ryaapb4XjL8rOlCQ4JzRQ/dOJpf/ZU4Y3kMl1r5HQ/i3zyYCvl1bKnUC93Q5+z2v17Lmb0m+UbkRt0U4j3ZwG+k3cKSuQiwm8wRhYA2apFRiU6XrGuLjZzfmRa+u1nzvadmGUYg3gD8i2FtzOgf0Gqv4+s1HMyxgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBOVcyX1AUbwDrGCkPVLTpaMoviQTSzROcMUkPdyb/E=;
 b=dPwRHMxaDtXwoOumzKEW9HJOJLZ+OvBFtMW3pgEznzCBaQshdW+q8vXTx5OuU6pU0f30q+OYEMzDFTjZfQpDafC1Fqe9okRlArkqLL4Py0qqaBynr5vgpHBVEnXk2SQ3DzUBVCbDGfBEgTcufc62pToh16Ju/JEYeWZKfZvXCBo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB15007.jpnprd01.prod.outlook.com (2603:1096:604:39a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 12:43:52 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 12:43:45 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: biju.das.au <biju.das.au@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, laurent.pinchart
	<laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <brgl@kernel.org>, magnus.damm <magnus.damm@gmail.com>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH 0/3] soc: renesas: rz-sysc: Add RZ/G3L PWRRDY power
 sequencing support
Thread-Topic: [PATCH 0/3] soc: renesas: rz-sysc: Add RZ/G3L PWRRDY power
 sequencing support
Thread-Index: AQHdHDH2Tbp759Xnw0yDeyi8DFseQbZ+Lajw
Date: Sat, 25 Jul 2026 12:43:45 +0000
Message-ID:
 <TY3PR01MB11346C900F415992B2B26EA5686CE2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB15007:EE_
x-ms-office365-filtering-correlation-id: 251aef62-e080-4484-3b1c-08deea4a5d8a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 f4tnf/95zrGktLBlEPDV+Vxa+eTPKvVhQOYvKkpP9Y/bVXDlcMjZkCcQbuWezMMfXf/jwhqlPRAbqtDZktlShzp9KdXRrNqoQQKgwnA1P+FWTICAFPM6cAnyQ6rtkazxKsJf9MKLX2DHAGw7vpd8qzf53kkKg2PX9DaYWlE0DdKMkUAwr2wOyZFXwEvESpCEUNGDg1AePGkMXlc2DSfmehcmRZFE3z2sv6pTaCig4ycGYFhZMkRWBP9axn0JYaN3vunXJakXi/5xrlPF43HMAkJBg3RTUjAoie0El+G9eT5cp4cdlLPCxSrsJ3NTxt7mAX4Tywd5qbgXZNqIPP6H+HotHRenjoRWUDaVIovM7FvSsoK7GSqIhFYXKar0E/i2ODkUck/WJ7O6LkYkFBja3GlcwUjkpQtzNeQYUVX1NPKbuHYTWTwwdmiSY92yBooyaJa4bNmIcu4fH7drOKS7q7Z6yeDJl11VdOz/HaeJNa9nQpwnuVfDIi6xUxvp6Gy7hff+0NvduML+GV9nRQa8ZAN8bL+8D0mczlAhSSi4Pn0eRNl4VeyZWty8SOdqDgdB/19oq4hZjeKfWcBOGNBkcx149z2J+HEKUDuAbZzuublWgeLY9P+df4Q4mdHSyMBeCzcJZUIPHTHSohZzCEIi3mjX01C+i3DqAeI6t5XlpCs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wOz85KD18uDeUKHKZs48b7xKnuy3eSYVyzWxyRPzl9RKQczyjgqKG10bOM/a?=
 =?us-ascii?Q?NB+JL8EBlQtBy1+NFsDxPLxM3tUHnswgp7G5ZwsXA9yhOJLS+FEPrs2tEnBw?=
 =?us-ascii?Q?8FBVHy0nnuiUKwxfbUgR1uoI0iJfO6fBW0FZ4gUJSIL9THog5NPoeOIHNzGC?=
 =?us-ascii?Q?XkbT/jrAW4nUmBC5/0yLUmmiokGUbph/QWooL/5xzgE59YAn1j5vIanZvd21?=
 =?us-ascii?Q?OhD8WwwCVGAr4sck6QrwHNputGnGnH6IkovhlL0SnDxM5vJz9OOOx1kDgAR5?=
 =?us-ascii?Q?NksFKwF2VgirA8gKZf8kmuiqQoseoVLi2jWpm6dhiXjFIhcEcYaJIcRkMXEI?=
 =?us-ascii?Q?yZrGzrIlUMk/67pnDJBRPCZd/V/ttRJrmAt2YgsMWHnpe8IuiFGvi9w5IgRP?=
 =?us-ascii?Q?eymLHnlBr+oAv3+WQZTHVyEkHAN0vT67l/Qr2ApUeRvhfiQOlARdKJSecCq9?=
 =?us-ascii?Q?eg5MI4gXaf7ZoHAtjFYbh3MbttXlJoP5zpykzTFxCOaopLYpCwIzAsWe7Rf0?=
 =?us-ascii?Q?GK2aWiA3dTHHGir3A0aWi3ycuupzD3mb+LhtRMYyEmo7cbX6YXkBZE3cGNfP?=
 =?us-ascii?Q?MAcY1p7xlwSvKNUsf+a5SpaX4uppSCLFcrFvNEtEs5e6H+b47vUTWiweBURn?=
 =?us-ascii?Q?maD5mpl/0XdPjpoWgmMX6Edz3cRfZ6OX8f0K1PGysqFrZ+Yd4xoF77HXegnK?=
 =?us-ascii?Q?t6mbhG8yJs7oo2T0D3uMQ+vWUxwQtZRAicfCiivBnNkcC2id2WQt9tp8vxx4?=
 =?us-ascii?Q?TK5ZocB/GVO2coSybJh+2sei12jLIft1Ej6T3AGZr8vDe2JPLTZhdVclkRgg?=
 =?us-ascii?Q?oFNcOJkFdREB7SIzA1cJTbuwVMWWdGAkO+4G0Me0sVc0eappx5vbte23mum5?=
 =?us-ascii?Q?8sYe7IjyzdpeEsX0pngyhd8Tl6hEmC6Qr3z/bVnxmHBl5fX+H+ZKDWHCeJj/?=
 =?us-ascii?Q?cc9e0r5z1o7enJlZKn4SnJG8sKRUoEf4rkF/Its/L7LF1UTOMLtt7xGilpSO?=
 =?us-ascii?Q?+Rru+WOYkBuXTFruEKzvPWur9VetI8dognPSUH2RQUyxWI2vj7xfNe2jKSGk?=
 =?us-ascii?Q?xug98MiiV0b98OcjUnlONipZn1BxHYnFzyUNfpvRLBXCGT3ShjkIOoxSrwRK?=
 =?us-ascii?Q?by2kidiWpJIey2EFf/6sIGDDjyOSBH1B4UzkUBlF01M44EME1AmyNMo9OcbJ?=
 =?us-ascii?Q?lipMEnJbZWA2Id9N0ibPJwMeDyef77D13GpQbflTI+RDxhGI/dBE+gOL9KrX?=
 =?us-ascii?Q?+lrcSIqNmS+/MSyVsSJuwDmHWiljDj77JVmEXgqQMWw2jAFtTRQ3EIaeERxB?=
 =?us-ascii?Q?trQ9o2k9K8TBTll98xbkqCW9ONiqb6oWx9ly3Qbmp2VaawhzLvTHVrvE2s6Q?=
 =?us-ascii?Q?VISiMnX+FZ1EUnlM0ubmdlrMJbAuEgymtora1K/bw77qd14AyFrs4gh9oW+C?=
 =?us-ascii?Q?VZTZuM2ZrksP+a5jxXsdPZT1OifG/C0tkb78J86P+FCZlmt9VAHKmKATdAsS?=
 =?us-ascii?Q?ZsOLJqS4PR/acfAFnJsnqnkdHgCDvYuIBpAGLrEO2mNBIEN//ulw1ns4mztV?=
 =?us-ascii?Q?UpTNSDtfMX/rjVV74r0AlGdzi0Owj9v5LshqtBL6X4hOq7FoUQJf470k5f0V?=
 =?us-ascii?Q?TeUgXn7YrCvgUYB0OUybaTJZS0anDj7iQIdTyrM+i+BsQB5dN2f/RcCzhD+d?=
 =?us-ascii?Q?C+NGMDJvfWkZkrY3ylPi2FuFCP1qobiyZU1P5Clv/YWAdmUblLPP3f9i9g9i?=
 =?us-ascii?Q?69kexZeRsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251aef62-e080-4484-3b1c-08deea4a5d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2026 12:43:45.0641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IggPjsNv5iUUAY0CJtkSLkRngeT+C1BIMUJTgkagjzjsPowVhtaunbgh3U294pKeuyoKqBjKgTAb3T0D7rBNOqpYfTBkicQPSD+xJL6f7Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15007

Hi All,

> -----Original Message-----
> From: Biju <biju.das.au@gmail.com>
> Sent: 25 July 2026 13:34
> Subject: [PATCH 0/3] soc: renesas: rz-sysc: Add RZ/G3L PWRRDY power seque=
ncing support
>=20
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Hi all,
>=20
> Some RZ SoCs (e.g. RZ/G3L) have a PWRRDY register that signals power read=
iness for various IPs (USB, DSI,
> CSI, etc.) to their respective controllers. This register is part of the =
SYSC IP. Add a dedicated power
> sequencing driver to handle these signals.
>=20
> This series adds that support:
>=20
> - Patch 1 adds a pwrrdy_pwrseq flag to struct rz_sysc_soc_id_init_data,
>   sets it for RZ/G3L, and has the SYSC driver register a
>   "pwrseq-pwrrdy" auxiliary device when the flag is set, so a
>   dedicated driver can bind to it and handle the sequencing.
>=20
> - Patch 2 adds that dedicated driver, pwrseq-renesas-pwrrdy, which
>   binds to the auxiliary device exposed by patch 1 and exposes
>   usb-pwrrdy, dsi-pwrrdy, and csi-pwrrdy pwrseq targets, toggling the
>   appropriate bits in the SYS_PWRRDY_N register via the parent SYSC
>   driver's regmap.
>=20
> - Patch 3 selects POWER_SEQUENCING_RENESAS_PWRRDY from
>   SYSC_R9A08G046 so the new driver is built whenever RZ/G3L SYSC
>   support is enabled.
>=20
> This series is based on proposal for power sequence driver [1] for USB PW=
RRDY signal and DSI PWRRDY
> signal[2].
>=20
> I will send USB/DSI/CSI driver patches based on this series soon.
>=20
>  [1] https://lore.kernel.org/all/CAPDyKFpLnREr4C=3DwZ7o8Lb-CZbQa4Nr2VTuYd=
ZHZ26Rcb1Masg@mail.gmail.com/

Please find the link for original proposal for power sequence driver

https://lore.kernel.org/all/c7fc31f1247332196516394a22f6feef9733a0b4.camel@=
pengutronix.de/#t

Cheers,
Biju
