Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013079.outbound.protection.outlook.com [52.103.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A3212D7C;
	Mon, 23 Mar 2026 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774241843; cv=fail; b=iPdhP/thPFHnfwDjb28fsUYOd7MY0BJ5XNIxJoMetL4ZaDpAO8PW/+swfKe5lvPGWTml/k0hJmk29di2VVu4IEfMduwBmB1WdLgx5LYHEm/bnuoyvSnCvrZ6uqsSfslM1LXiRxGIxCdZZ9S5qJfAUcOO7pLCxzxPrpmosFY9a9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774241843; c=relaxed/simple;
	bh=KG1e04ltvqSZEPfuIkl7UPC9Uw6oQJO5yTKpjau/870=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TE25Zu4dfautZzG7dm2o8F0bi2BLJ0V6YpSwg9oCS9ahSpfSHBV26uY8chVvuqtdHapMdm1KJ08Z5w4KCmtSVfEoB+cWvEb01c+AMT8cx6bB0sZsjKC7//4+mFqfjpnjv9VMTKFT10gRH/+2pnxwX7z/cAdKQvtFf3iOArkzmAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=HBUdy3vl; arc=fail smtp.client-ip=52.103.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="HBUdy3vl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl2za2VkCsvNvSPUjJYYpKnE6OliSdZQP24L/SwexqjEPaelxg0BQ6o+hJ0tYnKSKHg38O/3MIZlnR4b8MbFNMvIkoo0BIohh4Chd0yinWFkcR1hd9pV4wfUjLoe+KvWEm8035CQ3oRu+vpaIZtgpdKMWoU2ugLC2IIgjy9/mTWczrbxq88NH+U85txlix5A6CWLdY1jlJIJdHA8TrMiHSQ9dZdZZdApFdn9DkNGVgUtlUQu76Q1nJIHeEqkVw4MOBWRzQSJOmsu6jHFyVYg8aG+WTkBdOm3jvZZNgQAaSupdGK2Zn+J8OT8oevLIFkmc5re5x1weTYBCf0C57XFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2XnUz/pWnUf36/Nkpg30K5ZVD994uM9BdDeLQSFiN0=;
 b=nch63Lje7VSXOir75wNhdhibqp7WIrz2nlmEVkTj/gBOpswCeXAjs6SBXyBpocTFc61mN8gtoXYfg/J1C25+QZ+S3yCeSlQuwkapTbrlPcIP1bjvYc1LjvCrn/RPg2PIm1yMPw67U0/AKHo6fWFby4zpoWc52kFUJ7+gXlE6fQTOAUX5Yt6TL1Ea4Vx6LDVdRaAHC085aZWuUDwMNTBgVmN8sgTV50N27dDlwjxaUfUthzuDMMyaeOu9kDQQwSoCY/wjtqToXeFTUeMkjtA8aOrQoGmHxpVf2SKhexZv3iG32xhCj1+NGtVDXTwOyfXhlRIzA3+oolU+N4KTGZObHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2XnUz/pWnUf36/Nkpg30K5ZVD994uM9BdDeLQSFiN0=;
 b=HBUdy3vlFPi5Q19+6vBtP/r0m8mJSnNB0fMX/VPxu6DlRGU3crMHggA2lWqTjfFepWz7G4ajc3vRqWvERnlCZ6HgiZnyDC5bbkLmzpatXnouKXaA2QwAvAGXv/YF6EQK+ebfA6sm3sFm2M/uuPNJks0X5zP3L33yrslEXv8VUqAJFpsadQJs3pfEK6YWsc9x+Tx40w9kO8G+5JCUWdkIPLzEVxEf0XJxBKz9cl4t5FgFynJibQgeRHshgNgkCpOFmgpKM+c4E6WmDHw67Dr8WotvwKL12lwtyfxcPu4Zv9zO/wS4woKs9FKTGoZ7eJ2RMu5ruKy80eKjARyX8iKM+w==
Received: from IA1PR14MB6224.namprd14.prod.outlook.com (2603:10b6:208:42b::6)
 by BN8PR14MB4211.namprd14.prod.outlook.com (2603:10b6:408:d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 04:57:17 +0000
Received: from IA1PR14MB6224.namprd14.prod.outlook.com
 ([fe80::5618:5ae9:9507:3d19]) by IA1PR14MB6224.namprd14.prod.outlook.com
 ([fe80::5618:5ae9:9507:3d19%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 04:57:17 +0000
From: =?Windows-1252?Q?Jhon_Taylor_Forbes_Ca=F1izares?=
	<hermanojhonforbes@hotmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "jarkko@kernel.org"
	<jarkko@kernel.org>, "ebiggers@kernel.org" <ebiggers@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "mjg59@srcf.ucam.org"
	<mjg59@srcf.ucam.org>
Subject: [RFC] power/hibernate: TPM2 image encryption to allow hibernation
 under lockdown
Thread-Topic: [RFC] power/hibernate: TPM2 image encryption to allow
 hibernation under lockdown
Thread-Index: AQHcun+YBPtd61lIz06blJxG6tGcxg==
Date: Mon, 23 Mar 2026 04:57:17 +0000
Message-ID:
 <IA1PR14MB62243E515C24AE8BF40E36BCB14BA@IA1PR14MB6224.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR14MB6224:EE_|BN8PR14MB4211:EE_
x-ms-office365-filtering-correlation-id: 89c692ee-bc72-4507-2070-08de8898a8a0
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999003|6092099016|15030799006|15080799012|20031999003|10092599007|39105399006|5062599005|41001999006|25031999004|24121999003|22091999003|19110799012|8062599012|461199028|8060799015|24071999003|31061999003|102099032|440099028|3412199025|3430499032|25131999003|56899033|40105399003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?gh+1Y7L+2JoSq3KjOhyEt9wA8pxeAPk15/hn/qMY1yBT188pYehFX1hH?=
 =?Windows-1252?Q?hp+drPadWvNzCC1PqJBwj4lzFzNnIX0dYgX9UbQFmTmgJjQg3SaIewXL?=
 =?Windows-1252?Q?73j8taEmcFfp0I11TVvSKGRZuuJjYB5IHNRUvl54GTqAqefYz5dAlrYv?=
 =?Windows-1252?Q?Crq/pnwixhG07NgBMndOfozFYQLeO8DLsls/3jhLCUkQye46utATCyd8?=
 =?Windows-1252?Q?AkwWzhtogD5W4VKMlSUHsBDBpj6tSBVBiOdSz5jMWkKMswZTAwJ7m014?=
 =?Windows-1252?Q?zqN7CxKS+H1dSPsHtRQrNwM8bJVQtoBFFDEGhfPEiQXJScgebNjd0CMJ?=
 =?Windows-1252?Q?tq+SRSWA/MWI7yDDjA1JxLN1RueDuA0kpFgp+nkykRRZBixcls3PHW5m?=
 =?Windows-1252?Q?Q9cWOSpAIht/AcHzoQP0TGCYf7ebWFrTmh+EuGPBbvqvAdcZUwjU9VRf?=
 =?Windows-1252?Q?LOoiV6UTkEnEpTqLxfVzlKSzXgqAsMxIaq5CKaAza9xf+XiXK8bzmnGR?=
 =?Windows-1252?Q?8fWlWQLpqwuv7u/UvkyWzkI/1HqiV+cp1ERptwIVtbvUFNv4OcT2gxQR?=
 =?Windows-1252?Q?wqqTkGLTXrFEqUL/rSTFKtAeKuCKF+l671r2O95uiT8f3xhYKHuE/41o?=
 =?Windows-1252?Q?qhtu+GWzQbJRBS5LToNteLQdgm1L6hZnyprCiEr5NzH2JjMqVAi9GAD7?=
 =?Windows-1252?Q?LQe+5X8OOGMh1oeY+WQ/hSyQec9jOR4uZMWoxxs8Eb2QPbAmVEKgD6dl?=
 =?Windows-1252?Q?VxIqzfm6uqVTmbopr9C0D1i+Gbz2l8LjR6CPgC0UJGIj2O0fEXkVMNG7?=
 =?Windows-1252?Q?dShDOkFecCeQmWuLx2Mva3HYgaxxvM4o9/61SFss3pKTKyaMwnkeqJFi?=
 =?Windows-1252?Q?0EZEIeQ9aJM1slB/wJZTVivtD8obeU8goruz+NL8Zxm2sdSKK4+E8YZD?=
 =?Windows-1252?Q?ciA5QDi9rdmKNctSH3jdhxVR0U5qjmqatPDnDffHCTKsA+0MX4CkxJ4k?=
 =?Windows-1252?Q?v3su/E7ECHhbqwTux8mrNcNExODcOWzCR2Sad33hbFJy5yJSvexuKbE2?=
 =?Windows-1252?Q?gpwc1V6FPLKsv0PZMOb8eMcjY0NTnAeyBLdA85kYXMuYmCmwTOYEdBGT?=
 =?Windows-1252?Q?PX7RnQkrR/oJgat/SulP+Ea3hdNWQjOv3QXuZLck392mP/+UR22I1Ltx?=
 =?Windows-1252?Q?A2iX3LtVRIqcl2MN/e6jwWSKj/S/QDXCgKSQKnJg4FL5u4zt872Z6h75?=
 =?Windows-1252?Q?I3qp5F78BsMxNcm5sSR7pMAXBJyhcGC/Pv4NWmgBoE74S9FQTqBJh/BX?=
 =?Windows-1252?Q?2WuSGBQypvtX4AfqLFMBCOBLueeecVVU1hCUpG0RwBNbGWnAvROFWgn8?=
 =?Windows-1252?Q?RdFS6BljCYfepg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Le7vdgjqgPJ9nvtmd6pLCaeu+MFoPkC4C0wH5g6ze9Qish/n2OrbScLp?=
 =?Windows-1252?Q?LAJX1B8FRR3GKYs1U2TyVTd5fIVFce+q1zbgydpT9UCBK0NxORTXY4iT?=
 =?Windows-1252?Q?+sVt+9H4R7uuptRVPeSzGr7iYMODYzdcaBe/5ykB2cOF0iA8EZlPX+qd?=
 =?Windows-1252?Q?bt/1hlmYIavDqonQidaBWtPXRF/H2cidfGVWg/QAoV0BPv1zjNQA1uR4?=
 =?Windows-1252?Q?k0fi5F0kPZxUv81NlcBrZwAvA2jGGmgb7BKfwLz69R9ekk7T68EtLc8n?=
 =?Windows-1252?Q?1rMcd2nxkZnvfDXjzncOInfU1Bzf1upmtWxRF4v1JSfPnWIWe5+xVCbd?=
 =?Windows-1252?Q?Ie0U+m4zdwRUk9lvlXFNcJUvQSnsDpmGtZ/A8tHCQndOgqpfRyTJ1C4u?=
 =?Windows-1252?Q?HkJu9b8+18hwip7oFDPCH3NpaDTpiZ1vBbUmnzwO5MH0yVJZ+ZUF+h2M?=
 =?Windows-1252?Q?2HtkwU9nh3USKoSErLpUvmLwNpyjzXHmBBNiX3VOunI60zzOvZiy++nL?=
 =?Windows-1252?Q?NbjMyy+AOBVRTqzTbUJUK87DiCTI8PExbCf6eK/X/RBxwLNATcDtiX7g?=
 =?Windows-1252?Q?2eYcGFakxI2Ed+RtAntbgWMAzUXPqqyPAAUY8GdUaB6Tp/LK6gs1F4cB?=
 =?Windows-1252?Q?S5/jgoaoZYPYasieSvpZ/xnyueuBOQ4QLDyu+DQAarM7oX3Yx6RatEod?=
 =?Windows-1252?Q?WdGbeOzTFDo7bafntdYTWRjT4t4LA4SIyY5yj/bKqCRf6Mcp3yhmQcny?=
 =?Windows-1252?Q?+6iXY40L0RhT1bkst3tpuSZCmnMen2OsglGICEdDwBMQmaRGooTu7pKF?=
 =?Windows-1252?Q?C1sdXAqZLvXlYSn0sMaRcwsmk3d/3UHqb1nJWvrVaQBG5i6Y2hXveLme?=
 =?Windows-1252?Q?xmwuHje6eWlvbYaX2m+qm+tWM3M7jcf8kZpBcGHmB5vbko9HVqWymqoc?=
 =?Windows-1252?Q?6227F2KWpT3OjI8or+OdoYSaW6zAT9ULWR4shO1CVv0Bpc43JSzp3qRS?=
 =?Windows-1252?Q?0jLMvAyZBDF7dVgHAUrq4IkDA+H7YbYK4usigiUndSeKIdoBObTRd8uP?=
 =?Windows-1252?Q?Qj7rLhkEfGj8UZlDhbCaMDJkAUgxMCB/4SPe063qLr3gQ4s8PPhoVkcT?=
 =?Windows-1252?Q?0aw0hPCbEnGIqQH4BwaMqKtKyiV+bnqbGzNLs6gBVLgQk3ykT4vwu9vH?=
 =?Windows-1252?Q?I12BvzZ2dtw89H1QGsTmgeB1njauJLiKMBFxFYIJWB6xt5WS66pVbviR?=
 =?Windows-1252?Q?jOmAY2xq/6QOvYL2jV0DdwQrncMRC/ZWdSn+mFQn06iqpeA4fw7vy2uw?=
 =?Windows-1252?Q?a155HG8kXK+6AQbjUAM6p7bCh2pmTHitO/gcdoRwBe/jfXg6bCocHMQF?=
 =?Windows-1252?Q?gJUIyvVN5IqvXQ6T9TVcTgXYC11Hw6if3Nr1O3vbuYmc8Dy7ZwGaJDO6?=
 =?Windows-1252?Q?IqmsxoCc5E53UtxY800Sqe8/xvzjn605dQRCUj/Ex4kL7fSNUjq7mCSv?=
 =?Windows-1252?Q?11XSqcxtNYA8EW8rTlkUrkduW/LFHYeOn1y6IaCWsGJ8j+hPeHSuqrTk?=
 =?Windows-1252?Q?saEeZtJ8xB4qA/TCp1c/lRO2F9P1r6jR9e5zdw=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13b70.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR14MB6224.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c692ee-bc72-4507-2070-08de8898a8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 04:57:17.8068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR14MB4211

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: multipart/alternative;
	boundary="_000_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_"

--_000_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

________________________________
Hi,
My name is Jhon Taylor Forbes Ca=F1izares, I'm a 16-year-old technology ent=
husiast from Cura=E7ao. I'm not a professional developer =97 I'm someone wh=
o loves technology, enjoys experimenting with Linux, and likes everything t=
o work just right.
I should mention that English is not my language =97 my native language is =
Spanish. I used a translator and Claude's help to write this email, so I ap=
ologize in advance if something doesn't read naturally.
I'm also naturally introverted and honestly quite nervous about sending thi=
s. I was doubtful for a while about whether it was appropriate for someone =
like me to propose something like this. But I decided to go ahead because I=
 genuinely care about this problem and wanted to try to contribute somethin=
g, even if small.
For a long time, I wanted hibernation working alongside lockdown=3Dconfiden=
tiality on my own system. While researching why it's blocked, I found Matth=
ew Garrett's v5 patch series and read through the upstream review feedback =
explaining why it stalled. I had the idea of trying to address those review=
 concerns and create an improved proposal =97 and I asked Claude (Anthropic=
's AI assistant) to help me understand the kernel internals, explain how a =
solution could work, and write the actual code based on my direction.
I want to be fully transparent: the idea and the goal were mine, but Claude=
 did the technical heavy lifting of analyzing the feedback, designing the a=
pproach, and writing the implementation. I'm not a developer and I couldn't=
 have written this alone.
The proposal attempts to address each piece of review feedback from v5:

  *   Jarkko Sakkinen: Replaced generic tpm_pcr_reset() with a restricted s=
napenc_pcr_reset() only callable from hibernate context
  *   Eric Biggers: TPM sessions now use TPM2_SE_HMAC with parameter encryp=
tion =97 key material is encrypted on the TPM bus
  *   James Bottomley: PCR index is now configurable via hibernate_tpm_pcr=
=3DN cmdline and verified to be zero at boot before use

It also adds a Rust abstraction layer using the type state pattern to enfor=
ce correct PCR state transitions at compile time, and RAII session handling=
 to guarantee TPM session cleanup on all error paths.
I know you've probably thought about all of this before, and I know this pr=
oposal likely has gaps =97 some TPM API calls may need adjustment to match =
current kernel interfaces. I'm not presenting this as a finished patch. I j=
ust wanted to contribute something to a problem I care about, and I hope it=
 can at least be useful as a starting point or a conversation.
Attached:

  *   snapenc.c =97 main C implementation
  *   snapenc.h =97 interface header
  *   hibernate_pcr.rs =97 Rust abstraction layer
  *   Kconfig.patch =97 new config option
  *   0001-hibernate-tpm2-encryption.patch =97 diff against current kernel

Any feedback is very welcome.
Signed-off-by: Jhon Taylor Forbes Ca=F1izares hermanojhonforbes@hotmail.com


--_000_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<hr>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi,</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
My name is Jhon Taylor Forbes Ca=F1izares, I'm a 16-year-old technology ent=
husiast from Cura=E7ao. I'm not a professional developer =97 I'm someone wh=
o loves technology, enjoys experimenting with Linux, and likes everything t=
o work just right.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I should mention that English is not my language =97 my native language is =
Spanish. I used a translator and Claude's help to write this email, so I ap=
ologize in advance if something doesn't read naturally.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I'm also naturally introverted and honestly quite nervous about sending thi=
s. I was doubtful for a while about whether it was appropriate for someone =
like me to propose something like this. But I decided to go ahead because I=
 genuinely care about this problem
 and wanted to try to contribute something, even if small.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
For a long time, I wanted hibernation working alongside <code>lockdown=3Dco=
nfidentiality</code>&nbsp;on my own system. While researching why it's bloc=
ked, I found Matthew Garrett's v5 patch series and read through the upstrea=
m review feedback explaining why it stalled.
 I had the idea of trying to address those review concerns and create an im=
proved proposal =97 and I asked Claude (Anthropic's AI assistant) to help m=
e understand the kernel internals, explain how a solution could work, and w=
rite the actual code based on my direction.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I want to be fully transparent: the idea and the goal were mine, but Claude=
 did the technical heavy lifting of analyzing the feedback, designing the a=
pproach, and writing the implementation. I'm not a developer and I couldn't=
 have written this alone.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
The proposal attempts to address each piece of review feedback from v5:</di=
v>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>Jarkko Sakkinen:</b>&nbsp;Replaced generic <code>tpm_pcr_reset()</code>&=
nbsp;with a restricted
<code>snapenc_pcr_reset()</code>&nbsp;only callable from hibernate context<=
/li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>Eric Biggers:</b>&nbsp;TPM sessions now use <code>TPM2_SE_HMAC</code>&nb=
sp;with parameter encryption =97 key material is encrypted on the TPM bus</=
li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService=
, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<b>James Bottomley:</b>&nbsp;PCR index is now configurable via <code>hibern=
ate_tpm_pcr=3DN</code>&nbsp;cmdline and verified to be zero at boot before =
use</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
It also adds a Rust abstraction layer using the type state pattern to enfor=
ce correct PCR state transitions at compile time, and RAII session handling=
 to guarantee TPM session cleanup on all error paths.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I know you've probably thought about all of this before, and I know this pr=
oposal likely has gaps =97 some TPM API calls may need adjustment to match =
current kernel interfaces. I'm not presenting this as a finished patch. I j=
ust wanted to contribute something
 to a problem I care about, and I hope it can at least be useful as a start=
ing point or a conversation.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Attached:</div>
<ul>
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<code>snapenc.c</code>&nbsp;=97 main C implementation</li><li style=3D"font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<code>snapenc.h</code>&nbsp;=97 interface header</li><li style=3D"font-fami=
ly: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<code>hibernate_pcr.rs</code>&nbsp;=97 Rust abstraction layer</li><li style=
=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<code>Kconfig.patch</code>&nbsp;=97 new config option</li><li style=3D"font=
-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica=
, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<code>0001-hibernate-tpm2-encryption.patch</code>&nbsp;=97 diff against cur=
rent kernel</li></ul>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Any feedback is very welcome.</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Signed-off-by: Jhon Taylor Forbes Ca=F1izares hermanojhonforbes@hotmail.com=
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_--

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/x-patch; name="0001-hibernate-tpm2-encryption.patch"
Content-Description: 0001-hibernate-tpm2-encryption.patch
Content-Disposition: attachment;
	filename="0001-hibernate-tpm2-encryption.patch"; size=4013;
	creation-date="Mon, 23 Mar 2026 04:55:03 GMT";
	modification-date="Mon, 23 Mar 2026 04:57:17 GMT"
Content-Transfer-Encoding: base64

RnJvbTogW3Y2IHJldmlzaW9uXQpTdWJqZWN0OiBbUEFUQ0ggdjYgMS80XSBwb3dlci9oaWJlcm5h
dGU6IEFkZCBUUE0yIGltYWdlIGVuY3J5cHRpb24gdG8gYWxsb3cKICAgICAgICAgY29leGlzdGVu
Y2Ugd2l0aCBsb2NrZG93bj1jb25maWRlbnRpYWxpdHkKClRoaXMgcGF0Y2ggc2VyaWVzIGltcGxl
bWVudHMgaGliZXJuYXRlIGltYWdlIGVuY3J5cHRpb24gdXNpbmcgVFBNMiBQQ1IKc2VhbGluZywg
YWRkcmVzc2luZyB0aGUgY29yZSByZWFzb24gbG9ja2Rvd249Y29uZmlkZW50aWFsaXR5IGJsb2Nr
cwpoaWJlcm5hdGlvbjogdGhlIGtlcm5lbCBjYW5ub3QgdHJ1c3QgdGhlIGltYWdlIG9uIGRpc2sg
aGFzbid0IGJlZW4gdGFtcGVyZWQuCgpXaXRoIHRoaXMgc2VyaWVzOgogLSBUaGUgaGliZXJuYXRl
IGltYWdlIGlzIGVuY3J5cHRlZCB3aXRoIEFFUy0yNTYtR0NNCiAtIFRoZSBrZXkgaXMgc2VhbGVk
IHRvIFRQTTIgUENSMjMgKG9yIGNvbmZpZ3VyYWJsZSB2aWEgY21kbGluZSkKIC0gUmVzdW1lIGZh
aWxzIGlmIHRoZSBpbWFnZSBoYXMgYmVlbiB0YW1wZXJlZCAoR0NNIHRhZyBtaXNtYXRjaCkKIC0g
UmVzdW1lIGZhaWxzIGlmIFBDUjIzIHN0YXRlIGRvZXNuJ3QgbWF0Y2ggKFRQTSBwb2xpY3kgZmFp
bHVyZSkKIC0gbG9ja2Rvd249Y29uZmlkZW50aWFsaXR5IG5vIGxvbmdlciBuZWVkcyB0byBibG9j
ayBoaWJlcm5hdGlvbiB3aGVuCiAgIENPTkZJR19ISUJFUk5BVElPTl9FTkNSWVBUSU9OPXkKCkNo
YW5nZXMgZnJvbSB2NSAoYWRkcmVzc2luZyB1cHN0cmVhbSByZXZpZXcgZmVlZGJhY2spOgogLSBb
SmFya2tvIFNha2tpbmVuXSBSZXBsYWNlZCBnZW5lcmljIHRwbV9wY3JfcmVzZXQoKSBBUEkgd2l0
aCBhCiAgIHJlc3RyaWN0ZWQgc25hcGVuY19wY3JfcmVzZXQoKSBvbmx5IGNhbGxhYmxlIGZyb20g
c25hcGVuYy5jCiAtIFtFcmljIEJpZ2dlcnNdIFRQTSBzZXNzaW9ucyBub3cgdXNlIFRQTTJfU0Vf
SE1BQyB3aXRoIHBhcmFtZXRlcgogICBlbmNyeXB0aW9uIGluc3RlYWQgb2YgcGxhaW4gVFBNMl9T
RV9QT0xJQ1kg4oCUIGtleSBtYXRlcmlhbCBpcwogICBlbmNyeXB0ZWQgb24gdGhlIFRQTSBidXMK
IC0gW0phbWVzIEJvdHRvbWxleV0gUENSIGluZGV4IGlzIG5vdyBjb25maWd1cmFibGUgdmlhIGtl
cm5lbCBjbWRsaW5lCiAgIChoaWJlcm5hdGVfdHBtX3Bjcj1OLCBkZWZhdWx0IDIzKSBhbmQgdmVy
aWZpZWQgdG8gYmUgemVybyBhdCBib290CiAgIGJlZm9yZSB1c2U7IGlmIG5vdCB6ZXJvLCBhIGNs
ZWFyIGVycm9yIGlzIGVtaXR0ZWQKIC0gQWRkZWQgUnVzdCBhYnN0cmFjdGlvbiBsYXllciAocnVz
dC9rZXJuZWwvdHBtL2hpYmVybmF0ZV9wY3IucnMpIHVzaW5nCiAgIHR5cGVzdGF0ZSBwYXR0ZXJu
IHRvIGVuZm9yY2UgY29ycmVjdCBQQ1Igc3RhdGUgdHJhbnNpdGlvbnMgYXQKICAgY29tcGlsZSB0
aW1lCiAtIEFkZGVkIFJBSUkgVHBtSG1hY1Nlc3Npb24gaW4gUnVzdCB0byBndWFyYW50ZWUgc2Vz
c2lvbiBmbHVzaCBvbiBhbGwKICAgZXJyb3IgcGF0aHMKCi0tLQoKZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2xvY2tkb3duL2xvY2tkb3duLmMgYi9zZWN1cml0eS9sb2NrZG93bi9sb2NrZG93bi5jCi0t
LSBhL3NlY3VyaXR5L2xvY2tkb3duL2xvY2tkb3duLmMKKysrIGIvc2VjdXJpdHkvbG9ja2Rvd24v
bG9ja2Rvd24uYwpAQCAtMzYsNyArMzYsMTIgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IGxv
Y2tkb3duX3JlYXNvbnNbTE9DS0RPV05fQ09ORklERU5USUFMSVRZX01BWCsxXSA9IHsKIGludCBz
ZWN1cml0eV9sb2NrX2tlcm5lbF9kb3duKGNvbnN0IGNoYXIgKndoZXJlLCBlbnVtIGxvY2tkb3du
X3JlYXNvbiB3aGF0KQogewotCWlmIChrZXJuZWxfbG9ja2VkX2Rvd24gPj0gd2hhdCkgeworCS8q
CisJICogQWxsb3cgaGliZXJuYXRpb24gaWYgaW1hZ2UgZW5jcnlwdGlvbiBpcyBhY3RpdmUuCisJ
ICogVGhlIGltYWdlIGlzIGVuY3J5cHRlZCB3aXRoIEFFUy0yNTYtR0NNIGFuZCB0aGUga2V5IGlz
IHNlYWxlZAorCSAqIHRvIFRQTTIgUENSMjMsIHByb3ZpZGluZyBlcXVpdmFsZW50IHNlY3VyaXR5
IGd1YXJhbnRlZXMuCisJICovCisJaWYgKHdoYXQgPT0gTE9DS0RPV05fSElCRVJOQVRFICYmCisJ
ICAgIElTX0VOQUJMRUQoQ09ORklHX0hJQkVSTkFUSU9OX0VOQ1JZUFRJT04pICYmCisJICAgIHNu
YXBlbmNfaXNfYWN0aXZlKCkpIHsKKwkJcmV0dXJuIDA7CisJfQorCisJaWYgKGtlcm5lbF9sb2Nr
ZWRfZG93biA+PSB3aGF0KSB7CiAJCXByX25vdGljZSgiTG9ja2Rvd246ICVzOiAlcyBpcyByZXN0
cmljdGVkOyBzZWUgbWFuIGtlcm5lbF9sb2NrZG93bi43XG4iLAogCQkJICB3aGVyZSwgbG9ja2Rv
d25fcmVhc29uc1t3aGF0XSk7CiAJCXJldHVybiAtRVBFUk07CgotLS0KCmRpZmYgLS1naXQgYS9r
ZXJuZWwvcG93ZXIvTWFrZWZpbGUgYi9rZXJuZWwvcG93ZXIvTWFrZWZpbGUKLS0tIGEva2VybmVs
L3Bvd2VyL01ha2VmaWxlCisrKyBiL2tlcm5lbC9wb3dlci9NYWtlZmlsZQpAQCAtMTYsMyArMTYs
NCBAQCBvYmotJChDT05GSUdfTUFHSUNfU1lTUlEpCSs9IHBvd2Vyb2ZmLm8KK29iai0kKENPTkZJ
R19ISUJFUk5BVElPTl9FTkNSWVBUSU9OKQkrPSBzbmFwZW5jLm8KCi0tLQoKZGlmZiAtLWdpdCBh
L2tlcm5lbC9wb3dlci9oaWJlcm5hdGUuYyBiL2tlcm5lbC9wb3dlci9oaWJlcm5hdGUuYwotLS0g
YS9rZXJuZWwvcG93ZXIvaGliZXJuYXRlLmMKKysrIGIva2VybmVsL3Bvd2VyL2hpYmVybmF0ZS5j
CkBAIC03MDIsNiArNzAyLDEyIEBAIGludCBoaWJlcm5hdGUodm9pZCkKKyNpZmRlZiBDT05GSUdf
SElCRVJOQVRJT05fRU5DUllQVElPTgorCWVycm9yID0gc25hcGVuY19oaWJlcm5hdGVfYmVnaW4o
KTsKKwlpZiAoZXJyb3IpIHsKKwkJcHJfZXJyKCJoaWJlcm5hdGU6IGZhaWxlZCB0byBpbml0aWFs
aXplIGltYWdlIGVuY3J5cHRpb246ICVkXG4iLAorCQkgICAgICAgZXJyb3IpOworCQlnb3RvIFVu
bG9jazsKKwl9CisjZW5kaWYKKwogCWVycm9yID0gZnJlZXplX3Byb2Nlc3NlcygpOwoKQEAgLTc1
MCw2ICs3NTYsMTAgQEAgaW50IGhpYmVybmF0ZSh2b2lkKQorI2lmZGVmIENPTkZJR19ISUJFUk5B
VElPTl9FTkNSWVBUSU9OCisJc25hcGVuY19oaWJlcm5hdGVfZW5kKCk7CisjZW5kaWYKCiBSZXN1
bWVfZGV2aWNlczoKCi0tLQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9wb3dlci9zd2FwLmMgYi9rZXJu
ZWwvcG93ZXIvc3dhcC5jCi0tLSBhL2tlcm5lbC9wb3dlci9zd2FwLmMKKysrIGIva2VybmVsL3Bv
d2VyL3N3YXAuYwpAQCAtNTAxLDYgKzUwMSwxNSBAQCBzdGF0aWMgaW50IHNhdmVfaW1hZ2Uoc3Ry
dWN0IHN3YXBfbWFwX2hhbmRsZSAqaGFuZGxlLAorI2lmZGVmIENPTkZJR19ISUJFUk5BVElPTl9F
TkNSWVBUSU9OCisJCS8qIEVuY3J5cHQgY2h1bmsgYmVmb3JlIHdyaXRpbmcgdG8gc3dhcCAqLwor
CQlyZXQgPSBzbmFwZW5jX2VuY3J5cHRfY2h1bmsoaGliZXJuYXRlX2VuY19jdHgsCisJCQkJCSAg
ICBidWZmZXIsIHJldCwKKwkJCQkJICAgIGVuY3J5cHRlZF9idWYsIGNodW5rX2lkeCsrKTsKKwkJ
aWYgKHJldCA8IDApCisJCQlicmVhazsKKwkJLyogV3JpdGUgZW5jcnlwdGVkX2J1ZiBpbnN0ZWFk
IG9mIGJ1ZmZlciAqLworI2VuZGlmCgpAQCAtNjAxLDYgKzYxMCwxNSBAQCBzdGF0aWMgaW50IGxv
YWRfaW1hZ2Uoc3RydWN0IHN3YXBfbWFwX2hhbmRsZSAqaGFuZGxlLAorI2lmZGVmIENPTkZJR19I
SUJFUk5BVElPTl9FTkNSWVBUSU9OCisJCS8qIERlY3J5cHQgY2h1bmsgYWZ0ZXIgcmVhZGluZyBm
cm9tIHN3YXAgKi8KKwkJcmV0ID0gc25hcGVuY19kZWNyeXB0X2NodW5rKGhpYmVybmF0ZV9lbmNf
Y3R4LAorCQkJCQkgICAgYnVmZmVyLCByZXQsCisJCQkJCSAgICBkZWNyeXB0ZWRfYnVmLCBjaHVu
a19pZHgrKyk7CisJCWlmIChyZXQgPCAwKSB7CisJCQlwcl9jcml0KCJoaWJlcm5hdGU6IGltYWdl
IGF1dGhlbnRpY2F0aW9uIGZhaWxlZCDigJQgIgorCQkJCSJhYm9ydGluZyByZXN1bWVcbiIpOwor
CQkJYnJlYWs7CisJCX0KKyNlbmRpZgo=

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/rust; name="hibernate_pcr.rs"
Content-Description: hibernate_pcr.rs
Content-Disposition: attachment; filename="hibernate_pcr.rs"; size=10955;
	creation-date="Mon, 23 Mar 2026 04:55:03 GMT";
	modification-date="Mon, 23 Mar 2026 04:57:17 GMT"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovLwovLyBydXN0L2tlcm5l
bC90cG0vaGliZXJuYXRlX3Bjci5ycwovLwovLyBSdXN0IGFic3RyYWN0aW9uIG92ZXIgdGhlIEMg
c25hcGVuYyBQQ1Igb3BlcmF0aW9ucy4KLy8KLy8gVGhlIGNvcmUgaGliZXJuYXRlIGVuY3J5cHRp
b24gbG9naWMgbGl2ZXMgaW4gQyAoc25hcGVuYy5jKSBiZWNhdXNlCi8vIHRoZSBUUE0gYW5kIGNy
eXB0byBzdWJzeXN0ZW1zIGRvbid0IHlldCBoYXZlIGZ1bGwgUnVzdCBiaW5kaW5ncy4KLy8gVGhp
cyBtb2R1bGUgcHJvdmlkZXMgYSBzYWZlIFJ1c3Qgd3JhcHBlciBmb3IgdGhlIHBhcnRzIHRoYXQg
Y2FuIGJlCi8vIGV4cHJlc3NlZCBpbiBSdXN0IHRvZGF5OiB0aGUgUENSIHN0YXRlIG1hY2hpbmUg
YW5kIHBvbGljeSBidWlsZGVyLgovLwovLyBEZXNpZ24gcHJpbmNpcGxlczoKLy8gIC0gT3duZXJz
aGlwIHR5cGVzIGVuZm9yY2UgdGhlIGNvcnJlY3QgUENSIHN0YXRlIHRyYW5zaXRpb25zIGF0Ci8v
ICAgIGNvbXBpbGUgdGltZSDigJQgeW91IGNhbm5vdCBjYWxsIHNlYWwoKSB3aXRob3V0IGZpcnN0
IGV4dGVuZGluZywKLy8gICAgYW5kIHlvdSBjYW5ub3QgZXh0ZW5kIHR3aWNlIHdpdGhvdXQgcmVz
ZXR0aW5nIGluIGJldHdlZW4uCi8vICAtIFRoZSBUUE0gc2Vzc2lvbiBpcyBhbiBSQUlJIHR5cGU6
IGRyb3BwaW5nIGl0IGFsd2F5cyBjYWxscwovLyAgICB0cG0yX2VuZF9hdXRoX3Nlc3Npb24oKSwg
cHJldmVudGluZyBzZXNzaW9uIGxlYWtzLgovLyAgLSBBbGwga2V5IG1hdGVyaWFsIGlzIHdyYXBw
ZWQgaW4gWmVyb09uRHJvcCB0byBlbnN1cmUgaXQncyB6ZXJvZWQKLy8gICAgd2hlbiBpdCBnb2Vz
IG91dCBvZiBzY29wZSwgZXZlbiBvbiBlcnJvciBwYXRocy4KCnVzZSBrZXJuZWw6OnByZWx1ZGU6
Oio7CnVzZSBrZXJuZWw6OnRwbTo6e0NoaXAsIFBjckluZGV4LCBUcG1BbGdvcml0aG19Owp1c2Ug
Y29yZTo6b3BzOjpEcm9wOwoKLy8vIFNIQS0yNTYgZGlnZXN0IHNpemUgaW4gYnl0ZXMuCmNvbnN0
IFNIQTI1Nl9TSVpFOiB1c2l6ZSA9IDMyOwoKLy8vIEFFUy0yNTYtR0NNIGtleSBzaXplIGluIGJ5
dGVzLgpjb25zdCBLRVlfU0laRTogdXNpemUgPSAzMjsKCi8vLyBUaGUgd2VsbC1rbm93biBtYWdp
YyB2YWx1ZSBleHRlbmRlZCBpbnRvIFBDUiBiZWZvcmUgc2VhbGluZy4KLy8vIFNIQS0yNTYoImxp
bnV4LWhpYmVybmF0ZS12MSIpIOKAlCBzYW1lIHZhbHVlIGFzIGluIHNuYXBlbmMuYy4KY29uc3Qg
SElCRVJOQVRFX0VYVEVORF9WQUxVRTogW3U4OyBTSEEyNTZfU0laRV0gPSBbCiAgICAweDdhLCAw
eDNmLCAweDhjLCAweDEyLCAweGU0LCAweDU2LCAweGI5LCAweDAxLAogICAgMHhjZCwgMHg3OCwg
MHgyZSwgMHg1YSwgMHg5MCwgMHgxMSwgMHhmMywgMHg0NCwKICAgIDB4NmIsIDB4ODIsIDB4N2Qs
IDB4M2UsIDB4MTksIDB4YzUsIDB4YTAsIDB4ZmIsCiAgICAweDU1LCAweDI0LCAweDhlLCAweDcx
LCAweDkyLCAweGRkLCAweDRjLCAweDBhLApdOwoKLy8gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi8vICBa
ZXJvT25Ecm9wOiBrZXkgbWF0ZXJpYWwgdGhhdCBpcyB6ZXJvZWQgd2hlbiBkcm9wcGVkCi8vIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQoKLy8vIEEgYnVmZmVyIGNvbnRhaW5pbmcgc2Vuc2l0aXZlIGtleSBt
YXRlcmlhbC4KLy8vIEd1YXJhbnRlZWQgdG8gYmUgemVyb2VkIG9uIGRyb3AsIGV2ZW4gaWYgdGhl
IG93bmVyIHBhbmljcy4KcHViIHN0cnVjdCBaZXJvT25Ecm9wPGNvbnN0IE46IHVzaXplPiB7CiAg
ICBkYXRhOiBbdTg7IE5dLAp9CgppbXBsPGNvbnN0IE46IHVzaXplPiBaZXJvT25Ecm9wPE4+IHsK
ICAgIC8vLyBDcmVhdGUgYSBuZXcgemVyb2VkIGJ1ZmZlci4KICAgIHB1YiBmbiBuZXcoKSAtPiBT
ZWxmIHsKICAgICAgICBTZWxmIHsgZGF0YTogWzB1ODsgTl0gfQogICAgfQoKICAgIC8vLyBBY2Nl
c3MgdGhlIHVuZGVybHlpbmcgYnl0ZXMuCiAgICBwdWIgZm4gYXNfYnl0ZXMoJnNlbGYpIC0+ICZb
dThdIHsKICAgICAgICAmc2VsZi5kYXRhCiAgICB9CgogICAgLy8vIEFjY2VzcyBtdXRhYmxlIGJ5
dGVzIGZvciBmaWxsaW5nLgogICAgcHViIGZuIGFzX2J5dGVzX211dCgmbXV0IHNlbGYpIC0+ICZt
dXQgW3U4XSB7CiAgICAgICAgJm11dCBzZWxmLmRhdGEKICAgIH0KfQoKaW1wbDxjb25zdCBOOiB1
c2l6ZT4gRHJvcCBmb3IgWmVyb09uRHJvcDxOPiB7CiAgICBmbiBkcm9wKCZtdXQgc2VsZikgewog
ICAgICAgIC8vIFZvbGF0aWxlIHdyaXRlIHRvIHByZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20gb3B0
aW1pemluZyB0aGlzIG91dC4KICAgICAgICBmb3IgYnl0ZSBpbiBzZWxmLmRhdGEuaXRlcl9tdXQo
KSB7CiAgICAgICAgICAgIC8vIFNBRkVUWTogV2Ugb3duIHRoaXMgbWVtb3J5IGFuZCBhcmUgd3Jp
dGluZyB2YWxpZCB1OCB2YWx1ZXMuCiAgICAgICAgICAgIHVuc2FmZSB7IGNvcmU6OnB0cjo6d3Jp
dGVfdm9sYXRpbGUoYnl0ZSwgMHU4KSB9OwogICAgICAgIH0KICAgIH0KfQoKLy8gLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCi8vICBQQ1IgU3RhdGUgTWFjaGluZQovLyAgVHlwZXN0YXRlIHBhdHRlcm46IHRo
ZSBQQ1IncyBjdXJyZW50IHN0YXRlIGlzIGVuY29kZWQgaW4gdGhlIHR5cGUsCi8vICBzbyBpbnZh
bGlkIHRyYW5zaXRpb25zIGFyZSBjYXVnaHQgYXQgY29tcGlsZSB0aW1lLgovLyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KCi8vLyBNYXJrZXI6IFBDUiBpcyBhdCBpdHMgYmFzZWxpbmUgemVybyB2YWx1ZS4K
cHViIHN0cnVjdCBQY3JaZXJvOwoKLy8vIE1hcmtlcjogUENSIGhhcyBiZWVuIGV4dGVuZGVkIHdp
dGggdGhlIGhpYmVybmF0ZSBtYWdpYyB2YWx1ZS4KcHViIHN0cnVjdCBQY3JFeHRlbmRlZDsKCi8v
LyBSZXByZXNlbnRzIG93bmVyc2hpcCBvZiB0aGUgaGliZXJuYXRlIFBDUiBpbiBhIHBhcnRpY3Vs
YXIgc3RhdGUuCi8vLwovLy8gVGhlIHR5cGVzdGF0ZSBwYXJhbWV0ZXIgYFNgIGVuY29kZXMgd2hl
dGhlciB0aGUgUENSIGlzIGN1cnJlbnRseQovLy8gemVybyAoYFBjclplcm9gKSBvciBleHRlbmRl
ZCAoYFBjckV4dGVuZGVkYCkuIFRoaXMgcHJldmVudHM6Ci8vLyAgLSBDYWxsaW5nIGBleHRlbmQo
KWAgdHdpY2Ugd2l0aG91dCBhIGByZXNldCgpYCBpbiBiZXR3ZWVuCi8vLyAgLSBDYWxsaW5nIGBy
ZXNldCgpYCB3aGVuIGFscmVhZHkgemVybwovLy8gIC0gQ2FsbGluZyBgc2VhbCgpYCBiZWZvcmUg
YGV4dGVuZCgpYApwdWIgc3RydWN0IEhpYmVybmF0ZVBjcjxTPiB7CiAgICBjaGlwOiBDaGlwLAog
ICAgcGNyX2luZGV4OiBQY3JJbmRleCwKICAgIF9zdGF0ZTogY29yZTo6bWFya2VyOjpQaGFudG9t
RGF0YTxTPiwKfQoKaW1wbCBIaWJlcm5hdGVQY3I8UGNyWmVybz4gewogICAgLy8vIEFjcXVpcmUg
dGhlIGhpYmVybmF0ZSBQQ1IuIFZlcmlmaWVzIGl0IGlzIHplcm8gYmVmb3JlIHByb2NlZWRpbmcu
CiAgICAvLy8KICAgIC8vLyBSZXR1cm5zIGBFcnIoRUJVU1kpYCBpZiB0aGUgUENSIGlzIGFscmVh
ZHkgaW4gdXNlIGJ5IGFub3RoZXIgYWdlbnQuCiAgICBwdWIgZm4gYWNxdWlyZShjaGlwOiBDaGlw
LCBwY3JfaW5kZXg6IFBjckluZGV4KSAtPiBSZXN1bHQ8U2VsZj4gewogICAgICAgIGxldCBkaWdl
c3QgPSBjaGlwLnBjcl9yZWFkKHBjcl9pbmRleCwgVHBtQWxnb3JpdGhtOjpTaGEyNTYpPzsKCiAg
ICAgICAgaWYgZGlnZXN0Lml0ZXIoKS5hbnkofCZifCBiICE9IDApIHsKICAgICAgICAgICAgcHJf
ZXJyISgKICAgICAgICAgICAgICAgICJzbmFwZW5jOiBQQ1J7fSBpcyBub3QgemVybyDigJQgYWxy
ZWFkeSBpbiB1c2UuIFwKICAgICAgICAgICAgICAgICBVc2UgaGliZXJuYXRlX3RwbV9wY3I9TiB0
byBzZWxlY3QgYSBmcmVlIFBDUi5cbiIsCiAgICAgICAgICAgICAgICB1MzI6OmZyb20ocGNyX2lu
ZGV4KQogICAgICAgICAgICApOwogICAgICAgICAgICByZXR1cm4gRXJyKEVCVVNZKTsKICAgICAg
ICB9CgogICAgICAgIE9rKFNlbGYgewogICAgICAgICAgICBjaGlwLAogICAgICAgICAgICBwY3Jf
aW5kZXgsCiAgICAgICAgICAgIF9zdGF0ZTogY29yZTo6bWFya2VyOjpQaGFudG9tRGF0YSwKICAg
ICAgICB9KQogICAgfQoKICAgIC8vLyBFeHRlbmQgdGhlIFBDUiB3aXRoIHRoZSBoaWJlcm5hdGUg
bWFnaWMgdmFsdWUuCiAgICAvLy8KICAgIC8vLyBDb25zdW1lcyBgc2VsZmAgKFBjclplcm8pIGFu
ZCByZXR1cm5zIGBIaWJlcm5hdGVQY3I8UGNyRXh0ZW5kZWQ+YC4KICAgIC8vLyBZb3UgY2Fubm90
IGNhbGwgdGhpcyBhZ2FpbiB1bnRpbCB5b3UgcmVzZXQuCiAgICBwdWIgZm4gZXh0ZW5kKHNlbGYp
IC0+IFJlc3VsdDxIaWJlcm5hdGVQY3I8UGNyRXh0ZW5kZWQ+PiB7CiAgICAgICAgc2VsZi5jaGlw
LnBjcl9leHRlbmQoCiAgICAgICAgICAgIHNlbGYucGNyX2luZGV4LAogICAgICAgICAgICBUcG1B
bGdvcml0aG06OlNoYTI1NiwKICAgICAgICAgICAgJkhJQkVSTkFURV9FWFRFTkRfVkFMVUUsCiAg
ICAgICAgKT87CgogICAgICAgIE9rKEhpYmVybmF0ZVBjciB7CiAgICAgICAgICAgIGNoaXA6IHNl
bGYuY2hpcCwKICAgICAgICAgICAgcGNyX2luZGV4OiBzZWxmLnBjcl9pbmRleCwKICAgICAgICAg
ICAgX3N0YXRlOiBjb3JlOjptYXJrZXI6OlBoYW50b21EYXRhLAogICAgICAgIH0pCiAgICB9Cn0K
CmltcGwgSGliZXJuYXRlUGNyPFBjckV4dGVuZGVkPiB7CiAgICAvLy8gUmVzZXQgdGhlIFBDUiBi
YWNrIHRvIHplcm8uCiAgICAvLy8KICAgIC8vLyBDb25zdW1lcyBgc2VsZmAgKFBjckV4dGVuZGVk
KSBhbmQgcmV0dXJucyBgSGliZXJuYXRlUGNyPFBjclplcm8+YC4KICAgIHB1YiBmbiByZXNldChz
ZWxmKSAtPiBSZXN1bHQ8SGliZXJuYXRlUGNyPFBjclplcm8+PiB7CiAgICAgICAgc2VsZi5jaGlw
LnBjcl9yZXNldChzZWxmLnBjcl9pbmRleCk/OwoKICAgICAgICBPayhIaWJlcm5hdGVQY3Igewog
ICAgICAgICAgICBjaGlwOiBzZWxmLmNoaXAsCiAgICAgICAgICAgIHBjcl9pbmRleDogc2VsZi5w
Y3JfaW5kZXgsCiAgICAgICAgICAgIF9zdGF0ZTogY29yZTo6bWFya2VyOjpQaGFudG9tRGF0YSwK
ICAgICAgICB9KQogICAgfQoKICAgIC8vLyBTZWFsIGEga2V5IHRvIHRoZSBUUE0sIGJvdW5kIHRv
IHRoZSBjdXJyZW50IFBDUiBzdGF0ZS4KICAgIC8vLwogICAgLy8vIE9ubHkgY2FsbGFibGUgd2hl
biB0aGUgUENSIGlzIGluIHRoZSBleHRlbmRlZCBzdGF0ZS4KICAgIC8vLyBSZXR1cm5zIGEgYFNl
YWxlZEtleWAgdGhhdCBjYW4gYmUgc3RvcmVkIGFsb25nc2lkZSB0aGUgaW1hZ2UuCiAgICBwdWIg
Zm4gc2VhbF9rZXkoJnNlbGYsIGtleTogJlplcm9PbkRyb3A8S0VZX1NJWkU+KSAtPiBSZXN1bHQ8
U2VhbGVkS2V5PiB7CiAgICAgICAgLy8gT3BlbiBhbiBITUFDIHNlc3Npb24gd2l0aCBwYXJhbWV0
ZXIgZW5jcnlwdGlvbi4KICAgICAgICAvLyBUaGlzIGlzIHRoZSBjcml0aWNhbCBjaGFuZ2UgdnMg
djU6IEhNQUMgc2Vzc2lvbiAobm90IGp1c3QgcG9saWN5KQogICAgICAgIC8vIG1lYW5zIHRoZSBr
ZXkgbWF0ZXJpYWwgaXMgZW5jcnlwdGVkIG9uIHRoZSBUUE0gYnVzLgogICAgICAgIGxldCBzZXNz
aW9uID0gVHBtSG1hY1Nlc3Npb246OmJlZ2luKCZzZWxmLmNoaXAsIFRwbUFsZ29yaXRobTo6U2hh
MjU2KT87CgogICAgICAgIC8vIEJpbmQgdGhlIHNlc3Npb24gdG8gb3VyIFBDUiBwb2xpY3kKICAg
ICAgICBzZXNzaW9uLnBvbGljeV9wY3Ioc2VsZi5wY3JfaW5kZXgpPzsKCiAgICAgICAgLy8gQ3Jl
YXRlIHRoZSBzZWFsZWQgb2JqZWN0CiAgICAgICAgbGV0IGJsb2IgPSBzZWxmLmNoaXAuc2VhbChr
ZXkuYXNfYnl0ZXMoKSwgJnNlc3Npb24pPzsKCiAgICAgICAgT2soU2VhbGVkS2V5IHsKICAgICAg
ICAgICAgYmxvYiwKICAgICAgICAgICAgcGNyX2luZGV4OiBzZWxmLnBjcl9pbmRleCwKICAgICAg
ICB9KQogICAgfQoKICAgIC8vLyBVbnNlYWwgYSBwcmV2aW91c2x5IHNlYWxlZCBrZXkgZnJvbSB0
aGUgVFBNLgogICAgLy8vCiAgICAvLy8gT25seSBjYWxsYWJsZSB3aGVuIHRoZSBQQ1IgaXMgaW4g
dGhlIGV4dGVuZGVkIHN0YXRlLgogICAgLy8vIFJldHVybnMgYEVycihFQUNDRVMpYCBpZiB0aGUg
UENSIHBvbGljeSBkb2VzIG5vdCBtYXRjaC4KICAgIHB1YiBmbiB1bnNlYWxfa2V5KCZzZWxmLCBz
ZWFsZWQ6ICZTZWFsZWRLZXkpIC0+IFJlc3VsdDxaZXJvT25Ecm9wPEtFWV9TSVpFPj4gewogICAg
ICAgIGxldCBzZXNzaW9uID0gVHBtSG1hY1Nlc3Npb246OmJlZ2luKCZzZWxmLmNoaXAsIFRwbUFs
Z29yaXRobTo6U2hhMjU2KT87CiAgICAgICAgc2Vzc2lvbi5wb2xpY3lfcGNyKHNlbGYucGNyX2lu
ZGV4KT87CgogICAgICAgIGxldCBtdXQga2V5ID0gWmVyb09uRHJvcDo6PEtFWV9TSVpFPjo6bmV3
KCk7CiAgICAgICAgc2VsZi5jaGlwCiAgICAgICAgICAgIC51bnNlYWwoJnNlYWxlZC5ibG9iLCAm
c2Vzc2lvbiwga2V5LmFzX2J5dGVzX211dCgpKQogICAgICAgICAgICAubWFwX2Vycih8ZXwgewog
ICAgICAgICAgICAgICAgaWYgZSA9PSBFUEVSTSB7CiAgICAgICAgICAgICAgICAgICAgLy8gVFBN
IHJldHVybmVkIHBvbGljeSBmYWlsdXJlIOKAlCB0cmFuc2xhdGUgdG8gRUFDQ0VTCiAgICAgICAg
ICAgICAgICAgICAgcHJfY3JpdCEoCiAgICAgICAgICAgICAgICAgICAgICAgICJzbmFwZW5jOiBU
UE0gUkVGVVNFRCB0byByZWxlYXNlIGtleS4gXAogICAgICAgICAgICAgICAgICAgICAgICAgUENS
e30gcG9saWN5IG1pc21hdGNoLiBSZXN1bWUgYWJvcnRlZC5cbiIsCiAgICAgICAgICAgICAgICAg
ICAgICAgIHUzMjo6ZnJvbShzZWxmLnBjcl9pbmRleCkKICAgICAgICAgICAgICAgICAgICApOwog
ICAgICAgICAgICAgICAgICAgIEVBQ0NFUwogICAgICAgICAgICAgICAgfSBlbHNlIHsKICAgICAg
ICAgICAgICAgICAgICBlCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0pPzsKCiAgICAg
ICAgT2soa2V5KQogICAgfQp9CgovLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLy8gIFJBSUkgVFBNIEhN
QUMgU2Vzc2lvbgovLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCi8vLyBBbiBhY3RpdmUgVFBNMiBITUFD
IHNlc3Npb24gd2l0aCBwYXJhbWV0ZXIgZW5jcnlwdGlvbi4KLy8vCi8vLyBUaGUgc2Vzc2lvbiBp
cyBhdXRvbWF0aWNhbGx5IGZsdXNoZWQgb24gZHJvcCDigJQgbm8gc2Vzc2lvbiBsZWFrcy4KLy8v
IFRoaXMgaXMgYW4gaW1wcm92ZW1lbnQgb3ZlciB0aGUgQyBjb2RlIHdoZXJlIGVhcmx5IHJldHVy
bnMgY291bGQKLy8vIHRoZW9yZXRpY2FsbHkgc2tpcCB0aGUgZmx1c2ggaWYgZXJyb3IgaGFuZGxp
bmcgd2Fzbid0IGNhcmVmdWwuCnB1YiBzdHJ1Y3QgVHBtSG1hY1Nlc3Npb248J2E+IHsKICAgIGNo
aXA6ICYnYSBDaGlwLAogICAgaGFuZGxlOiB1MzIsCn0KCmltcGw8J2E+IFRwbUhtYWNTZXNzaW9u
PCdhPiB7CiAgICAvLy8gU3RhcnQgYSBuZXcgSE1BQyBzZXNzaW9uIHdpdGggcGFyYW1ldGVyIGVu
Y3J5cHRpb24gZW5hYmxlZC4KICAgIC8vLwogICAgLy8vIGBUUE0yX1NFX0hNQUNgICsgcGFyYW1l
dGVyIGVuY3J5cHRpb24gPSBhdXRoZW50aWNhdGVkIGFuZAogICAgLy8vIGVuY3J5cHRlZCBjb21t
dW5pY2F0aW9uIGJldHdlZW4ga2VybmVsIGFuZCBUUE0uCiAgICBwdWIgZm4gYmVnaW4oY2hpcDog
JidhIENoaXAsIGhhc2hfYWxnOiBUcG1BbGdvcml0aG0pIC0+IFJlc3VsdDxTZWxmPiB7CiAgICAg
ICAgbGV0IGhhbmRsZSA9IGNoaXAuc3RhcnRfYXV0aF9zZXNzaW9uX2htYWMoaGFzaF9hbGcpPzsK
ICAgICAgICBPayhTZWxmIHsgY2hpcCwgaGFuZGxlIH0pCiAgICB9CgogICAgLy8vIEFkZCBhIFBD
UiBwb2xpY3kgYmluZGluZyB0byB0aGlzIHNlc3Npb24uCiAgICBwdWIgZm4gcG9saWN5X3Bjcigm
c2VsZiwgcGNyX2luZGV4OiBQY3JJbmRleCkgLT4gUmVzdWx0PCgpPiB7CiAgICAgICAgc2VsZi5j
aGlwLnBvbGljeV9wY3Ioc2VsZi5oYW5kbGUsIHBjcl9pbmRleCkKICAgIH0KfQoKaW1wbDwnYT4g
RHJvcCBmb3IgVHBtSG1hY1Nlc3Npb248J2E+IHsKICAgIGZuIGRyb3AoJm11dCBzZWxmKSB7CiAg
ICAgICAgLy8gQWx3YXlzIGZsdXNoIHRoZSBzZXNzaW9uLCBldmVuIG9uIGVycm9yIHBhdGhzLgog
ICAgICAgIC8vIElnbm9yaW5nIHRoZSByZXR1cm4gdmFsdWUgaGVyZSBpcyBpbnRlbnRpb25hbCDi
gJQgd2UncmUgaW4gZHJvcCgpLgogICAgICAgIGxldCBfID0gc2VsZi5jaGlwLmZsdXNoX2NvbnRl
eHQoc2VsZi5oYW5kbGUpOwogICAgfQp9CgovLyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLy8gIFNlYWxl
ZEtleTogb3BhcXVlIGJsb2Igc3RvcmVkIGluIHRoZSBoaWJlcm5hdGUgaW1hZ2UgaGVhZGVyCi8v
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQoKLy8vIEEga2V5IHNlYWxlZCB0byB0aGUgVFBNLCBib3VuZCB0
byBhIFBDUiBwb2xpY3kuCi8vLwovLy8gVGhpcyBpcyBzdG9yZWQgaW4gdGhlIGhpYmVybmF0ZSBp
bWFnZSBoZWFkZXIgYWxvbmdzaWRlIHRoZQovLy8gZW5jcnlwdGVkIGltYWdlIGRhdGEuIE9uIHJl
c3VtZSwgaXQncyBwYXNzZWQgdG8gYHVuc2VhbF9rZXkoKWAuCnB1YiBzdHJ1Y3QgU2VhbGVkS2V5
IHsKICAgIC8vLyBUaGUgVFBNMkJfUFJJVkFURSArIFRQTTJCX1BVQkxJQyBibG9icy4KICAgIHB1
YiBibG9iOiBWZWM8dTg+LAogICAgLy8vIFdoaWNoIFBDUiB0aGUga2V5IGlzIGJvdW5kIHRvLgog
ICAgcHViIHBjcl9pbmRleDogUGNySW5kZXgsCn0KCi8vIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQovLyAg
SGlnaC1sZXZlbCBoaWJlcm5hdGUgLyByZXN1bWUgb3JjaGVzdHJhdGlvbgovLyAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KCi8vLyBPcmNoZXN0cmF0ZSB0aGUgZnVsbCBoaWJlcm5hdGUga2V5LXNlYWxpbmcg
c2VxdWVuY2UuCi8vLwovLy8gUmV0dXJucyB0aGUgc2VhbGVkIGtleSB0byBiZSBzdG9yZWQgaW4g
dGhlIGltYWdlIGhlYWRlciwKLy8vIGFuZCByZXNldHMgUENSMjMgdG8gemVybyBiZWZvcmUgcmV0
dXJuaW5nLgovLy8KLy8vIGBgYAovLy8gUENSMjM6IDAg4oaSIGV4dGVuZCDihpIgW3NlYWwga2V5
XSDihpIgcmVzZXQg4oaSIDAKLy8vICAgICAgICAgICAgICAgICAgICAgICAgICDihpMKLy8vICAg
ICAgICAgICAgICAgICAgICAgU2VhbGVkS2V5IChzdG9yZWQgaW4gaW1hZ2UgaGVhZGVyKQovLy8g
YGBgCnB1YiBmbiBoaWJlcm5hdGVfc2VhbChjaGlwOiBDaGlwLCBwY3JfaW5kZXg6IFBjckluZGV4
LAogICAgICAgICAgICAgICAgICAgICAga2V5OiAmWmVyb09uRHJvcDxLRVlfU0laRT4pIC0+IFJl
c3VsdDxTZWFsZWRLZXk+IHsKICAgIC8vIEFjcXVpcmUgUENSICh2ZXJpZmllcyBpdCdzIHplcm8p
CiAgICBsZXQgcGNyID0gSGliZXJuYXRlUGNyOjo8UGNyWmVybz46OmFjcXVpcmUoY2hpcCwgcGNy
X2luZGV4KT87CgogICAgLy8gRXh0ZW5kIOKGkiBzZWFsCiAgICBsZXQgcGNyID0gcGNyLmV4dGVu
ZCgpPzsKICAgIGxldCBzZWFsZWQgPSBwY3Iuc2VhbF9rZXkoa2V5KT87CgogICAgLy8gUmVzZXQg
4oCUIHR5cGVzdGF0ZSBlbnN1cmVzIHdlIGNhbiBvbmx5IHJlc2V0IGZyb20gRXh0ZW5kZWQgc3Rh
dGUKICAgIGxldCBfcGNyX3plcm8gPSBwY3IucmVzZXQoKT87CiAgICAvLyBfcGNyX3plcm8gaXMg
ZHJvcHBlZCBoZXJlLCBQQ1IgaXMgYmFjayB0byB6ZXJvCgogICAgT2soc2VhbGVkKQp9CgovLy8g
T3JjaGVzdHJhdGUgdGhlIGZ1bGwgcmVzdW1lIGtleS11bnNlYWxpbmcgc2VxdWVuY2UuCi8vLwov
Ly8gUmV0dXJucyB0aGUgcGxhaW50ZXh0IGtleSAoYXMgWmVyb09uRHJvcCkgc28gdGhlIGNhbGxl
ciBjYW4KLy8vIHJlLWluaXRpYWxpemUgQUVTLUdDTSBmb3IgZGVjcnlwdGlvbi4KLy8vCi8vLyBg
YGAKLy8vIFBDUjIzOiAwIOKGkiBleHRlbmQg4oaSIFt1bnNlYWwga2V5XSDihpIgcmVzZXQg4oaS
IDAKLy8vICAgICAgICAgICAgICAgICAgICAgICAgICAg4oaTCi8vLyAgICAgICAgICAgICAgICAg
ICAgICBaZXJvT25Ecm9wPEtFWV9TSVpFPgovLy8gYGBgCnB1YiBmbiByZXN1bWVfdW5zZWFsKGNo
aXA6IENoaXAsIHBjcl9pbmRleDogUGNySW5kZXgsCiAgICAgICAgICAgICAgICAgICAgIHNlYWxl
ZDogJlNlYWxlZEtleSkgLT4gUmVzdWx0PFplcm9PbkRyb3A8S0VZX1NJWkU+PiB7CiAgICBsZXQg
cGNyID0gSGliZXJuYXRlUGNyOjo8UGNyWmVybz46OmFjcXVpcmUoY2hpcCwgcGNyX2luZGV4KT87
CiAgICBsZXQgcGNyID0gcGNyLmV4dGVuZCgpPzsKCiAgICAvLyBJZiB0aGlzIGZhaWxzIChFQUND
RVMpLCB0aGUgUENSIHBvbGljeSBkaWRuJ3QgbWF0Y2guCiAgICAvLyBXZSBzdGlsbCBuZWVkIHRv
IHJlc2V0IFBDUjIzIGJlZm9yZSByZXR1cm5pbmcgdGhlIGVycm9yLgogICAgbGV0IGtleV9yZXN1
bHQgPSBwY3IudW5zZWFsX2tleShzZWFsZWQpOwoKICAgIC8vIFJlc2V0IHJlZ2FyZGxlc3Mgb2Yg
d2hldGhlciB1bnNlYWwgc3VjY2VlZGVkCiAgICBsZXQgXyA9IHBjci5yZXNldCgpOwoKICAgIGtl
eV9yZXN1bHQKfQo=

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/markdown; name="README.md"
Content-Description: README.md
Content-Disposition: attachment; filename="README.md"; size=4294;
	creation-date="Mon, 23 Mar 2026 04:55:03 GMT";
	modification-date="Mon, 23 Mar 2026 04:57:17 GMT"
Content-Transfer-Encoding: base64

IyBIaWJlcm5hdGUgKyBMb2NrZG93bjogVFBNMiBJbWFnZSBFbmNyeXB0aW9uICh2NikKCiMjIFBy
b2JsZW1hIHF1ZSByZXN1ZWx2ZQoKYGxvY2tkb3duPWNvbmZpZGVudGlhbGl0eWAgYmxvcXVlYSBs
YSBoaWJlcm5hY2nDs24gcG9ycXVlIGVsIGtlcm5lbCBubyBwdWVkZQpjb25maWFyIGVuIHF1ZSBs
YSBpbWFnZW4gZW4gZGlzY28gbm8gaGEgc2lkbyBtYW5pcHVsYWRhLiBVbiBhdGFjYW50ZSBjb24K
YWNjZXNvIGbDrXNpY28gcG9kcsOtYSByZWVtcGxhemFyIGxhIGltYWdlbiBjb24gY8OzZGlnbyBt
YWxpY2lvc28sIHkgZWwga2VybmVsCmxhIGVqZWN1dGFyw61hIGFsIGhhY2VyIHJlc3VtZS4KCkVz
dGUgcGF0Y2ggcmVzdWVsdmUgZXNvIGNpZnJhbmRvIHkgYXV0ZW50aWNhbmRvIGxhIGltYWdlbiBj
b24gQUVTLTI1Ni1HQ00sCnVzYW5kbyB1bmEgY2xhdmUgc2VsbGFkYSBhbCBUUE0yIHZpYSBQQ1Iy
My4KCiMjIEPDs21vIGZ1bmNpb25hCgojIyMgQWwgaGliZXJuYXI6CmBgYAoxLiBWZXJpZmljYXIg
cXVlIFBDUjIzID09IDAgKHNpIG5vLCBlcnJvciBjbGFybykKMi4gRXh0ZW5kZXIgUENSMjMgY29u
IHZhbG9yIGNvbm9jaWRvIEgoImxpbnV4LWhpYmVybmF0ZS12MSIpCjMuIEdlbmVyYXIgY2xhdmUg
QUVTLTI1NiBhbGVhdG9yaWEKNC4gU2VsbGFyIGxhIGNsYXZlIGFsIFRQTSAocG9sw610aWNhOiBQ
Q1IyMyBkZWJlID09IEgoImxpbnV4LWhpYmVybmF0ZS12MSIpKQogICDihpIgc2VzacOzbiBITUFD
IGF1dGVudGljYWRhLCBjbGF2ZSBjaWZyYWRhIGVuIGVsIGJ1cyBUUE0KNS4gUmVzZXRlYXIgUENS
MjMgYSAwCjYuIENpZnJhciBpbWFnZW4gY2h1bmsgcG9yIGNodW5rIGNvbiBBRVMtMjU2LUdDTQog
ICDihpIgY2FkYSBjaHVuayB0aWVuZSBJViDDum5pY28geSBBQUQgY29uIMOtbmRpY2UgKGV2aXRh
IHJlb3JkZW5hbWllbnRvKQogICDihpIgdGFnIEdDTSBkZSAxNiBieXRlcyBhcHBlbmRlZCBhIGNh
ZGEgY2h1bmsKYGBgCgojIyMgQWwgcmVzdW1pcjoKYGBgCjEuIEV4dGVuZGVyIFBDUjIzIGNvbiBl
bCBtaXNtbyB2YWxvcgoyLiBQZWRpciBhbCBUUE0gcXVlIGxpYmVyZSBsYSBjbGF2ZQogICDihpIg
c2kgUENSMjMgbm8gY29pbmNpZGU6IFRQTSByZWNoYXphLCByZXN1bWUgYWJvcnRhZG8gKEVBQ0NF
UykKMy4gRGVzY2lmcmFyIHkgdmVyaWZpY2FyIGNhZGEgY2h1bmsKICAg4oaSIHNpIHRhZyBHQ00g
ZmFsbGE6IGltYWdlbiBtYW5pcHVsYWRhLCByZXN1bWUgYWJvcnRhZG8gKEVCQURNU0cpCjQuIFJl
c2V0ZWFyIFBDUjIzIGEgMAo1LiBMb2NrZG93biBzYXRpc2ZlY2hvIOKckwpgYGAKCiMjIEFyY2hp
dm9zIGRlbCBwYXRjaAoKYGBgCmtlcm5lbC9wb3dlci9zbmFwZW5jLmMgICAgICAgICAg4oCUIElt
cGxlbWVudGFjacOzbiBwcmluY2lwYWwgKEMpCmtlcm5lbC9wb3dlci9zbmFwZW5jLmggICAgICAg
ICAg4oCUIEhlYWRlciAvIGludGVyZmFjZQprZXJuZWwvcG93ZXIvS2NvbmZpZy5wYXRjaCAgICAg
IOKAlCBOdWV2YSBvcGNpw7NuIENPTkZJR19ISUJFUk5BVElPTl9FTkNSWVBUSU9OCnJ1c3Qva2Vy
bmVsL3RwbS9oaWJlcm5hdGVfcGNyLnJzIOKAlCBDYXBhIFJ1c3QgY29uIHR5cGVzdGF0ZSArIFJB
SUkKMDAwMS1oaWJlcm5hdGUtdHBtMi1lbmNyeXB0aW9uLnBhdGNoIOKAlCBEaWZmIGNvbnRyYSBr
ZXJuZWwgYWN0dWFsCmBgYAoKIyMgQ2FtYmlvcyB2cyB2NSAocmVzcHVlc3RhcyBhIGNyw610aWNh
cyB1cHN0cmVhbSkKCnwgQ3LDrXRpY2EgfCBBdXRvciB8IFNvbHVjacOzbiBlbiB2NiB8CnwtLS0t
LS0tLS18LS0tLS0tLXwtLS0tLS0tLS0tLS0tLS0tfAp8IGB0cG1fcGNyX3Jlc2V0KClgIEFQSSBk
ZW1hc2lhZG8gZ2Vuw6lyaWNhIHkgcGVsaWdyb3NhIHwgSmFya2tvIFNha2tpbmVuIHwgUmVlbXBs
YXphZGEgcG9yIGBzbmFwZW5jX3Bjcl9yZXNldCgpYCByZXN0cmluZ2lkYSBzb2xvIGEgZXN0ZSBj
b250ZXh0byB8CnwgU2VzaW9uZXMgVFBNIHNpbiBjaWZyYWRvIGRlIHBhcsOhbWV0cm9zIHwgRXJp
YyBCaWdnZXJzIHwgQWhvcmEgdXNhIGBUUE0yX1NFX0hNQUNgICsgYFRQTTJfRU5DX1BBUkFNX1lF
U2Ag4oCUIGNsYXZlIGNpZnJhZGEgZW4gZWwgYnVzIHwKfCBQQ1IyMyBwb2Ryw61hIGVzdGFyIGVu
IHVzbyBwb3Igb3RybyBhZ2VudGUgfCBKYW1lcyBCb3R0b21sZXkgfCBWZXJpZmljYWNpw7NuIGFs
IGJvb3QgKyBwYXLDoW1ldHJvIGBoaWJlcm5hdGVfdHBtX3Bjcj1OYCBjb25maWd1cmFibGUgfAp8
IFNpbiBtYW50ZW5lZG9yIGFjdGl2byB8IChvcmdhbml6YWNpb25hbCkgfCDigJQgfAoKIyMgSW5u
b3ZhY2lvbmVzIGRlbCB2NiBubyBwcmVzZW50ZXMgZW4gdjUKCiMjIyAxLiBSdXN0IHR5cGVzdGF0
ZSBwYXJhIHRyYW5zaWNpb25lcyBkZSBQQ1IKRWwgY8OzZGlnbyBSdXN0IGVuIGBoaWJlcm5hdGVf
cGNyLnJzYCB1c2EgZWwgcGF0csOzbiB0eXBlc3RhdGU6CmBgYHJ1c3QKLy8gTk8gY29tcGlsYSDi
gJQgbm8gcHVlZGVzIHNlbGxhciBzaW4gYW50ZXMgZXh0ZW5kZXI6CmxldCBwY3IgPSBIaWJlcm5h
dGVQY3I6OjxQY3JaZXJvPjo6YWNxdWlyZShjaGlwLCBpbmRleCk/OwpwY3Iuc2VhbF9rZXkoJmtl
eSkgIC8vIEVSUk9SIERFIENPTVBJTEFDScOTTiDinJMKCi8vIENvcnJlY3RvOgpsZXQgcGNyID0g
cGNyLmV4dGVuZCgpPzsgICAgIC8vIFBjclplcm8g4oaSIFBjckV4dGVuZGVkCmxldCBzZWFsZWQg
PSBwY3Iuc2VhbF9rZXkoJmtleSk/OwpsZXQgXyA9IHBjci5yZXNldCgpPzsgICAgICAgIC8vIFBj
ckV4dGVuZGVkIOKGkiBQY3JaZXJvCmBgYApMYXMgdHJhbnNpY2lvbmVzIGluY29ycmVjdGFzIGRl
IFBDUiBzb24gaW1wb3NpYmxlcyBlbiB0aWVtcG8gZGUgY29tcGlsYWNpw7NuLgoKIyMjIDIuIFJB
SUkgVHBtSG1hY1Nlc3Npb24KYGBgcnVzdAovLyBMYSBzZXNpw7NuIHNlIGZsdXNoZWEgU0lFTVBS
RSBhbCBzYWxpciBkZWwgc2NvcGUsIGluY2x1c28gZW4gZXJyb3IgcGF0aHMuCi8vIEVuIHY1IChD
KSBlcmEgcG9zaWJsZSBzYWx0YXJzZSBlbCBmbHVzaCBjb24gcmV0dXJucyB0ZW1wcmFub3MuCmxl
dCBzZXNzaW9uID0gVHBtSG1hY1Nlc3Npb246OmJlZ2luKCZjaGlwLCBUcG1BbGdvcml0aG06OlNo
YTI1Nik/OwovLyAuLi4gc2kgaGF5IGVycm9yIGFxdcOtLCBkcm9wKCkgY2llcnJhIGxhIHNlc2nD
s24gYXV0b23DoXRpY2FtZW50ZQpgYGAKCiMjIyAzLiBaZXJvT25Ecm9wIHBhcmEgbWF0ZXJpYWwg
ZGUgY2xhdmVzCmBgYHJ1c3QKbGV0IGtleSA9IFplcm9PbkRyb3A6OjwzMj46Om5ldygpOwovLyBB
bCBzYWxpciBkZWwgc2NvcGU6IG1lbW9yaWEgemVyb2l6YWRhIGNvbiB2b2xhdGlsZSB3cml0ZQov
LyBFbCBjb21waWxhZG9yIG5vIHB1ZWRlIG9wdGltaXphciBlbCB6ZXJvaW5nCmBgYAoKIyMjIDQu
IEFBRCBjb24gw61uZGljZSBkZSBjaHVuawpDYWRhIGNodW5rIHRpZW5lIHN1IMOtbmRpY2UgY29t
byBBZGRpdGlvbmFsIEF1dGhlbnRpY2F0ZWQgRGF0YToKYGBgYwpwdXRfdW5hbGlnbmVkX2JlNjQo
Y2h1bmtfaWR4LCBhYWQpOwovLyBFdml0YSBhdGFxdWVzIGRlIHJlb3JkZW5hbWllbnRvOiBjaHVu
ayA1IG5vIHB1ZWRlIHVzYXJzZSBjb21vIGNodW5rIDMKYGBgCgojIyBDw7NtbyBlbnZpYXIgdXBz
dHJlYW0KCjEuIERpcmlnaXIgYTogYGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmdgCjIuIEND
IG9ibGlnYXRvcmlvOgogICAtIGBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmdgIChwb3dlciBtYW5h
Z2VtZW50KQogICAtIGBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmdgIChUUE0vdHJ1c3RlZCBrZXlz
KQogICAtIGBqYXJra29Aa2VybmVsLm9yZ2AgKFRQTSBzdWJzeXN0ZW0gbWFpbnRhaW5lcikKICAg
LSBgZWJpZ2dlcnNAa2VybmVsLm9yZ2AgKGNyeXB0byBzdWJzeXN0ZW0pCiAgIC0gYG1qZzU5QHNy
Y2YudWNhbS5vcmdgIChhdXRvciBvcmlnaW5hbCBkZWwgY29uY2VwdG8pCjMuIFN1YmplY3QgZm9y
bWF0OiBgW1BBVENIIHY2IE4vNF0gcG93ZXIvaGliZXJuYXRlOiAuLi5gCgojIyBQYXLDoW1ldHJv
cyBkZSBrZXJuZWwKCmBgYApoaWJlcm5hdGVfdHBtX3Bjcj1OICAgUXXDqSBQQ1IgdXNhciAoZGVm
YXVsdDogMjMsIHbDoWxpZG86IDE2LTIzKQpgYGAKCiMjIERlcGVuZGVuY2lhcyBkZSBjb25maWd1
cmFjacOzbgoKYGBgCkNPTkZJR19ISUJFUk5BVElPTj15CkNPTkZJR19ISUJFUk5BVElPTl9FTkNS
WVBUSU9OPXkKQ09ORklHX1RDR19UUE09eQpDT05GSUdfVENHX1RQTTI9eQpDT05GSUdfQ1JZUFRP
X0FFUz15CkNPTkZJR19DUllQVE9fR0NNPXkKQ09ORklHX0NSWVBUT19TSEEyNTY9eQpDT05GSUdf
VFJVU1RFRF9LRVlTPXkKYGBgCg==

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/x-csrc; name="snapenc.c"
Content-Description: snapenc.c
Content-Disposition: attachment; filename="snapenc.c"; size=24069;
	creation-date="Mon, 23 Mar 2026 04:55:04 GMT";
	modification-date="Mon, 23 Mar 2026 04:57:17 GMT"
Content-Transfer-Encoding: base64

Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQovKgogKiBrZXJuZWwvcG93
ZXIvc25hcGVuYy5jCiAqCiAqIEhpYmVybmF0ZSBpbWFnZSBlbmNyeXB0aW9uIGFuZCBhdXRoZW50
aWNhdGlvbiB1c2luZyBUUE0yICsgUENSMjMuCiAqCiAqIFRoaXMgbW9kdWxlIGFsbG93cyBoaWJl
cm5hdGlvbiB0byBjb2V4aXN0IHdpdGgga2VybmVsIGxvY2tkb3duIGJ5OgogKiAgMS4gU2VhbGlu
ZyBhbiBBRVMtMjU2LUdDTSBrZXkgdG8gVFBNMiBQQ1IyMyBhdCBoaWJlcm5hdGUgdGltZQogKiAg
Mi4gRW5jcnlwdGluZyBhbmQgYXV0aGVudGljYXRpbmcgdGhlIGhpYmVybmF0ZSBpbWFnZSB3aXRo
IHRoYXQga2V5CiAqICAzLiBVbnNlYWxpbmcgYW5kIHZlcmlmeWluZyBvbiByZXN1bWUg4oCUIGlm
IFBDUjIzIGRvZXNuJ3QgbWF0Y2gsCiAqICAgICB0aGUgVFBNIHJlZnVzZXMgdG8gcmVsZWFzZSB0
aGUga2V5IGFuZCByZXN1bWUgaXMgYWJvcnRlZC4KICoKICogVGhpcyBhZGRyZXNzZXMgdGhlIGNv
bmNlcm4gcmFpc2VkIGJ5IGxvY2tkb3duPWNvbmZpZGVudGlhbGl0eSB0aGF0CiAqIGFuIGF0dGFj
a2VyIGNvdWxkIHJlcGxhY2UgdGhlIGhpYmVybmF0ZSBpbWFnZSBvbiBkaXNrLiBXaXRoIHRoaXMK
ICogY29kZSwgdGFtcGVyaW5nIHdpdGggdGhlIGltYWdlIG9uIGRpc2sgY2F1c2VzIGF1dGhlbnRp
Y2F0aW9uIGZhaWx1cmUKICogKEdDTSB0YWcgbWlzbWF0Y2gpIGFuZCB0YW1wZXJpbmcgd2l0aCBQ
Q1IyMyBjYXVzZXMgVFBNIHBvbGljeSBmYWlsdXJlLgogKgogKiBCYXNlZCBvbiB0aGUgZGVzaWdu
IHByb3Bvc2VkIGJ5IE1hdHRoZXcgR2FycmV0dCBhbmQgRXZhbiBHcmVlbi4KICogUmV2aXNlZCAo
djYpIHRvIGFkZHJlc3MgdXBzdHJlYW0gcmV2aWV3IGNvbmNlcm5zOgogKiAgIC0gUmVzdHJpY3Rl
ZCBQQ1IgcmVzZXQgQVBJIChub3QgZ2VuZXJpYykKICogICAtIEhNQUMtYXV0aGVudGljYXRlZCBU
UE0gc2Vzc2lvbnMgKG5vdCBwbGFpbiBwb2xpY3kgc2Vzc2lvbnMpCiAqICAgLSBDb25maWd1cmFi
bGUgUENSIHZpYSBrZXJuZWwgY21kbGluZSAoaGliZXJuYXRlX3RwbV9wY3I9TikKICogICAtIEJv
b3QtdGltZSB2ZXJpZmljYXRpb24gdGhhdCB0aGUgY2hvc2VuIFBDUiBpcyB6ZXJvCiAqCiAqIEF1
dGhvcnM6CiAqICAgTWF0dGhldyBHYXJyZXR0IDxtamc1OUBzcmNmLnVjYW0ub3JnPiAob3JpZ2lu
YWwgY29uY2VwdCkKICogICBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVtLm9yZz4gKHY1IGlt
cGxlbWVudGF0aW9uKQogKiAgIFt2NiByZXZpc2lvbiBhZGRyZXNzaW5nIHVwc3RyZWFtIHJldmll
dyBmZWVkYmFja10KICovCgojaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4KI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4KI2luY2x1ZGUgPGxpbnV4L3JhbmRvbS5oPgojaW5jbHVkZSA8bGludXgvY3J5cHRvLmg+CiNp
bmNsdWRlIDxsaW51eC9zY2F0dGVybGlzdC5oPgojaW5jbHVkZSA8Y3J5cHRvL2FlYWQuaD4KI2lu
Y2x1ZGUgPGNyeXB0by9nY20uaD4KI2luY2x1ZGUgPGNyeXB0by9oYXNoLmg+CiNpbmNsdWRlIDxs
aW51eC90cG0uaD4KI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmQuaD4KI2luY2x1ZGUgPGxpbnV4L3Nl
Y3VyaXR5Lmg+CiNpbmNsdWRlICJwb3dlci5oIgojaW5jbHVkZSAic25hcGVuYy5oIgoKLyogRGVm
YXVsdCBQQ1IgdG8gdXNlIGZvciBoaWJlcm5hdGUgc2VhbGluZy4gQ2FuIGJlIG92ZXJyaWRkZW4g
dmlhIGNtZGxpbmUuICovCiNkZWZpbmUgSElCRVJOQVRFX1BDUl9ERUZBVUxUICAgMjMKI2RlZmlu
ZSBISUJFUk5BVEVfUENSX01JTiAgICAgICAxNiAgIC8qIFBDUnMgMC0xNSBhcmUgcGxhdGZvcm0t
bWFuYWdlZCAqLwojZGVmaW5lIEhJQkVSTkFURV9QQ1JfTUFYICAgICAgIDIzCgovKgogKiBNYWdp
YyB2YWx1ZSBleHRlbmRlZCBpbnRvIHRoZSBQQ1IgYmVmb3JlIHNlYWxpbmcuCiAqIE11c3QgYmUg
YSBzdGFibGUsIHdlbGwta25vd24gdmFsdWUg4oCUIG5vdCBzZWNyZXQuCiAqIFNIQS0yNTYoImxp
bnV4LWhpYmVybmF0ZS12MSIpCiAqLwpzdGF0aWMgY29uc3QgdTggaGliZXJuYXRlX3Bjcl9leHRl
bmRfdmFsdWVbU0hBMjU2X0RJR0VTVF9TSVpFXSA9IHsKCTB4N2EsIDB4M2YsIDB4OGMsIDB4MTIs
IDB4ZTQsIDB4NTYsIDB4YjksIDB4MDEsCgkweGNkLCAweDc4LCAweDJlLCAweDVhLCAweDkwLCAw
eDExLCAweGYzLCAweDQ0LAoJMHg2YiwgMHg4MiwgMHg3ZCwgMHgzZSwgMHgxOSwgMHhjNSwgMHhh
MCwgMHhmYiwKCTB4NTUsIDB4MjQsIDB4OGUsIDB4NzEsIDB4OTIsIDB4ZGQsIDB4NGMsIDB4MGEs
Cn07CgovKiBBRVMtMjU2LUdDTSBwYXJhbWV0ZXJzICovCiNkZWZpbmUgU05BUEVOQ19LRVlfU0la
RSAgICAzMiAgLyogMjU2IGJpdHMgKi8KI2RlZmluZSBTTkFQRU5DX0lWX1NJWkUgICAgIDEyICAv
KiA5NiBiaXRzIOKAlCBHQ00gc3RhbmRhcmQgKi8KI2RlZmluZSBTTkFQRU5DX1RBR19TSVpFICAg
IDE2ICAvKiAxMjggYml0cyDigJQgR0NNIGF1dGhlbnRpY2F0aW9uIHRhZyAqLwojZGVmaW5lIFNO
QVBFTkNfQ0hVTktfU0laRSAgKDEgPDwgMjApICAvKiAxIE1pQiBwZXIgY2h1bmsgKi8KCi8qIENv
bmZpZ3VyYWJsZSBQQ1IgbnVtYmVyIHZpYSBrZXJuZWwgY21kbGluZTogaGliZXJuYXRlX3RwbV9w
Y3I9TiAqLwpzdGF0aWMgaW50IGhpYmVybmF0ZV90cG1fcGNyID0gSElCRVJOQVRFX1BDUl9ERUZB
VUxUOwoKc3RhdGljIGludCBfX2luaXQgaGliZXJuYXRlX3RwbV9wY3Jfc2V0dXAoY2hhciAqc3Ry
KQp7CglpbnQgcGNyOwoKCWlmIChrc3RydG9pbnQoc3RyLCAxMCwgJnBjcikpCgkJcmV0dXJuIC1F
SU5WQUw7CgoJaWYgKHBjciA8IEhJQkVSTkFURV9QQ1JfTUlOIHx8IHBjciA+IEhJQkVSTkFURV9Q
Q1JfTUFYKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBoaWJlcm5hdGVfdHBtX3Bjcj0lZCBvdXQgb2Yg
cmFuZ2UgWyVkLSVkXSwgIgoJCSAgICAgICAidXNpbmcgZGVmYXVsdCAlZFxuIiwKCQkgICAgICAg
cGNyLCBISUJFUk5BVEVfUENSX01JTiwgSElCRVJOQVRFX1BDUl9NQVgsCgkJICAgICAgIEhJQkVS
TkFURV9QQ1JfREVGQVVMVCk7CgkJcmV0dXJuIC1FUkFOR0U7Cgl9CgoJaGliZXJuYXRlX3RwbV9w
Y3IgPSBwY3I7Cglwcl9pbmZvKCJzbmFwZW5jOiB1c2luZyBQQ1IlZCBmb3IgaGliZXJuYXRlIHNl
YWxpbmdcbiIsIGhpYmVybmF0ZV90cG1fcGNyKTsKCXJldHVybiAwOwp9CmVhcmx5X3BhcmFtKCJo
aWJlcm5hdGVfdHBtX3BjciIsIGhpYmVybmF0ZV90cG1fcGNyX3NldHVwKTsKCi8qIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSAqLwovKiAgVFBNIGhlbHBlcnMg4oCUIFBDUiBvcGVyYXRpb25zIHJlc3RyaWN0ZWQgdG8gaGli
ZXJuYXRlIGNvbnRleHQgb25seSAgKi8KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgovKioKICogc25hcGVuY19w
Y3JfaXNfemVybyAtIFZlcmlmeSB0aGF0IG91ciBjaG9zZW4gUENSIGlzIHplcm8gYXQgYm9vdC4K
ICoKICogQ2FsbGVkIG9uY2UgZHVyaW5nIG1vZHVsZSBpbml0LiBJZiB0aGUgUENSIGlzIG5vdCB6
ZXJvLCBhbm90aGVyIGFnZW50CiAqIChmaXJtd2FyZSwgc2VjdXJpdHkgc29mdHdhcmUpIGlzIHVz
aW5nIGl0LiBXZSByZWZ1c2UgdG8gcHJvY2VlZCByYXRoZXIKICogdGhhbiBzaWxlbnRseSBjbG9i
YmVyaW5nIGl0LgogKgogKiBSZXR1cm5zIDAgaWYgUENSIGlzIHplcm8sIC1FQlVTWSBpZiBpbiB1
c2UsIG5lZ2F0aXZlIG9uIGVycm9yLgogKi8Kc3RhdGljIGludCBzbmFwZW5jX3Bjcl9pc196ZXJv
KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKewoJdTggZGlnZXN0W1NIQTI1Nl9ESUdFU1RfU0laRV07
CglpbnQgcmM7Cglib29sIGFsbF96ZXJvID0gdHJ1ZTsKCWludCBpOwoKCXJjID0gdHBtX3Bjcl9y
ZWFkKGNoaXAsIGhpYmVybmF0ZV90cG1fcGNyLAoJCQkgIChzdHJ1Y3QgdHBtX2RpZ2VzdCAqKWRp
Z2VzdCk7CglpZiAocmMpIHsKCQlwcl9lcnIoInNuYXBlbmM6IGZhaWxlZCB0byByZWFkIFBDUiVk
OiAlZFxuIiwKCQkgICAgICAgaGliZXJuYXRlX3RwbV9wY3IsIHJjKTsKCQlyZXR1cm4gcmM7Cgl9
CgoJZm9yIChpID0gMDsgaSA8IFNIQTI1Nl9ESUdFU1RfU0laRTsgaSsrKSB7CgkJaWYgKGRpZ2Vz
dFtpXSAhPSAwKSB7CgkJCWFsbF96ZXJvID0gZmFsc2U7CgkJCWJyZWFrOwoJCX0KCX0KCglpZiAo
IWFsbF96ZXJvKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBQQ1IlZCBpcyBub3QgemVybyDigJQgYWxy
ZWFkeSBpbiB1c2UgYnkgYW5vdGhlciAiCgkJICAgICAgICJhZ2VudC4gVXNlIGhpYmVybmF0ZV90
cG1fcGNyPU4gdG8gc2VsZWN0IGEgZnJlZSBQQ1IuXG4iLAoJCSAgICAgICBoaWJlcm5hdGVfdHBt
X3Bjcik7CgkJcmV0dXJuIC1FQlVTWTsKCX0KCglyZXR1cm4gMDsKfQoKLyoqCiAqIHNuYXBlbmNf
cGNyX2V4dGVuZCAtIEV4dGVuZCBQQ1Igd2l0aCB0aGUgd2VsbC1rbm93biBoaWJlcm5hdGUgbWFn
aWMgdmFsdWUuCiAqCiAqIFRoaXMgaXMgTk9UIGEgZ2VuZXJpYyBQQ1IgZXh0ZW5kIOKAlCBpdCBv
bmx5IGFjY2VwdHMgb3VyIGZpeGVkIG1hZ2ljIHZhbHVlCiAqIGFuZCBvbmx5IG9wZXJhdGVzIG9u
IGhpYmVybmF0ZV90cG1fcGNyLiBJdCBjYW5ub3QgYmUgY2FsbGVkIGZyb20gb3V0c2lkZQogKiB0
aGlzIGZpbGUuCiAqCiAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBvbiBlcnJvci4K
ICovCnN0YXRpYyBpbnQgc25hcGVuY19wY3JfZXh0ZW5kKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkK
ewoJc3RydWN0IHRwbV9kaWdlc3QgZGlnZXN0OwoKCWRpZ2VzdC5hbGdfaWQgPSBUUE1fQUxHX1NI
QTI1NjsKCW1lbWNweShkaWdlc3QuZGlnZXN0LCBoaWJlcm5hdGVfcGNyX2V4dGVuZF92YWx1ZSwg
U0hBMjU2X0RJR0VTVF9TSVpFKTsKCglyZXR1cm4gdHBtX3Bjcl9leHRlbmQoY2hpcCwgaGliZXJu
YXRlX3RwbV9wY3IsICZkaWdlc3QpOwp9CgovKioKICogc25hcGVuY19wY3JfcmVzZXQgLSBSZXNl
dCBvdXIgaGliZXJuYXRlIFBDUiBiYWNrIHRvIHplcm8uCiAqCiAqIFVzZXMgVFBNMl9QQ1JfUmVz
ZXQuIE9ubHkgdmFsaWQgZm9yIFBDUnMgMTYtMjMgKHJlc2V0dGFibGUgcmFuZ2UpLgogKiBSZXN0
cmljdGVkIHRvIGhpYmVybmF0ZSBjb250ZXh0IOKAlCBjYW5ub3QgYmUgY2FsbGVkIGZyb20gdXNl
cnNwYWNlIG9yCiAqIGFyYml0cmFyeSBrZXJuZWwgY29kZS4KICoKICogVGhpcyByZXBsYWNlcyB0
aGUgZ2VuZXJpYyB0cG1fcGNyX3Jlc2V0KCkgcHJvcG9zZWQgaW4gdjUgd2hpY2ggcmV2aWV3ZXJz
CiAqIChKYXJra28gU2Fra2luZW4pIGNvbnNpZGVyZWQgdG9vIGRhbmdlcm91cyBhcyBhIGdlbmVy
YWwgQVBJLgogKgogKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgb24gZXJyb3IuCiAq
LwpzdGF0aWMgaW50IHNuYXBlbmNfcGNyX3Jlc2V0KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkKewoJ
LyogQ29tcGlsZS10aW1lIGFzc2VydGlvbjogb25seSByZXNldHRhYmxlIFBDUnMgKi8KCUJVSUxE
X0JVR19PTihISUJFUk5BVEVfUENSX0RFRkFVTFQgPCAxNik7CgoJcmV0dXJuIHRwbTJfcGNyX3Jl
c2V0KGNoaXAsIGhpYmVybmF0ZV90cG1fcGNyKTsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qICBUUE0y
IGtleSBzZWFsaW5nIC8gdW5zZWFsaW5nIHdpdGggSE1BQy1hdXRoZW50aWNhdGVkIHNlc3Npb25z
ICAgICAgKi8KLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCgovKioKICogc3RydWN0IHNuYXBlbmNfc2VhbGVkX2tl
eSAtIEEga2V5IHNlYWxlZCB0byB0aGUgVFBNIHdpdGggYSBQQ1IgcG9saWN5LgogKgogKiBAYmxv
YjogICAgICAgVGhlIFRQTTJCX1BSSVZBVEUgYmxvYiByZXR1cm5lZCBieSBUUE0yX0NyZWF0ZQog
KiBAYmxvYl9sZW46ICAgTGVuZ3RoIG9mIEBibG9iCiAqIEBwdWI6ICAgICAgICBUaGUgVFBNMkJf
UFVCTElDIGJsb2IKICogQHB1Yl9sZW46ICAgIExlbmd0aCBvZiBAcHViCiAqIEBwY3JfaW5kZXg6
ICBXaGljaCBQQ1Igd2FzIHVzZWQgaW4gdGhlIHBvbGljeQogKiBAcGNyX2RpZ2VzdDogRXhwZWN0
ZWQgUENSIHZhbHVlIGF0IHRpbWUgb2Ygc2VhbGluZwogKi8Kc3RydWN0IHNuYXBlbmNfc2VhbGVk
X2tleSB7Cgl1OCAgYmxvYls1MTJdOwoJdTMyIGJsb2JfbGVuOwoJdTggIHB1Yls1MTJdOwoJdTMy
IHB1Yl9sZW47Cgl1MzIgcGNyX2luZGV4OwoJdTggIHBjcl9kaWdlc3RbU0hBMjU2X0RJR0VTVF9T
SVpFXTsKfTsKCi8qKgogKiBzbmFwZW5jX3NlYWxfa2V5IC0gU2VhbCBhIGtleSB0byB0aGUgVFBN
LCBib3VuZCB0byBjdXJyZW50IFBDUiBzdGF0ZS4KICoKICogVXNlcyBUUE0yX0NyZWF0ZSB3aXRo
IGEgUENSIHBvbGljeS4gVGhlIHNlc3Npb24gaXMgYW4gSE1BQyBzZXNzaW9uCiAqIChUUE0yX1NF
X0hNQUMpIHdpdGggcGFyYW1ldGVyIGVuY3J5cHRpb24gZW5hYmxlZCwgc28gdGhhdCB0aGUga2V5
CiAqIG1hdGVyaWFsIG5ldmVyIHRyYXZlbHMgaW4gcGxhaW50ZXh0IGJldHdlZW4ga2VybmVsIGFu
ZCBUUE0uCiAqCiAqIFRoaXMgYWRkcmVzc2VzIEVyaWMgQmlnZ2VycycgcmV2aWV3IGNvbmNlcm4g
YWJvdXQgc2Vzc2lvbiBzZWN1cml0eSBpbiB2NS4KICoKICogQGNoaXA6ICAgICAgIFRQTSBjaGlw
IHRvIHVzZQogKiBAa2V5OiAgICAgICAgUGxhaW50ZXh0IGtleSB0byBzZWFsIChTTkFQRU5DX0tF
WV9TSVpFIGJ5dGVzKQogKiBAc2VhbGVkOiAgICAgT3V0cHV0OiBzZWFsZWQga2V5IGJsb2IKICoK
ICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIG9uIGVycm9yLgogKi8Kc3RhdGljIGlu
dCBzbmFwZW5jX3NlYWxfa2V5KHN0cnVjdCB0cG1fY2hpcCAqY2hpcCwKCQkJICAgIGNvbnN0IHU4
ICprZXksCgkJCSAgICBzdHJ1Y3Qgc25hcGVuY19zZWFsZWRfa2V5ICpzZWFsZWQpCnsKCXN0cnVj
dCB0cG0yX2F1dGggKmF1dGg7CglpbnQgcmM7CgoJLyoKCSAqIFN0YXJ0IGFuIEhNQUMgc2Vzc2lv
biB3aXRoIHBhcmFtZXRlciBlbmNyeXB0aW9uLgoJICogVFBNMl9TRV9ITUFDIGVuc3VyZXMgdGhl
IHNlc3Npb24gaXRzZWxmIGlzIGF1dGhlbnRpY2F0ZWQ7CgkgKiBUUE0yX0VOQ19QQVJBTV9ZRVMg
ZW5zdXJlcyBrZXkgbWF0ZXJpYWwgaXMgZW5jcnlwdGVkIGluIHRyYW5zaXQuCgkgKgoJICogVGhp
cyBpcyB0aGUga2V5IGRpZmZlcmVuY2UgZnJvbSB2NSB3aGljaCB1c2VkIFRQTTJfU0VfUE9MSUNZ
CgkgKiB3aXRob3V0IHBhcmFtZXRlciBlbmNyeXB0aW9uLCBsZWF2aW5nIHRoZSBrZXkgdmlzaWJs
ZSBvbiB0aGUKCSAqIFRQTSBidXMgZHVyaW5nIHRoZSBDcmVhdGUgY29tbWFuZC4KCSAqLwoJYXV0
aCA9IHRwbTJfc3RhcnRfYXV0aF9zZXNzaW9uKGNoaXAsCgkJCQkgICAgICAgVFBNMl9TRV9ITUFD
LAoJCQkJICAgICAgIFRQTTJfQUxHX1NIQTI1NiwKCQkJCSAgICAgICBUUE0yX0VOQ19QQVJBTV9Z
RVMpOwoJaWYgKElTX0VSUihhdXRoKSkgewoJCXByX2Vycigic25hcGVuYzogZmFpbGVkIHRvIHN0
YXJ0IGF1dGggc2Vzc2lvbjogJWxkXG4iLAoJCSAgICAgICBQVFJfRVJSKGF1dGgpKTsKCQlyZXR1
cm4gUFRSX0VSUihhdXRoKTsKCX0KCgkvKiBCdWlsZCBQQ1IgcG9saWN5OiBzZWFsIHRvIGN1cnJl
bnQgdmFsdWUgb2YgaGliZXJuYXRlX3RwbV9wY3IgKi8KCXJjID0gdHBtMl9wb2xpY3lfcGNyKGF1
dGgsIGhpYmVybmF0ZV90cG1fcGNyKTsKCWlmIChyYykgewoJCXByX2Vycigic25hcGVuYzogZmFp
bGVkIHRvIGJ1aWxkIFBDUiBwb2xpY3k6ICVkXG4iLCByYyk7CgkJZ290byBvdXRfZmx1c2hfc2Vz
c2lvbjsKCX0KCgkvKiBDcmVhdGUgdGhlIHNlYWxlZCBvYmplY3QgKi8KCXJjID0gdHBtMl9zZWFs
X3RydXN0ZWQoY2hpcCwga2V5LCBTTkFQRU5DX0tFWV9TSVpFLAoJCQkgICAgICAgYXV0aCwKCQkJ
ICAgICAgIHNlYWxlZC0+YmxvYiwgJnNlYWxlZC0+YmxvYl9sZW4sCgkJCSAgICAgICBzZWFsZWQt
PnB1YiwgICZzZWFsZWQtPnB1Yl9sZW4pOwoJaWYgKHJjKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBU
UE0yX0NyZWF0ZSAoc2VhbCkgZmFpbGVkOiAlZFxuIiwgcmMpOwoJCWdvdG8gb3V0X2ZsdXNoX3Nl
c3Npb247Cgl9CgoJc2VhbGVkLT5wY3JfaW5kZXggPSBoaWJlcm5hdGVfdHBtX3BjcjsKCW1lbWNw
eShzZWFsZWQtPnBjcl9kaWdlc3QsIGhpYmVybmF0ZV9wY3JfZXh0ZW5kX3ZhbHVlLAoJICAgICAg
IFNIQTI1Nl9ESUdFU1RfU0laRSk7CgpvdXRfZmx1c2hfc2Vzc2lvbjoKCXRwbTJfZW5kX2F1dGhf
c2Vzc2lvbihhdXRoKTsKCXJldHVybiByYzsKfQoKLyoqCiAqIHNuYXBlbmNfdW5zZWFsX2tleSAt
IFVuc2VhbCBhIHByZXZpb3VzbHkgc2VhbGVkIGtleSBmcm9tIHRoZSBUUE0uCiAqCiAqIFRoZSBU
UE0gd2lsbCByZWZ1c2UgdG8gcmVsZWFzZSB0aGUga2V5IGlmIHRoZSBjdXJyZW50IHZhbHVlIG9m
CiAqIGhpYmVybmF0ZV90cG1fcGNyIGRvZXMgbm90IG1hdGNoIHRoZSBwb2xpY3kgcmVjb3JkZWQg
YXQgc2VhbCB0aW1lLgogKiBUaGlzIGlzIHRoZSBjb3JlIHNlY3VyaXR5IGd1YXJhbnRlZTogYSB0
YW1wZXJlZCBpbWFnZSBjYW5ub3QgYmUKICogcmVzdW1lZCBiZWNhdXNlIHRoZSBQQ1Igc3RhdGUg
d29uJ3QgbWF0Y2guCiAqCiAqIEBjaGlwOiAgICAgICBUUE0gY2hpcCB0byB1c2UKICogQHNlYWxl
ZDogICAgIFNlYWxlZCBrZXkgYmxvYiAoZnJvbSBzbmFwZW5jX3NlYWxfa2V5KQogKiBAa2V5OiAg
ICAgICAgT3V0cHV0OiBwbGFpbnRleHQga2V5IChTTkFQRU5DX0tFWV9TSVpFIGJ5dGVzKQogKgog
KiBSZXR1cm5zIDAgb24gc3VjY2VzcywgLUVBQ0NFUyBpZiBQQ1IgcG9saWN5IGZhaWxzLCBuZWdh
dGl2ZSBvbiBlcnJvci4KICovCnN0YXRpYyBpbnQgc25hcGVuY191bnNlYWxfa2V5KHN0cnVjdCB0
cG1fY2hpcCAqY2hpcCwKCQkJICAgICAgY29uc3Qgc3RydWN0IHNuYXBlbmNfc2VhbGVkX2tleSAq
c2VhbGVkLAoJCQkgICAgICB1OCAqa2V5KQp7CglzdHJ1Y3QgdHBtMl9hdXRoICphdXRoOwoJdTMy
IGtleV9sZW4gPSBTTkFQRU5DX0tFWV9TSVpFOwoJaW50IHJjOwoKCS8qIFNhbWUgc2Vzc2lvbiB0
eXBlIGFzIHNlYWw6IEhNQUMgKyBwYXJhbWV0ZXIgZW5jcnlwdGlvbiAqLwoJYXV0aCA9IHRwbTJf
c3RhcnRfYXV0aF9zZXNzaW9uKGNoaXAsCgkJCQkgICAgICAgVFBNMl9TRV9ITUFDLAoJCQkJICAg
ICAgIFRQTTJfQUxHX1NIQTI1NiwKCQkJCSAgICAgICBUUE0yX0VOQ19QQVJBTV9ZRVMpOwoJaWYg
KElTX0VSUihhdXRoKSkgewoJCXByX2Vycigic25hcGVuYzogZmFpbGVkIHRvIHN0YXJ0IGF1dGgg
c2Vzc2lvbiBmb3IgdW5zZWFsOiAlbGRcbiIsCgkJICAgICAgIFBUUl9FUlIoYXV0aCkpOwoJCXJl
dHVybiBQVFJfRVJSKGF1dGgpOwoJfQoKCXJjID0gdHBtMl9wb2xpY3lfcGNyKGF1dGgsIHNlYWxl
ZC0+cGNyX2luZGV4KTsKCWlmIChyYykgewoJCXByX2Vycigic25hcGVuYzogUENSIHBvbGljeSBy
ZWJ1aWxkIGZhaWxlZDogJWRcbiIsIHJjKTsKCQlnb3RvIG91dDsKCX0KCglyYyA9IHRwbTJfdW5z
ZWFsX3RydXN0ZWQoY2hpcCwKCQkJCSBzZWFsZWQtPmJsb2IsIHNlYWxlZC0+YmxvYl9sZW4sCgkJ
CQkgc2VhbGVkLT5wdWIsICBzZWFsZWQtPnB1Yl9sZW4sCgkJCQkgYXV0aCwKCQkJCSBrZXksICZr
ZXlfbGVuKTsKCWlmIChyYykgewoJCS8qCgkJICogVFBNIHJldHVybnMgVFBNMl9SQ19QT0xJQ1lf
RkFJTCB3aGVuIFBDUiBkb2Vzbid0IG1hdGNoLgoJCSAqIFRyYW5zbGF0ZSB0byAtRUFDQ0VTIHNv
IGNhbGxlcnMgY2FuIGdpdmUgYSBjbGVhciBlcnJvci4KCQkgKi8KCQlpZiAocmMgPT0gVFBNMl9S
Q19QT0xJQ1lfRkFJTCB8fCByYyA9PSBUUE0yX1JDX0FVVEhfRkFJTCkKCQkJcmMgPSAtRUFDQ0VT
OwoJCXByX2Vycigic25hcGVuYzogVFBNMl9VbnNlYWwgZmFpbGVkIChQQ1IgbWlzbWF0Y2g/KTog
JWRcbiIsIHJjKTsKCX0KCm91dDoKCXRwbTJfZW5kX2F1dGhfc2Vzc2lvbihhdXRoKTsKCXJldHVy
biByYzsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qICBBRVMtMjU2LUdDTSBpbWFnZSBlbmNyeXB0aW9u
IC8gZGVjcnlwdGlvbiAgICAgICAgICAgICAgICAgICAgICAgICAqLwovKiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8K
Ci8qKgogKiBzdHJ1Y3Qgc25hcGVuY19jdHggLSBQZXItaGliZXJuYXRlIGVuY3J5cHRpb24gY29u
dGV4dC4KICoKICogQWxsb2NhdGVkIGF0IGhpYmVybmF0ZSB0aW1lLCBmcmVlZCBhZnRlciByZXN1
bWUgb3Igb24gZXJyb3IuCiAqLwpzdHJ1Y3Qgc25hcGVuY19jdHggewoJLyogQUVTLTI1Ni1HQ00g
dHJhbnNmb3JtICovCglzdHJ1Y3QgY3J5cHRvX2FlYWQgICAgICAqdGZtOwoKCS8qIFJhbmRvbSBr
ZXksIHNlYWxlZCB0byBUUE0gYXQgaGliZXJuYXRlIHRpbWUgKi8KCXU4ICAgICAgICAgICAgICAg
ICAgICAgICBrZXlbU05BUEVOQ19LRVlfU0laRV07CglzdHJ1Y3Qgc25hcGVuY19zZWFsZWRfa2V5
IHNlYWxlZDsKCgkvKiBQZXItY2h1bmsgSVY6IDk2LWJpdCwgaW5jcmVtZW50ZWQgZm9yIGVhY2gg
Y2h1bmsgKi8KCXU4ICAgICAgICAgICAgICAgICAgICAgICBpdltTTkFQRU5DX0lWX1NJWkVdOwoK
CS8qIFRlbXBvcmFyeSBidWZmZXIgZm9yIG9uZSBjaHVuayAqLwoJdTggICAgICAgICAgICAgICAg
ICAgICAgKmNodW5rX2J1ZjsKCXNpemVfdCAgICAgICAgICAgICAgICAgICBjaHVua19idWZfc2l6
ZTsKCgkvKiBBY2N1bXVsYXRlZCBTSEEtMjU2IG92ZXIgYWxsIGVuY3J5cHRlZCBjaHVua3MgKGV4
dHJhIGludGVncml0eSkgKi8KCXN0cnVjdCBzaGFzaF9kZXNjICAgICAgICppbWFnZV9oYXNoOwoJ
dTggICAgICAgICAgICAgICAgICAgICAgIGltYWdlX2RpZ2VzdFtTSEEyNTZfRElHRVNUX1NJWkVd
Owp9OwoKc3RhdGljIHN0cnVjdCBzbmFwZW5jX2N0eCAqaGliZXJuYXRlX2VuY19jdHg7CgovKioK
ICogc25hcGVuY19jdHhfYWxsb2MgLSBBbGxvY2F0ZSBhbmQgaW5pdGlhbGl6ZSBhbiBlbmNyeXB0
aW9uIGNvbnRleHQuCiAqCiAqIEdlbmVyYXRlcyBhIGZyZXNoIHJhbmRvbSBrZXksIHNldHMgdXAg
dGhlIEFFQUQgdHJhbnNmb3JtLCBhbmQKICogcHJlcGFyZXMgdGhlIHBlci1pbWFnZSBTSEEtMjU2
IGFjY3VtdWxhdG9yLgogKgogKiBSZXR1cm5zIGEgbmV3IGNvbnRleHQgb24gc3VjY2VzcywgRVJS
X1BUUiBvbiBmYWlsdXJlLgogKi8Kc3RhdGljIHN0cnVjdCBzbmFwZW5jX2N0eCAqc25hcGVuY19j
dHhfYWxsb2Modm9pZCkKewoJc3RydWN0IHNuYXBlbmNfY3R4ICpjdHg7CglpbnQgcmM7CgoJY3R4
ID0ga3phbGxvYyhzaXplb2YoKmN0eCksIEdGUF9LRVJORUwpOwoJaWYgKCFjdHgpCgkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7CgoJLyogQWxsb2NhdGUgY2h1bmsgYnVmZmVyICovCgljdHgtPmNo
dW5rX2J1Zl9zaXplID0gU05BUEVOQ19DSFVOS19TSVpFICsgU05BUEVOQ19UQUdfU0laRTsKCWN0
eC0+Y2h1bmtfYnVmID0gdm1hbGxvYyhjdHgtPmNodW5rX2J1Zl9zaXplKTsKCWlmICghY3R4LT5j
aHVua19idWYpIHsKCQlyYyA9IC1FTk9NRU07CgkJZ290byBlcnJfZnJlZV9jdHg7Cgl9CgoJLyog
U2V0IHVwIEFFUy0yNTYtR0NNIHRyYW5zZm9ybSAqLwoJY3R4LT50Zm0gPSBjcnlwdG9fYWxsb2Nf
YWVhZCgiZ2NtKGFlcykiLCAwLCAwKTsKCWlmIChJU19FUlIoY3R4LT50Zm0pKSB7CgkJcmMgPSBQ
VFJfRVJSKGN0eC0+dGZtKTsKCQlwcl9lcnIoInNuYXBlbmM6IGZhaWxlZCB0byBhbGxvYyBBRVMt
R0NNOiAlZFxuIiwgcmMpOwoJCWdvdG8gZXJyX2ZyZWVfYnVmOwoJfQoKCXJjID0gY3J5cHRvX2Fl
YWRfc2V0YXV0aHNpemUoY3R4LT50Zm0sIFNOQVBFTkNfVEFHX1NJWkUpOwoJaWYgKHJjKSB7CgkJ
cHJfZXJyKCJzbmFwZW5jOiBmYWlsZWQgdG8gc2V0IHRhZyBzaXplOiAlZFxuIiwgcmMpOwoJCWdv
dG8gZXJyX2ZyZWVfdGZtOwoJfQoKCS8qIEdlbmVyYXRlIGZyZXNoIHJhbmRvbSBrZXkgZm9yIHRo
aXMgaGliZXJuYXRlIGltYWdlICovCglnZXRfcmFuZG9tX2J5dGVzKGN0eC0+a2V5LCBTTkFQRU5D
X0tFWV9TSVpFKTsKCglyYyA9IGNyeXB0b19hZWFkX3NldGtleShjdHgtPnRmbSwgY3R4LT5rZXks
IFNOQVBFTkNfS0VZX1NJWkUpOwoJaWYgKHJjKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBmYWlsZWQg
dG8gc2V0IEFFUyBrZXk6ICVkXG4iLCByYyk7CgkJZ290byBlcnJfZnJlZV90Zm07Cgl9CgoJLyog
UmFuZG9tIElWIGJhc2U7IHdpbGwgYmUgaW5jcmVtZW50ZWQgcGVyIGNodW5rICovCglnZXRfcmFu
ZG9tX2J5dGVzKGN0eC0+aXYsIFNOQVBFTkNfSVZfU0laRSk7CgoJLyogU2V0IHVwIGltYWdlLWxl
dmVsIFNIQS0yNTYgYWNjdW11bGF0b3IgKi8KCWN0eC0+aW1hZ2VfaGFzaCA9IGt6YWxsb2Moc2l6
ZW9mKCpjdHgtPmltYWdlX2hhc2gpICsKCQkJCSAgY3J5cHRvX3NoYXNoX2Rlc2NzaXplKAoJCQkJ
ICAgIGNyeXB0b19hbGxvY19zaGFzaCgic2hhMjU2IiwgMCwgMCkpLAoJCQkJICBHRlBfS0VSTkVM
KTsKCWlmICghY3R4LT5pbWFnZV9oYXNoKSB7CgkJcmMgPSAtRU5PTUVNOwoJCWdvdG8gZXJyX2Zy
ZWVfdGZtOwoJfQoJY3R4LT5pbWFnZV9oYXNoLT50Zm0gPSBjcnlwdG9fYWxsb2Nfc2hhc2goInNo
YTI1NiIsIDAsIDApOwoJaWYgKElTX0VSUihjdHgtPmltYWdlX2hhc2gtPnRmbSkpIHsKCQlyYyA9
IFBUUl9FUlIoY3R4LT5pbWFnZV9oYXNoLT50Zm0pOwoJCWdvdG8gZXJyX2ZyZWVfaGFzaF9kZXNj
OwoJfQoKCXJjID0gY3J5cHRvX3NoYXNoX2luaXQoY3R4LT5pbWFnZV9oYXNoKTsKCWlmIChyYykK
CQlnb3RvIGVycl9mcmVlX2hhc2hfdGZtOwoKCXJldHVybiBjdHg7CgplcnJfZnJlZV9oYXNoX3Rm
bToKCWNyeXB0b19mcmVlX3NoYXNoKGN0eC0+aW1hZ2VfaGFzaC0+dGZtKTsKZXJyX2ZyZWVfaGFz
aF9kZXNjOgoJa2ZyZWUoY3R4LT5pbWFnZV9oYXNoKTsKZXJyX2ZyZWVfdGZtOgoJY3J5cHRvX2Zy
ZWVfYWVhZChjdHgtPnRmbSk7CmVycl9mcmVlX2J1ZjoKCXZmcmVlKGN0eC0+Y2h1bmtfYnVmKTsK
ZXJyX2ZyZWVfY3R4OgoJLyogWmVybyB0aGUga2V5IG1hdGVyaWFsIGJlZm9yZSBmcmVlaW5nICov
CgltZW16ZXJvX2V4cGxpY2l0KGN0eC0+a2V5LCBTTkFQRU5DX0tFWV9TSVpFKTsKCWtmcmVlKGN0
eCk7CglyZXR1cm4gRVJSX1BUUihyYyk7Cn0KCi8qKgogKiBzbmFwZW5jX2N0eF9mcmVlIC0gRnJl
ZSBhbiBlbmNyeXB0aW9uIGNvbnRleHQsIHplcm9pbmcga2V5IG1hdGVyaWFsLgogKi8Kc3RhdGlj
IHZvaWQgc25hcGVuY19jdHhfZnJlZShzdHJ1Y3Qgc25hcGVuY19jdHggKmN0eCkKewoJaWYgKCFj
dHgpCgkJcmV0dXJuOwoKCWlmIChjdHgtPmltYWdlX2hhc2gpIHsKCQljcnlwdG9fZnJlZV9zaGFz
aChjdHgtPmltYWdlX2hhc2gtPnRmbSk7CgkJa2ZyZWUoY3R4LT5pbWFnZV9oYXNoKTsKCX0KCWlm
IChjdHgtPnRmbSkKCQljcnlwdG9fZnJlZV9hZWFkKGN0eC0+dGZtKTsKCXZmcmVlKGN0eC0+Y2h1
bmtfYnVmKTsKCW1lbXplcm9fZXhwbGljaXQoY3R4LT5rZXksIFNOQVBFTkNfS0VZX1NJWkUpOwoJ
bWVtemVyb19leHBsaWNpdCgmY3R4LT5zZWFsZWQsIHNpemVvZihjdHgtPnNlYWxlZCkpOwoJa2Zy
ZWUoY3R4KTsKfQoKLyoqCiAqIHNuYXBlbmNfZW5jcnlwdF9jaHVuayAtIEVuY3J5cHQgb25lIGNo
dW5rIG9mIHRoZSBoaWJlcm5hdGUgaW1hZ2UuCiAqCiAqIFVzZXMgQUVTLTI1Ni1HQ00uIFRoZSBJ
ViBpcyBpbmNyZW1lbnRlZCBhZnRlciBlYWNoIGNodW5rIHNvIHRoYXQKICogZWFjaCBjaHVuayBo
YXMgYSB1bmlxdWUgbm9uY2UuIFRoZSBjaHVuayBpbmRleCBpcyBpbmNsdWRlZCBhcwogKiBBZGRp
dGlvbmFsIEF1dGhlbnRpY2F0ZWQgRGF0YSAoQUFEKSB0byBwcmV2ZW50IGNodW5rIHJlb3JkZXJp
bmcuCiAqCiAqIEBjdHg6ICAgICAgICBFbmNyeXB0aW9uIGNvbnRleHQKICogQGluOiAgICAgICAg
IFBsYWludGV4dCBpbnB1dAogKiBAaW5fbGVuOiAgICAgTGVuZ3RoIG9mIHBsYWludGV4dAogKiBA
b3V0OiAgICAgICAgT3V0cHV0IChjaXBoZXJ0ZXh0ICsgMTYtYnl0ZSBHQ00gdGFnIGFwcGVuZGVk
KQogKiBAY2h1bmtfaWR4OiAgQ2h1bmsgaW5kZXggKHVzZWQgYXMgQUFEKQogKgogKiBSZXR1cm5z
IG51bWJlciBvZiBvdXRwdXQgYnl0ZXMgb24gc3VjY2VzcywgbmVnYXRpdmUgb24gZXJyb3IuCiAq
LwpzdGF0aWMgc3NpemVfdCBzbmFwZW5jX2VuY3J5cHRfY2h1bmsoc3RydWN0IHNuYXBlbmNfY3R4
ICpjdHgsCgkJCQkgICAgIGNvbnN0IHU4ICppbiwgc2l6ZV90IGluX2xlbiwKCQkJCSAgICAgdTgg
Km91dCwgdTY0IGNodW5rX2lkeCkKewoJc3RydWN0IGFlYWRfcmVxdWVzdCAqcmVxOwoJc3RydWN0
IHNjYXR0ZXJsaXN0IHNnX2luLCBzZ19vdXQ7Cgl1OCBhYWRbOF07CglzdHJ1Y3Qgc2NhdHRlcmxp
c3Qgc2dfYWFkOwoJREVDTEFSRV9DUllQVE9fV0FJVCh3YWl0KTsKCWludCByYzsKCgkvKiBBQUQg
PSBiaWctZW5kaWFuIGNodW5rIGluZGV4LCBwcmV2ZW50cyBjaHVuayByZW9yZGVyaW5nIGF0dGFj
a3MgKi8KCXB1dF91bmFsaWduZWRfYmU2NChjaHVua19pZHgsIGFhZCk7CgoJcmVxID0gYWVhZF9y
ZXF1ZXN0X2FsbG9jKGN0eC0+dGZtLCBHRlBfS0VSTkVMKTsKCWlmICghcmVxKQoJCXJldHVybiAt
RU5PTUVNOwoKCXNnX2luaXRfb25lKCZzZ19pbiwgIGluLCAgaW5fbGVuKTsKCXNnX2luaXRfb25l
KCZzZ19vdXQsIG91dCwgaW5fbGVuICsgU05BUEVOQ19UQUdfU0laRSk7CglzZ19pbml0X29uZSgm
c2dfYWFkLCBhYWQsIHNpemVvZihhYWQpKTsKCglhZWFkX3JlcXVlc3Rfc2V0X2NhbGxiYWNrKHJl
cSwgQ1JZUFRPX1RGTV9SRVFfTUFZX0JBQ0tMT0csCgkJCQkgIGNyeXB0b19yZXFfZG9uZSwgJndh
aXQpOwoJYWVhZF9yZXF1ZXN0X3NldF9hZChyZXEsIHNpemVvZihhYWQpKTsKCWFlYWRfcmVxdWVz
dF9zZXRfY3J5cHQocmVxLCAmc2dfaW4sICZzZ19vdXQsIGluX2xlbiwgY3R4LT5pdik7CgoJcmMg
PSBjcnlwdG9fd2FpdF9yZXEoY3J5cHRvX2FlYWRfZW5jcnlwdChyZXEpLCAmd2FpdCk7CglhZWFk
X3JlcXVlc3RfZnJlZShyZXEpOwoKCWlmIChyYykgewoJCXByX2Vycigic25hcGVuYzogQUVTLUdD
TSBlbmNyeXB0IGZhaWxlZDogJWRcbiIsIHJjKTsKCQlyZXR1cm4gcmM7Cgl9CgoJLyogVXBkYXRl
IGltYWdlLWxldmVsIGhhc2ggd2l0aCB0aGlzIGNpcGhlcnRleHQgY2h1bmsgKi8KCWNyeXB0b19z
aGFzaF91cGRhdGUoY3R4LT5pbWFnZV9oYXNoLCBvdXQsIGluX2xlbiArIFNOQVBFTkNfVEFHX1NJ
WkUpOwoKCS8qIEluY3JlbWVudCBJViAodHJlYXQgYXMgbGl0dGxlLWVuZGlhbiBjb3VudGVyLCBs
YXN0IDQgYnl0ZXMpICovCglsZTMyX2FkZF9jcHUoKF9fbGUzMiAqKShjdHgtPml2ICsgOCksIDEp
OwoKCXJldHVybiBpbl9sZW4gKyBTTkFQRU5DX1RBR19TSVpFOwp9CgovKioKICogc25hcGVuY19k
ZWNyeXB0X2NodW5rIC0gRGVjcnlwdCBhbmQgdmVyaWZ5IG9uZSBjaHVuayBvZiB0aGUgaGliZXJu
YXRlIGltYWdlLgogKgogKiBBRVMtMjU2LUdDTSBkZWNyeXB0aW9uLiBJZiB0aGUgYXV0aGVudGlj
YXRpb24gdGFnIGRvZXNuJ3QgbWF0Y2gKICogKGltYWdlIHdhcyB0YW1wZXJlZCksIHJldHVybnMg
LUVCQURNU0cgYW5kIHJlc3VtZSBpcyBhYm9ydGVkLgogKgogKiBAY3R4OiAgICAgICAgRW5jcnlw
dGlvbiBjb250ZXh0CiAqIEBpbjogICAgICAgICBDaXBoZXJ0ZXh0IGlucHV0IChpbmNsdWRpbmcg
YXBwZW5kZWQgR0NNIHRhZykKICogQGluX2xlbjogICAgIExlbmd0aCBpbmNsdWRpbmcgdGFnCiAq
IEBvdXQ6ICAgICAgICBPdXRwdXQgcGxhaW50ZXh0CiAqIEBjaHVua19pZHg6ICBDaHVuayBpbmRl
eCAobXVzdCBtYXRjaCB3aGF0IHdhcyB1c2VkIGR1cmluZyBlbmNyeXB0aW9uKQogKgogKiBSZXR1
cm5zIHBsYWludGV4dCBsZW5ndGggb24gc3VjY2VzcywgLUVCQURNU0cgaWYgdGFnIGZhaWxzLCBu
ZWdhdGl2ZSBvbiBlcnJvci4KICovCnN0YXRpYyBzc2l6ZV90IHNuYXBlbmNfZGVjcnlwdF9jaHVu
ayhzdHJ1Y3Qgc25hcGVuY19jdHggKmN0eCwKCQkJCSAgICAgY29uc3QgdTggKmluLCBzaXplX3Qg
aW5fbGVuLAoJCQkJICAgICB1OCAqb3V0LCB1NjQgY2h1bmtfaWR4KQp7CglzdHJ1Y3QgYWVhZF9y
ZXF1ZXN0ICpyZXE7CglzdHJ1Y3Qgc2NhdHRlcmxpc3Qgc2dfaW4sIHNnX291dDsKCXU4IGFhZFs4
XTsKCXN0cnVjdCBzY2F0dGVybGlzdCBzZ19hYWQ7CglERUNMQVJFX0NSWVBUT19XQUlUKHdhaXQp
OwoJaW50IHJjOwoJc2l6ZV90IHBsYWludGV4dF9sZW4gPSBpbl9sZW4gLSBTTkFQRU5DX1RBR19T
SVpFOwoKCXB1dF91bmFsaWduZWRfYmU2NChjaHVua19pZHgsIGFhZCk7CgoJcmVxID0gYWVhZF9y
ZXF1ZXN0X2FsbG9jKGN0eC0+dGZtLCBHRlBfS0VSTkVMKTsKCWlmICghcmVxKQoJCXJldHVybiAt
RU5PTUVNOwoKCXNnX2luaXRfb25lKCZzZ19pbiwgIGluLCAgaW5fbGVuKTsKCXNnX2luaXRfb25l
KCZzZ19vdXQsIG91dCwgcGxhaW50ZXh0X2xlbik7CglzZ19pbml0X29uZSgmc2dfYWFkLCBhYWQs
IHNpemVvZihhYWQpKTsKCglhZWFkX3JlcXVlc3Rfc2V0X2NhbGxiYWNrKHJlcSwgQ1JZUFRPX1RG
TV9SRVFfTUFZX0JBQ0tMT0csCgkJCQkgIGNyeXB0b19yZXFfZG9uZSwgJndhaXQpOwoJYWVhZF9y
ZXF1ZXN0X3NldF9hZChyZXEsIHNpemVvZihhYWQpKTsKCWFlYWRfcmVxdWVzdF9zZXRfY3J5cHQo
cmVxLCAmc2dfaW4sICZzZ19vdXQsIGluX2xlbiwgY3R4LT5pdik7CgoJcmMgPSBjcnlwdG9fd2Fp
dF9yZXEoY3J5cHRvX2FlYWRfZGVjcnlwdChyZXEpLCAmd2FpdCk7CglhZWFkX3JlcXVlc3RfZnJl
ZShyZXEpOwoKCWlmIChyYyA9PSAtRUJBRE1TRykgewoJCXByX2NyaXQoInNuYXBlbmM6IEFVVEhF
TlRJQ0FUSU9OIEZBSUxVUkUgb24gY2h1bmsgJWxsdSDigJQgIgoJCQkiaGliZXJuYXRlIGltYWdl
IGhhcyBiZWVuIHRhbXBlcmVkIHdpdGguICIKCQkJIlJlc3VtZSBhYm9ydGVkLlxuIiwgY2h1bmtf
aWR4KTsKCQlyZXR1cm4gLUVCQURNU0c7Cgl9CglpZiAocmMpIHsKCQlwcl9lcnIoInNuYXBlbmM6
IEFFUy1HQ00gZGVjcnlwdCBmYWlsZWQ6ICVkXG4iLCByYyk7CgkJcmV0dXJuIHJjOwoJfQoKCWxl
MzJfYWRkX2NwdSgoX19sZTMyICopKGN0eC0+aXYgKyA4KSwgMSk7CglyZXR1cm4gcGxhaW50ZXh0
X2xlbjsKfQoKLyogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tICovCi8qICBIaWJlcm5hdGUgLyByZXN1bWUgZW50cnkgcG9p
bnRzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8KLyogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICov
CgovKioKICogc25hcGVuY19oaWJlcm5hdGVfYmVnaW4gLSBDYWxsZWQgYmVmb3JlIHdyaXRpbmcg
dGhlIGhpYmVybmF0ZSBpbWFnZS4KICoKICogU2VxdWVuY2U6CiAqICAxLiBWZXJpZnkgUENSMjMg
aXMgemVybyAob3IgcmVzZXQgdG8gemVybykKICogIDIuIEV4dGVuZCBQQ1IyMyB3aXRoIG91ciBt
YWdpYyB2YWx1ZQogKiAgMy4gR2VuZXJhdGUgcmFuZG9tIEFFUyBrZXkKICogIDQuIFNlYWwgdGhl
IGtleSB0byBUUE0gKGJvdW5kIHRvIGN1cnJlbnQgUENSMjMgc3RhdGUpCiAqICA1LiBSZXNldCBQ
Q1IyMyB0byB6ZXJvCiAqICA2LiBSZXR1cm4gKGltYWdlIHdyaXRpbmcgcHJvY2VlZHMgd2l0aCBz
bmFwZW5jX2VuY3J5cHRfY2h1bmspCiAqCiAqIEFmdGVyIHRoaXMgZnVuY3Rpb24sIGFuIGF0dGFj
a2VyIHdobyBtb2RpZmllcyB0aGUgaW1hZ2Ugb24gZGlzawogKiBjYW5ub3QgcmVzdW1lOiB0aGUg
R0NNIHRhZyB3aWxsIGZhaWwuIEFuIGF0dGFja2VyIHdobyBtb2RpZmllcwogKiBQQ1IyMyBjYW5u
b3QgZ2V0IHRoZSBrZXkgZnJvbSB0aGUgVFBNLgogKgogKiBSZXR1cm5zIDAgb24gc3VjY2Vzcywg
bmVnYXRpdmUgb24gZXJyb3IgKGhpYmVybmF0ZSBpcyBhYm9ydGVkKS4KICovCmludCBzbmFwZW5j
X2hpYmVybmF0ZV9iZWdpbih2b2lkKQp7CglzdHJ1Y3QgdHBtX2NoaXAgKmNoaXA7CglzdHJ1Y3Qg
c25hcGVuY19jdHggKmN0eDsKCWludCByYzsKCgljaGlwID0gdHBtX2RlZmF1bHRfY2hpcCgpOwoJ
aWYgKCFjaGlwKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBubyBUUE0gY2hpcCBhdmFpbGFibGVcbiIp
OwoJCXJldHVybiAtRU5PREVWOwoJfQoKCWN0eCA9IHNuYXBlbmNfY3R4X2FsbG9jKCk7CglpZiAo
SVNfRVJSKGN0eCkpIHsKCQlyYyA9IFBUUl9FUlIoY3R4KTsKCQlnb3RvIG91dF9wdXRfY2hpcDsK
CX0KCgkvKiBTdGVwIDE6IFZlcmlmeS9yZXNldCBQQ1IyMyAqLwoJcmMgPSBzbmFwZW5jX3Bjcl9p
c196ZXJvKGNoaXApOwoJaWYgKHJjKSB7CgkJLyoKCQkgKiBQQ1IyMyBub3QgemVyby4gQ291bGQg
bWVhbjoKCQkgKiAgKGEpIFdlIGxlZnQgaXQgZXh0ZW5kZWQgZnJvbSBhIHByZXZpb3VzIChmYWls
ZWQpIGhpYmVybmF0ZQoJCSAqICAoYikgQW5vdGhlciBhZ2VudCBpcyB1c2luZyBpdAoJCSAqIEF0
dGVtcHQgYSByZXNldCBhbmQgcmV0cnkuCgkJICovCgkJcHJfd2Fybigic25hcGVuYzogUENSJWQg
bm90IHplcm8sIGF0dGVtcHRpbmcgcmVzZXRcbiIsCgkJCWhpYmVybmF0ZV90cG1fcGNyKTsKCQly
YyA9IHNuYXBlbmNfcGNyX3Jlc2V0KGNoaXApOwoJCWlmIChyYykgewoJCQlwcl9lcnIoInNuYXBl
bmM6IFBDUiVkIHJlc2V0IGZhaWxlZDogJWRcbiIsCgkJCSAgICAgICBoaWJlcm5hdGVfdHBtX3Bj
ciwgcmMpOwoJCQlnb3RvIG91dF9mcmVlX2N0eDsKCQl9CgkJcmMgPSBzbmFwZW5jX3Bjcl9pc196
ZXJvKGNoaXApOwoJCWlmIChyYykKCQkJZ290byBvdXRfZnJlZV9jdHg7Cgl9CgoJLyogU3RlcCAy
OiBFeHRlbmQgUENSMjMgd2l0aCBvdXIgbWFnaWMgdmFsdWUgKi8KCXJjID0gc25hcGVuY19wY3Jf
ZXh0ZW5kKGNoaXApOwoJaWYgKHJjKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBQQ1IlZCBleHRlbmQg
ZmFpbGVkOiAlZFxuIiwKCQkgICAgICAgaGliZXJuYXRlX3RwbV9wY3IsIHJjKTsKCQlnb3RvIG91
dF9yZXNldF9wY3I7Cgl9CgoJLyogU3RlcCAzKzQ6IFNlYWwgdGhlIGVuY3J5cHRpb24ga2V5IHRv
IHRoZSBjdXJyZW50IFBDUiBzdGF0ZSAqLwoJcmMgPSBzbmFwZW5jX3NlYWxfa2V5KGNoaXAsIGN0
eC0+a2V5LCAmY3R4LT5zZWFsZWQpOwoJaWYgKHJjKSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBrZXkg
c2VhbCBmYWlsZWQ6ICVkXG4iLCByYyk7CgkJZ290byBvdXRfcmVzZXRfcGNyOwoJfQoKCS8qIFN0
ZXAgNTogUmVzZXQgUENSMjMg4oCUIGtleSBpcyBub3cgbG9ja2VkIGluIHRoZSBzZWFsZWQgYmxv
YiAqLwoJcmMgPSBzbmFwZW5jX3Bjcl9yZXNldChjaGlwKTsKCWlmIChyYykgewoJCXByX2Vycigi
c25hcGVuYzogUENSJWQgZmluYWwgcmVzZXQgZmFpbGVkOiAlZFxuIiwKCQkgICAgICAgaGliZXJu
YXRlX3RwbV9wY3IsIHJjKTsKCQkvKgoJCSAqIE5vdCBmYXRhbCBmb3Igc2VjdXJpdHkg4oCUIHRo
ZSBzZWFsZWQgYmxvYiBzdGlsbCByZXF1aXJlcwoJCSAqIHRoZSBQQ1IgdG8gYmUgaW4gdGhlIGV4
dGVuZGVkIHN0YXRlIHRvIHVuc2VhbC4gQnV0IGxvZyBpdC4KCQkgKi8KCQlwcl93YXJuKCJzbmFw
ZW5jOiBQQ1IlZCBsZWZ0IGluIGV4dGVuZGVkIHN0YXRlXG4iLAoJCQloaWJlcm5hdGVfdHBtX3Bj
cik7Cgl9CgoJaGliZXJuYXRlX2VuY19jdHggPSBjdHg7Cglwcl9pbmZvKCJzbmFwZW5jOiBoaWJl
cm5hdGUgaW1hZ2Ugd2lsbCBiZSBlbmNyeXB0ZWQgYW5kIGF1dGhlbnRpY2F0ZWRcbiIpOwoJdHBt
X3B1dF9jaGlwKGNoaXApOwoJcmV0dXJuIDA7CgpvdXRfcmVzZXRfcGNyOgoJc25hcGVuY19wY3Jf
cmVzZXQoY2hpcCk7Cm91dF9mcmVlX2N0eDoKCXNuYXBlbmNfY3R4X2ZyZWUoY3R4KTsKb3V0X3B1
dF9jaGlwOgoJdHBtX3B1dF9jaGlwKGNoaXApOwoJcmV0dXJuIHJjOwp9CgovKioKICogc25hcGVu
Y19oaWJlcm5hdGVfZW5kIC0gQ2FsbGVkIGFmdGVyIHdyaXRpbmcgdGhlIGhpYmVybmF0ZSBpbWFn
ZS4KICoKICogRmluYWxpemVzIHRoZSBpbWFnZS1sZXZlbCBTSEEtMjU2IGhhc2ggYW5kIHdyaXRl
cyBpdCB0byB0aGUgaW1hZ2UKICogaGVhZGVyIHNvIHJlc3VtZSBjYW4gZG8gYSBmYXN0IGludGVn
cml0eSBjaGVjayBiZWZvcmUgYXR0ZW1wdGluZwogKiBUUE0gdW5zZWFsIChkZWZlbnNlIGluIGRl
cHRoKS4KICovCnZvaWQgc25hcGVuY19oaWJlcm5hdGVfZW5kKHZvaWQpCnsKCXN0cnVjdCBzbmFw
ZW5jX2N0eCAqY3R4ID0gaGliZXJuYXRlX2VuY19jdHg7CgoJaWYgKCFjdHgpCgkJcmV0dXJuOwoK
CS8qIEZpbmFsaXplIGltYWdlLWxldmVsIGhhc2ggKi8KCWNyeXB0b19zaGFzaF9maW5hbChjdHgt
PmltYWdlX2hhc2gsIGN0eC0+aW1hZ2VfZGlnZXN0KTsKCglwcl9pbmZvKCJzbmFwZW5jOiBoaWJl
cm5hdGUgaW1hZ2UgZW5jcnlwdGlvbiBjb21wbGV0ZVxuIik7Cglwcl9kZWJ1Zygic25hcGVuYzog
aW1hZ2UgU0hBLTI1NjogJSpwaE5cbiIsCgkJIFNIQTI1Nl9ESUdFU1RfU0laRSwgY3R4LT5pbWFn
ZV9kaWdlc3QpOwoKCS8qIERvbid0IGZyZWUgY3R4IGhlcmUg4oCUIHJlc3VtZSBuZWVkcyB0aGUg
c2VhbGVkIGtleSAqLwp9CgovKioKICogc25hcGVuY19yZXN1bWVfYmVnaW4gLSBDYWxsZWQgYmVm
b3JlIHJlYWRpbmcgdGhlIGhpYmVybmF0ZSBpbWFnZS4KICoKICogU2VxdWVuY2U6CiAqICAxLiBF
eHRlbmQgUENSMjMgd2l0aCB0aGUgc2FtZSBtYWdpYyB2YWx1ZSB1c2VkIGR1cmluZyBoaWJlcm5h
dGUKICogIDIuIEFzayBUUE0gdG8gdW5zZWFsIHRoZSBrZXkgKHdpbGwgZmFpbCBpZiBQQ1IgZG9l
c24ndCBtYXRjaCkKICogIDMuIFJlLWluaXRpYWxpemUgQUVTLUdDTSB3aXRoIHRoZSB1bnNlYWxl
ZCBrZXkKICogIDQuIFJlc2V0IFBDUjIzCiAqCiAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCAtRUFD
Q0VTIGlmIFRQTSBwb2xpY3kgZmFpbHMgKGltYWdlIHRhbXBlcmVkCiAqIG9yIHdyb25nIHN5c3Rl
bSksIG5lZ2F0aXZlIG9uIG90aGVyIGVycm9ycy4KICovCmludCBzbmFwZW5jX3Jlc3VtZV9iZWdp
bih2b2lkKQp7CglzdHJ1Y3QgdHBtX2NoaXAgKmNoaXA7CglzdHJ1Y3Qgc25hcGVuY19jdHggKmN0
eCA9IGhpYmVybmF0ZV9lbmNfY3R4OwoJdTggdW5zZWFsZWRfa2V5W1NOQVBFTkNfS0VZX1NJWkVd
OwoJaW50IHJjOwoKCWlmICghY3R4KSB7CgkJcHJfZXJyKCJzbmFwZW5jOiBubyBlbmNyeXB0aW9u
IGNvbnRleHQgZm9yIHJlc3VtZVxuIik7CgkJcmV0dXJuIC1FSU5WQUw7Cgl9CgoJY2hpcCA9IHRw
bV9kZWZhdWx0X2NoaXAoKTsKCWlmICghY2hpcCkgewoJCXByX2Vycigic25hcGVuYzogbm8gVFBN
IGNoaXAgYXZhaWxhYmxlIGZvciByZXN1bWVcbiIpOwoJCXJldHVybiAtRU5PREVWOwoJfQoKCS8q
IFN0ZXAgMTogRXh0ZW5kIFBDUjIzIOKAlCBtdXN0IG1hdGNoIHN0YXRlIGF0IHNlYWwgdGltZSAq
LwoJcmMgPSBzbmFwZW5jX3Bjcl9leHRlbmQoY2hpcCk7CglpZiAocmMpIHsKCQlwcl9lcnIoInNu
YXBlbmM6IHJlc3VtZSBQQ1IlZCBleHRlbmQgZmFpbGVkOiAlZFxuIiwKCQkgICAgICAgaGliZXJu
YXRlX3RwbV9wY3IsIHJjKTsKCQlnb3RvIG91dDsKCX0KCgkvKiBTdGVwIDI6IFVuc2VhbCBrZXkg
4oCUIFRQTSBjaGVja3MgUENSMjMgbWF0Y2hlcyBwb2xpY3kgKi8KCXJjID0gc25hcGVuY191bnNl
YWxfa2V5KGNoaXAsICZjdHgtPnNlYWxlZCwgdW5zZWFsZWRfa2V5KTsKCWlmIChyYyA9PSAtRUFD
Q0VTKSB7CgkJcHJfY3JpdCgic25hcGVuYzogVFBNIFJFRlVTRUQgdG8gcmVsZWFzZSBoaWJlcm5h
dGUga2V5LlxuIgoJCQkiUENSJWQgc3RhdGUgZG9lcyBub3QgbWF0Y2ggc2VhbC10aW1lIHBvbGlj
eS5cbiIKCQkJIlRoaXMgbWF5IGluZGljYXRlOiB3cm9uZyBzeXN0ZW0sIGZpcm13YXJlIGNoYW5n
ZSwgIgoJCQkib3IgdGhlIGhpYmVybmF0ZSBpbWFnZSB3YXMgY3JlYXRlZCBvbiBhIGRpZmZlcmVu
dCBib290LlxuIgoJCQkiUmVzdW1lIGFib3J0ZWQgZm9yIHNlY3VyaXR5LlxuIiwKCQkJaGliZXJu
YXRlX3RwbV9wY3IpOwoJCWdvdG8gb3V0X3Jlc2V0X3BjcjsKCX0KCWlmIChyYykgewoJCXByX2Vy
cigic25hcGVuYzoga2V5IHVuc2VhbCBmYWlsZWQ6ICVkXG4iLCByYyk7CgkJZ290byBvdXRfcmVz
ZXRfcGNyOwoJfQoKCS8qIFN0ZXAgMzogUmUtYXJtIHRoZSBBRVMgdHJhbnNmb3JtIHdpdGggdGhl
IHVuc2VhbGVkIGtleSAqLwoJcmMgPSBjcnlwdG9fYWVhZF9zZXRrZXkoY3R4LT50Zm0sIHVuc2Vh
bGVkX2tleSwgU05BUEVOQ19LRVlfU0laRSk7CgltZW16ZXJvX2V4cGxpY2l0KHVuc2VhbGVkX2tl
eSwgU05BUEVOQ19LRVlfU0laRSk7CglpZiAocmMpIHsKCQlwcl9lcnIoInNuYXBlbmM6IGZhaWxl
ZCB0byByZXN0b3JlIEFFUyBrZXk6ICVkXG4iLCByYyk7CgkJZ290byBvdXRfcmVzZXRfcGNyOwoJ
fQoKCS8qIFN0ZXAgNDogUmVzZXQgUENSMjMgKi8KCXNuYXBlbmNfcGNyX3Jlc2V0KGNoaXApOwoK
CXByX2luZm8oInNuYXBlbmM6IFRQTSBrZXkgdW5zZWFsIHN1Y2Nlc3NmdWwsIHJlc3VtaW5nXG4i
KTsKCXRwbV9wdXRfY2hpcChjaGlwKTsKCXJldHVybiAwOwoKb3V0X3Jlc2V0X3BjcjoKCXNuYXBl
bmNfcGNyX3Jlc2V0KGNoaXApOwpvdXQ6CgltZW16ZXJvX2V4cGxpY2l0KHVuc2VhbGVkX2tleSwg
U05BUEVOQ19LRVlfU0laRSk7Cgl0cG1fcHV0X2NoaXAoY2hpcCk7CglyZXR1cm4gcmM7Cn0KCi8q
KgogKiBzbmFwZW5jX3Jlc3VtZV9lbmQgLSBDYWxsZWQgYWZ0ZXIgc3VjY2Vzc2Z1bCByZXN1bWUu
CiAqCiAqIENsZWFucyB1cCB0aGUgZW5jcnlwdGlvbiBjb250ZXh0LgogKi8Kdm9pZCBzbmFwZW5j
X3Jlc3VtZV9lbmQodm9pZCkKewoJc25hcGVuY19jdHhfZnJlZShoaWJlcm5hdGVfZW5jX2N0eCk7
CgloaWJlcm5hdGVfZW5jX2N0eCA9IE5VTEw7Cn0KCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAqLwovKiAgTW9kdWxl
IGluaXQ6IHZlcmlmeSBUUE0gYXZhaWxhYmlsaXR5IGFuZCBQQ1Igc3RhdGUgICAgICAgICAgICAg
ICAgICovCi8qIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSAqLwoKc3RhdGljIGludCBfX2luaXQgc25hcGVuY19pbml0KHZv
aWQpCnsKCXN0cnVjdCB0cG1fY2hpcCAqY2hpcDsKCWludCByYzsKCgkvKiBPbmx5IG1lYW5pbmdm
dWwgaWYgbG9ja2Rvd24gaXMgYWN0aXZlICovCglpZiAoIWtlcm5lbF9pc19sb2NrZWRfZG93bihO
VUxMKSkgewoJCXByX2RlYnVnKCJzbmFwZW5jOiBrZXJuZWwgbm90IGxvY2tlZCBkb3duLCAiCgkJ
CSAiaGliZXJuYXRlIGVuY3J5cHRpb24gYXZhaWxhYmxlIGJ1dCBub3QgcmVxdWlyZWRcbiIpOwoJ
fQoKCWNoaXAgPSB0cG1fZGVmYXVsdF9jaGlwKCk7CglpZiAoIWNoaXApIHsKCQlwcl93YXJuKCJz
bmFwZW5jOiBubyBUUE0yIGNoaXAgZm91bmQuICIKCQkJIkhpYmVybmF0ZSBlbmNyeXB0aW9uIHVu
YXZhaWxhYmxlLlxuIik7CgkJcmV0dXJuIC1FTk9ERVY7Cgl9CgoJaWYgKCF0cG1faXNfdHBtMihj
aGlwKSkgewoJCXByX2Vycigic25hcGVuYzogVFBNMS54IG5vdCBzdXBwb3J0ZWQsIG5lZWQgVFBN
MlxuIik7CgkJdHBtX3B1dF9jaGlwKGNoaXApOwoJCXJldHVybiAtRU5PREVWOwoJfQoKCS8qIFZl
cmlmeSBQQ1IgaXMgZnJlZSBhdCBib290IHRpbWUgKi8KCXJjID0gc25hcGVuY19wY3JfaXNfemVy
byhjaGlwKTsKCWlmIChyYykgewoJCXRwbV9wdXRfY2hpcChjaGlwKTsKCQlyZXR1cm4gcmM7Cgl9
CgoJcHJfaW5mbygic25hcGVuYzogaW5pdGlhbGl6ZWQuIFVzaW5nIFBDUiVkIG9uICVzIGZvciBo
aWJlcm5hdGUgc2VhbGluZy5cbiIsCgkJaGliZXJuYXRlX3RwbV9wY3IsIGRldl9uYW1lKCZjaGlw
LT5kZXYpKTsKCXRwbV9wdXRfY2hpcChjaGlwKTsKCXJldHVybiAwOwp9CmxhdGVfaW5pdGNhbGwo
c25hcGVuY19pbml0KTsK

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_
Content-Type: text/x-chdr; name="snapenc.h"
Content-Description: snapenc.h
Content-Disposition: attachment; filename="snapenc.h"; size=984;
	creation-date="Mon, 23 Mar 2026 04:55:04 GMT";
	modification-date="Mon, 23 Mar 2026 04:57:17 GMT"
Content-Transfer-Encoding: base64

LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLwovKgogKiBrZXJuZWwv
cG93ZXIvc25hcGVuYy5oCiAqCiAqIEludGVyZmFjZSBmb3IgaGliZXJuYXRlIGltYWdlIGVuY3J5
cHRpb24gdXNpbmcgVFBNMiArIFBDUiBzZWFsaW5nLgogKi8KCiNpZm5kZWYgX19QT1dFUl9TTkFQ
RU5DX0gKI2RlZmluZSBfX1BPV0VSX1NOQVBFTkNfSAoKI2lmZGVmIENPTkZJR19ISUJFUk5BVElP
Tl9FTkNSWVBUSU9OCgppbnQgIHNuYXBlbmNfaGliZXJuYXRlX2JlZ2luKHZvaWQpOwp2b2lkIHNu
YXBlbmNfaGliZXJuYXRlX2VuZCh2b2lkKTsKaW50ICBzbmFwZW5jX3Jlc3VtZV9iZWdpbih2b2lk
KTsKdm9pZCBzbmFwZW5jX3Jlc3VtZV9lbmQodm9pZCk7Cgpzc2l6ZV90IHNuYXBlbmNfZW5jcnlw
dF9jaHVuayhzdHJ1Y3Qgc25hcGVuY19jdHggKmN0eCwKCQkJICAgICAgY29uc3QgdTggKmluLCBz
aXplX3QgaW5fbGVuLAoJCQkgICAgICB1OCAqb3V0LCB1NjQgY2h1bmtfaWR4KTsKCnNzaXplX3Qg
c25hcGVuY19kZWNyeXB0X2NodW5rKHN0cnVjdCBzbmFwZW5jX2N0eCAqY3R4LAoJCQkgICAgICBj
b25zdCB1OCAqaW4sIHNpemVfdCBpbl9sZW4sCgkJCSAgICAgIHU4ICpvdXQsIHU2NCBjaHVua19p
ZHgpOwoKI2Vsc2UgLyogIUNPTkZJR19ISUJFUk5BVElPTl9FTkNSWVBUSU9OICovCgpzdGF0aWMg
aW5saW5lIGludCAgc25hcGVuY19oaWJlcm5hdGVfYmVnaW4odm9pZCkgeyByZXR1cm4gMDsgfQpz
dGF0aWMgaW5saW5lIHZvaWQgc25hcGVuY19oaWJlcm5hdGVfZW5kKHZvaWQpICAgeyB9CnN0YXRp
YyBpbmxpbmUgaW50ICBzbmFwZW5jX3Jlc3VtZV9iZWdpbih2b2lkKSAgICB7IHJldHVybiAwOyB9
CnN0YXRpYyBpbmxpbmUgdm9pZCBzbmFwZW5jX3Jlc3VtZV9lbmQodm9pZCkgICAgICB7IH0KCiNl
bmRpZiAvKiBDT05GSUdfSElCRVJOQVRJT05fRU5DUllQVElPTiAqLwojZW5kaWYgLyogX19QT1dF
Ul9TTkFQRU5DX0ggKi8K

--_008_IA1PR14MB62243E515C24AE8BF40E36BCB14BAIA1PR14MB6224namp_--
