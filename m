Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012036.outbound.protection.outlook.com [40.107.75.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBE31197C;
	Wed, 15 Jul 2026 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098385; cv=fail; b=eD6fXjpndLGWlFcMW9k+ifA0ck+CqKX2PoNFO0njjivKv5RsulDHTS/7MvONzKL1ku+ry+8+aE7aYYyyltMjAz0cBN/o/+2Ey24ZGQ1sy9uIbFuNM1cz00KajeWwm6syyRpu7p2MoXAWmZvNpg5LuXP63dLq902rpIJxDznyWFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098385; c=relaxed/simple;
	bh=Jt4a6BVHgLriTp6UUkMfXDJZcYuE8QtiklPfJZ5KkFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlcGH7S6UHkOHeFhXfP0bp/ywtUhjK27+yxUAAIfJmOpparU+eAsAU+hJXpPY0NGuSFacaQIcEbC2FAVMScUpbcW/i1510uZvOoMEKGTOjXyQVQLDQ+lr2nsXVUpZTaD6NLugwLzDxe0fGPSB+1BozdgQJ0yfcUzx3gVIN8pqPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hZJfuEgl; arc=fail smtp.client-ip=40.107.75.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hZJfuEgl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGDseWPa8cIFXRok5Q4bthKWr5hu364j8KrqcrvqsVoGiZQBwxN10/q7d4suRBHHOFJbOoYnQPPWA1Lyk6wL0yDQqwvanPELEcurTrDTTQz5HIL3JAf+0J9B2/vfQn7dMAXXqLKs6MNM8A0gIhjAh/SA1bGvWQSji2WR6wVSR98/jS1Cr37nY0OC+9jUS6seX9cWJiEj1n0Oud5NrQCYwD/O9O345BedgFboxo3Rz9OZ17OsPPf4CdGY0RsIKvroPcNVZB/LPKjKS7fJBbGX3ZlwkWPmq5G6yEZhKPUxoxpaAcd+8tyLrOyQ5+Ibc1hwW2YyKglSMwdCjrvnsjYH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt4a6BVHgLriTp6UUkMfXDJZcYuE8QtiklPfJZ5KkFo=;
 b=aRt84hpF4Or730y6uyunviNZ7Rvw24N/ZLfEdI/7nYkc0egV0dx7slfgUJo3mBVmLJW1MsSBcI4mXaZLGfbOMiwwD7vcrT9cHXBZsKodjS8U4Fl2nB8KvXmrTaQ76MvnVN9PX6WbHpe7AfiCuI8PZ1KORHg9AP9DMZPzcGZxBLQss60dNhuTrcgIBjFKjr0IigyAOfXCppY3X3/OX0Rqlo2q1HwiPZbuGlLDYnYiaPqsgF2UMlpzzVjMazh1MbvKtJGv5Tis1ZHQ4zO0h83dUb5j7G0myrqwhpAwueQWn9CxPk6WAoaLwuphoozI2Q01Yjs5U40ojjeP3y/5BrFDkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jt4a6BVHgLriTp6UUkMfXDJZcYuE8QtiklPfJZ5KkFo=;
 b=hZJfuEgldLxKIqnvuy9JwQ9L3SlfmrjD8dSR1QGvWNMdTM2+6bu4OK320roVE5zXj0mZA3O4z/H8zsXrO2BsOF/5o00PE9oZEnEejbbehpTS2Z8KVJbrMPXZxrAs0lUxOFMugRwYsEil00v4F99LHt0g2Mu+a63HjooLJt8ZpXWatNF5fcyJb3bTyH2CyKveV00tmjWviZVD/Osgl4XpkRzzrRVVJ9i5IK4NF5s1w7YYeARemnqAadLiHQ7yt/lkkooT2MIK+6l5gDLH0d157fh+hTgXCJ5w5Qu1SDyi2QPj5JbQG++ceNLzXhzT4CtSzQtLWjDTA+BQArU/+xHiFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUZPR06MB8025.apcprd06.prod.outlook.com (2603:1096:d10:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 06:52:59 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:52:59 +0000
From: Pan Chuang <panchuang@vivo.com>
To: wsa+renesas@sang-engineering.com
Cc: Frank.Li@nxp.com,
	alexandre.torgue@foss.st.com,
	alim.akhtar@samsung.com,
	amitk@kernel.org,
	andriy.shevchenko@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	bcm-kernel-feedback-list@broadcom.com,
	bzolnier@gmail.com,
	clamor95@gmail.com,
	daniel.lezcano@kernel.org,
	festevam@gmail.com,
	florian.fainelli@broadcom.com,
	frank-w@public-files.de,
	fshao@chromium.org,
	geert+renesas@glider.be,
	heiko@sntech.de,
	imx@lists.linux.dev,
	jiapeng.chong@linux.alibaba.com,
	jirislaby@kernel.org,
	john.madieu.xa@bp.renesas.com,
	jonathanh@nvidia.com,
	kernel@pengutronix.de,
	krzk@kernel.org,
	laura.nao@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mason-cw.chang@mediatek.com,
	matthias.bgg@gmail.com,
	mcoquelin.stm32@gmail.com,
	miquel.raynal@bootlin.com,
	mmayer@broadcom.com,
	niklas.soderlund@ragnatech.se,
	panchuang@vivo.com,
	peter.griffin@linaro.org,
	rafael@kernel.org,
	rui.zhang@intel.com,
	s.hauer@pengutronix.de,
	srinivas.pandruvada@linux.intel.com,
	thara.gopinath@gmail.com,
	thierry.reding@kernel.org,
	zhanghongchen@loongson.cn,
	zhuyinbo@loongson.cn
Subject: Re: [PATCH 00/18] thermal/drivers: Remove redundant error messages on IRQ request failure
Date: Wed, 15 Jul 2026 14:52:48 +0800
Message-Id: <20260715065248.564211-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ak9MldvSmaDyJn42@shikoro>
References: <ak9MldvSmaDyJn42@shikoro>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0113.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::17) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUZPR06MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: dd127d35-3bcb-45ce-a171-08dee23db4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QrT28/4+OdI4Etz4nGUYIkUst/HskiHodApxnhmNvZgy8HkIVhPEcL4BuFkAmzw62CfXObL6nCW9IxU17Iccaw17HpXcZxliBC8uQZR2ZhuTZXDbJUPTxBM+Z37vT1OKnascENBU9xV1E+ZCL6/FuUCtkV2l1MuZaJhLZxviGl/7bcLwO0r06lozco3QvgKc7SIKn1JKg833j+lrG1LsC2VoisZc3tyzTcelaeNXwqB5tfjTv6OnFdBGmORW4A5ObHIaYC2fTFgGyrmMjBYm4LVLIwNRAMN709fLIfdAmJOSSCATJnTPN3XmdXcHvlSelfAPbKq9yXk3OjFiFfQkPykxcrlc+yRauaPPQz49hqvvqRTttD7PVY52y9fC5eQ/sTeswx1sRtAfMLymYnSRQR1GMmpR90BZJJpTkCtAOzHTM3ePR4P67OcD/RSpWS4S5W5rTnmLb9Yn9M3V1NfOPJXWuSkhCtEMQtjyWgpk/S4AroVSsFAzJngLb8uvglIWGQk1AR6aWQtMo8mKCQZxwIfQ7efprmeRJT7QpNE90KbtdnzNf5EAfTQFNKGoWVPeS/w0mA71LONNL+kxSp7D8VR1TM6HajDpI8cxVB0uqAAeLRTYK22fThJqSTsrYHL5LcgyJZ+cwErk9Ovrc4W2N0GO/AzIIZyf+dRis/yCOJdNHCLmjxTiEbL6Ygoy4168qxmI3w8WqCeld3BsFFcgMV2X4khzF8SoR7qhzXzsivc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pgFUuHitPzGyG8Utc3kVLM9fc7LMPqiDC+cO9/J8YnI92/Oz+qlRcnw/KCiS?=
 =?us-ascii?Q?+bfdEb3MS9HHMoOOXDey9aJ5EWcKTCp2VYMLKvBL3Z861ll4UOoxCBGZ1Lbl?=
 =?us-ascii?Q?POfeZ0/uMW0zSJXSLPi8jX0jcIrLzGtSFgLgOnrvqJ0d5+ZLg7T833JQ/1kk?=
 =?us-ascii?Q?rW9rHh9KUqIOXaHTQ540O3zU0XQZuJGxK13qTyMTrzx+2ECoUUZGDcZvVo1K?=
 =?us-ascii?Q?S6B1poSjgQpi07YxXYTIy8BZ7g5LW7/MXWfPxUuz94bq5IOoh9g4j6YHMGLa?=
 =?us-ascii?Q?36JKIIodCU36FrDWdSF4ESFBfuFWdDPY38eSynqo49EtdCzhPwuS97gaDk6y?=
 =?us-ascii?Q?FY0xKPx4PK8pm+8lYjmQtsKciltFh9e2BTA37G+WJI2W+emvkxL9+G162wm2?=
 =?us-ascii?Q?Xp7tTeN0egpsVuWc1al4mGyQBWBiX2KGourm88m0+jaGvNrlvPvcjfdPMo55?=
 =?us-ascii?Q?cE5WDeqHx6VP02nxOWD7viFgzxF1SKfYNTHSTQtEONigjPZ6o1oWnvQUYetX?=
 =?us-ascii?Q?bbk2LMHh/UDxOFKGt2HYNr+LVcbajrTEBnjy6rthMBnJ9Crr+1JDWYNzHTTH?=
 =?us-ascii?Q?dv1kmys4C9bllmHt2Ad5jgWJ/SP8+aeLnsv8/lfXZ2C8m8B35kb/eDHjt5rR?=
 =?us-ascii?Q?l9b6U+2dz6efGCwEalGNxhK+xjMtHc6YnIOmMO1cbVomZMadm5z5nmo8pR4J?=
 =?us-ascii?Q?BHKMj4Po2dZYtUCcL2GFOOT7vOvVTOcUxkB9Pfb1J55nS1pG9ftnPtH1a0LC?=
 =?us-ascii?Q?A0e5JAKaL+DTdHgbzuCkFhhnSUsCiIDrGOXIsAzMFlF9/kfs1gU+mrapWFjG?=
 =?us-ascii?Q?ZYE5/YbYnek2gS65ccY18C/r1P7aqSRTx216BA84VFZb2mbdZXfBEpHuxokW?=
 =?us-ascii?Q?Gr+sjYPIA52PQ6jDTgA3p3bMuUFhbtQhuHBeVURSFEH+J39iDKMVqKvJMyPc?=
 =?us-ascii?Q?ImzXlzCm1iYza0Oud4VN2BuPxklAlj19XItZWTYdR/5s2wIQxhhmg8CBcPZf?=
 =?us-ascii?Q?KJqB5IOVOtC6h0snxunyVGevkexT2a8f4RDC3BhQPedOORZsrxi8q71Qv3Bf?=
 =?us-ascii?Q?Pcfi4K9xDIz8M5ezErVA7OvLMGw0ZeE12zWfiHjl3w13q6wZcUoJp9pWPWD/?=
 =?us-ascii?Q?opYRApEA3R3pPn6cFFWDO6PbN+DOpoZUDe7jA9g6T0QI8ZNxd09ZJGOttDW/?=
 =?us-ascii?Q?IO7XRh3nXeKfikKTaWMRSetXvC38EhzFbWxoi5DisqA8pt08y9uefQwJeA5V?=
 =?us-ascii?Q?cg9BFNvzHVoGhWtIC055R/Ln88DXKAyJJkCXcMW/MvIGqSASdWskrwE7F/ZY?=
 =?us-ascii?Q?146ePReeGI7rDuAJaRTwG6nt5nnvjtGs4jsF4LW+uv2y48ZrzGufdtVtOUx3?=
 =?us-ascii?Q?LBqtHRgfagKeMqMMZHqx54G5GWwZs2dLiPToyf8+mNzk6KgGgPrHBo4N0C6n?=
 =?us-ascii?Q?u9/gHiee816KcEcNvd2+DmXvdhmSMUKawnQIw8f+AO6dIr+2uthG9Fi7L4pb?=
 =?us-ascii?Q?QnC4ErzuNNBZCRn3kRU1J22vG9TON4WS71vpN+MXVkm+iYY+m99M4+pccvkm?=
 =?us-ascii?Q?7lwBmfpiSlEsBYirT1gVE19gfRtQrz9L3YOWrt67B0hygBcyag9QvWceb+sW?=
 =?us-ascii?Q?0HKFbuQs2h3rp8LZk4+P2a+DK2O3BQZAzC22keB1gk73efSE0ml1YSlbIbNx?=
 =?us-ascii?Q?yz3KOBv57E16ZnPZNck4d/XAoALyXIvMWvCH8oe2w+fD+qtjbWPQmAejHvpt?=
 =?us-ascii?Q?vSvWzIt0FA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd127d35-3bcb-45ce-a171-08dee23db4c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:52:58.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcysCyivOyx7sIoh6Sa5nLo/TMmuDdkTngUJhcniphVIvPzELXC5/xte+rYOfQf/fBrTbk7v8yjbJwo01XDfmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8025

On 2026/7/9 15:24, Wolfram Sang wrote:
>
>> all of these 18 are just one commit, no?
>
> I think so, too.
>
Thanks, I'll merge them in v2.

Best Regards,
PanChuang
