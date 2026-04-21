Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB7382F3B;
	Tue, 21 Apr 2026 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757211; cv=fail; b=Wrr+kbxNP2QfTxUZih3wKjKg1OIpKuH/NKWdQI0xglJcANPwvGWVBKp1NIaD7SZDgk3qEZYY2pKsjOtknpnZYifar3iwFDJe+tyvDlh+a4UY6APVaSRRhb4g3QT583fwUPvBRPwD5iSxud1mROPFAwrESXfHRqe00doVtgydBYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757211; c=relaxed/simple;
	bh=4IUMxwLHp3MzZ7puMpiD8xAkmFOT7qfmituhBwHGBr8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VAVpgORiuCe5UjE9Bh1l3EN3EJb+zvHTdFuD8LL/A338PkOrH/y1G6nJ1YFlXyfC2Z1qL3+0PvzjB6LXGuhwx5DSCnCfvuYI2LEExtyEfwADGaeRoy5hjn8O8cMuZ/dZWxN/W9gqSs2G1fQiEaqY2+4Eud7SlELzwLvXCljW7vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVTf3heM; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVTf3heM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr83f+CSKrolxygdvO+1XYgIvaIwzOLhuEMehQbHkAcx9zw7h2ywlXDpvJEMdhEtJCKhqiyOG7vluW4EBpO0HB17z9vsW4ORPcWCWsbxYsrMdLfK6E2qJ2AGxiGMyYP6ZjVJ6v6WoXotvpWWQHr38yZgUfadlRVu9ss4Nowfl7MSvWrQYAafXndQ0c4owTfSe5J/tDJpYS6w/BwBoqBLG0Ecuuepf9pWZ8duthzYVSIVpu3CRI4xt6CYqqvgxWxFPO4xJlAb/FN0YQ/98SRDUVr6YHa3ttnVSEnif50Kq/1rinHwKf5bohZvGjVKb3XeCZqGF58XWoOcyT+kGM801Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkW8nCnkcB5oTti/jiwxS7jSl1bcsSDcpSn/eGoGpVM=;
 b=bGCkTpbHyL0439pKkzPamlXc5nHLVnLmEYBL70y42y4IRaOrCYtpxT0hMYAb/e2OFKRV+YfIg8H4QJA4GlwfAZ6fxhfPvsjCZ6sUCEV8thIeO8QRGPRCujF/MxYwRXEYtjTFm/lUGOW8ZJDLaezhgKf3DdkBPOUlN9KXHwxSLzED2w45OwBnSx6fR2odAvhzOaiuPjaZvQPCcFaclKV8Q3PvWyS4GPiJvxxnaiD7di2yBbeo3eB+k8UAgmhXxqkORYrJxfCbyX0sSuQpnhmke0Qi8iAWKNSxw4QKINfAGUA+eO+NHcfkqlgc5La19cgsVedjAOknHypaMQGCD7dr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkW8nCnkcB5oTti/jiwxS7jSl1bcsSDcpSn/eGoGpVM=;
 b=KVTf3heM9pBK8IVVz9F3AOS77k8+I7hHUiJWSwbuqz9Bt4V/rZPO4gHGVEZyQK84DeBUGmGilCMYZpYWXRCa/3hzch/EDy2Tlj8K81+Zl9R3/r/eRXVTXrWVIeZ6CE2jD94HTPXZh3aB0XlpY9mnu76dQSNpE7llrXvof140CgSFWswGBPeT26I7zeyAIJej2Sm0l5VEY8PTVDEnqeeN8fUvosL4YdG/Y6gcS43+eQE7gtnVipA+9ss7nXgfcij/XzeFdS2ezCmMCiVEw8wcO4KXwyvbLkA4K3/kCC3NFV4POFqA0o2fZjaZXUdY4TIS/zhuXU76uuUavUfuHVy/2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 by DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 07:40:06 +0000
Received: from VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5]) by VI1PR04MB6861.eurprd04.prod.outlook.com
 ([fe80::7f96:4bde:2e55:cd5%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 07:40:06 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Tue, 21 Apr 2026 15:42:22 +0800
Subject: [PATCH v5 1/4] dt-bindings: thermal: qoriq: Add compatible string
 for imx93
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx93_tmu-v5-1-05ea1969bb9f@nxp.com>
References: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
In-Reply-To: <20260421-imx93_tmu-v5-0-05ea1969bb9f@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776757357; l=1218;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=4IUMxwLHp3MzZ7puMpiD8xAkmFOT7qfmituhBwHGBr8=;
 b=Trnufu1BqMbF57hHjuP66GAgIQC/E4NAOjAuyWIWUEoElGcjgu5TnDgoHGu+VHrRyLgunMrgL
 PH9dXktmIHpCsmbHhV0VHQ5NfzjSHnX+utytl+Cj2TzBhg7rEsnQ5j+
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To VI1PR04MB6861.eurprd04.prod.outlook.com
 (2603:10a6:803:13c::9)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6861:EE_|DB9PR04MB9476:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c279082-a7fc-4364-98c0-08de9f793517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|38350700014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	o/shpH5l68vUWTsrKzkOFUCdi5B3vC6SDDlcrMJAu7EkHE6KGVGEy7/ReFlB0Cz9RLymA0EyF24Pk1BO2CkHNAAtbNtTgTBt5yWTwPKylNn8mmLt9klKf+RyTe2CREzg3Az/pcnzDe8TDDZrZPtjmNhJmPOovwDn5pQ/PrUv7d/vtOzPZ2uWaYkEWU6j24JpOirWuXnMvUw50Pghxz0+2tMyZ+oqXpwbYRcj/Ha4zkB/w+yebtjbCdfycQxUtpNT2jialnjHZBgvbOk8gGXpqPEEo/lU0zrP1aY/IhU37qxi204fhZAZY7j5m4WYYWvTbXkwa2wVprma07I/9GTyVvdAeb1hqyj7FztfZsDJ0PxIWR06SP+EIAE5/Eho47aRL3sjdpa17DZbmiEUnRGf0UbNsMQAyoSwCsTNBKAkZ4NkM9YZ/TxBE9r5dqvG3DbMqHf5lBvmD5v31I4CW/C8PITJHg0s8tZVPCGeQvlz3oTzJdC19osqUmKiTgQ4GMwIuseV/SaLu0V7k1vCQyFcmgusYL06rdNGoUy2aM/Q4I+9x6GPUM3ccbpqqavwYCsYkyiJ8EK4FDvDCfVtv2K5SPimOm+KD0/u3Vy6UDV4TAFtUk8lfSHogDav3jPJpfMx7lmQIy1YinKHCdTNzmKn0wRmxF4AxeQU5LgyfPY5O81sxKbc+DHL01rm6l2BFFRLLO09mwWHzapVA13E0InJ3knzkF8TwOMvcCa3ExNOc1xu61zejoQvDYQKH2r19JuDSTTatXfQqhBwd88ehFSYl5B/quu4Lxmqw8cHRIJsMz+R6VOB9J2jNXUOHbPWabDV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6861.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(38350700014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm1PYUx3dUN4S3B4akYyQ2hKWlZ6QnJFUU01UHFRNXJsWjRjOFBuKzJ4c2lM?=
 =?utf-8?B?aXhrL0R4WTRLaXVLOUV5WUcwck02K0Y2REh0djZ1Wi9aeWxwUnYrWEhSanla?=
 =?utf-8?B?bXBLRlNkSk5DUnJ3UzQ5STF1cXJsYzNuS2NzNXNwb3pnejAyemNhWGdiQ1JM?=
 =?utf-8?B?c0hrc1Y3QWdadW9zSUx6a2hvUnpyclVuMkZsTWRmUklaUXlkb1NUN2ExMWRJ?=
 =?utf-8?B?SEhsa0kxelpJOFg4cFk5ZWdBNlZRMDYvM0VjaUtWd2p1SWxYU2hiVkhVQXdz?=
 =?utf-8?B?a0VOcytKNlV4S3VZVExFTVM1SW5sT0hLajZ6QVZWSDcyRURnL2Z5d0EzU3JS?=
 =?utf-8?B?bEI2N3ljaDh4OWhJR2srWU8rM2J5NHE4cHlPNHpoajMvVGJnaVFENHZWZjdF?=
 =?utf-8?B?ZHk4M2hGWkZIZlNISy80MHlLbXVidk9mbjRUUUlzZ2x1V1QrY3dqUXFkL3Fr?=
 =?utf-8?B?clpIaThPbEVvUkdJZnpsbFR1cDFSR0VUY0QxanVkZGdPSzA4QVM3dkIvQm50?=
 =?utf-8?B?ZkhFaUxBaEt5SHMrVXVsd2FMbkVyc3JJLzdYZ0pVaFhhdGc2ZnUvYmh0cjlX?=
 =?utf-8?B?RFV6N1l5N0ZSaThYaVNEMGNqbzMrYUlHNGJzczJYQlVtQXd3Tnk5RmEvYjZV?=
 =?utf-8?B?UDJXODBqZkVYYzh0eCtadUxMNjdwLzgwRDZndkZ0NmFlc2pOeXYrdUMyZGY4?=
 =?utf-8?B?VDAySUkvcWZjU2dTcG1TWXBVc09pZk1BRCtYNjk4UGU0enpyVTdYMFgrZ3VM?=
 =?utf-8?B?Z2ZLRzdFNUkycmJWcjN5WlBOTk9yaG9LaG51aHpsR09rSDNBdVlVWGtnYTNi?=
 =?utf-8?B?SVhHSWlRejUrL1Q4eDBWVlhoTXlieXNrSEV0d1hIdjJRL1M0QTd1VXY3L1Jy?=
 =?utf-8?B?K3NNZHloUldodHgrb3B4MkF4ZHNweEgxUFBLUzZxZmQvcG1BWjhTU25NTVd1?=
 =?utf-8?B?OXJvRC9La2ZkOW10dTZ0RmZzcTVPTFI4czU0MGpsSXRONkV2cjR6LzN0c2Uz?=
 =?utf-8?B?ZnkwSFV3ZWhScUp3SGN5YlYwV1NCYjhtaXE0OThHcGtvWU1KZjdDUGhNQWo3?=
 =?utf-8?B?WHRnOVE2UW9sYWJTeFZmU0J5bDN2RXNZWUwwRGs3SFlqcVIyOHBQT2lHRU9O?=
 =?utf-8?B?dVhXbmhzWG9wSitMUHhWbGtHK05UY3ZYbmJLVm1MMk5TVmtzc3BrYmU0Mkx1?=
 =?utf-8?B?MzJQbkZzWTh0eEpySVBaZ1pSZ1hnUGlhWFJXVktpcXRNWHdWTHBQNEQxbEh4?=
 =?utf-8?B?Z3dyYWdyMjRBZFlkdm04bUV5Q2NPL3hFS1dRT2NoMEdSc2UrV09jZEdRelVZ?=
 =?utf-8?B?OWVjV2FWcGNjeklGWVBrUVFDTllqSytSZTNiakI3Y1orcWdxdi9GdDA0cElM?=
 =?utf-8?B?TWtJT0M3UDVhT1VINllXaFg4aG5BTWlOenhHQTlFemVZZE9qZ2tmNS9QYU5T?=
 =?utf-8?B?N3pmWGxSOWNDVE9jQVp1ekVOSFZ2YkR0OVd0ZEZ5MmpLOGRiZE1nM0VGOGg2?=
 =?utf-8?B?Tm1jcXFqT2NyRXIzVkoyUGlOTjVZRy9zN3JScEZQWHR2N3NjeWQ1cy9Qb2dm?=
 =?utf-8?B?V1R5Ynkyc1gyVXVLUjhuUmNQdFF3WXVxNHc0SGRMV3BEd0xzd2xoQjJRWFFF?=
 =?utf-8?B?V2FnMHpSdWkxdWdzMjVDSnpqNGliN2tDRjEzVVJmdUhGRWdzZDVQU2FKdFJq?=
 =?utf-8?B?Qkcvc2x2d214TGZmK3NyNHpZMmpCWTdHN3Y0clMzZFFYZUVVbFRSYU0wdkhk?=
 =?utf-8?B?ZTJ3YzBPZVYxWmppZ0xyZG1vQVNRKzY5MzVnYzlWVVRRdEZuUlI4WUxySENv?=
 =?utf-8?B?OFRpSVVPSkVYaFJKUHFVUVVPZWxjU2RpbWZCeHpKYzF3RGYva2JEdHdnQ0tr?=
 =?utf-8?B?T3lXSnJSVy8zb044QTBjWjc4cXhyeWU5S0JPMUNaTmZWb0xxaWgveHpCS1l3?=
 =?utf-8?B?TlFvN0wyR20wakRXaGVYRlkxRk5TUlFjYWJ6L0RVQmFNVEZEcDRZa2NkRzFO?=
 =?utf-8?B?dS9ib0svTU5PcERkZldwcXNDRlJOc1k0Z2VWSjF2NC82Mi9NOVZRbWVFOVhz?=
 =?utf-8?B?QTV1K1N1MGVVN241RDk4d0h3WHZZVi9wVTFLSFZsK0F2UTY2UTRrQXBWbkM1?=
 =?utf-8?B?Y0VsQVh5SnpZZm9qTUtuNmZTendyTHY2bC9WTzlud1FVdEh5R2FqQWhjUFVY?=
 =?utf-8?B?cFlQRCtOY1ZBeU1nQVRCT3htMzJBQm5uTXpvcnpydlVESWtwNUx6UWVDOXY5?=
 =?utf-8?B?WnBpMTJlTzhzazJJdmJvUnZzOU5ZZzlZZ3JVMDJpZmN0WVh6K3FLQTVtNmkz?=
 =?utf-8?Q?d8GpSdYfT1le1tHvUV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c279082-a7fc-4364-98c0-08de9f793517
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6861.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:40:06.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hgyy41YOSo3ul8iOh3Bz9utE9Ql6OT8L848uPqbHKTa3ZxQpqWKdz55HLQrdHBzITAhkYq1Y2Dg2jmWjLvPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9476

Add i.MX93 compatible string 'fsl,imx93-tmu' because Thermal monitor
unit(TMU) on i.MX93 has differences with QorIQ platform and not fully
compatible with existing Platform, such as fsl,qoriq-tmu.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v5 changes:
  - no

 - v4 changes:
  - no

 - v3 changes:
  - refine the commit log
  - drop the compatible fallback support

 - v2 changes:
  - keep the enum
  - refine the commit log to use i.MX93 and QorIQ name
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
index aa756dae512a2c6e3f0b6bb1ab4a65c01e373ea7..f3b136f5e1cba1fff7e90678d7e3d7ec3ddd25c1 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
@@ -25,6 +25,7 @@ properties:
     enum:
       - fsl,qoriq-tmu
       - fsl,imx8mq-tmu
+      - fsl,imx93-tmu
 
   reg:
     maxItems: 1

-- 
2.34.1

