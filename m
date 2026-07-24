Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2C32B9A1;
	Fri, 24 Jul 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907844; cv=fail; b=SvLoc/86wlhpVwxMane/UAzrgBaABvtnh2GWXTOv5vRJKcavAomEPRRgloUBcFnf8yV82F79tqRmXKbf0jaOwIZ+GrUYXO3b942AMziKTTV0k1wrZxAI5zhnGpHDWx2xZGbWqvCz6jcYYzcBve3OzbTxXJyyI8kqlk8ZukTgK6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907844; c=relaxed/simple;
	bh=sS7+3fueIAM5KEbA2oYyEz3cFlG2nw8F4TJFfI/OtHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rS6olRk7CXrqgiRNHoCPPjZFBJLZF2FC58bTbmuHec/7ehc4fu6uJObiiStQH46VMslSbjWnbPpKP2RWhU6NE/KnLHIoqnANnSPuPwvHeKN1QZqxX85cJNU9SlhL5gUX/rO55XQMfnC8FfXDzNtwn8LTtz4NYxobH/NIP00Biwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H+Yj167t; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H+Yj167t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVnnWdfAyKntoKVd23NdBJ9Fe9pf5hycQ/S5HyLuacc7cWdM1+3qVs5zq6QE6WZ/h50YHc+IIj0Uih43gStyS4vgLXMcA8FYY5ijbCG8nfBFpaOcdrf0Uw+gTd2cQLagttaakAgWr7w8ehyBcAkHqmjYp/rX2JvMxXWEvrzfwNPDJh8MOU3rHSDfMFYNMyeW0uCYxV9vgrAxaneUeyW330m799GkCX9GPHoCLBIdkMGSkP4IWGYkESXPm7DDrROqNms/qi8Jd/8RBAuHkBEzRzUyThTSraSYzPhGDxRdy+cGIual9tz5xFHIBLib2cBAgvXLoNzNkR7LZFC7cwQzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeojhf12d21dNy1YDIvGzHQ7OrxGSlOIQTP6xSyyLHo=;
 b=ObpZme8v8LrfIiV/eL3EeCO3AjCXs7Qup4EmKCmzS7yR+gw+RntYWXb19g9zbtYtU0F8OiCJakQyYe/KhMtN/59ykMAe4qbS9UYTzMfZTdhc7U1aMv5YR0Ml/s7A1PKwCN8QCycP2VZWnP0obP8nw5mxJ6R3URWArqc9mSQh6Da0TypGSNelej1HUVcKKkeGg3W8HqMymFl4WV73EmbsqHYHXpnWpMnhtWgnjipV8d1AKAwqR2kl04bWaLUrwSgZWjc28tRNTcztIve/IwlIA6M3dCPX3Zaa3GF6m+H1Tyf63RbGK2fNDUL5JL8aLnA7JTyk7Y7F955bJAzneQOvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeojhf12d21dNy1YDIvGzHQ7OrxGSlOIQTP6xSyyLHo=;
 b=H+Yj167tdt5MEK7QRb2FKikbktr/iReR7hy7B3E8H+bLy2e8T9gtpQzHqqXvdFimYdnxhrsVaX6QzUkqZ8+kK8CeNr8D1GgowTJmbgL1e7G0vwwO7hNa/Tax/PKq7dl5lf/9ULl2ck0LBDe8xttq7rkBXRWBDXWaaocDPAbEUzVypyKRY/7oQvC+Lozh7EKn/5KPda463jvlpyN6QlSOtjY5ngqMukXnMOqbLqrB4bH8A2VNbjC8dB0o4Pa1f+NNVeaj5jdjeOXE//0OM9r/UQEtZgTBhXMg20ZjtN6Cmt+8K7fBYh0hNPtx6CS6pQrk0YCIBBjHSNPuEn/3DRndeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 15:43:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 15:43:58 +0000
Date: Fri, 24 Jul 2026 10:43:41 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
Message-ID: <amOILRFmlzcBaf4w@SMW015318>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
X-ClientProxiedBy: PH0PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:510:f::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0a82bf-b269-4f7b-ea3e-08dee99a6001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|23010399003|1800799024|366016|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	iVbQqVJP6oaB31hZxXqnp4kMtklhKHUXPhovTYDKuuVEa4yLQL7YP+LTKSVnnTJMiTvDdDQAmL5DeIsZrJ20/xSTYQd972Rfdw9822u3T1nDGQ3JKU0mxR7/2AzYTO3Vlsb12pfS457Z3WiJVt+jFCaUaVXPS7d7tyhRGqkQR7ipdQv94l3rtc87nyoPg7ezTqMR1nWGb3nNI6GhAbMUSPWZ4oIUyr2HXqhmKth477RTs9LEtgpyGrBU7SV69m7vp1B86mlo7qET5brzPsn0XGmgK6POMokNUlyoTzyuwivtC3tsoN8QkypZmH/L/SMXea1XUArJrFWS4DHGbrTz7Aa6nKTPFmWCGDyF30jhVYxg/4jjzm4J94cZ/eCoBOhmlrzWDy9cOs//n4/WQ7xNx68lWCRLWNKBjEumEzDChgLO/4QwgaLCNwI4LsXHprfdp5OoUbW/TJ7klleoabM5ZI+R2NehbtsV82QwP9z1cTvpUOyl52nXO3bTBY9jL+GtKPAvYHRrFfYQlr39DneomVkI8oWn46B4llYyfwdFU/YwWBLppqK2r9EJyBCbsNSpK+kHp1O384mO3bW9ZHtPwKSucnUofZ30FSBF6CjQwxDOmekW2PMeXKaBtFrunzJBwL4te+sBeIua3t6gHW/kwAFcXuQBBE4lK+SCWzvSgLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IEJyitdMY2gibfYCPqWeT0uI2+JQBbodwqW4HacPb8ifYktjZd8zo8oi0FjH?=
 =?us-ascii?Q?VHIByAsqpNOCCoLx9uvODVf7E09fSFrHGmcIpcIWkc4ziGWhi6o6omk2QVPr?=
 =?us-ascii?Q?ea9+YxIFqDos3911QPADr1qFyGRxSiG21oGxcGy54JDtakcVFqrO02gbgZvl?=
 =?us-ascii?Q?eY659GLaw76wHAm8M167dHS0iK/YxxoRtEP5Oy4z7oRFgYdkCQqESvtJi83E?=
 =?us-ascii?Q?nZnNMIHNTjS0369mnNE48HcV5AVdnwVncK3yRVJVq+GuI+4fX7lsE4Udkhro?=
 =?us-ascii?Q?CqoV4Qw9j8hGDYwJ9Xy0Z+WFlkncaMLi/5dhdjjMDVJ18tjf+sn8suf47rJp?=
 =?us-ascii?Q?Tjx0cu+qX7d3P05h/g7OJ0BtPr20yOkDJT46orNLAXrfIlApVz3uW0keQ7/X?=
 =?us-ascii?Q?cwg5yQOVqd2zR8LeN5qdczvS7n5ni3zasdS64v9JBc5juFCceN8ZmwqSlu6y?=
 =?us-ascii?Q?zR5f+9kgaVWvbjkJepiI7XLuGO4c3BZ/3fYqyTsbEgmb7/Vnbxy5bHkunwE6?=
 =?us-ascii?Q?2M+In3Z5KVOR1zB1q45eESolyob7kPJZXOEGrtz9g2mF8t8/Nbg4WbuzY1qR?=
 =?us-ascii?Q?nNhoEZes/eZbP1fGldr3y3XSZS0/5lqUKgCFKbFrfZffQ+TpTVN4xJ4KF1tB?=
 =?us-ascii?Q?T94IqXgKm04xysibxYFmJAn5hA0fBm86oy13oSDiKvsqTsCbIfvDw4o6K2DL?=
 =?us-ascii?Q?HFD6ArTB9XzLN4lloWcR4O3lBQKV5g2kTQdjiXBzjSgpGclTp5xWYC0/Xl1a?=
 =?us-ascii?Q?Vq5COK8/VhSHJvCHtgOu5zAdaP8djJQhMZPF/pLsWNTmsG+/AB0q4GMG0OMK?=
 =?us-ascii?Q?8CgW18adO/4/jfMcx1X+47pJFTEbqp9FqEvSJpjRas0JLsAJ4d3/2p4tCkjR?=
 =?us-ascii?Q?vhXtTTTVzkFNdFiRvtYjVDQBu2Id6qikXSGQlsf/o84l/7w9hIaZGCLB8caD?=
 =?us-ascii?Q?cHZdVkmwNpWrxayekv05Sa1yi9z8vBbfBlUXebkFsMth2Xf7kexTwRwqrqNS?=
 =?us-ascii?Q?q7WMkrdMmSoad8L8gMH9m/fkLC1xX9JHABZOKsz20CHR0Zc1m+yfLxanYK1D?=
 =?us-ascii?Q?gFXE43S43NV26jCSd2KOA8PPYMQwBdPaWKgNgMLcV2ZIB4ZLvhpm0UiB+bM4?=
 =?us-ascii?Q?6x33HLvdZdEgM/zNepRpDKLgMXO2AtejSwhJSQCTOJ04oQYIJDoYywPCvg2r?=
 =?us-ascii?Q?lnIchV1uDjKNkS3AWeIOkUN1mfGz3r9krgzcE2cImlrDwGfXuPf7lxKKTO6I?=
 =?us-ascii?Q?99QL9ZLreC2PF4lp5HhGU7LlL1g8gkHHg5ZX4vJjAvBR8EFzxCpadefo3PYZ?=
 =?us-ascii?Q?XhqF4yMdOcYn3Jtg0olD/LyfPRwlhNiNwbBipClTpkF6ib8gnWrnySYF7iSE?=
 =?us-ascii?Q?Vw5lYxP0axcngr1mscmwCO1Q3kYZN+PLY9sEDVlZL53NFxJJGOKgP6CLtJuL?=
 =?us-ascii?Q?T29xfQzP/oNQwQPEp4Qps2DE+zP51O4oA5Rl14SVnb0X2A2BEKYiaVjD29tE?=
 =?us-ascii?Q?jLu/LTVzXB1KMuRzlzIAbzHIWt+T4RAiqJrrIcH0ygKBrKiysnUUBTwtmyim?=
 =?us-ascii?Q?x0t2cUdawl1M4QOzVcmyA8zwrFGzUIpDo6yH/kM2NFq/RutUn4+6tVlyVcx2?=
 =?us-ascii?Q?vcsyBiqF/x0nlhHqj+LWpgByqJng39I3ZQ45pKOhtCODfXjaJioPuFbt7dNR?=
 =?us-ascii?Q?UdfxVgbEVpPOAvybIeFWvwI48HqzZXbv6MwOq9Z3eTz7qugQe5FgPZXdKG5T?=
 =?us-ascii?Q?kj/JffN4o4iIxacjpHVyLk1CaLhWkNuXA7vNxn6gU+Nx3R77503d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0a82bf-b269-4f7b-ea3e-08dee99a6001
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 15:43:58.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nusJO5leX/TBQXgmjmNrBx5Pi1N85mCyIrJYdnd0BcgJ/BqLRGy7AXWunP95vUSo5W/i0lD7N4z+Es3Aku35tkWHsWxBUHi2hboGHCS1Qg52aM4RJUksN4nrdQ4b3GRQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

On Mon, Jul 20, 2026 at 11:24:52AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec87029420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>  			domain->ipg_rate_mhz = ipg_rate_mhz;
>
>  			pd_pdev->dev.parent = &pdev->dev;
> -			platform_device_set_of_node(pd_pdev, np);
> +			platform_device_set_fwnode(pd_pdev, of_fwnode_handle(np));
>
>  			ret = platform_device_add(pd_pdev);
>  			if (ret) {
>
> --
> 2.47.3
>
>
