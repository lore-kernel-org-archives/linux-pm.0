Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31B377EDB;
	Mon, 20 Apr 2026 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776652013; cv=fail; b=b88EJ/yAsOUYFc1xFvemZVGGYC5aJ6aGxfMh+iDlPx5b/JMqZN0mmIJ8qfrWh30NipOjPFLylGbjruYlLQYDG7X0mHQt330KqE1495cTpPe0LTJQdeIrlHRwnHBU1Et6i8LbRFQw9V7V1hsdZArofT8HyczdIQjmKIpbQj2HrW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776652013; c=relaxed/simple;
	bh=RK98rOUvCp9SPt/v9CVlUB0IsR86MdWl2Ecgg5wsTDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTtQmTRIyxS0qEyaZvDfOk9HZISBjs2cHtSexjvX9MZvE1doqGGoNf3wQw8ndlNCFlP6cpAw1bn1B7G/LCdTAOOsVlEeQ+NJ6cUyPfTchdXEC6f15BLvc4AE4ZdI0GFA9hTK5E2yZ6IxhJo6zns17Gzq7fA+cXLo580hQoVxLZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dDpAYpFk; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dDpAYpFk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgxC4AGpAjphp4wcx5a0RYeL4MfoGDe6C5x0p6c+k99aX3iLKY9Bdk/uKn+DxCA7e7JNl73nvPAzc23ck/LjggF01GshnIraRAyIX+ChG3g7sAbfwiDf2ua/+BI1E5ypmV1Ra6poa3lOfJn4EOgO/TmbVzP/0ZAJ5eOJElgYZWcOuDG+V7yxM/E90584nMZr60UFcnHDSrY/4LAbrBWJ3k205Vmpr6PD02hGzY5GTaU0g4ISJPtle3hEA0laERgQVg6mqlhwcF08WFlYRP9xAy3HrBeK2XetPcSrxVUO31ZV+QXngYw2n6X21yXv7IvVBxLYTGnwgtigWVM0zxrHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK98rOUvCp9SPt/v9CVlUB0IsR86MdWl2Ecgg5wsTDg=;
 b=iGYI9yLBekebE+dtPfNlrN7Tfa1uBvF5Wd7DruLIi7v63JpHzTNBBgL8VJmQfbSuUcN+5Y/AIdoNAhA8IHx1LuvDS5lkDfeKMxrsz1r4E41pfwE5mKG2q18FALY56QTNSwlq2PKVXBaWtqaxj+R6edHrITiTq3/mRIP2yGGV/R6MwODFM+uv3rP8tbRwdcU7zSH8BEevvz4SKr2hKaB0Go1VEIwwcw/Cibd+OfKScO9+SQ1KXCwcSmWAUPT+KCNYBkbEkE4Sqh2ertVtz7KNkPTmwityEUY1eHLlwS/SK5/cIAs6/jbRIUpC+6dFZBkeN2ygHfL+3YAfidVWi/M3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK98rOUvCp9SPt/v9CVlUB0IsR86MdWl2Ecgg5wsTDg=;
 b=dDpAYpFkYgYW29xAYfrG5i7TTz4eVqUPTA0293Qzk3v+tn37IWk8AKNbgUvmzkMG29l07wfQw64QcQv8iHQrQg05yU001zVTME2/f9wzrRVqKg7PWoV26yBBRWZC/QESV1XP7CSotUETHe+lResqwht5tjrZC1Xd6qToBnRWqWR2FkmJeo75sA2WbmEt+gOC+zxsWpGgcWgy6IW4VtiSmAUztfZYl/H6ttdAnTWc6NnuAtnI+dFeH//00DZ2gCga8PcONNNGLtPWLFNe3Emqpf8+undOBCno+GUBhMYRiKl8mYae6bdPXHWHK+WRTLQbIlv65AGQx7KtkYkZYkj2ow==
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5)
 by AMDPR04MB11605.eurprd04.prod.outlook.com (2603:10a6:20b:71a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 02:26:49 +0000
Received: from AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457]) by AMBPR04MB12334.eurprd04.prod.outlook.com
 ([fe80::9b4f:ab4e:94c3:c457%6]) with mapi id 15.20.9818.028; Mon, 20 Apr 2026
 02:26:49 +0000
From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, Marco Felsch
	<m.felsch@pengutronix.de>
CC: "ulfh@kernel.org" <ulfh@kernel.org>, Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Xuegang Liu <xuegang.liu@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL
 tristate
Thread-Topic: [EXT] Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL
 tristate
Thread-Index: AQHcywa8jFjWeOFOMEiinevo9PMwILXc+CcAgADVNaCAA2o6gIAGDEfg
Date: Mon, 20 Apr 2026 02:26:49 +0000
Message-ID:
 <AMBPR04MB1233451EEE5551561CF478E26EB2F2@AMBPR04MB12334.eurprd04.prod.outlook.com>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
 <ql2c6m54fjjwifycaan3hcr3p3bp4phva2vdux2qcramt7wrvy@4dsvpyct5tqx>
 <AMBPR04MB123344C1F802528A10CEA7FADEB252@AMBPR04MB12334.eurprd04.prod.outlook.com>
 <d44a60ff-c8a3-4347-9199-def61e855066@oss.nxp.com>
In-Reply-To: <d44a60ff-c8a3-4347-9199-def61e855066@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12334:EE_|AMDPR04MB11605:EE_
x-ms-office365-filtering-correlation-id: 08c4501f-742d-4ab3-6ad9-08de9e8446de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 wRw2h8QEj/Q7XQytLdZtjoMFT1Dj9s29r/RduTYlE/QJco7HrXkX4N3PkO2DnlIzsxiy/Bmj05JVCjdLsBHE1IAQz3X74vceyFMB4e8Wu+r4yRv8Z+SY/sBVLAIJEFNgaLyYvIICFeqVQLPLlDr+NrulhTFsOMDN4cqL6xvOcGGZQdk9Owv8iz3fUCHQcbLBPXf73KGUDhnn3Cd9IiB6Ey8XmvjqqTaUYx+C3hFghNJ4Zlg1GzDtvUKXhBqXYCJLY7R+qUSgy204dYx34+A4GEHwDbQneQM6X4CA9Fm4nzjSAL0KVX/5ESHvkYPErYBf2BfufDiL9PSb1738l/Mx3aWYtcOP4LlgV95stsEx52aWqqYM0JnPv7cs2yoeVNTpJstzh+d3nXxwLnWRadH6PjJCdjK8vfeFpFw30jd2I08FgEYsTBHFdXyTtoGwqN9CAXsBJ8i+STHc+fmrU3QinFiv/nt6/3US7+i0MVtCIJxlvcci/7ovYNWpFxWavgOklFSOaJs/ELv4TvN0SNagbK0bEC80YqDM3HdyN8gXVRBc16+k0928qZv+4x0RgjD9Mhew/dlYAGSgfJu42Tz3AGU2w8QF6pFKBO8TQn4bZhFkGOeVLQmHoxktQKWQI8RaSXdSRI+q4FO6FzS0MAH5W8OCVkp6O5ETn/g/3b2ws9kNKtwcR9HlgM4AvIYeNchtF9ewhdNfkS1SGW5EMe9mTGZcT4+OBpeeKwwCiwlG2miqklADpYareU2N4O+PPt2b6wQKlYoL38x/iCJwChLdsqDrn19sqzuS8Nka3Aohcfk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12334.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cUt1c045dXU4cGp4TDRkTFFRRFpGVlRmeGtkTkxjNE9sL000aTU1ckRmNDcy?=
 =?gb2312?B?OUNCZ0FORE9wTHRnUWhjQUpKWHROenlVbHFOUGZ5bzBZT0ZXbU1MdjVvZ01G?=
 =?gb2312?B?WHlPTUM3L0diRVIvWEIvV2I4K01LaVRFUi9MSDJIOExwbUd2UTVROVB2WXhQ?=
 =?gb2312?B?dXFmVlF1Qm1GbE83RU5WRDVXclhxbXdTKzYvczBNWkV5VlRhRzdZdk03bXNi?=
 =?gb2312?B?WVl0cndyVVBwZG16dmYyK1FjWDlUemtib05EUUdUY3lsR2ZoUmZaRlBCRkgy?=
 =?gb2312?B?U2QrMXlZZmQ1RjdTQUpzV25YNGN3SzVnb0FOeTdPKysrN2J4OEhFYStSUjRV?=
 =?gb2312?B?YnV6QWUzZnFSNi9SUER0a3JUcmpzS0crd0NuR2hXWlM3YVEvWGxPUUlLNXRJ?=
 =?gb2312?B?RzVmZkk1aTU1cnBmSVBzd3BzTWtRM213WUdlVkpSZjEvWmlNcDNNejhYRHpE?=
 =?gb2312?B?SldHVXBDTWVIWEw0alM1TmJUaXJOVVJFWE5KNVpEV2lyQklKNnR0NCtsUzQw?=
 =?gb2312?B?aGoyczJDd2ozWGdpYkNUekxxU3JzTHFkang1VGtXK2wybWtuVWpMK3QzdDhy?=
 =?gb2312?B?dVhTOVNoaDdacUtKNHk1WURsQ3JYb084elBZV0dTOVZKYVdJOThtdlVoRjhm?=
 =?gb2312?B?SFBsU0ZwbjFCWDZWL2RWOVJqU2huTVc3Ui9NMS9SaWhxSW9GT21PRWlHZmI2?=
 =?gb2312?B?eFQ3aFlzUFRYRVJMSmdpT2Iyc0dMTU1QT0U2YkxaTVE2YjRGVGUvRzdLUEdn?=
 =?gb2312?B?RTdCbm10NlR0c2RkL1krMHlpL2NHRVZNNUJiU1RpSWxJL0pZMDFhWGg3RXIz?=
 =?gb2312?B?SU5oSkFNVnVFUVFoZWtUOFdqMFVXVFNhNkEzemxJS25UczZESFV5UmxzWE9p?=
 =?gb2312?B?RXNldjhVQlJCcEowZXpsUWpiR0VGb0x3MzdjVGlYbElVWWdSaTd1M0xSRStx?=
 =?gb2312?B?bnRQbHdydlA5ck96TTlPdkRsbU4xem9PU2pPcWlNSlFPNmNZY2dGN0NnUmw2?=
 =?gb2312?B?WGxjSk5KZzJiWU40OVFBZkFQaGtjWnRrWVlicENCRHlmUEZVOWpuRC9EQU1j?=
 =?gb2312?B?T0Vxb3JTUWhyRC9JYmFic3BsRm5PMlQrd1VLanI0MHFiWUMzd2QxVE1oZExF?=
 =?gb2312?B?Z3BCR3QydlFTR3BKUUc3MW9QK3IxSVcvcXJFSnVLelBENndPL1VFSzBHRk10?=
 =?gb2312?B?SnZYeXNOaGFWcEVNVVpQVjVNVzNOTDI1N2Y1QmliS3dPZy9oZExWK2MyUzRB?=
 =?gb2312?B?OENGd0xBRHpSTzBUdVJNTWZiODBuaWhxZVJzc3JiTFhlcmxsRkgwQ1V6TFlZ?=
 =?gb2312?B?MFFUZ2IyaGg0amFjZnRTWHhuOURtYWJudHEyWWFYY29nNmhCejBGQnh0YUVo?=
 =?gb2312?B?eGd4cnQvUWxJbnQ1Q3JTcWpMTUhLTlVGNTUrQk0yNUNFQnBhOXkxWFF6clRu?=
 =?gb2312?B?Y0xZSjgyaVZGZ3V4aTduSStFT2xUTllTMWhTOTdyb09peFF5VmhyWXpONVJh?=
 =?gb2312?B?WkRHeUJFUUFjL0NCRkxRYWRaZCtZcVRYVE1WUWIvd1pZNjRkT09CUElxdzRm?=
 =?gb2312?B?VFVBVFd3QmF5cHd5UGZYNUF1bkFWRWRoUzVwUW1hYjNONFh1RG8veE1SY09Q?=
 =?gb2312?B?M0JPVlM5eFM4M1JrZFVZVXBZS2IyZHVrTWdUZndac1RyTVpacDlKdDV1eHBT?=
 =?gb2312?B?VXpJY0krc29DdzlkSFgrd1UwcG9CL1JyZkwreld2cC9yTDNESFJlMTdKeTlC?=
 =?gb2312?B?MDIvejhObWEvS0RLcWgrV1BlZ1hsZVVESkxJWkUyMEI2UHY4MlhqVHdDQ0RY?=
 =?gb2312?B?bDRJZ1BHcDBpT1hnVXlRSFAzYzIwSUtSR2VqWk8xUXY1eEFiTHA1VFNoc0lu?=
 =?gb2312?B?VllJNTE2dVA5SXoxSmZGUkV1WXBLWWlOUU5uTWhrV3NwTFVrSVdzSDdxaUdL?=
 =?gb2312?B?WjAxRHY1L1Jwc2l2L1BjRk8xNDJDd3dENnloWUJRR2wzQ1IyOUkrRWVjNUg1?=
 =?gb2312?B?anh5c2FLUndHMDFkRXRZY3diVFFsZDdTczNCWmpRaXRWZTdlRHo2VUlmSFBl?=
 =?gb2312?B?bnRjWjdxYk9XVjVvZ2NIN0VDTGRRakRWNUJQK2hhbXpqelJnUWYvbzJsMDFJ?=
 =?gb2312?B?L1FzZVlhQk56enh0NjNNY0VlU0RuNFczRTY1R0ZHeHlQR3RxWTJBRjBkQUI0?=
 =?gb2312?B?b1psT0FMdERYSENQK1BmajgzWmtrMmY2QUNFdC9WaDE0Tm43aEprajUzQzQ5?=
 =?gb2312?B?a0kveWQxY1dQNkQ2eUl2cm5QN2o0SEJqSGd2TGU2aTloVVlYWHJGVXpxYk51?=
 =?gb2312?B?U3RWYjNycjBDbTRxMjZoa2JTZXhxSWZwOGlpeWNobWVNMEJ3VmtGQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12334.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4501f-742d-4ab3-6ad9-08de9e8446de
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 02:26:49.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXGs2ZIcFmAIaihKUhcBq7AuVQnAzna2FnKLXa0BgAmu0mo8NELpPIgvOqJKyW251bZVgX6nM8n+xFy6g55BHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11605

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIEJhbHV0YSAo
T1NTKSA8ZGFuaWVsLmJhbHV0YUBvc3MubnhwLmNvbT4NCj4gU2VudDogMjAyNsTqNNTCMTbI1SAx
NDowNA0KPiBUbzogWmhpcGVuZyBXYW5nIDx6aGlwZW5nLndhbmdfMUBueHAuY29tPjsgTWFyY28g
RmVsc2NoDQo+IDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IHVsZmhAa2VybmVsLm9y
ZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0K
PiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IFh1ZWdhbmcg
TGl1DQo+IDx4dWVnYW5nLmxpdUBueHAuY29tPjsgSmluZG9uZyBZdWUgPGppbmRvbmcueXVlQG54
cC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9u
aXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYyXSBwbWRvbWFpbjog
aW14OiBNYWtlIElNWDhNL0lNWDkNCj4gQkxLX0NUUkwgdHJpc3RhdGUNCj4gDQo+IE9uIDQvMTQv
MjYgMDQ6NTksIFpoaXBlbmcgV2FuZyB3cm90ZToNCj4gPiAgPiBPbiAyNi0wNC0xMywgWmhpcGVu
ZyBXYW5nIHdyb3RlOg0KPiA+Pj4gQ29udmVydCBJTVg4TV9CTEtfQ1RSTCBhbmQgSU1YOV9CTEtf
Q1RSTCBmcm9tIGJvb2wgdG8gdHJpc3RhdGUgdG8NCj4gPj4+IGFsbG93IGJ1aWxkaW5nIGFzIGxv
YWRhYmxlIG1vZHVsZXMuDQo+ID4+IE91dCBvZiBjdXJpb3NpdHksIHdoeSBkbyB5b3Ugd2FudCB0
byBoYXZlIGEgUE0gZHJpdmVyIHRvIGJlIGJ1aWxkYWJsZQ0KPiA+PiBhcyBtb2R1bGU/DQo+ID4+
DQo+ID4+IFJlZ2FyZHMsDQo+ID4+ICAgTWFyY28NCj4gPj4NCj4gPiBIaSBNYXJjbywNCj4gPg0K
PiA+IFRoYW5rIHlvdSBmb3IgeW91ciBxdWVzdGlvbi4NCj4gPg0KPiA+IFRoZSBwcmltYXJ5IG1v
dGl2YXRpb24gaXMgdG8gc3VwcG9ydCBHb29nbGUncyBHS0kgKEdlbmVyaWMgS2VybmVsDQo+ID4g
SW1hZ2UpIHJlcXVpcmVtZW50IGZvciBBbmRyb2lkIGRldmljZXMuDQo+ID4NCj4gPiBHS0kgc2Vw
YXJhdGVzIHRoZSBrZXJuZWwgaW50byB0d28gcGFydHM6DQo+ID4gMS4gQSB1bmlmaWVkIGtlcm5l
bCBpbWFnZSAoR0tJKSB0aGF0IGlzIGNvbW1vbiBhY3Jvc3MgYWxsIEFuZHJvaWQNCj4gPiBkZXZp
Y2VzIDIuIFZlbmRvci1zcGVjaWZpYyBkcml2ZXJzIHRoYXQgbXVzdCBiZSBidWlsdCBhcyBsb2Fk
YWJsZQ0KPiA+IG1vZHVsZXMNCj4gPg0KPiA+IFVuZGVyIHRoZSBHS0kgYXJjaGl0ZWN0dXJlLCBT
b0Mtc3BlY2lmaWMgZHJpdmVycyBsaWtlIElNWDhNL0lNWDkNCj4gPiBCTEtfQ1RSTCBjYW5ub3Qg
YmUgYnVpbHQgaW50byB0aGUgY29yZSBrZXJuZWwgaW1hZ2UuIEluc3RlYWQsIHRoZXkNCj4gPiBt
dXN0IGJlIGxvYWRhYmxlIG1vZHVsZXMgdGhhdCB2ZW5kb3JzIGNhbiBzaGlwIHNlcGFyYXRlbHku
IFRoaXMgYWxsb3dzOg0KPiA+DQo+ID4gLSBBIHNpbmdsZSBrZXJuZWwgYmluYXJ5IHRvIHN1cHBv
cnQgbXVsdGlwbGUgaGFyZHdhcmUgcGxhdGZvcm1zDQo+ID4gLSBWZW5kb3JzIHRvIHVwZGF0ZSB0
aGVpciBkcml2ZXJzIGluZGVwZW5kZW50bHkgd2l0aG91dCByZWJ1aWxkaW5nIHRoZQ0KPiA+IGVu
dGlyZSBrZXJuZWwNCj4gPiAtIEJldHRlciBjb21wbGlhbmNlIHdpdGggQW5kcm9pZCdzIGtlcm5l
bCB1cGRhdGUgYW5kIHNlY3VyaXR5IHBvbGljaWVzDQo+ID4NCj4gQ2FuIHlvdSBwbGVhc2UgYWRk
IHRoZSBiZWxvdyBsaW5lIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCg0KSGkgRGFuaWVsLA0KDQpU
aGFuayB5b3UhIFY0IHNlbnQuDQoNCkJScywNClpoaXBlbmcNCj4gPiBGb3IgaS5NWDhNL2kuTVg5
IGRldmljZXMgcnVubmluZyBBbmRyb2lkIHdpdGggR0tJIGtlcm5lbHMsIHRoZQ0KPiA+IEJMS19D
VFJMIGRyaXZlcnMgbmVlZCB0byBiZSBsb2FkZWQgYXMgbW9kdWxlcyBkdXJpbmcgYm9vdC4gV2l0
aG91dA0KPiA+IHRyaXN0YXRlIHN1cHBvcnQsIHRoZXNlIGRldmljZXMgY2Fubm90IHByb3Blcmx5
IGluaXRpYWxpemUgdGhlaXIgcG93ZXINCj4gPiBkb21haW5zLCBtYWtpbmcgdGhlbSBub24tZnVu
Y3Rpb25hbCB1bmRlciBHS0kuDQo+IA0KDQo=
