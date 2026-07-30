Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBB2DE702;
	Thu, 30 Jul 2026 01:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374954; cv=fail; b=ECQ2Olnd5m9x9HPC6OAGxYDlhRkrEQI8G9jvSuAgOzCf8rPxVrow1Yo9W8a7vMb3hhwO+sKph4dPA1XCobEEq0u8IMryUBU7U6wUuzTglmv6fElPNkCwCD+e3hGAqq8hLMSmu3HWVtwJxaU79HgD3XZk51l8Nkvpv8HQbbMTBY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374954; c=relaxed/simple;
	bh=1UMc5vMfffOY/aK1eTDtcuJSsfYaj40HmTVak7CVZEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d5XZonIJIUBzC1Di9hk8rQR0PL+XlL3GC4PlFPFXsbMXx46rpSAV7LJIFpfe3D3g6MbmtDNV0vCmLllnuZOKDBYsiR7160zvFnuH6ouGxxPDbQQgyAj6P6IIqCqXM8/KwnIk4pngHz9cLWx7NX/LYXZ1YzN1McHYU0f666icjKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com; spf=pass smtp.mailfrom=cn.bosch.com; dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b=N8z9QUHW; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cn.bosch.com header.i=@cn.bosch.com header.b="N8z9QUHW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or9npVSFH2J+5FsaxKAvyQwJYRYYq2M39Oo+SNcvFwHj9/nvAnbhOIuiAFgZIuL3cMClJcSkv6UVvmbMpQrXpdSiw/RrU8RERTgRxSh6q6fUkjkRZ2oPEvFa7J3KducAKju1965jTLB3fF5IOZXI7mpAtBLYrgBGpeI/gO1xc7lfiNUlP0HbZzuLfA3OqRQcVuKbfQae0aZRX+BZ3KP3gev06I+vfkOIrrvbkJLT13YfcSTB3DdEhFNL59CN2u+naRonHJxQ3ObjnB64N3QKaFxSrdbyFp/Viv4KDcMkGy6QbmWhpF6vXi8X7JTR8hr5u/0ytOYZMOzvVXpLcGJOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UMc5vMfffOY/aK1eTDtcuJSsfYaj40HmTVak7CVZEo=;
 b=bytKoalolNbhzZtLa7SChzHIC5CgyE2u4gO3jUqj7pqslI7c8X5j2i33iCkjUT52NphGDae1vaGtv612LLDzHnXCN4yQMPXwYBkQf9QL3tzHmWEES4TSNLM+QBvijC9F4e67X8UGeufBw1BXBTUYMaxI2RiEKtMJb+sDrakozeXxunQHrS3uUr7a8VcTmeZMimkCVB0q/Fz0R7IDA2qSHY5sQkHQ3bOvjB1fv1ysywf9zaAsvp12BvRHQw2zcSj9gUCylexa7datRnNu+YmoBbcwCxZo1YILa4qEZxDw5u32UPhZfHZqSJIJ/gl53SuaE3L0JAmW698i6ah2HMsUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cn.bosch.com; dmarc=pass action=none header.from=cn.bosch.com;
 dkim=pass header.d=cn.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UMc5vMfffOY/aK1eTDtcuJSsfYaj40HmTVak7CVZEo=;
 b=N8z9QUHW0HEP324SkV+kgI0EcA7UId1cYKdAqiEaCvf7qTxu4akaAnDkdMIkC/uRuGBebfHfTj3wDDVotfJ4MyNv2bZ/QF+BzBvYJUNwzJS3H4wwGzULL/FT2p2MEECvMn/1SfvusPuNeDo94kXqmxW3xozb5Lk7xK6f3jLdyJdpVRGfBxCM470x1lmH3JUKd/fULPrFV/wzffn4PpOB6tRzkP26VDaGk97FR6zbCIRKwmQWGy94SarWUul2dLRL2ht3lYM/iRDpfClm3C+eAbJ5TJEKjJe5q4CcB0HGW9OxouVcqM26Qw8V9QLf4MVfPK+QbNhj3lPlWrWh5AmmRg==
Received: from DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e::28)
 by AS4PR10MB6229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 01:29:08 +0000
Received: from DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::30a7:b546:71c8:a648]) by DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::30a7:b546:71c8:a648%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 01:29:08 +0000
From: "CHENG Haoning (BCSC/ENG1)" <Haoning.CHENG@cn.bosch.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v11 0/3] thermal: imx: Add calibration offset support
Thread-Topic: [PATCH v11 0/3] thermal: imx: Add calibration offset support
Thread-Index: AQHdGYNGZWJpHKktD0SdF6SB0unrWbaFUpew
Date: Thu, 30 Jul 2026 01:29:07 +0000
Message-ID:
 <DB7PR10MB2362977EAE8350A4015A8966C2C92@DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM>
References:
 <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
In-Reply-To:
 <20260722-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-90e4e46c0a13@cn.bosch.com>
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
x-ms-traffictypediagnostic: DB7PR10MB2362:EE_|AS4PR10MB6229:EE_
x-ms-office365-filtering-correlation-id: 6b141321-1f66-477a-f79e-08deedd9f353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|38070700021|921020|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 V9qvsmX8VzN+gDeyg2e+4xI+cGAHQKyxfxcJUCHYft00iDHuOUEoaBlst7X04ra86BeHeC3M/ZXnMNAOTuHLbLe+OVJUBaI10fYJtrWzZVXHrFdZR8e7hJXRyulTfq/ZF6M7ip0Bii6Jvqp1SCQ5DrNf9eySfFPqif/F+J/q3jelOJfUo+9GgOVATMlVLlci8TbvbUhGepy4xxgQwlI1TLDiCFhONqAb0ISnCa5jfYCGOzy9sjSWwkIJHXkqxrw+twTL+gyLDz1NQHupin0r36AmINuAcrd0VQ8KrqBL84PiYKmBY0px9vopzh54/NVDpOjYvKuAl8vDP2rKVlQRWiR5FdVqjYPI2K1e27omE31l96PBob1gGnTR6i94u87hzs6IV0xuQBRPxi8z3EQlnyGbdluIaZ8Woo/IS4C9OIMHUoy3bmhhPKogpT/mgAEXJWSfZ2rXGpO4calmb0vz9wsxbnMlJ6ojnMTELtunDZoGUFG1E48Z/N6jVBR4euWoR/viqLvGZVyEX/0N/Ap1AYZ5NVjSUZzmnaYclFzNsWBDQLO8MA9qD4NjW7qxgu/RELAJU4Eq1gjQW3DjpAM3DKtKkxcoAgCBiQ2nUl59X7fXLma+pOzL1kolDTlN8hjg+HnqJtIq8vR7Yzc2ikmgoSEs5tGJRj9Mq6oek9DgCbFDL/jKaobqK9tSPnmdNK+UgZRyUn+yHV7E0IvCnvmWg3+LzOlOKMlh3EIaxayWNCZWbBNj4NNc1TZBrdAccWxb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fv64Z6IigvHLANalOy+zJtI8YspNYKsJd8UNjDArGqmU3hmmjVlmREB3+gYg?=
 =?us-ascii?Q?EwFsnlytz/YXOaHz3omXKNqTv0GgvMfncLtd4irfyY7pTULsUXvQwAWBbXuB?=
 =?us-ascii?Q?WtOX8zEsBf72W/hw4C1dPo6iiKs0hUjXNL0Z3zM73ICS/07y5RXFy2ZO7PJU?=
 =?us-ascii?Q?xoAiYsDQO1yKMnnwJ54ARIwBUjul1NtuPSyHCXUZj0lf42zONCCPzC0WrZvG?=
 =?us-ascii?Q?4ZAk4mWni01pXiLUDrOFUYkJaDxS764JYu3531FBYmfddV1V1pTDisY7tzN5?=
 =?us-ascii?Q?FIwMjsJk64sEr9CQPt0AOo7BcH4jBFFvF60kjs6JlB1Tt4MhFWcm0RddGy76?=
 =?us-ascii?Q?OUcLfrIi+UyMTQta9eZ4FMc7+E/gnegkv+D9JVXZzKXAq9BNmqASMY5gS1ac?=
 =?us-ascii?Q?RzVs6kevzGobT/WPuqrb7xK3ydSwciWycnaiaxWqLSrTprrMLC9g2vkc0O5Q?=
 =?us-ascii?Q?hN51qhhyjd+ILhTqOeSUT8zj7G15lHncDmO2NlbOibkTjtHtjNqpJ+9hKYVv?=
 =?us-ascii?Q?/HnrrPSDS7Z9WFKaC4Az0pNUKOSKmWOqVzFnEONyecECyV/5KFenoXcNnDcW?=
 =?us-ascii?Q?U13y5k2eoEuqbjU4TMEujkddS6giY/DCZO7DdAVEqCg+2QF6w41vHMOKoGId?=
 =?us-ascii?Q?4VR7GgZ0UL/XHyUtmt+5H9gFBGlN3TNbq6r97IMvk0tOh2QfwIvHrfasFi4O?=
 =?us-ascii?Q?EEW6ZMWWCVdepWe0zyAfx0T9JXbKBM0rwu0BXRmro3AzBtztXwx5HfhKMPMB?=
 =?us-ascii?Q?nw1ETA9uw/LqGirecR6Q1YCnzbdTfHzdaeGyVYeFvYgk9Nx7ZyxIvLyIUviO?=
 =?us-ascii?Q?+EvxjEPtDTNsMTBns19ozAgKBP1KQgAnUi2fgaRm0dyEsD40Q+Vma1feJg4t?=
 =?us-ascii?Q?f26b3KoGtZ3gsLoqGGxDL8wZzHNzFE6yEYMCdwCQPjTJPJF5EaQH02GLeEjO?=
 =?us-ascii?Q?2RoWDiJ09Pi80rTnlOl7TAIBSVz6vPZWqScBYEhM7jwhYCetjQOi4vXQKCSW?=
 =?us-ascii?Q?KAItlIuJ3fL+LWuHk4bjankUrvUGYLTCa2CJLGPEfqrWlm+Vp34ls6RBLeRE?=
 =?us-ascii?Q?SEPvRwr1Q/LuITcu8XBo2j+iaiJjALggcbCnCT9sk+bdhxzfXYWoursTyqoW?=
 =?us-ascii?Q?8MwGrMB0jheBHp7ih5NY/1bwrOdMUiBUb7so+m51AFfz0PLSSlK7kIyJXD2Y?=
 =?us-ascii?Q?IDduCionW8HyLD2tD+PuYIw57bb6U6IJ9ZrQqDXU1MLE9maCIXO6a/TWst6w?=
 =?us-ascii?Q?C7qwJBcUSuaTajk9C1XxUkDVNTqX+T8QNM1lDgO/FK0DQukHHHwPpTme8CVP?=
 =?us-ascii?Q?Yq8831Ufj6PXT848OOIffn5S8UYUkAaVIxlOTUS+shKudbexHMNgDtgjTX77?=
 =?us-ascii?Q?SVFytr+qJDnrQ4+epI65m3cc8fyBcGzrllCWU9YRTRonuWmUuXrbtwqdPPcv?=
 =?us-ascii?Q?IVCoDPYFtheKbYp8gZSh7hQwNo8wMKYbhV5y2Qyzgj7sQSaZcvMvOo7Ea+dm?=
 =?us-ascii?Q?c9ZX1zQOFTtj3QKlT3jV+cZyME61yE+a6HBJjAjW9bW3E8pLZHEv+VftLbbz?=
 =?us-ascii?Q?ueKxoFXH3o2gxPJ67avwuhdTEz/WwmseORgVC9SLCIokuN3bxPVGj7U0qjxW?=
 =?us-ascii?Q?oSyh15cWZwvG/LMNIHaO2ZJCOF8QXEjcN957M2E+jTRdZds0MDA/R9T2NHLk?=
 =?us-ascii?Q?fWEtEM4m1FXS4XdNG9AK+J9bHn0NepsL2JMRjc4B/gqcnynm?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2362.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b141321-1f66-477a-f79e-08deedd9f353
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 01:29:07.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4x8pzNI19aWq+nLnaZS1ZkGfEWreSzq6NC7nv6r8VP85qcopGEugORbSGMRVxtfYQE8zCss11TJEgoz6XDGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6229

Hi Daniel and Rafael,

A gentle ping on this series.

Please let me know if there are any remaining concerns, or if the series ca=
n be considered for the thermal tree.

Thanks,
Haoning
