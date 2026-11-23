Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795423380;
	b=3qSDLo/UzcMXnHfbEEspRYsNkhI1LeNH04IUHFjC2TODvQb1Q8aTebmDMBkBawfxmqef
	 PtRwXPiMygdK77SOBVd6B9ADRynt2BUTem/Ulvlk40qR/JR+aEjQroF1KwWJld4ExkTYP
	 w3itqvwbzRdl8VPmJ40dSrUk8OxT7c0Dt8k5BgKomk4QbVGZcqObQyNBvNLk+GL1lw03b
	 8DZT2VQoNaNPg1uNQVIiC2vnPlsDFV1deD7wNqbHq7evzw00RWOHdxIo1FspsJACWoI4T
	 /kWci1uOZbO+4z4g+leKdhuEGt4Tqh6wr9AuSYtjn2d/Oa+ShhW0b0ouo/XGiWZw73Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423380;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8s4i2E5iaDeYzRsh0s43wEv+6ErGRhw1SyUqfOWfgVg=;
	b=pfUffrCJnl5hyIoEcV8NSzteZPYI/WsrQXGXUeKhR/kFY4TNXKeAuOcbmtgSDjf0fnCD
	 IOyF/f+EzW/IODXe8/F2cSPBi1M4WAkamoDQMFR5l9mTjF4ndU1KcM9Gyo7Ssd+diDvSN
	 J+z0b9w2IcWvw0Wcx2+ZvT49ZrbGWFnLaftMHjAswpd6bL9I6bk0Hx3EPkImQDA0yZhRL
	 Gm3tobDVpuqVCXCaFLp/uo+LvoQfWx33f4+VLfYCY1v1HDIV1x4KqmKpo1MN1E/XFJCjo
	 sw3BA7uz7L9hjYGusFTIlEM4KYV6sdvZiaKDz1AWDD3neHeNPGu8HvfXnNci5N7Na4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JxtyMeNQ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=blD0tWqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3697606A330;
	Mon, 23 Nov 2026 08:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3697606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JxtyMeNQ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=blD0tWqX
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN51Qp03146382;
	Mon, 23 Nov 2026 02:42:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=8s4i2E5iaDeYz
	Rsh0s43wEv+6ErGRhw1SyUqfOWfgVg=; b=JxtyMeNQ8s/t09ZDCZYMfPKeNrK7G
	JXZgFhnTrVXYlUOyNkVi8EARQcBkIYjRP/gcpAi81jykcO2iLXl7xUvPOsktvRmx
	Psi+Jq1jp84RTXoRp7+06Kd/gfWq1hKg7Wh9j6KddzWh6X/yzFZ1I6e/tiTVwHOs
	2Hgh65MttQ4fU64sTE38bKrC0pR6O4IjP64vTJgdQk9GBHPf5ugPU6vwHGdWztrD
	c1pcgEnaT0l48Ne1SsyBu0oZAVOWPStbOJGVkwtKYAQboglQs0v0Z7NsZtWGRv0X
	x39u9e9MTsHOGg/C3dTc96ySjXqn0Xnpofc664QhpWZk8DMt1305c3Qaw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j3uj9cw14-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 02:42:44 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPW/oY8ui9iJ+k0ZwJop2VrTKCzWBmXr3DM/lRB5DqjQ5v4MDC1Cz7tcZrxI+rLDb9SojHHo5ErybDXXmK/rmJXKQx2aV/u3zIENMh0OeJ5xE2lrHkoU6URx1fxWEWlcF6y9n/bfoc/DoDOyccOriPEWPSgmHEfp/be0SpBxCO0606mmlGZGMNPr/RZsTs1YkUdWM/9Y/Pw6pr1IR05g7fHW4DogZV9enX/9oDR37jNzpt6hgsVzS/2uXDd0wBoS5orBcOAlQGsLTnmPwiOWy4L4LQzkystVpAn/92pS8VbXK10dbOfhw0ThSFcM+RLA5ikKYQHhI8wgzvDqAqot9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8s4i2E5iaDeYzRsh0s43wEv+6ErGRhw1SyUqfOWfgVg=;
 b=ULAlAKgCnMLZuzIvmHfv0vER7i8eOUQ/zbW2DWN8/zCrmZKYmUC2BSqbFy85/WXK6NEzsHpN5K9Aqkrs6x0U22sl+gEHY99bgniyXsvAmS7czwYpdbicauvflUFAYsQfGvlk9wrykdEojDPu/U686ChwCBAIyhgELGswUFk4eiTSCZnJ0Tjb0yzDabrgjoAlS7VCUd6+vgDsNkKP8U3kkyHRwUirI6JfEJ6QbUq/mev5zrq37Ntm7wfJTn2vCYAtjt3/FShHZNvmdfoYIkjoSjpdfNR/AULpjZUDSx2mNTohMaJ61aKsjIqrh7fUYz8P8bMfGciTBCenPbHst5H7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8s4i2E5iaDeYzRsh0s43wEv+6ErGRhw1SyUqfOWfgVg=;
 b=blD0tWqXeFolR2xstvsoqvVWn84qW5xvQg60GAY3RHIRk9jk5WepeNAEqOooAPClQ5/OnauQ/HbtUKoiw9wwuUrB9eodFaem34v+4L7kEu74MxNRwLIyVKJCUYmhyIsVzsYjF83OXvdbKGDiGm+eGQO+9L7jdx8lotFyjdczVH4=
Received: from BYAPR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:74::19)
 by SA2PR10MB4604.namprd10.prod.outlook.com (2603:10b6:806:11c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 08:42:40 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::1f) by BYAPR05CA0025.outlook.office365.com
 (2603:10b6:a03:74::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 08:42:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 08:42:39 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:24 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:24 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 02:42:24 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AN8gIfk2298779;
	Mon, 23 Nov 2026 02:42:19 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 0/2] Allow platform drivers to skip PM domain power-on at probe
Date: Mon, 23 Nov 2026 14:12:16 +0530
Message-ID: <20261123084218.673382-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SA2PR10MB4604:EE_
X-MS-Office365-Filtering-Correlation-Id: e591df38-3a80-4bdf-b7d0-08df493dbb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|18002099003|261021121427099003|261021123027099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	RUxMcJMC8QkjyTud9Em8dL3w0CnJ7d5H2Icee3mhXN15CMSS7juLVwjQBfBvc/RaQGMJJCcxuc8vu6oWROJeuBdXtNCfJEzV7ewHqQ2Qv2tO2j2B5+xsfS2Kp3bWvRNyNPTzWBw1rs6Muelh5UpXpt0vQWqLh5C1Hsztlclov/pArlRzyjIZA56RNwfc65eoNQdThThoIOiUhbnsQCfivgsLQQ1C3sAhdxXgsISy87dNzLPgr/KBKuoJzL9smxx/xFwX2vCZfSVoo2YF5uBPEB1ezJBXg3qC1eoezc3SI8Y1dzQ5Hyefd2YlO8yRE2Or5kLgjzm0cJnkhNDGYDks0KX2zCoKo3mqmJzpTQ5EWSO0LNzeFk5T5jj1F+cdhJF2JUO1Fq1AfvWW4jm6Ci6Mow50lVCkFEgbDbS2JHTJa3kEF0XWiPK+FQ1FcwQHm+T7a587Eow8WQu5vtr9Dpi6doG2Pj85lVYPrmRBKSjiDq+DsHSWVUt9sGkWDnyRYBJg+nI3nAGAk8weiluHkt+SWV+8MzwFVQTOcAFdG42mRPJvPDRkX7/8udtmBxMpiLC3KNC9QXgcJOiaBeKrC1nhln52+70JJk3N/z3QI9q2ZZG8WfQ5wwsvWFTpJ+T2j3teL3GMWde2m2NNDbJ/Ere51A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qpO6OXWjqCL/9B7B2DSBxT3wJPOauxgcqwSXEpwX1hTDITElO9u8FIjhQm+ycucl0uEOwF3faJ0IN1X/wSKUih9CXsp5l7W6iRzpmxwXwPX+n2JcSpI/G6EW9Sk9nt02ibhptCr0Pod5P4Vrw8wRFYdN+ChmaMSK8HNui9Ghi6YqGfuOnXhyOkISM737kzn2u41lAuvF5TZZFDoqrlLFWMtF74N8jthjCWh08fSKm0TdAXaRV6yzqhWwrJV39zani2Ti/+8HrqVTIPo6ly1l9WOCuUgm/gBpHeKli2Hz7QJ5ovd9Ik69iwgqq7VTe87s7A5A+hM377yrxUbCk5fVXPoKhEpHp+0Zu0OhSvcbW0xW9p3feMXm0JXW7ugpN1WaUsBhIOrvTMmaol6MtrYZWcIJaWf9u8BRNYVHoPtB0jeeHwc5B1BWXhX+EcwzQzbh
X-Exchange-RoutingPolicyChecked:
	AMF/ERJ6GSFuBovT3MJVSZ/a7GErEEtdJXZyuclFFQRS8C+TvSRKldGh3MXARd6/Tqq8Wsrdwsx+otAUOR4Yu4chl/nUcO9bs25YFnTUx4I9jH3mZwVSN/PuQTB4+0VdSx/XMp58tRJ1Hw+R1uBmq3gA1TYLYphyMZZswmVU1A0MVdP+O5wDGOfveh2M+vTtUlJclMvptlAKAKEwUIT+33d9bjw6ihaIkBbmDYsCFC8UDsiASFUH/cqAcz/uCQGoyIOSKW3liMC+VqyhxborgJoht/bmoXXT+FFTdIsvT3l4WCsy5oTJEOTslPzzFPE56eDxHwW9GDrJg7nsZaPY/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:42:39.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e591df38-3a80-4bdf-b7d0-08df493dbb85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4604
X-Proofpoint-GUID: zNFgb-QKIk3DcG-OrTshol5KuJeFDguu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX3s9bIHcnCzt9
 A77n9mIEIVoFLlr19Bkf0l+5B9uU7kaOXEEbijEMnBLyN58qdeH8EkuQa9csdjAL92eBnABKWiq
 8Hr7YdB1onj8efmCKxv1imOVkM8rlcTN2vqm6T2jUtLQw9Jez+Lmbj9ZGlmo2ZkNY8M4iU4Ct8o
 9htENDI89C1jTCtPsFUeKlAX8O7aZ5VNFBsi8jcI2g1OfSnVUwryMxNiqyxD1uCUndLKvaqNegj
 oOQSyqIGHSt3yeBOGH3CbhQp0XzxZdlzAHxrXOB8930xH3UxkBHsgcyXmRVxfWg8+gds6xirY6G
 TjfvywIEIn/UUYzpxlQIDEIOu+nbzFAnqygdBEvaO0Qcz1ufNWS7I7ufpzicKZ1gAqHGZ07k6L2
 blK+pCUxZnCDYjGpdcfJkH3Oho1n/IXPlAyiWEnHHLitYNkahyf4QurZiVtCqzGF6v72iwkdKH0
 91iZ02qGyiwHDGUDkcA==
X-Authority-Analysis: v=2.4 cv=IYISymqa c=1 sm=1 tr=0 ts=6b03fc84 cx=c_pps
 a=urLXRHf+rrcNZWEu7FangQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=UADNjzvouC0em2RctdYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX1yOP9/oUvSiW
 phlZVDIMNyK9rUVbjn0phheP9VT8KYlxuxAyf7P9O280bBpZylbG23/KMVbHEC2hForqjWgdmS0
 LkvQpS/ys64y3cVmKwT6NdIhiOkHBwY=
X-Proofpoint-ORIG-GUID: zNFgb-QKIk3DcG-OrTshol5KuJeFDguu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230034

Some devices must be configured before their PM domain is powered on,
but on DT based platforms platform_probe() always powers it on first.
This series lets a platform driver opt out.

The user will be the TI K3 DSP/M4 remoteproc drivers which need to put
those remote cores in reset before powering on the pmdomain. A patch has
been posted to add "power-domains" DT property to these devices[0] which
is the motivation of this series as well.

[0]: https://lore.kernel.org/all/8cb23b44-027d-4d81-b342-7eaca0248f63@ti.com

No changelog since RFC. Re-submitted after removing RFC tag.

Link to RFC:
https://lore.kernel.org/all/20261027140751.2465743-1-b-padhi@ti.com/

Thanks,
Beleswar

Beleswar Padhi (2):
  PM: domains: Honour PD_FLAG_ATTACH_POWER_ON for genpd
  driver core: platform: Allow drivers to skip PM domain power-on at
    probe

 drivers/base/platform.c         | 7 +++++--
 drivers/base/power/common.c     | 5 +++--
 drivers/pmdomain/core.c         | 5 +++--
 include/linux/platform_device.h | 8 ++++++++
 include/linux/pm_domain.h       | 4 ++--
 5 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.34.1

