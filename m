Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110148;
	b=pQtpimJCfSMLK1fp5XA+KAdRHEAe2HVdnGpq91PHzF9f+/l3D7kUmA6/VXPoZzai9VuG
	 C/v3IJFnNBqjMX4oZOJwaIfmXdnyNyjGVm6ulyq0XEovIrGxLMUjEpk5YCBUOmO/1fHgq
	 04iG55s0VmEpZEsFdo6fHcsidDOv099mF6ynaPZocFG2yHetM02PCoPBBIVJ51gv16ja9
	 gw+svRbX27lQSuc2iSVzDJbFOak6/7II0Iu/YRrKFqokHVNWweLWXYLZvfhH2hfTDcF4k
	 4xZRbFVieObsd8nN494zn/jp000fmcFluEFqrmbtnpG8jPrbTj6/4ZSxtQY5jFIkaVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110148;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7RlZJqglhfpA5WLHh36utK7jH7Ieqr/JW9qtq5IrM4w=;
	b=tHqCkTmqYRBpNnKI8YKh1pZXCCJZ894NVyzdV3Tn2SB8rqgUT1Z3ed496qkuPHrvZzO4
	 rl4berBvugdgSAC+Z9ToLydHPfxYEdz2D0bJR+7Homt6BUZ5arI1tP32eX3YUaTi1enkr
	 Rn59uFThCa2NdOCc5AHMz09DCNaZhbyflTGJKHUGfQpKqUoUQRBjRaz0DtkCnXITpQYUC
	 IUxRya1ZJ9LvFKlmaRfNpF/qKphypQEnLRRLHfKfFDvS98Kcwxkrj5f4v01AYYdd6uScy
	 9LWZTU4icmNHJluQ0YGFeHX/483SqenKu/T1/Wfc8U3OVwV/jD8gNBukqOPk1YxsgQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DJlQwGmD;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RXoPXHcP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2ED60A2616;
	Tue, 27 Oct 2026 14:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2ED60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DJlQwGmD;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RXoPXHcP
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDmeFS1461730;
	Tue, 27 Oct 2026 09:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=7RlZJqglhfpA5WLHh36utK7jH7Ieqr/JW9qtq5IrM
	4w=; b=DJlQwGmDFmQE44KKjgCqlVFDQ0yUWRox09VpYC7ZJaPW5zL+06GNsiEyK
	lm980xNy+bm8oq1zM4Nz7Q+TmTokbISIrCHVxBCLF5RsJmvOnlHSiYvI61We8KPM
	RNCoFNkofEWj7piyorp+jH5WDeFR3+W6bxnTYTHPmI5jvIgzKGrTiJ7uTjEuC5wC
	iSKOAq1t0LuMqUDVpT0HCNJAFv2fk/5usHdgOAPhzREepCHxWTiTGx1rlZr4hbHW
	EHk2MI9vrnbQtrkau4T2+36FTZMNDBua5vTnwsLxjb996M7n4aSP8fJyPl9hJtmN
	qzVTTryQsYRMCFVyWZhsU/EFjm61g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hjp2yjtxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:09:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+6xdI1wMtk6KoaoHXEoqe7MtAf4KA/IkZIjUHrj/h6a70VAJiotXMNgTCuArWfxwLsPawfGahhe3gEiMNaLIm7nmVoS99Z+6itzoTjoy0uchR0+FdSDArfBL5r9TFPOmCkXpmHIdYJHFZqw0ITn756WdLkdBEs5N5yQYrvWrn8DrdYMq4mYFQQT2rRfXrCLZZ6Jq1OgrJRuCHUjrkv981zpIPJ5P6Xam7D/ZS40GEQ3sHyinI46nVifCYtVfTT/fkWNzyXzGyt7fOJ/iIytM83gHls+iv5CBO+0A7P8C4RZvtZLL433HAzWq1vvCJAQfCxBfCnYdHJ/1Dztb93jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RlZJqglhfpA5WLHh36utK7jH7Ieqr/JW9qtq5IrM4w=;
 b=Bf/cODAKUac8ZpwphqQ8sce4Rm3kR1YueUbJYNeJTqQKcFcO3pBBlmDB9elMq1DA6XR2KHaEvV486A5D0d+0qsqtHoKVWUyd9/kZWlLw9EXojYlRfCRHGo3Nfbptd7Jp+RrQgrMHMwEqPfXmotwpLuRCEN34XNVtEIMy3c4OlniWejc9BEgzOwVHfpIfNm9T5F3YTBjffAIV9NLP+ttzqkXCMvrCvimNyST9BTk1+F8JK4zgnhgpqdDehUgxO3KJSaQ6tM5iFyEwpRTvUmudslHqbx1TE9sxQteP01cNv3ZT2meH5fdGFtSIxKaJVDyLRBaNRELi1sk0/Wa9Uyo7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RlZJqglhfpA5WLHh36utK7jH7Ieqr/JW9qtq5IrM4w=;
 b=RXoPXHcPpKqgmFFlsaL7LU9C8JOXEZQdyppvm1nYPIiFCRq6G+utCLesupQCkOkSIK80BIZIJqduWyUhMxgvJ29pNoBNU1FAi5s3Mak4KXbYLxw5ADddQhDnVWYEwubNkUm1fH3+UZI61CzNNSM+SngjlnsRcgH2uSXGXooQAvA=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by DSWPR10MB997884.namprd10.prod.outlook.com (2603:10b6:8:39f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 27 Oct
 2026 14:08:59 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::8f) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Tue,
 27 Oct 2026 14:08:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:08:57 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:08:06 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:08:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 09:08:06 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RE7pfh2040122;
	Tue, 27 Oct 2026 09:08:01 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 2/2] driver core: platform: Allow drivers to skip PM domain power-on at probe
Date: Tue, 27 Oct 2026 19:37:51 +0530
Message-ID: <20261027140751.2465743-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027140751.2465743-1-b-padhi@ti.com>
References: <20261027140751.2465743-1-b-padhi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DSWPR10MB997884:EE_
X-MS-Office365-Filtering-Correlation-Id: b6218ecb-d078-44aa-406e-08df3433d7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|261026140227099003|10067099003|56012099006|261021121427099003|5023799004|261009223027099003|261021123027099003|261026121527099003|22082099003|18002099003|6133799003|261022105027099003|261022075727099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SHMt9CE/7tyI/tTX7A7L/OEnDxZE2o/KVPN8qLlP31dT6pEepFVJhzF7pil2Cvoz3d9V6ob+0OiQtKNaTrD5QmeYUAx+VojO25F9gNHXBs50waYkJt+6+aZYXXrADmAyKqa+19NACLxScIv/CDasg0yyOBZ3sFmTsh6LRO2RLdREKuzdBnbrFAUdLpM4aO7hWAa4anpglAkKc5bllhg7vV0+gq6kNucjeGDNZhfzHC70dQS065bn0IRS6lvqdKNlfGHfhBoLTEdlNjNb4t5731FNKo32sHAQWj3K3XeEhE8+BufwylsXXnzgTgwfrB08SOCx1NVtw4VbYaIiD12ycyb9iWGnt65zGKzPD+PqHXY0w9GCe6G7oW20jmqIhwMRpZU4cr2efsy+1qW/msZykibFpSsqyI+a2QgE8J//ggCeRxJOztGnRD0FKaIR5QESVV1v9w4SPfITC8lXrLIeAOtwVsabzvclIIsNtePPpzuCnqi3lAVZZeAMNEN6xKf+2VTzo10EfnmgZ4vEWUl7tasHZavREwzhloQz0IWcyEOuCHLGU1pwWH9d2fSViKobYU0XH9P3lnGqPwW9mCbJxzMGYSVORB1ML0Oll+/DWvjhnWiqWXRHy5xzy6kRl1hR9YaLLP+rOT7MtbTvHF5PaL23lcOcG1FA1Vlv5w1/l+liJ1ttM4AP63yadl1FFiw1fSw0QR7hW+nju8nMAujMTg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(261026140227099003)(10067099003)(56012099006)(261021121427099003)(5023799004)(261009223027099003)(261021123027099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(261022105027099003)(261022075727099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v0853lBvx6aO2/X5EVPBa4+hoVvek3C/VFz0StwL9+AJjnsCBtckXaJz0s5p4MlcLXW++rbur1B/cV1l+oMzHLtv0y9v6e4YNF8TuikeEiVkqgJiwq0bjT/Ww3pRWWRwqQoCSFYE8YBb6oJonyKbgIbKW/Msou3SCTi7TlWQAHrO+oO0MYHJ9OJGtydk4jY/sprnVfUNIswpg69rLmaLzYuwMomzTLLbMdXkJa4kTJqXlRNI1U0ZI3ck8PfGivURSFzAHTdA6guayPfOYWLF74aYSeQve7T32Knnr5p2S0C8UQrZYQtqoYTrOMqFnQrO2yWky8PqZxONWvX3wqHVKtEFpOrAE5TmGeQmbrOHXqLTwu2LhzF57LQyW6G3OkrYtbW3YeJbvXZZ+lHKDQazdSk7irn8udEQnqRce1YE9M3e5EamI2tGnsSRXxltBiYm
X-Exchange-RoutingPolicyChecked:
	EknTo/F+PDzhMAJ9DMF6NbI2RXZFD8UPZoRJ25nwTuK2Y8IBn++U6/ngaJJVeJFbAkNKzewuvcusrbIw02sQmex9smAtjyj5fzHw/1Qvt+jaok3tO5Jux14Vz9FnvLWBcgxx8bpx5jpY5g6XHjVBuX/fSAyNDREE+6f6i0rMORS/+qrO0OMSV8zbuNxomlZvBsyoKQb0L4nsurX4FJFps8Fnz2Mn5PigGkLSW0czAV50+HUhHALpQyneG+8ZlQR5Mo2kQAob3PQHua1I+1PyUAHNVHhMTyxLTCpiCw8p+NZcpQA2UNxxKGu2DApNMtFraRvCx3NlgIpxNxWscZu5Ng==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:08:57.5669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6218ecb-d078-44aa-406e-08df3433d7b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997884
X-Proofpoint-ORIG-GUID: pQe5mPz5uHLDdprFn_jSrgD5qQGcNniB
X-Proofpoint-GUID: pQe5mPz5uHLDdprFn_jSrgD5qQGcNniB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXxuavJiJNP3gA
 iL4AUcHeZAp1e0DVhMMrDBXS21xJNX0Ax0f/BwTbTi1Mk9FdD/UEFEoCixYxygBMGiaGk3MvRKz
 OGjFTKsGMvhU4rcg2t/dGg5GXVRgl4CpbrboknsZKN+uPR0k2aY4IYX7L91Nvb1YiBEsh2YDs4Q
 R+B584cAcmJBej99VTJqkf9f1useQ5th820CCB+9HjLChqVkzkqztNl5wgG7TPU6+uvJUD/4f9t
 /OWqSSg8zPeeRAMn6a5wSmYkCUTaczJl+kUFrNuih4xms9SaMtoJAWEz1gSAmAr9xjVPAc47pll
 KBrEChBZ4yme9rMYfDr0eR87hwJjGTu+LMGvY9m0VizrjFwsG3Zf+kDHco0sGsi/aafWwyt2FCK
 MOluZZBiteuV1SsvacfJ68pVK6frH+HB+DGmeCm2MdahIyvZkDylCoFyRvUWIMt7JoMxKPUpK1A
 99OqBD60DjjIcHdoFZg==
X-Authority-Analysis: v=2.4 cv=FbaiV5+6 c=1 sm=1 tr=0 ts=6ae0b07e cx=c_pps
 a=kfEGYAivpUbBRfgbjfv6iA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=LTqVseZ_fjbzjx0MZbUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1pHwmqppWflo
 QbhisdtDXjiyLqlmMNXzUYzi/oUFHXAWeF3VwOZs2DesP1TLfXSFb3xwYFHPl04on4EBDBI56Ie
 c9gYnelrvNSgGOZB427GiJ3GNr4oVLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

Currently, platform_probe() attaches the PM domain to the device and
powers the domain on before calling the driver's probe. This works for
most cases, but would be erroneous for devices that must be configured
before they can be powered on.

One example is the C66x/C7x remote processors on TI K3 SoCs like AM62A.
Such a remote core's local reset must be asserted before the device is
powered on, otherwise the core can start running bogus instructions
whatever happens to be in its memories at that point.

dev_pm_domain_attach() lets its caller skip the power-on by not passing
PD_FLAG_ATTACH_POWER_ON. So, add a pm_domain_no_power_on flag to struct
platform_driver by which platform drivers can opt out of the power-on
at attach. Drivers that set it must power on the PM domain themselves.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/base/platform.c         | 7 +++++--
 include/linux/platform_device.h | 8 ++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3593d45f4a7ae..774f7214877d9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1483,6 +1483,7 @@ static int platform_probe(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
+	u32 pd_flags = PD_FLAG_DETACH_POWER_OFF;
 	int ret;
 
 	/*
@@ -1499,8 +1500,10 @@ static int platform_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
-					 PD_FLAG_DETACH_POWER_OFF);
+	if (!drv->pm_domain_no_power_on)
+		pd_flags |= PD_FLAG_ATTACH_POWER_ON;
+
+	ret = dev_pm_domain_attach(_dev, pd_flags);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 3bd0f1f0d8704..4d1679c4ea78e 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -292,6 +292,14 @@ struct platform_driver {
 	 * to setup and manage their own I/O address space.
 	 */
 	bool driver_managed_dma;
+	/*
+	 * By default the PM domain of a platform device is powered on before
+	 * the driver's probe is invoked. Drivers that need to configure the
+	 * device (e.g. hold it in reset) before its PM domain can be powered
+	 * on must set this flag, and are then responsible for powering on the
+	 * PM domain themselves.
+	 */
+	bool pm_domain_no_power_on;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
-- 
2.34.1

