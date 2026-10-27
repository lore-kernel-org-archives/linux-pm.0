Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110138;
	b=Fc7GbSgKXyKK/ma6mTlGfjhUpZJqKs6VVH3xL0Bc3I8tLGgcnYBIzWgw68++7TBHh5uD
	 5vr+aaXn+TXS99oPRcSqO19FMpkDk6a7pgyYMXauEKtOUQgxCAepPfbJBbUPuuqI0Vi5U
	 QX0mbOfjhCPTaqYfJCchZI+GvQ4W7cg2PAtnGNx/QSO4joeAEOa231WhPKJZWh4ttUnhz
	 lRuvlZQGrCgN8J++NmUK1ebckGmqJa1OrNAnYZ0HnOwbXDqk0uAyuCj7p7JcwZrLV66S6
	 mopQMQDNL7rTIauVswx/bfHbxG2WlRDR6PcNHHMQ92DlqZUkPD9pRPNj18Ybek1hZSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110138;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8q3q2JtIfl/F6WvQT4UjzaOdPSyvjpsMfV8TapYNAxI=;
	b=iLqiFtm6dysGe8xqeXoTtbly2MyMGYJZYpfeRytDCCRv6pLrmxwBFhKMSrLzkHoLkMzr
	 qTRJsBy4xM2f0/tDPQQvmEeUkOeDLK81Qzj0S8z84MOd9de8zwJcX1HVxwViN5eOwE0Nd
	 ZW4SmFxIoE8BljZI+0cKvWvOi0JQpmu5rgCAHgg9W7e63+WPeXc7HIGVQTeIrq0ReRynX
	 fVJVNymaEpXjTqn/4RBxRIL6hLGANvBGFeCG+XURsnUbvalA5ulvfp7M9scZXSVJBiiVt
	 movNu4S2xZ5xz6fyzDX9KJmYAOzvlYVPo26eNOr22oAhkJSoVvx+3QusPN3gOAgjFYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i58ntB0Q;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j2n249Rg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A3606A336;
	Tue, 27 Oct 2026 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C6A3606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i58ntB0Q;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=j2n249Rg
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDmFCi856473;
	Tue, 27 Oct 2026 09:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=8q3q2JtIfl/F6
	WvQT4UjzaOdPSyvjpsMfV8TapYNAxI=; b=i58ntB0QUmGjNBoCXtBK1yloEgPoA
	+W3dOcOa+5bIBOqNAC30Ql3I+ynHbkPXZdxgLsz5XmCmbuta4Y8fRhnH3J3wUsIG
	k+B53S8wKJ0FiH8SBzctXDrGyxZdiPWrAGrHFHngesYXwbG/uzCWkLGkuWTueTJS
	DiUQIpDatYrChgGxV9K8dJDo2ss90piOwchpZ/cYTOHeFYcF96T26lsw21Vx4rPn
	SmTn/aefg22fQiC1KEjLKbMpf6r9pJ7/aHe4UUboNZoFv662Q8IoUq4nCeG3Opiw
	pq9VRhgnP2Qyo1jJrqHuncI5+CCz9ZH2lPFn0WqnUAOPF2oU982GjV33A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hjuyv0n30-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:08:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwXSa1cIPvsW8S4/KPyWXPFGPV5MyI6vbteCcTGKSspucAB20Rpl+oHWrNmPc2ID69VrZhtBrO+xdDSUOorXRedP38KtY40uqpc6tFVqYg2r7CyiIeBgU7ZG1aDmFas4dActD2vFTSK62WL46MZZ+x/Om7E0lVAHGv2pvoPawS9t6d37InHnARzhZQ9tgNZo0so0uD/oIkcBFQbcImUlwYOSd1qbATy6PqPtqtvrula0ZnjuZQ2hioJ4MC9rl4fl8AzIOCsj9RGuygcUOw6Nk1lAcscOCqnOH/RugEiKc6hGpF0sYGQmSuM27wJHpfdeNfgg9FvbD5nhJEdIxlqjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q3q2JtIfl/F6WvQT4UjzaOdPSyvjpsMfV8TapYNAxI=;
 b=Ar5kOoVPGZYELxSxdwT9FS4f8ID4LDYxnqfi8PbKvJPvrJj9oZkMZeoOqs7nQUt+8T1tD41+qBeaX5zi84i9vl3G3EsZlYXhyan4XiIG2c+YNJlyHCVtSKQlz0rk07W+RKCTLNQjwlQFd2hwuhTs3sGC1mheVFTHiLqjhkOoRdy/DwAk8MPfj7Tp992mLfuw4hGqx9cujAlVNpXxcDSTPOQTY8A/+U08iqmtNL4pJeIWVevkKPs6BnqK/hlZpuWEkCUFGecUQxhKRc1bCJZqmYlylGbHDt9W87brd82SsxgoOmdoO4sjvWEacHbILdrUPiLI4Noi5XH8mpej+RNk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q3q2JtIfl/F6WvQT4UjzaOdPSyvjpsMfV8TapYNAxI=;
 b=j2n249RgML95nyKdFv8bWaZgi4M7tgJDJmJQG+7gZMPH0v6rykZO/B3EO2ns6BbCItUhdsP7UKF5002YfdRZoJCOAcGABmm9KrSiAr3A228odlEDwQKwEEIDyUErBiYuMUHnYCj3OIhQHSH5awI7h0e+OaWeEs6q0tax09DG1pg=
Received: from BYAPR21CA0012.namprd21.prod.outlook.com (2603:10b6:a03:114::22)
 by IA1PR10MB6075.namprd10.prod.outlook.com (2603:10b6:208:3ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 14:08:48 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::a2) by BYAPR21CA0012.outlook.office365.com
 (2603:10b6:a03:114::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.3 via Frontend Transport; Tue, 27
 Oct 2026 14:08:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:08:47 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:07:56 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:07:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 09:07:56 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RE7pff2040122;
	Tue, 27 Oct 2026 09:07:52 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 0/2] Allow platform drivers to skip PM domain power-on at probe
Date: Tue, 27 Oct 2026 19:37:49 +0530
Message-ID: <20261027140751.2465743-1-b-padhi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA1PR10MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a490f4-62f1-428f-9d59-08df3433d1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|7416014|18002099003|261026140227099003|56012099006|261021123027099003|10067099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	7NBrP+5L1XQjlSits3SshPRMYHZ4qnnJXqY2iveLULRJlVh91onHQXZpis1V5C+unUVS6Ld1p+JwvH83qv8qqwKoY8ZvlwLt6XFxqa0ME5EZFrGXrqwU/MQpHHAU6VVH5x5AxudAz9XBbQFLMy3R0t/rL1zPhYHMQ2SdG2bxaBbkiY6PehpAoX5VkAINoClV0nmd5mFFMoEeReg1qM6YRSugilwYqM8eUkgj5KabPzBnudtApslWgHKhx1JulcpL7p7yf/9e32z0pSeLJ05Z3OhrcrqWrfY4WEBxZ5gOjTgWV3RguQgn89tJ1Gg4UCo8vYc65YuupLRxGI4yg3kFfkMKCOzr4at/9ucNOcSnyVO1U+TdiL5k1w5+G9U7MgHKmdFeuzFDJptvXRexhzt8Yqo2r2PmXvSUrLzzZ+GuhA61M+PfM64qJUQYPOd9E5ah8P+Scj4vpjcbLzeaq/49r8Dj2QFPTCO7erV4nRVkGV9Km5dPuVY5FFQW1fAHSh91XPgOdDP7+XcPBnMvtwuePU1d5DvtWVcnPT1jGR1zaCjdpooNQGKJhzsk6uOFpFK1cbVD1eZrN+MeZ47AVTIx4UzRXvwzcXuWChYWq8UUvdbIVbF/xyOdsPofxxVx6u+vFhkGNUyaTfmJ3gbmOTChfw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(7416014)(18002099003)(261026140227099003)(56012099006)(261021123027099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6NaEu8JDZJgcxczGLNdeFj1VPlhB4covMaqYttzQQauztD1l++ucizNMg8uwaoTQISpPqLoloeMIllVL4XIWvZj7Z0+0Pl9Ju30kMCg3K/ZDoaJettsRX1y0O2aNCc8YVM0yWDrEPfkHjBxrOloeasUHB+nB3QS/V5WqezgEkJQ8E+ER6TQ5VGpvPbmVydxsHsPdZfx7ZgW/YMyWT52sCpDspf60FAGRCfCd4FCjDzvrVX9j2YKO9BcVC3AEtJ9+Rs4+cBbrULKan2LVk/fvESEQYwtU5FxXEBtkyXcMDrYbiLUDVOIUElnJBLQTPTI9x2FS94VTcmN9EpGzowqb+ge4KUtm1+4K9O/Jbig1IfEhtqlw6XeOzYnyn91nrik6lDDiSfp/rJwCZcj38P9aElCN7nvaQafxMZXsxMSrk2P/nE31nQXfPeB9N8blw+G/
X-Exchange-RoutingPolicyChecked:
	Rly4nu4iohl6nZEyeNJ8X0Xa4tD6LMtJ1T10wXbVKcUp0fWjsoc27GFg/WgUI8zbAi8+Je6Ay62Onq1uaMjFdIaOb8kTznm9GArwjFUr6tNJLv2zX0ubsmavod/1HfGzhAXtVKqBrpCMNngvfxNPFhiOuPVBwEq6OqdsDfQRWRtsAKtT7pa5c3E1vxtX0IJ0mJPQrBMm2U2TRwGOLuxtZhGukAhMg21DvufxUfqJ7Sji7G52DwPT5iYTeSV+QJ/SscPVl7KOWOR3r+KWT8dfVUNyM4hxcbggArtnLfIev46Je5WiHQtLFXNP6khKDqeStVBmcRxx1tH1PXLoQvt86A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:08:47.4966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a490f4-62f1-428f-9d59-08df3433d1b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6075
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXxpRCe0v8wTe9
 jRlrsbbMvun5kL3PMotb+djUNHbaAeJmZmVMWyZeFOGRar5R++/sgEHjk6UuWWdgOvVuiaeDFQz
 bXkTfniZsw/Uq2gPymuUAkk5VA1iL14=
X-Authority-Analysis: v=2.4 cv=KPHPn1Fo c=1 sm=1 tr=0 ts=6ae0b074 cx=c_pps
 a=9D7zFwNo98o+tMWDMQIn6w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UADNjzvouC0em2RctdYA:9
X-Proofpoint-ORIG-GUID: 0f-OXkZMvJxd6RC3oAEajWXeS1justYp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXyeCNbJ3f5tK/
 DKA9xSievgNQSUdtFDTu4jtFy4K/CmqSYCH85n5iRfe4HpLDT2xEcs31/UIRzbsYZNg7t68Drcq
 p2pBbZvastoXggV4BYULZ/CFCZrqCZNtfNjNzenD9UG0Fi6M8w04RyTmfr4keln1JwyrmAL0ldP
 jxgg2t8Wgp3Vxg5wUWays7ALEY8zanTXyFJ0RQfsuYBKRjBSKq6g1474nOuuDwMJWO+KNNqh77y
 +hBF8Q6mAXumyv3m5PrX1DXYlF9JVh7ocO1Vt/HoQUNWnY8ZrXO1q+jVSvz0UPhIO4sob624/wj
 +MkUssTIky0QrOGq7Tnv726H3IdAnEdIu4MBhF4otLXnnzr7cWz3Uw0CVQ7ZO3hCaEIeWugx441
 H/ORC0tSIYsEIvZQm2+gOpe+cG7adb9DevulUxvyjJUDmc/ev592J4FPMuf3VRU6H3TMrB1240H
 dxOxyXhhikySA9uvUEg==
X-Proofpoint-GUID: 0f-OXkZMvJxd6RC3oAEajWXeS1justYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Some devices must be configured before their PM domain is powered on,
but on DT based platforms platform_probe() always powers it on first.
This series lets a platform driver opt out.

The user will be the TI K3 DSP/M4 remoteproc drivers which need to put
those remote cores in reset before powering on the pmdomain. A patch has
been posted to add "power-domains" DT property to these devices[0] which
is the motivation of this series as well.

[0]: https://lore.kernel.org/all/8cb23b44-027d-4d81-b342-7eaca0248f63@ti.com/

Please provide your comments.

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

