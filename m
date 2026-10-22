Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792684376;
	b=5ZzB3Ikfs+IQck2ehXEtLiw2F4N+S0hQWK+qEyczZeBZAcidk5wX/h/7ENw/B9y5mMDZ
	 RmGZcZ5g3adm4SPA+oFcNAgKs9MzGdQ0cR20Yk4hxqrINGVZIokK66bwFles/myZxloz3
	 cPFf+z+jjgElWiBKrx4H+sXCYIzeHURrBUkCKQlEi5HAmE9GfLWejCCPEWZvVoiLYtO7T
	 T8U2XIN/xIPkMHW7zpbMdDAk9ZYfABhv3pRUHBOOWzb9++gtx8l6h62zDn/F8x8gCiWgv
	 n1L3+MlU1UqAoRAq83hNZ7T7X9IFyDF0YhqhfssIjPjgNqUJ/buTx4NW7YjPLIN+hjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684376;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Qr1vP+OgnJHy8jPEybda2XB3G+VunFh1U/WUL872/4o=;
	b=ZYZKpj+GA8JY+OfH2wuVPbmNssX+5iSIM2OH3qmKP3SXfXwc+psluTQCOI2fEOfxvOCT
	 +LBjLd3t80nyhDkJ67fyZ0c354JxSF6Q+mVO/VjcM96h+JmRRR+NtkQLcFb99XpXRPEfp
	 fD/0mmMEu1yfOam22nSpXZMbhJolJCbX82GonZCTd8F4Gg27R4HRD7dVhq89xiLKzJckp
	 Hye0hx6ZTM7zwLC2HzHjqXul59SJCr4gnGyUvc6ntaGgzBPDqFSMG1W4knUlA2pQFWyVK
	 b5RHOmsuUZLYfhwtDbZilg1ULiOgJHopwbB2aFxrTSx8GrQso/rB6vdmtXPHOiI7PeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PCVghYfp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.19
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F56606A319;
	Thu, 22 Oct 2026 15:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F56606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PCVghYfp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgXc4O2HfdENmna5ANGZO/CSolotueChf5L0giaCJ10LrOE9g2gcKoJ/P2uFHrIQVrCEOET1kN2lXXFlxq42f1/7NNcFrpzLRci/fzufJnydkrHBZQsUj0GpQIGApcfZg5Qwq6cPUY8Xigjfg2CIxlXjJArj65Lhi6pfZwS0Gzm7sEwNH0zZs+oRcV/d6mFbXRVpulnxRyEympV8rAXjoVV0LYN4YiXKbToH2AGPtJ7RfWKBbgRSk9qNYhkM5+cblF4gZUQ3SE8cq8J0LbR78TS/5dFjb3fwlbmUW5KNVRIu5XHamp3YSYt1NRvzDDQXN6iJpa21ViP/885SmbJr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qr1vP+OgnJHy8jPEybda2XB3G+VunFh1U/WUL872/4o=;
 b=EyNOSzFXVFWRquY/cQI2vrTVy1eTA2X/v6t7jGnti4wD1xEADZSc9aZzuFoRHtyAQq4Re1NLY+kYY7gOZjMKVk4eu9tl4GdNoDFCah7si0AoZBHTOSNum2iVQYOruy0Ze9FvgcPXu2sRDWKxEeqEUiPUjzPAs8l5C2wdkFS7sg9635fTtamyDlBlc4QQgXZutc3IgpxYE/uzyBI59rJe9SBMDow5YFA0BLs18butkgOQ9WIqeSIUgNn1cxOypHqaox95DkWd5OAsgqtgA+JfHfBVx3ryNW4GAGciR24Jh6C3dKrZMAzJ2YRfhhOniIoePtV6dmF0CLNfs89Z4AIuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr1vP+OgnJHy8jPEybda2XB3G+VunFh1U/WUL872/4o=;
 b=PCVghYfpQvzUHZtHO0zZEhe6LZSbpCb04tlNgoMg64pcma3MuXd36A8DwmbhUXutypea+18APUxv3kaeGRljEB8BtaybJuQew92X/d/b15Zs7nd3mFaKrr3qELiGmQ95K9drk8kq9r/+Db+27OPTVTbDomIq/XqY5frM3V1153qzoDWonQQxeRRtSnrm/GXSJDduq3aLqHtMcEEXtUzO6ZbFF9WJZEHcphYkhLkDVq/r3PDfSg2fD3ghCuQmgboNwguy7AWh/ZQGHuda7ATBWMPlcthWztwgItUst8KDWPnxS6aE+R+QgpsCK5BHmMPDhnUyhwroMNvjdxKtfoQHcQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB11032.eurprd04.prod.outlook.com (2603:10a6:10:58a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 15:52:48 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:52:47 +0000
Date: Thu, 22 Oct 2026 10:52:36 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Golla, Nagendra" <Nagendra.Golla@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Harini Katakam <harini.katakam@amd.com>,
	Shyam Pandey <radhey.shyam.pandey@amd.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, git@amd.com
Subject: Re: [PATCH v4 1/6] dmaengine: zynqmp_dma: Use PM guard for
 probe-time runtime PM reference
Message-ID: <atoxRAVvHx1Ng2GB@SMW015318>
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
 <asmsVD1RP6FoMN9l@SMW015318>
 <212a4fc4-437a-409a-821e-86b9b8c7f85c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <212a4fc4-437a-409a-821e-86b9b8c7f85c@amd.com>
X-ClientProxiedBy: PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB11032:EE_
X-MS-Office365-Filtering-Correlation-Id: f710abf8-23b9-4290-e601-08df305484f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|3023799007|4143699003|11063799006|261009221227099003|261009220027099003|261009223027099003|261009221727099003|261021123027099003|261021121427099003|10067099003|261009223327099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NdiDm/pLPyDJL02L7Wp8uD9g+R47n0ZhP9fYDiC920J0Y1xRb2Ea74Qb6ltHNF64C1BiYlZDjAPO0h6I2nBxcYmz3U2Sn2XGASVXmbf4N4hh/eLCOMNU4RpJEPS29TwaySIEMP3X+fWaIP7yVgtgwqwkBD3/wn7Jr4disA1i915ggfJSO4xIECKUfeebg1qxvs5qilN5DcINKWqb6OnmeF0pEBi0b+rz28E4XODz8Dq75rF0gOOYaJAOELs+BJa85/R11D5hsOQe6DY9o9ciPE52ImdFlXu8GsqlXRiV1irDZQd/SCLLI0cJ5n5Gu1YznEbYU99fos0uAgf7RNfZmf166eO5iG+MXCqM9GL9QArfghW/4wTy3adRxcd+MYcY6h8HJH2yJd4IUmNv1PGj0V4ByWhaBdqyrlpJjlhyxBs28FA8Sg1DzGm9VR2bvk7S+CHbvPO1SwYo7Q3BTCUdVJSj/4mokTUdk1qSxM8cigGY1/5+1mzgY6TcF0DQhkIoHtXyiEmgallPSkr9h3QLqqDQyYe3BCtTKDwfwaXVQ4MpYYHCfnQnlpjtJTE3KiHSyboWvxrrxbZmX0dwBSsIFctTO/gjezRqvksX/dy4U3laj9emboAkdzaqN1C0dBwg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(261021123027099003)(261021121427099003)(10067099003)(261009223327099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTU2QUpRTFJXWkZLZjhwOVlISlZTUnc1QkZPbUlBdTBzMjdyRVNrQzFJemhK?=
 =?utf-8?B?b1NhMEFBWjFUOFo4MnZKbXVwR3h3K3BGd2hBNkRzL3dxdlNaOWdVZytQSEtB?=
 =?utf-8?B?aVBjeGU5bzRQWGRjWkVzVElSdWxhdUdNSWhjbDBjOHFPdUJ4V0xDWmVPWWxh?=
 =?utf-8?B?STdPSEpvTzV2UHF1QWxJcnVQcm9PRnZvQmFaV09OZmdYK0RLWHZlY0dJeDc4?=
 =?utf-8?B?YllKQTkzQWsyN3pnVnJ6UFBNQzluWG00ZlBUMERiYnE3YWk0QmMrdjFWUW8r?=
 =?utf-8?B?VjlGMzNhTklJWFJiY3RlMnF2Z0NkRWh6YnpkOVc3dEhCRnltdzFaNlN1V1M5?=
 =?utf-8?B?QnBtQnpGUjVWdlNKSmM1S3BSU0piYUpQdkRJeVViWWVSVmsxdnh1dDl1Vzlk?=
 =?utf-8?B?cEJnelpxenRiNXRZMmk0dGdWQnV5Q2lRdEpyeGZXaTdYMVRQbFk0dGk3elFT?=
 =?utf-8?B?QWlMdm1Cdm4vTWEyOHYxaFNRd3BzVFo4aEdqQnhQcGpHTEhGaGE5YzMvTUdX?=
 =?utf-8?B?RXJEc2hrWG9QL2k1RHJRUjF1NGJGc3p3SVVUV3hrQm0walJhYUhzNkVXd2lN?=
 =?utf-8?B?bHYvN0IrVC83Y3MwOG45MXgxREdHL245amRwS1NyZWlUSVR6WC8xSWtzaDZL?=
 =?utf-8?B?d3NxcW5Tb2dUTjJXMDlhUzZVbXRpeEY2RysvcHNvajhycENpeFNyWnJWMnJE?=
 =?utf-8?B?OUJjOTR0cUliUVlUdVhXT0lDNW00ZG5Gb3pkelZVRXRHcEIzMlNqYzdjN2Ja?=
 =?utf-8?B?cTYwODVjL3pCYUJJb2FPcTV0Y1B6ZXNGZHdJc3FuOG9ZajV6VlAzMUl6WDE2?=
 =?utf-8?B?OHd0dVRzMG1nVndRZ2w2aE0zTWhQRFR2VGU5SW1KRGdRWWxNbVZZTnRFOGt0?=
 =?utf-8?B?ZUFyT04weXA1R21XNUxocHN3bFdmWmVjSnpDZ2c3K3EzYjBydmtkSHpOUjhv?=
 =?utf-8?B?b3F0NGY4YUNvNWxnQ3pQTlBFTlVjd1hJMjZyYi9RRGFOR2xnU1NUdmRic3dz?=
 =?utf-8?B?enZXdHBYdExUK2Y0RGJDajZBaXdtSENkREVPem9GNUQvR1dsb2RQQVVkUjlp?=
 =?utf-8?B?d0lTYW9uYUVCclF4TzF6ZFlIU2NCUGVjVzhQS1lqdkIwd1ZYSmdzZS8wdkI2?=
 =?utf-8?B?T25WQTFqcGpRTXc4Q2R1UEJHQ2tDNTB2VUhvMVp0aWd5NWUxY0dXc3IxRmxM?=
 =?utf-8?B?MUFhN2h0aHRiRjRrdDM2R3UxWEw1RXY0UkRaOXU3T2RwaDA3RUhFdGtETmd5?=
 =?utf-8?B?T3k2eS9TM0VkbVpJTlVtNnRpaS9UMnFhNkFnZmxHcTFYNnkybTRaaEZoYm9B?=
 =?utf-8?B?ek5vYTN0UDNaNU41Y3VQVkl1M2xoeFUxOXZMSVhEUjdRbGk4cSs0OWVINTh1?=
 =?utf-8?B?MGVNQkZvQzlEWE8vRXdFS3kvMUowdkdNeE05QXE5NFNXdEFrVStIU0hJTnNa?=
 =?utf-8?B?S3BydndRb1JtbTRoZy9GWkpIbkh5K2oxUm5UcHZKamZoN3ZSeGhscGpTU0kw?=
 =?utf-8?B?UVZmbDA3aWlTbFcxSU9mRzYvYUQ2ZHNFd2tqU3pReUdwU29FWGFVVWttbzJp?=
 =?utf-8?B?dkd3U2hVa1BzQlJUVExxQmVBYk5PcFBNeksyWDMxY3ZVaUxDWFgrSW5IQ1VY?=
 =?utf-8?B?OFBnMktmZ1l1QzVNcXQzY05mVjBRaU9iK0FhUWVDeXdBZXVMc0FTN1BMaUI1?=
 =?utf-8?B?K1ZGSXNkcCtPV2k0bUxYWnQrZGtLdThuZ01SRWRyRDBCU3ljNGtBckgzV2ht?=
 =?utf-8?B?UkR1aXhxKzZvTS9uWlJHbSs5Q1U2UXpuTVVMRFpNMlMrN2swRVZidWVtWXdB?=
 =?utf-8?B?anQ2NkVkblFTYndrWmdYUzVDYlBlRDZNQUdmOUEzMlZFS05CUmY0SHRBM1Bx?=
 =?utf-8?B?c2xXRzRrZzBJMm1LYlZFL3BlOW5nVFJtY0x6MklSNmJyNEU5NXFZTTRDcjB0?=
 =?utf-8?B?dFovcDF6U0hLU2d0U2plNmVtK1A4ekN3bXk1dUxwazZXWGNBMVkybnBkUmtq?=
 =?utf-8?B?dnFISlZNRm85NWxGKytRNGgyUUxkcElVMHo3dXQ0eTB3NTdFcGlYU0lrYi9M?=
 =?utf-8?B?ZWxrcjY1VzRBVWlhRTR4MkVJaGtXb3JoNWtOWW9MV2ZzSmVlMXgwQmlyNnVa?=
 =?utf-8?B?WHVFU3FtYk1LaG43YXJJYi96K1FBWnNJZmE0VzZEQ2N1Rm94NDNhWndndlJt?=
 =?utf-8?B?VWg1aS9xUnRwb3hzSk1yNDFvc2o2NHJYVWtRazVncVhjL1gwTVBRNFdrOHlv?=
 =?utf-8?B?eTJOWHRhQW5kVVFjdUhEQnNUa2lrSjUvcC80VTdudEFXRWtwWVgreUVhMzE0?=
 =?utf-8?B?SEdRckRzQmJqQ3hrcXI3Q3MxYWVwR1BkUGtGelQyYmFWVVlnM25HZUszanRW?=
 =?utf-8?Q?UxfRLZrUQoJBzW5fzO8HfShLFBieLdO82NOU/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f710abf8-23b9-4290-e601-08df305484f4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:52:47.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FhcYJAYFf33YYS/iJS6FIt/U1TaVrkxltnPeRXthc/hCMdJTUJCfsW2KNdlsxcz1U8Qbc49VnYEvMLND9e7lFvXoNiYxU3u4N6Ic7pfbHKPp4LnCE5MNRGQcN6xbsli
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11032

On Thu, Oct 22, 2026 at 10:40:53AM +0530, Golla, Nagendra wrote:
> Hi Frank,
>
> On 10/10/2026 8:39 AM, Frank Li wrote:
> > On Fri, Oct 09, 2026 at 09:30:10AM +0530, Golla Nagendra wrote:
> > > Replace pm_runtime_resume_and_get() with the PM_RUNTIME_ACQUIRE_AUTOSUSPEND
> > > guard to manage the probe-time runtime PM reference lifecycle. If the guard
> > > acquire fails, fail probe immediately so a broken device is never
> > > registered.
> > >
> > > When runtime PM is not enabled for the device, call
> > > zynqmp_dma_runtime_resume() directly after pm_runtime_enable() to bring the
> > > clocks up for probe.
> > >
> > > On probe failure after a successful guard acquire, drop the reference with
> > > zynqmp_dma_probe_pm_put(), inhibit the guard destructor with
> > > retain_and_null_ptr(), and gate the clocks through
> > > zynqmp_dma_probe_fail(). When runtime PM is enabled,
> > > zynqmp_dma_probe_pm_put() uses pm_runtime_put_sync_suspend(). When runtime
> > > PM is not enabled for the device, balance the guard usage counter with
> > > pm_runtime_put_noidle() and gate the clocks with
> > > zynqmp_dma_runtime_suspend(). Runtime PM does not suspend a device that
> > > is already disabled, so pair every direct zynqmp_dma_runtime_suspend()
> > > call with pm_runtime_set_suspended() to keep the runtime PM status in
> > > sync with the clocks.
> > >
> > > On probe success, release the probe-time reference with
> > > pm_runtime_put_sync_autosuspend() when runtime PM is enabled for the
> > > device. When runtime PM is not enabled for the device, balance the guard
> > > usage counter with pm_runtime_put_noidle() only and leave the clocks
> > > enabled so that later channel allocation can use the hardware. Inhibit the
> > > guard destructor with retain_and_null_ptr(pm).
> > >
> > > Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
> > > ---
> > >   drivers/dma/xilinx/zynqmp_dma.c | 68 ++++++++++++++++++++++++++++++-----------
> > >   1 file changed, 50 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> > > index 3b7dfa53f972..a48106e404e7 100644
> > > --- a/drivers/dma/xilinx/zynqmp_dma.c
> > > +++ b/drivers/dma/xilinx/zynqmp_dma.c
> > > @@ -18,6 +18,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/clk.h>
> > >   #include <linux/io-64-nonatomic-lo-hi.h>
> > > +#include <linux/cleanup.h>
> > >   #include <linux/pm_runtime.h>
> > >
> > >   #include "../dmaengine.h"
> > > @@ -1077,6 +1078,29 @@ static const struct dev_pm_ops zynqmp_dma_dev_pm_ops = {
> > >   			   zynqmp_dma_runtime_resume, NULL)
> > >   };
> > >
> > > +static void zynqmp_dma_probe_pm_put(struct device *dev)
> > > +{
> > > +	if (pm_runtime_enabled(dev))
> > > +		pm_runtime_put_sync_suspend(dev);
> > > +	else
> > > +		pm_runtime_put_noidle(dev);
> > > +}
> > > +
> > > +static int zynqmp_dma_probe_fail(struct zynqmp_dma_device *zdev, int ret)
> > > +{
> > > +	bool rpm_disabled = !pm_runtime_enabled(zdev->dev);
> > > +
> > > +	zynqmp_dma_chan_remove(zdev->chan);
> > > +	zynqmp_dma_probe_pm_put(zdev->dev);
> > > +	pm_runtime_disable(zdev->dev);
> > > +	if (rpm_disabled || !pm_runtime_status_suspended(zdev->dev)) {
> > > +		zynqmp_dma_runtime_suspend(zdev->dev);
> > > +		pm_runtime_set_suspended(zdev->dev);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >   /**
> > >    * zynqmp_dma_probe - Driver probe function
> > >    * @pdev: Pointer to the platform_device structure
> > > @@ -1087,7 +1111,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
> > >   {
> > >   	struct zynqmp_dma_device *zdev;
> > >   	struct dma_device *p;
> > > -	int ret;
> > > +	int ret, pm_err;
> > >
> > >   	zdev = devm_kzalloc(&pdev->dev, sizeof(*zdev), GFP_KERNEL);
> > >   	if (!zdev)
> > > @@ -1128,21 +1152,30 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
> > >   	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
> > >   	pm_runtime_use_autosuspend(zdev->dev);
> > >   	pm_runtime_enable(zdev->dev);
> > > -	ret = pm_runtime_resume_and_get(zdev->dev);
> > > -	if (ret < 0) {
> > > -		dev_err(&pdev->dev, "device wakeup failed.\n");
> > > -		pm_runtime_disable(zdev->dev);
> > > -	}
> > >   	if (!pm_runtime_enabled(zdev->dev)) {
> > >   		ret = zynqmp_dma_runtime_resume(zdev->dev);
> > > -		if (ret)
> > > +		if (ret) {
> > > +			pm_runtime_disable(zdev->dev);
> > >   			return ret;
> > > +		}
> > > +	}
> > > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(zdev->dev, pm);
> > > +	pm_err = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > > +	if (pm_err) {
> > > +		retain_and_null_ptr(pm);
> >
> > Not sure why need call retain_and_null_ptr() here, generally only need
> > call retain_and_null_ptr() at success pass if you use want to keep
> > runtime_pm active. at fail case, needn't do that.
> >
> > > +		pm_runtime_disable(zdev->dev);
> >
> Thanks for the Review> If use devm_pm_runtime_enable(), needn't this one.
>
> We intentionally keep the nondevmpm_runtime_enable()pm_runtime_disable()
> pair here and do not switch to devm_pm_runtime_enable().
> devm_pm_runtime_enable() registers a devm action that calls
> pm_runtime_disable() automatically after .remove returns. Since remove()
> already calls pm_runtime_disable() explicitly itself, switching to the devm
> variant would mean pm_runtime_disable() gets called a second time for the
> same device
> — driving disable_depth into underflow, along with any other
> invalid state that comes from disabling an already-disabled runtime PM.
>
> If we remove the explicit pm_runtime_disable() from remove() to avoid that
> double-disable call, it would affect the fix introduced in commit
> 9c58a42c1612 ("dmaengine: zynqmp_dma: fix race between runtime PM and device
> removal"),
> https://lore.kernel.org/all/20260630064844.705173-2-nagendra.golla@amd.com/
> which added that explicit disable specifically to close a race between
> runtime PM and device removal.

"[Severity: High]
This isn't a bug introduced by this patch, but does zynqmp_dma_remove() need
to halt the DMA hardware before disabling clocks?

The function disables device clocks via zynqmp_dma_runtime_suspend() but never
writes to the hardware to halt active transfers or waits for idle.

Could stopping clocks while an AXI master is mid-transaction violate the bus
protocol and cause an interconnect hang?"

Is this one?

Frank

> Dropping it would reopen that same race.
>
> Thanks,
> Nagendra
>
> >
> > > +		if (!pm_runtime_status_suspended(zdev->dev)) {
> > > +			zynqmp_dma_runtime_suspend(zdev->dev);
> > > +			pm_runtime_set_suspended(zdev->dev);
> > > +		}
> > > +		return dev_err_probe(&pdev->dev, pm_err, "device wakeup failed\n");
> > >   	}
> > >
> > >   	ret = zynqmp_dma_chan_probe(zdev, pdev);
> > >   	if (ret) {
> > >   		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
> > > -		goto free_chan_resources;
> > > +		retain_and_null_ptr(pm);
> > > +		return zynqmp_dma_probe_fail(zdev, ret);
> > >   	}
> > >
> > >   	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
> > > @@ -1151,7 +1184,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
> > >   	ret = dma_async_device_register(&zdev->common);
> > >   	if (ret) {
> > >   		dev_err(zdev->dev, "failed to register the dma device\n");
> > > -		goto free_chan_resources;
> > > +		retain_and_null_ptr(pm);
> > > +		return zynqmp_dma_probe_fail(zdev, ret);
> > >   	}
> > >
> > >   	ret = of_dma_controller_register(pdev->dev.of_node,
> > > @@ -1159,19 +1193,17 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
> > >   	if (ret) {
> > >   		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
> > >   		dma_async_device_unregister(&zdev->common);
> > > -		goto free_chan_resources;
> > > +		retain_and_null_ptr(pm);
> > > +		return zynqmp_dma_probe_fail(zdev, ret);
> > >   	}
> > >
> > > -	pm_runtime_put_sync_autosuspend(zdev->dev);
> > > +	if (pm_runtime_enabled(zdev->dev))
> > > +		pm_runtime_put_sync_autosuspend(zdev->dev);
> > > +	else
> > > +		pm_runtime_put_noidle(zdev->dev);
> > > +	retain_and_null_ptr(pm);
> >
> > You mix use auto cleanup and pm_runtime_put_sync_autosuspen() and
> > pm_runtime_put_noidle() to make code mess up.
> >
> > Frank
> > >
> > >   	return 0;
> > > -
> > > -free_chan_resources:
> > > -	zynqmp_dma_chan_remove(zdev->chan);
> > > -	if (!pm_runtime_enabled(zdev->dev))
> > > -		zynqmp_dma_runtime_suspend(zdev->dev);
> > > -	pm_runtime_disable(zdev->dev);
> > > -	return ret;
> > >   }
> > >
> > >   /**
> > >
> > > --
> > > 2.43.7
> > >
>
