Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795232495;
	b=Gi8ZRJErs++N1h/SyVmcf6sn+I9/dSfTPoAmL6zJ2qDi5Batp80OKbmuOOjjrk1dOR2I
	 E4HXTB+sxHtYDwrTMtoGqL262dsQDlasX593ISrkik9TfOVnqNWaOX6ekJ5R7mbu5ggoB
	 Bdg2aLYdUK7X0pMPM/079PAv/IxRtE3sSaLAa4lryMuVdLqZgDNuRTy/q7N5juHmsKAc9
	 fdJlRgFPmdgtJVaryCv2q2CAQ/rnaZ6AuzFo4feNN7vGv2oukA6ux7Urm4S6wW+gLsACb
	 BSF9/Zrau2P1r16DdNiUuhczBTbr06z1ehRdHlH5qxYBCR9RlHy+7ARxX0fOFOvgkyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795232495;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=c/00dh0CulQU11q7sM3BBBJYYHX/xtd6aK4aQkT4IU8=;
	b=W2RW/6zpLDlPw2iTF7AxZNP+Gi5d/gSuRRauuLRncJl3BKM5xdVf2JFzrxG/wVBYI3Rl
	 BCygJ2HjHwgGgsvJg2o429pzBeEdhQUyIQzXy8kKVgQF7gr0VlmA2bEgszuhAiE3n0Aq7
	 Gxe4/AQHNpKmf5oUviHWlEnTsHY+xPM9sckS+hrN2gA30YLbp863gNZ5lyeP+Q26RMGoE
	 ICbifWcR2gk6WtKamYbafyq6/m3+trO/FC9ps7VIgq/GmfkDJqv9rMsUD+4Kn8inM9vWM
	 FIc/0JR2eCsVWeJW0uO7Ux0V74MEmh+6as3kDNnIUq5n6iGDA4AcQYIevN/OuNCtJJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=koS3Qmfj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.17
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010017.outbound.protection.outlook.com [52.103.23.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C7606A687;
	Sat, 21 Nov 2026 03:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C1C7606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=koS3Qmfj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9TgazzkkTliuKtg3IqLfsME/OfmZC4WhHe8YHc+oXnmxfvUaUldn5+VDjxnMdkKSE4fmEodzwVNhVHzIoM/rNmWNbN1rL5Nn/w/i0vgqdT7wpXmY+cnDTmztV4dJy6tLMZYpWhJWOdvBMdJ6GNdJhi2xZPXOHGID5xxCkKCBlFVtzEluMU6PMvP8QQNndbIT+NBQPGeEXqF41qnLoCwOLx7YldNSi8MdGVQzjnUFdRiRy2osVSJFcHpT6ho7M8sj1Fzrcu931PgVKnme/RTXzsqZf524qlD6f2TdqfVfuFD4njBHqwOmblxt80iG16efXv40qnfMIwq17quDovbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/00dh0CulQU11q7sM3BBBJYYHX/xtd6aK4aQkT4IU8=;
 b=oLaIhHkEyPCvkV3K7plfrC2PzxZzi28KrCCMQ7rjU2P8W/fjfmK621gqTqnIRIRkiV1m7o40M1uegBP9iM9MZUyBXe+Bo7KzyM1h0hHk9czuJ15vI/pzZHzZWw9W+M4VNDpqtdr8PFYYHDWhT9TVBxd8YN9rNIzUaB4sMhPKEybGtFrb25+HVL3Qr8IBQ/1/B2Fwvx8bmO/dWKGbHKP6SS+LaseRmPyfg3ddfn3bzVbbZNw39nDMw6GV0PUKa+EE9o4EPTjrO4VFzzG10UmI2eqsnXdofbC/QsENwXmU/ski5MjklMuZbw+zJjNoBcKlk9qttmAFYfBKDfgBxRqNuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/00dh0CulQU11q7sM3BBBJYYHX/xtd6aK4aQkT4IU8=;
 b=koS3QmfjZlpMTWUw1SsVWBVJcup992I7Ee392T+ZN6BmfYoMKiQ75d1OZntdMaziSxdaUhiSABjMz354dTw0n3oP+zezDlavYCNcZENhuiS1lNZtHqhtMndzvSge69Ep3m+z7lG45YMLHDlIo9RHs8N6IOv6WIJz8/Q3SIzYO0J6Oy70BIKfz2xi67mt6XdYGibsEous4nZuygB30lek5TPaVXZv/PIVhWocwiIEotYPN1gxUASSN1nVflrjmlcjwR7aX9yiJ7nMOj3RRW3JZSxiNs+fkc8YnxT+wSQ62DBykamrMcAo8r2OCzJWhQCzKSfyMmH41pxC90Q8Yi/X/A==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by PH8PR19MB6975.namprd19.prod.outlook.com
 (2603:10b6:510:229::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Sat, 21 Nov
 2026 03:41:24 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 03:41:24 +0000
Date: Fri, 20 Nov 2026 21:41:21 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, heiko@sntech.de,
	conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	sre@kernel.org, t.schramm@manjaro.org, xsf@rock-chips.com
Subject: Re: [PATCH V2 0/3] Add Cellwise CW2217
Message-ID:
 <PH0PR19MB997338AAE9A8E779ACF4704859A5472@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20261120212815.35663-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120212815.35663-1-macroalpha82@gmail.com>
X-ClientProxiedBy: SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::9) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <awES4b4BSdLUONCl@wintermute.localhost.fail>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|PH8PR19MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac33379-51ce-48fa-460b-08df478150c4
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6cUe9t9Fs5HiQGsDL5YS4QsFmOvmoV0Sqc++Y5PF3irWZVUOjF05FTc6RXYrTgCipJuPZX3jeveqsOpNaE6tQY03rd126K2yeVcd1KScOPvX99Sz5Y8qAgbxXqsPxtOCFkW4CJ5HGeT2bpiEudu169+z24Au5Na1yC6kX4ZVFSZbZcBp8cNhUl9VmPZMyL+D9DfzoF8GG5TOrR/EjrN11fq+ImSrZUQx93dEQob7kjUU5ydSGsvKTEMw0jXWtMoGaJhybOdYGDCUPQT4EMbcIKpGzj+gbNX3FMeWuXIuBZinGsIwOycN3D4TZoXxhUuv6f0PaLljQT9XM5lZ4s7MPeu4aNySchBrp/bPdwC69XLZJ0x3jwcn2Yw/W1g6QnRWvAkzW+vp4j8wOXyiXOQT1kkPnq9orknmlEA9yJVPzH5F5ZEAT4uoSQyeuqubuiQOpc78rt53wz8gIEVnkpd2iETnnx66zwAkFAEe0bNulqf/+OsJ3wY3Zv907/pzxnvATQgjA9qA/vezG9IoRD5QsdSIKdWqw4rUgW7SfdOiUT4txJrUwqGkqjfJENhQiymlx0gzWPXO4/8yY55gIfWe73ZuvJqowaBOVYvjRj36jWHratY6cPzBJxIjSVmLBEs/b16kxyWYwvVWXTedfnrg5ogYygSJcSpBof3dom9cdIi2QDVmCX8HsOHj4fxWQSt1928chSWqNsq6dxheJYWvsxB1qYK/NjKr4nlyDpV9QJ0iMMd7/qik7kYqCtEF8BzHno=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|25010399006|24021099003|5072599009|41001999006|23021999003|25031999004|8060799015|15080799012|6090799003|19110799012|37011999003|4140399003|1602099012|10035399007|40105399003|52005399003|3412199025|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KF7CE1kaJC+VJj8sNZWXhlS5CLUSYVIMcmc1S85orr/CjQ9+1B70vGHiW7Ul?=
 =?us-ascii?Q?WWYrtAbcHydWAzs9Bi41Hc/qnnCZc+C+BSHSD1zVHWHhYAOiKvYayoM1cmc+?=
 =?us-ascii?Q?lMw0ZTzH5Ff8EeNI4EVGV6l8c2ksYlVsPQw/PEKJEXpt+v/AnqSBTiZCZxEK?=
 =?us-ascii?Q?c9qftxRLfWQhV/LXoOFBwqMoIwqJBuLlRwwEbIsqDlYzVycQxleu5NNpqzcS?=
 =?us-ascii?Q?WUc/6Z8yfYhBWG4CIfvp50b8tPqPY82W55vtyRTQFwhtbRX/rs8eD7+SvKaK?=
 =?us-ascii?Q?0sRhb6Dvf69vUXmGSlw5sFCW3V4JC4EsKGMmChAoS25TppOZsUIZr1qkGvTd?=
 =?us-ascii?Q?necEBYlRSOdIBMuoRCZV+GdpnLNRNgbHDNOHDqqDTQt/TVOxX1Gh4kFedCiJ?=
 =?us-ascii?Q?Z0Qc9cYfEK3dlcb0B8CQ6RgLakZLpr5LPOc6Jgct0g482n0PY3U3A8TfNvW5?=
 =?us-ascii?Q?9g7IMS1T4lTLBRGAXZ9dJxkFoKNz5cs3Z7nmxANNBcgaoZ6DK4jzx/B7abvi?=
 =?us-ascii?Q?cLy0DrE10hjnMnZyqiKcwzsOyvVIdT++2IKhltoyh5ajLk7CciWQwA3p0e7E?=
 =?us-ascii?Q?khnDSjmGSLBqEhi2/aLVxuwsa5j5ZHOWM3h5uzcMGOkoLoSR8/v8/jTbFlgX?=
 =?us-ascii?Q?5HkxmCGCp07aIwkITVf+36d1FhbL5cruSl8rbgF9uu42hoeBpet/LQIoVOqs?=
 =?us-ascii?Q?WsoFvoPy/eMigWUdd/I7UkJ1jW7K6lA8ojbc2cGvPsrtoGwVupQq5USHLfuU?=
 =?us-ascii?Q?/14Z9ptfdMavwNNxKR52AfqAB3dB124y3Jd1uQioPllbyNFWMlP0mvowy6/n?=
 =?us-ascii?Q?vXPdMRcBArn3VwzxMGpfV34ib+vKW5u8MRtyxR3ImDRYiEMxyn7cKdL6o2V/?=
 =?us-ascii?Q?sS56nTV7FephSacKpld2V2E7cxzXkhI0B2y65CydF0IvhfVMK5CkCf0GFo+w?=
 =?us-ascii?Q?4Jp/fx4eHvE5MiJWltUT6awIFePAmg0FeT6TmacWwDRRCMFfBgaK90KHU/FL?=
 =?us-ascii?Q?/R7wDGsTp+zDbuaoN7PMRfjkun+wK6JMLJNhGdnDp8qfb9fmKYPxW/jCkN4/?=
 =?us-ascii?Q?zpvpJja1liaKonpZR0x1PSFilIchQhW6vCvFax1EBakjnwpvhPhgj0f/79bN?=
 =?us-ascii?Q?bU+d7lk3iD0RYxvHSwWbKLcR4vjyiTkYem8XBD/AYwQJkPkgyvHbfD7cF2Nr?=
 =?us-ascii?Q?cLL1dGDJ8u06aB8F?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iA569asZk/YAaUHiSKeC2cmAZB9q3L8cyfSf7B5hRmK1wFxYfcq9QJmwSoMw?=
 =?us-ascii?Q?vPmLYdj/QxJHECjurJo6nPHVAzjsq+Ij8utUGioFHQrII4TsUcySzRoQWGVT?=
 =?us-ascii?Q?u892UMHWxM1xlzhJUA2ekYaB6rmlMSd6WLiV9hdOkT40e2vUxt3YJrzKPXg9?=
 =?us-ascii?Q?lncJNh1sgF9vhYtAOXD2Bplk0WNhP6shoGnHL6zPB7ZE6QG8wsKNGzORaKyv?=
 =?us-ascii?Q?Qz+3LVgXV1Y14WpTOD9cN4qpjBztoh976+x7b0ZStVJU6ht0ssvhhtYQ9kao?=
 =?us-ascii?Q?0SMGM2sldcnWKoY9yN4P/D6mUx/RGufGWwrjsh2ve7v12QdQb6F8qrj/4LY3?=
 =?us-ascii?Q?knF62XwEdolQUh2BjAkiB9ue8c6DMYvFCYTY6rfRl73hQ/m+EV/j/AIPUaUP?=
 =?us-ascii?Q?J1VP+RWdhwo55grpHp/CC+h2MH4Ue5rk0HJylZzATOINHhBpmCHwWFH84vaN?=
 =?us-ascii?Q?luXkGnaPag9md0+5VGH/mtNBuJWjBxAazxccGzwVmbI1suEjVXa4pKRlMdH9?=
 =?us-ascii?Q?tosQ1SH9jKuW0XsBQl4WOiPLdAUgkiWGh1uQmSqLX910E4vQgCasc/9+Yd/o?=
 =?us-ascii?Q?XK05H1lSgCP6isBRI/woKqPhFu6Jq7Zxq++L4MJdqHVvxfstrCyBur2pNC+A?=
 =?us-ascii?Q?UtkYi71KRuUrbKpfQMHfdN1oH+hKmXtvOqbbU1Ogdcjm9bd3KcoF2/9yyh+7?=
 =?us-ascii?Q?sY9EM4gz9Ajf0AvsYuJ4dt9MjRfs+mwqY4N1UDl192zO5ya9tZxJnNbOHEjo?=
 =?us-ascii?Q?siLe0NRUnNcrX8/hxduTItFWVfGV1fA1m/oWW0ZJACmvt0e2FgY7i2j4tZ5x?=
 =?us-ascii?Q?ywQdPdYXWNbBVh6lgh6vNYVtIrSy4rdypS9cCN7hPGWFZKixGKhfCbwC3VMJ?=
 =?us-ascii?Q?RaB8BoqTCpBEAlPhXjtdYT3voFctnLkMpiqNRpcj+uav+ugQBLnqtCYcgRf4?=
 =?us-ascii?Q?vUlF9DtVb9L1oezMgNylwhUTLODk5zDY/GfLHcL2UB5UtoDbcOrfnPFGwqNC?=
 =?us-ascii?Q?u2Ce8ifVHSQUwriGfALHkImId4OUV3tHYqZWSBKeXKWMMn1kubveeNOgZZ/S?=
 =?us-ascii?Q?sXrmXATXIobGvaqM9iaY7t+fhe9qT9VJcJGovCCVpxFyvrP2G3dUVP/8J/mc?=
 =?us-ascii?Q?YMZqSRebrbCG6G3OJhSXMoQUQ5zVmhWfBBBiv2EE7FTGB0LcL3l1HtC0pSoy?=
 =?us-ascii?Q?PQN+A9c8BZDe9cN/PAVZ/bGLNYEr6JN6j2T8+v2uMyl2mkGS6o4qGHaxSR26?=
 =?us-ascii?Q?joKlGcgLxFeD9P/RTT6LoyoxZ10bnFS9ACbpcleb//VYdp/TT+n/8UaL9n89?=
 =?us-ascii?Q?jjscHmYWTaPQgyBJPR3010MGiyBuvgpfsPO5ekbs/daG/30IL062H3jN2GBl?=
 =?us-ascii?Q?zaAn/IdhBfEVjLiieSroLYjsYiEw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac33379-51ce-48fa-460b-08df478150c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 03:41:24.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6975

On Fri, Nov 20, 2026 at 03:28:12PM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the Cellwise CW2217 battery gauge driver. This driver is based on
> the sources used for Rockchip's Board Support package [1] but has
> been updated to use the regmap API and devm helpers.
> [1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/power/supply/cw221x_battery.c
> 
> Changes Since V1:
>  - Added a default value for the shunt resistor in the binding
>    documentation, and updated the commit description to note that the
>    min and max for the battery profile is now per-compatible string.
>  - Fixed bugs pointed out by Sashiko bot, and corrected units for
>    temp and shunt resistor values.
>  - Corrected include pointed out by kernel test robot.
>  - Noted in the commit message the patch is based on original work by
>    Xu Shengfei at Rockchip. I did not list him as co-developed or
>    signed-off since I did not have his permission (yet) to do so,
>    but I have his authorship included in the file itself.
> 
> Chris Morgan (3):
>   dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
>   power: supply: cw2217: Add support for Cellwise cw2217
>   arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro
> 
>  .../bindings/power/supply/cw2015_battery.yaml |  41 +-
>  .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  21 +-
>  drivers/power/supply/Kconfig                  |  11 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/cw2217_battery.c         | 826 ++++++++++++++++++
>  5 files changed, 893 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/power/supply/cw2217_battery.c
> 
> -- 
> 2.53.0
> 

Sashiko found a few more bugs I missed. I'll fix them and resubmit
in a few days.

Thank you,
Chris
