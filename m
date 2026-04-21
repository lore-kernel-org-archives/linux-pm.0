Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776072C0299;
	Tue, 21 Apr 2026 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765384; cv=fail; b=NKGYIH1OUcqEwwFh5wKqxRd9jy3w0KZ+ldS0EwzhtNX5I/xtl9MIWk86knWGMPHVHNbCPbAw4tJmY3bHI1p/OHXtiQdwO5BiQnr3zAuzr+au+/MCeKfvTM9I1W/i84+ECn4WNHamwtay+h0ds1TZPv2QESERoEAXDi9iAsIGTC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765384; c=relaxed/simple;
	bh=DHWcYgL9PPkrqfSctHnY+BpVmmHPZH1aU+GQHdDtp6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m3yEJtuBvQHtCPhlk4Kp01p2EVta1ORTvsEj9wQZ5YAPqp7M02QtYaZ0Op6YTui4jp4/wBh4tZZvSr2o4dEUfzF7WAg0rV9mWsjMPC+k2hJAfFNTw9QPeaHLQVmZJ9yXrauIqivDdm0I4BnQ5c9LtFF0clbNE3gnq1E61C5Y1mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EewqilaG; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EewqilaG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pscZMQWIYutI9B5v4robzo3G3yvhDWFkAWr49CrOgYoGZQ5jj4XEe5+XWxXtCHcGJ8evqA7Qi7UBrTx3UmzT5bTenzuEp9NadW1hX9FSLkOumV2OBrB+bUx03HYIyFj3Qgu8CBu//ZITW/hQF1VZ2u9lskXKCbYON1ZuAEoIe/BytpwKMjy35KJrd5DTd2JkCBQ2EXYTXPXD1B2QjNV0NxdejAPo3Qu0nqVsyFxW5tuSYQCm1GsZKF3dbZVTm3WTTmJdiggjRqWuolJAKhLVeUVRq6W2vBeDOl0v7o16qno1Q1LZiDeaxWrB05P1nnveYTHxkD4UrPonxe9EsJfx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHC6xcsXrxQLW+MieiF8OG9mFTzdm4AENrIxgJTI26Y=;
 b=RfC5ulzyU5QeiLKu0VLvKyUhk1jT5QtFq1QkT5EA9rsir+hT7c60n8ibD/eNDBYiq+Z0pKwTE6E/xGrn8qVeeWUCtsL3Wf/8clhw/5u8rmzXx9nHc4PsvL259RVAfJmhYiGl1WUem78bHd/oa0tkhnSLdpKEQQW581zT8d6H0BiIGfi+NCKjcY0f2yx2EEAOPO3g6vRXvM3jsApGibmF0D3E99/IkAkGSEBlVqzjnMRReRWQjZw1O3QYJB8vXqNfrV00ODqE7qNgsQmaEjImYerNHvuE74CQ2OT552KJBKQCsAAxHNuFBHJJyyHbmbOavsz9GZEDz0HcwrY3lhIUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHC6xcsXrxQLW+MieiF8OG9mFTzdm4AENrIxgJTI26Y=;
 b=EewqilaGtEx/7c/+1XDnLYx7FdL0pwnzv8N/Peb7KR15fNbgHQTT0DmVLtMI4uOcSJ/p4UEX0pE5mwP3cC6XpxCGktZU5OnA/KEsv49yk7Gq1yqGgm32DUtwtnsHr2AfmMmEQxuhXJ3fhpP9wEk7lpwpDNljP851OZ2e8thzdCa1r2sD7fDVvbYKp8MDdFn2jsBmVEU0WAwiK2JHT4+u0KRVBhGgK/tGQJaLrhxuiwl455clHr/k/MtBBvDs9cZswVKfA1VzwneQnI4FtRMnh/kRvjBkovfxJKSW79cNPP9UqsdPTKbQHVylFu+o0aQGzNbegNw6LpGVjVZGkiG07A==
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB8PR04MB6940.eurprd04.prod.outlook.com (2603:10a6:10:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 09:56:15 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:56:18 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Thread-Topic: [PATCH v5 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Thread-Index: AQHc0WIYfhVWJYqqDU6451jagDa7RLXpOvgAgAADPXA=
Date: Tue, 21 Apr 2026 09:56:18 +0000
Message-ID:
 <VI1PR04MB6861B0C33CF3030D6C9293B8872C2@VI1PR04MB6861.eurprd04.prod.outlook.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
 <20260421-imx93_tmu-v5-3-05ea1969bb9f@nxp.com>
 <aec_TlguJkc4A1qN@lizhi-Precision-Tower-5810>
In-Reply-To: <aec_TlguJkc4A1qN@lizhi-Precision-Tower-5810>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6861:EE_|DB8PR04MB6940:EE_
x-ms-office365-filtering-correlation-id: c882edf9-4ea3-4dad-7738-08de9f8c3c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|11006099003|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 GsgcsN4R7UmIy2RKAKDuJ1H9Gi4lGpxeeqR1JDMVD+KMaqvaz1RP6Kxx5IKPYAqmB4uVyK4c4/lhlBTbj4GlvbuC30eGU1LczIx2hMu7FQtBSulO69+iDDMqduAZPiIBLO951z22IKFPpadzoEhAOOx7q0Gg5rewRNOCjcCoRmLxP3CU8KBer+z/X3CbkUWUOwJPtjznMPeCDHFs6RhMgB8PxYtl2af9HV0dcfVImm73wFf68DGPlm07AhCtl1wVHrnmCFDqKSL7Vw1LooBQ+9oTU+xksGvX6GC00YIN/D+w7PVP7NQ/HPdeHtEFY9lxeyH9pwHW19qt97gmJFWw5gPeGPv9xTWfUD0YxEYmbAmtMHhKba4F63/4h2vOkWWJVuYBk6vGXG8ewCxfQyl+cDaS/F66FUwKKhFEFclsLIWVkABSaic/t7LmvZ/4TzJx+DVUpmCf7uSsRlsO9EhXHX0hD76eKeexoUPyqXs1aHgXcTbrSv6nB6kU2j736tm+2qEVsq6SYiwfBdgU5vSL2g7/GK4R55g8tSeqkPChpKLi/So2lPCtNbo5vau0ttGGXO+pQ7bHXhmis0OYDWp7q0D7bTcXOOBX8vseSYS3/F2i+vM+H6VIBO7pKEmUfug7U3vdnNoPJdpFnqwaqXVXXVPf8gXGlJvgaFibbDoYF+siH4yMc727GDyd97nFtChRwBirXgKRnpQSxLaRSJ9jOermlKSj7k3MYU7JdYirdJe9m9V5rUZVLbujLE7DAfmVQweSA4A2X0EjsvbLhJP0wYTKCZfLdz9//OD0vO4mQY4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(11006099003)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iyqz01iyKHNjKVqDe/7ywc+0snrPbnP8pub15NaC3vfL3FUqOONLlv89FKYu?=
 =?us-ascii?Q?7pg6gxkeGR1Zcagvgpbu3RBI0gMqyzNRYKOi5iH6ebLocSBZHNGAik3TWjYO?=
 =?us-ascii?Q?6x7Zrw7s9c5HQd3mZdB6Wkq5ZnAS6HZSDkaY6eChX0LZWXasD7YniP7KgnjU?=
 =?us-ascii?Q?a3ZpeKE/Q2NVLDvuQGMGACoZg7HtB1BlUz9JF6JiGsEox36lqDYVHgYtSpNs?=
 =?us-ascii?Q?L+K4TZfT81hvlEZEnCOJX3XtW7lkB6xcfcfkKFaNE0NVqwoyhlQdZ3krxeiE?=
 =?us-ascii?Q?qGQ1WnDQjMm/blNuRLXD5NlUlcYy2BQWox1XvKKwJMRyAuaZIhUWSIdW/oXx?=
 =?us-ascii?Q?BOdv+CE74hUfzfU3ffC1WhgusWVR5TmVSaK8qtNuECcWnoFhBakq4yu8M8xa?=
 =?us-ascii?Q?OvfLNWfXyQ0TILbougkhMXxuraVTtYshouZr3wUgXIwzrjHtuUURrqa6yjt3?=
 =?us-ascii?Q?g/x5OxVC5fW8ce50K6cbJ/UO8PXqGxagmwyYRooI65g+NrJSLy+TiDqDbGEj?=
 =?us-ascii?Q?X5dvaJkPnQb12hyLQlQNSInPMtkH88u3qYeM46zYPECmwkjWhNER0aGx68Ix?=
 =?us-ascii?Q?5G/xk5tRDZcgfQkuKr/xQy8FLD/7xuENDGEqkva70R4tGigq6rqMoQ4Qr94t?=
 =?us-ascii?Q?VclxVPIseVzE75bm6D/D4M/eJbrEMbtdAY6Rq8L873SxjkRWmgMlCqvepXn9?=
 =?us-ascii?Q?Awf57WHdwDf+++M1FAqNyOrY1Hn1rMFny7pv7bTUraDtvxJIKmOJqot1CtNq?=
 =?us-ascii?Q?BQC4m43UTRBbg/lSQAFDWRGSfDtNgQs4wgHs29Wb7pWgF4nPzzPitwZTwtVx?=
 =?us-ascii?Q?7wCyTOG/eqKBfxb3V7TFhn1cFxjUgL/ywd/wsn02vy2fgl4sf2gmKez32iLu?=
 =?us-ascii?Q?ztRMBxTA4B1RVm9DwHUx0DO+0y85p0t65t2Qmz093drVyaNy3Am0gGUsUB34?=
 =?us-ascii?Q?YvrzKYIzfA4enDGnIdyCTXSayxDI2kvJtHGKQcQACVgDKdvljJb32PkHjWeb?=
 =?us-ascii?Q?UvqpzmAcv2qA6XQ2u9HcIaLkx8EAdyPjjtIYlZM/hqYHuK+YFZUT7ztJouDL?=
 =?us-ascii?Q?YQLm3lUFozogzKc7DXJgu0ZDuMdeu7lQqnpW6iRHVXKNdaXWjGVXaFfmRSk6?=
 =?us-ascii?Q?kKQpvgtNcwU9UI/0KhMmS99icasuoMvjsswIJ1+TnhlSQ5voUmzUEVyHNm/F?=
 =?us-ascii?Q?hpYb7BNnHV700W3+aHv+6wrTGiAiP35vwUMG0YF/tVkYhGRqhKaBvOMQae8T?=
 =?us-ascii?Q?TMw7SlbUBmaRLZjergnqTKAHgyLV6MQH7f++OZ47UxVjZK2tv4F+eZq2eUNg?=
 =?us-ascii?Q?LfQQ1EDT6tfMm9prZQM7DPHJ5NSodtVULiJS7HL+z8LdfhYPY/hVbdu6vLq7?=
 =?us-ascii?Q?xXiLpxh4pc0bv/6eYJNlId6LnLOlUjkk0hMqKbbAx38n0aXDHtde7ZGDkkJ0?=
 =?us-ascii?Q?JJySi/Nrx9tCEZJV7OJqLdTUQNL0MPr3lnJ8CXqkUDnn4ZY7aJTHUx5kU3Qh?=
 =?us-ascii?Q?RF1PAuLjwEKexAwKQoYkvLCcZJlwSMD3nCfDEyBO/2RwgVMIuM/gmgoFmHg9?=
 =?us-ascii?Q?wuIHeY5r/l42Jlg/jcD6hvxcl1ba9A6Cd3RdVeKArAHkAvCEWm7FXTnBgWOL?=
 =?us-ascii?Q?Vhq2oIg1qkynCc05km0+fTS2RsIwyirQ3TUIavyAtGf+O4hjJl345yJLtCTA?=
 =?us-ascii?Q?LYJD6oUzYSQTg+tlw90cGVvBbXCyesWTIoKoh6BKDQC6xV7t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c882edf9-4ea3-4dad-7738-08de9f8c3c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 09:56:18.5276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugusOYEQ6Ha99f6j6HXylUkXLA6DgBt1KY2QidXVE/ONwtCGIdVAUfbZ4sDRQ7uSn5RMgQJLvHxIJu5zWUx7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6940

> Subject: Re: [PATCH v5 3/4] thermal: qoriq: workaround unexpected
> temperature readings from tmu
>=20

[...]

> >
> > +	/* ERR052243: If a raising or falling edge happens, try later */
> > +	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
> > +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> > +		if (tidr & TEMP_RATE_IRQ_MASK) {
> > +			regmap_write(qdata->regmap, REGS_TIDR,
> TEMP_RATE_IRQ_MASK);
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +
> >  	if (regmap_read_poll_timeout(qdata->regmap,
> >  				     REGS_TRITSR(qsensor->id),
> >  				     val,
> > @@ -130,6 +159,15 @@ static int tmu_get_temp(struct
> thermal_zone_device *tz, int *temp)
> >  				     10 * USEC_PER_MSEC))
> >  		return -ENODATA;
> >
> > +	/*ERR052243: If a raising or falling edge happens, try later */
> > +	if (qoriq_tmu_has_errata(qdata->drvdata, TMU_ERR052243)) {
> > +		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
> > +		if (tidr & TEMP_RATE_IRQ_MASK) {
> > +			regmap_write(qdata->regmap, REGS_TIDR,
> TEMP_RATE_IRQ_MASK);
> > +			return -EAGAIN;
> > +		}
> > +	}
> > +
>=20
> The above two code blocks are the same. Use helper function to avoid
> duplicat code. And why need check twice?
>=20
> 	ret =3D qoriq_tmu_err052243()
> 	if (ret)
> 		return ret;
>=20

The first check is to make sure no error already happened. if any error, no=
 need
to polling read the sensor value from tmu, return early to save time. The s=
econdary
check is to make sure the sensor value just read out is still a valid one a=
s the error may
happen after the first check.

It should be ok to remove the first check. As the error only happens in som=
e rare
corner case, the sensor read polling delay is acceptable.

If only keep the secondary check, I think no need to wrap this code block i=
nto a helper function?

BR

> Frank
>=20
> >  	if (qdata->ver =3D=3D TMU_VER1) {
> >  		*temp =3D (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
> >  	} else {
> > @@ -247,6 +285,14 @@ static void qoriq_tmu_init_device(struct
> qoriq_tmu_data *data)
> >  		regmap_write(data->regmap, REGS_V2_TEUMR(0), teumr0_val);
> >  	}
> >
> > +	/* ERR052243: Set the raising & falling edge monitor */
> > +	if (qoriq_tmu_has_errata(data->drvdata, TMU_ERR052243)) {
> > +		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
> > +			     FIELD_PREP(TMRTRCTR_TEMP_MASK,
> TEMP_RATE_THR_LVL));
> > +		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
> > +			     FIELD_PREP(TMFTRCTR_TEMP_MASK,
> TEMP_RATE_THR_LVL));
> > +
> > +	}
> >  	/* Disable monitoring */
> >  	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);  } @@
> -400,6
> > +446,7 @@ static const struct tmu_drvdata imx8mq_tmu_data =3D {
> >
> >  static const struct tmu_drvdata imx93_data =3D {
> >  	.teumr0 =3D TEUMR0_V21,
> > +	.tmu_errata =3D TMU_ERR052243,
> >  };
> >
> >  static const struct of_device_id qoriq_tmu_match[] =3D {
> >
> > --
> > 2.34.1
> >
