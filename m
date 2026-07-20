Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A41A8F84;
	Mon, 20 Jul 2026 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513419; cv=fail; b=UnRWa/mQ0TJcmnF/xH/iZBhIf2D8LPBVSneJY+B6nf0WtE5Xar0+z+Hf+TGEVm351K7DXj7Euin9CRVR7c5kbLC310V4Lc5SerUFZzDb3zFwSYweOmqJ98f4vFUhK1sRA/t1u7LqKuIfP5PAqiQT8eKhFebq/k1NXfC96cxkfok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513419; c=relaxed/simple;
	bh=XyP3beKTqKy7/tm4NGhKSSOYn9FOIhNtE617thQbnkU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C806ipuUUDWjO07/RTeqK5B0nfxC016kM1VKKwg0P3hUI2jBNuOtoIcy7U031uuZ0mOf2Vr0G6ur+uLa35AXyWcanUHmXpKBYnhSv1OEGfSsQgHiqV9aVijWbS5gTYmIZK8b78qjBpdvz8ypriyaANuPbHGt36TpPDtldBdGAaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com; spf=pass smtp.mailfrom=cn.bosch.com; dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b=UyBYuORW; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b="UyBYuORW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1oBf0IpiB1U0sClW86H5gqsWmrbDDgi/qcZCEd5swAFUF2Z9bV5QkG5XZOgj1o9QnuY+fKplilT2ukAGPhs9Xw/d26TknaRSTooclcC4+z4/2Zt/4D3gTkY/kgJ4r2bu50iip+D/54Ut1mR9/b5/IoUtPd6l6xR4pzCh4FtQklW4Dp0V/4eHSypNgTXydTnCLJYnPsFMVtySzIOTv2U4mO8R8FfDrKxQBoufxDYPrn9IKBNKTnQuZlONiBscFfH/qfP851oiME/D/LgrmYBfLkzuEw0YampJmX+AaDrQzIeswaW2sdsagrthmGTWAidANT3Dz8bVjtuPyrAKN+SKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyP3beKTqKy7/tm4NGhKSSOYn9FOIhNtE617thQbnkU=;
 b=wW82cp6NZnJ4V8lVPNQwEPVGUbDZ8G8cA5bUafktXP6NWUBgvsVe/DU4X2UFURhcZCQglRTk8Fkd2KrvWnyqt0puvbp2iWc1eBjdbPTxc2LthDDKAYuoYEJ8i8XnZbtg7gzYlY0BWD06tx0drUz1PPrgWNxBgDI0MRHNXj8ntp8Z4n5aBpVtHnorBPstlVKNgfDWiyLbDp5G/SIB3EXjjjKijb/MtRPkw/9xGYtCZuRuhSFSHtBivX0Ug/QsjXS3DgGWBaDLnmNCKa73Wlr/Y72f1BU0runnrXqU7TlTQsYgxIs8QgcNsei16WPwiYATP2KY3GpFG+Ynd1Ax62UHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.bosch.com; dmarc=pass action=none header.from=cn.bosch.com;
 dkim=pass header.d=cn.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyP3beKTqKy7/tm4NGhKSSOYn9FOIhNtE617thQbnkU=;
 b=UyBYuORWgCOBjMPCrZkujyIRLA2JB0h8e6ww+y+fxrFa0xLVvpPB4dFT3OH+qCCd5pHDzScsB60Qf0TOH3gsqJWXXwkH7ctxRMiVkHt/u/QGXBKKhQJisytfexGKjPakda6my5YebY0oVg3wZ8O0o8C7rCWjctvEVtci5C2ZibWQQ8mPQrbyEQd0yC8SAuGjUc2j0wYXsYEJieYAm36OExeWa4qXB87wNJ3aiSDgoAlDLObtTFJQuJ4544f2khJaW2cGII9C119UrIP3GtRfQ6MIuiEfvUPnFlWr8frSxGbIJxrq3B9akh3KSdABF3Ad4DbGTRpwwspoyFxKrLV6vg==
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::8)
 by DB4PR10MB6285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:10:09 +0000
Received: from PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b]) by PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa9a:794b:21d4:ae9b%5]) with mapi id 15.21.0223.008; Mon, 20 Jul 2026
 02:10:09 +0000
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
Thread-Index: AQHdE3uQOwhGQ7gvREa8/JzAX/2zpLZuS2CAgAL3SOCABHAl0A==
Date: Mon, 20 Jul 2026 02:10:09 +0000
Message-ID:
 <PAWPR10MB7415DE998EA3CCA639F14EF2C2C32@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
References:
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com>
 <20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-3-d54d8690e16e@cn.bosch.com>
 <5a000235-5e17-4d54-8bbe-42fda0b59db0@kontron.de>
 <PAWPR10MB741520A95E4822E935A0B7C0C2C62@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <PAWPR10MB741520A95E4822E935A0B7C0C2C62@PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: PAWPR10MB7415:EE_|DB4PR10MB6285:EE_
x-ms-office365-filtering-correlation-id: 03119b5c-d9e6-4135-62cf-08dee604064f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 3kJ1emsaDpw/4M+G7TPcNCFquyBdEPJoXbsp6Qbn50YG9k6mcWDo+fdl6fK6YrswiTes9HBkggkBWL+uXFbfe0gy72zezh5sKo8xcue9E/7kwC+b4ZDwz8b/lL0SshULZM4eHXYXP1TppYmkF/dl3KRdExbJWdIg56S2jewYeQfa1/qcFVjSI/MjHMN7ejmts1D41mR7FtierQY2Sbx/miVA/qHdHwiAleU/Cuwew/awP376BEbqbrf1Je1tDGAJx4Qk63w8oO6ZWcYa6+Seo/UN8U7w70kQ52+Y9AYMLTYKB9SYEpDl69yfDUwlGR7AVovktlWmsHUr87pVFl5kDb/BvHt0vhSxdMP6yKpbC6thvk1JCHZbAHszuroojumrBUiiQPn75vk12E8AeKxjWTyipPiRjGlG+ODFpQ5t/fw+8cdqVv2JRfO9jb7+gcko3r2vN0m6sifLVSpsA2EkH14gb/JZsw6qmcD66WPVl39wy5i7GbLufHQTJR2ijT9qE9hexsupkry632xrusoWNofKKkH2Uqb7cqSNdOjDCRpH3zk67AWE6Ww2Aopu09cfNY6WtabDBnJ5zJIHrAaspequuO4qBuNl6RFFEEt8IVye8eFcPj5Sy7Qz2RXsKEvSBJWaGklEGWNOsC7EZsh5/lth1Fp7O92neProjh5ymf8iUd0LUQbYH0IhR1fQyByk0pJxMdP3c4JZNdXDHX1KspAcn2b7uM6IEivalPSAEfA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR10MB7415.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o3OdH4hCEhmv1qhVPehSBgRTfuGCpX6F1T4qB1hKvpou8QybS4SP/6FpYCmC?=
 =?us-ascii?Q?6MMLKIq0j9C3v+1L+pYuSvYngwvkTnKTOZtVrbG24/ojNYzcvyg1mKNmah4X?=
 =?us-ascii?Q?DNJh4e2+hsk7VsrN+qrjzn3BtJ0PJruU3uwEK8WOVIEuQWpDfhmSKnX5jTTZ?=
 =?us-ascii?Q?ho5Ng73rFEk/EbC03K+3yW5xXmXqn8xOap/yEULIK3Xsur+P+00pBasCiLBL?=
 =?us-ascii?Q?8j6oCo7EKdQF9KRkN3/5RqvU31EUkPZxUYdB+t3xoKdzQWHTmhACBrtqxsri?=
 =?us-ascii?Q?Lfabl7xDr6IEt6LKxpsF4GWKqYeaaor6tyFePn8PZdIlo5ymV3IHnvJYLxJy?=
 =?us-ascii?Q?8K5FaVezJDoko+9PQ6PcmZs6OFebU0hfi0IMZp0cbEWV9oEw1YEI6MXFYZ4o?=
 =?us-ascii?Q?RFZatxiMymZbC7b9jpmoPuMkplo7DxudxoMoLKUTAh+7qcnB9fg1H5rGBxIM?=
 =?us-ascii?Q?ZSeXDmqKKa8D92d62MF1+7owE+OBSmXW6TXyFcyhr2JsJJ5Se61cFY0Mquhv?=
 =?us-ascii?Q?ouYpPdTrYHgWJ9txHTR2RlT4FWrsGMTs5ybAgdJSFxAp38DBTlgfqKhaGEi4?=
 =?us-ascii?Q?PnHdy40pH9u9i0hE63L/sKqXYkQnt2/ViKYK699XwKhslBJ7oTYjPJPw6eVH?=
 =?us-ascii?Q?Idj8rZyzv01tl7cm8PYF4vydcmXPLsWQ2t6I1IhKizzvlw28/XqOhAOqZ3DM?=
 =?us-ascii?Q?tKUmWOzBKlYHrRlBeJRYrzPDIQW9GCaNwYTsIDgHUdFFQy8kRvhiWWdLtzbx?=
 =?us-ascii?Q?CFrqh6k7nv70yTfiDq+rci2lIK4lGDiBHM2TTQVWGVZK+sCWVzU6HEfkGzDq?=
 =?us-ascii?Q?kFg4uvZGz+iw5LdXsW3QRfjieEERQ9w5Mcn0Xi8l1/tVitqtx0+MZNSMIfOn?=
 =?us-ascii?Q?EkFea2AbBrWNVJK2lQ1RDmo3ao6Jigr798KZhBlEEUj/xQsB315KczQICqTt?=
 =?us-ascii?Q?MSHMa6ewfVu4rucSgnlbf1TsnpxsbDw2E50xb6XA48B+8kSMPbgHlru0opVM?=
 =?us-ascii?Q?50Z9QqWwCJnypDHwX5LKqczz2+FoG5yjdbqSvylDkhzBwsI5RHhsTIeLkcGg?=
 =?us-ascii?Q?5RQFUIuHdySpc7Zp8LyADWDTjuA1nSdUZdWHK7TOk0MjZCcosQJr0zdT+Qp9?=
 =?us-ascii?Q?1/zNGpuqjwJMuWp9Gky6RufChgjv14uO/L0rfvMMaTrUUeyPgLYsPKhETtui?=
 =?us-ascii?Q?AMTM1Rh60GP8T6gRKEQm77chz9et4BkjYEayJoRXTTXzXFt8bGIwInJ3IsRt?=
 =?us-ascii?Q?S0sKxmQ6i2ZUpnVrBSwUMx0XsnW5aHWC8dN/w2WLXEfDd9j8X3+WwmjIAqi9?=
 =?us-ascii?Q?jwb+Aa3TlolMY+pUsBRqE4g9ek/pJGy42SfY6WoiPGxufCgPYUBBixGzcLyE?=
 =?us-ascii?Q?Ghs3UNeIdh+2d8Ci8Gs14nIADw8dMlSX8cIGugP/DqIiTgyu8noMo1EdWMPP?=
 =?us-ascii?Q?jFqmojwKSBOsVkHk4p0/979B5M2NWHb3yJ10kezP/PAiS74aCvDi0Zjm4nzg?=
 =?us-ascii?Q?KmmfNDbNTK9N9hJQ0ueiRAhXsH1WZmxc5IZeDq9/9lBNrwKF+AkUShFn+o0W?=
 =?us-ascii?Q?Jp8+lBMc1bvREBhx1uvdblUnP0IAiKFcYFyW4QlNrTu+CDJ10k7WGjbFG+1w?=
 =?us-ascii?Q?/YEbvnO3Sw/D80a27Lwjx2JTI0ZB6asiGrUmKv4aJDKW/Wp4SsQZpxBljNx+?=
 =?us-ascii?Q?D1hTnEwHkbQ8G26XkDNwAuTs0ZtpZd+gNOVNqIYXhwps6k15?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03119b5c-d9e6-4135-62cf-08dee604064f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 02:10:09.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGLUKlXUdMJiscDCwUKOWWmjlC3ZEe5FEpzX0n+bxPeObQfTc9OWa1fSqZSdyoDUja0UrHWStwUAY48/o1XqmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6285

On 2026-07-17 06:23:44+00:00, CHENG Haoning (BCSC/ENG1) wrote:
> On Wed, Jul 15, 2026 at 11:06:07AM +0200, Frieder Schrempf wrote:
>
> > On 14.07.26 12:28, Haoning CHENG via B4 Relay wrote:
> >
> > Sorry to chime in so late. I just want to understand what this
> > calibration offset is about. Why would there be a need of a
> > board-specific offset? The sensor is in the SoC and if you add a
> > board-specific offset, you no longer measure the SoC core temperature,
> > right?
> >
> > How would you determine the offset in the first place? How would I know
> > what fsl,temp-calibration-offset-millicelsius should be set to? I could
> > put a sensor on the SoC case and use the delta as offset, but then I
> > would just account for the thermal resistance of the casing and not
> > measure the SoC core temperature anymore, right?
>
> Hi Frieder,
>
> Thanks for pointing this out. Your understanding is correct: after
> applying the offset, the reported value no longer represents the raw
> SoC die or junction temperature.
>
> For this board, the required "SoC temperature" is the package-surface
> temperature. The offset was derived by comparing the TEMPMON reading
> against a calibrated external sensor placed near the SoC package
> surface under steady-state thermal conditions, and is used to
> approximate the package-surface temperature from the internal TEMPMON
> reading.
>
> The Linux thermal framework does not require a thermal zone to use a
> specific temperature reference. It only requires the reported
> temperature and trip points to use the same temperature domain.
>
> In this driver, the offset is added in get_temp() and subtracted in
> set_alarm() and set_panic() when programming the hardware thresholds.
> This keeps the reported temperature and trip points in the same
> package-surface temperature domain. Doing this in the driver is
> necessary because the hardware alarm thresholds must also be offset-
> corrected; applying the offset only in userspace would cause the
> TEMPMON IRQ to fire at the wrong die temperature.
>
> I agree that "calibration offset" is misleading, since this does not
> calibrate TEMPMON to a more accurate junction temperature. In the next
> revision, the commit messages and DT binding have been updated to
> describe this as a board-specific conversion offset from the internal
> sensor reading to an estimated package-surface temperature.
>
> Thanks,
> Haoning
Hi Frieder,

I need to correct my previous reply. After further discussion with our hard=
ware team, the offset does NOT convert die temperature to package-surface t=
emperature.

Their thermal characterization shows that the raw TEMPMON sensor reading it=
self deviates from the theoretical junction temperature - this deviation ex=
ists even at the die level, before any board or package influence. The offs=
et corrects the sensor reading toward the actual junction temperature, so i=
t is a genuine sensor calibration.

Board-level effects may contribute additionally, but they are not the prima=
ry reason for this feature. I apologize for the confusion - my earlier desc=
ription was inaccurate. The v10 series reflects this corrected understandin=
g.

Thanks,
Haoning
