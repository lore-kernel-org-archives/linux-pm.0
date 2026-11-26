Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683370;
	b=T9El/W+zu3uW4l6lS+WIlSOmiFmkyH6C/QFhKdolIIkH0HnboNXaLceidFOjeIQdDTUb
	 jwhUh+2h6LxWO5FErCfCFA61Z60VGIjIGqv9/yW+y+53Z5UOZR7V2eUoeC69BVWZrLmhr
	 WvhHzAGz4jLqYgaqU16sWSezfoGJaDJhZiX2cfXfdW7dTDQbnfI8UZJcXuXvR6klfDg5X
	 vC2sEhrbGp579RoWyJCSlzGGbvNN2l8E4QS8BeRQa+aZkUjY+6t7sJjDL+TBlUi4xnj1v
	 pb1HhZ63/QbJGpKmhm/zPeQ2svYKzzwviZQFNCxyTo55TK4eWLmYxnhrNhXeazb52ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683370;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=k42k+geJzawg3w4e53lp9hkcYfZ0uHoFHWcFHGk5jCg=;
	b=KU56ktDAsDKJeQf7N2LAGrO5HhDiRJmrZV1nTxABgM46Ow3rcbjdifhP+tJQy6ak7qGX
	 BGo/daXXtmCotAGxAzLyKfLiHPqk7ckTptzFLlLLG04KwvgT3FZYGgvkmrXXC1hh4OKmi
	 aL+ts8HFx+Psyu69gMOBByEUkUcxZArq2gNoFwN/yxwJvThf8LaJm1aMPD0zxIPQKcOZh
	 f6dKHiBI7nQb/n6SSF9l9QCEzfPmS3UPZlKeQSCpondYHMfFDeqwxHP7aaG+oOLaSgbbX
	 U0YIXt5Si6axI2ok7QIG9pUEC15CqXHYR1iJ1ep/z77lE4p92U40DC6JykobeW6hqnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=frUtwdBR;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=G8fxhFyD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D850606A32A;
	Thu, 26 Nov 2026 08:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D850606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=frUtwdBR;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=G8fxhFyD
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Bclc3007657;
	Thu, 26 Nov 2026 02:55:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=k42k+geJzawg3w4e53lp9hkcYfZ0uHoFHWcFHGk5j
	Cg=; b=frUtwdBRzwY2O7iJyBzJDhM4rgP6sukKjLkEB+3xtYdWytCM98w4G4LjN
	1GhcBdcGqHF762Dqp0UvHQC9z3Cq+Vu8/0OBeKLjlAevFtZ/RbqhBZerWefEx/60
	8WmJvDUDQv0yupA6DJYAQWertdzgkKejpitQI1fnhDSAMDu7/NwYn7yrEF+aSzOn
	uxmCuFm3iFzqUtxxQRgwd8xvIM0n9LTIXXRgPGq4q306l1wbi3xNkmGbIbgDZ9pK
	p4BIRxfwzlaUZa02zRJsRrQwHuxrvMdXmVgD3vKlbY0eyWj7un3x2mzfceXgI0r4
	5uFaM1Fuqqi2AF06o9harkiGDkr9Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j606fdwkh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 02:55:59 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okOVfZIJ0GOKuQRSjVeqRZBJZMmC/QiwaDFFVhY4zTo7qJ9syzcuzKX4rnyctEs8UgeGahD96OamUZF8CBQ6+G/SbdnEkJ9BkM8R7Av5pctS8ADqbkhQ4NlyR4SEPI5KLwcptbMzJ6lq5yxmPXFEt9Z3QG+vetntoWs6BiiomF4GLmVIKe9hNQbs6Zh5NLEg9xiYqcg01oAG9Wdq9qAYumK5oOSMo09twTSxmyXxngNerVcWVlYF5pVYstDG+xl4DdcW6D4/8aGrpViHg51D7jWn7N+n6KfzNMcmhQFTJkP+HOgpeQr+OFjUJ6rC7anmMbTWWYTeKtNQKKlPwOR5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k42k+geJzawg3w4e53lp9hkcYfZ0uHoFHWcFHGk5jCg=;
 b=O0cRQFfwdCu6nkH1MBA6aVobQz+wQkda1xAEq+MC4iXre2EKQCAjhYQriC6c2VuiIsfrYodmmiFCZVcBrw3Kuue2Jj2kE8B7lGabNU4LRE91/KL5ivI/dImqQ8xJ7P4CUB8qECHHp7W/HwMGXyyEeUjnbOc6nMGtea8fxDBXWIF4LBAqdmTTDhqvGqVw+MocSaY0Z/7GAVhUiUgWSEkAbfmX7NWgNbP5HVrLKzWwZ40E89bWKDn9dx6rbtXEyiuMHkUe5ckZCP1uX3SyEAN6SfODpKZ9BAQ0FqHgrKg0hTmuPYusUuzCZsvM8rekNYJ6kzg5E8iJhM0QNYvvs3+2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k42k+geJzawg3w4e53lp9hkcYfZ0uHoFHWcFHGk5jCg=;
 b=G8fxhFyDt6REwBgQNlG0bjm+PhFeP9cn8qNx3Sq6sZ4gpq8UvLLB89/QrXSX358Xf9gAKvhoaa0aqPYz5WCf36vD/PmFHoO+4H5G0V6rW0E6oemaNRQJzT6mAB2Qa+77HV9edpWkxAyFxkBGSGkrSe+ZzVN3tqaT1unYkbqpbAc=
Received: from DS1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:8:450::11)
 by CH3PR10MB7702.namprd10.prod.outlook.com (2603:10b6:610:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 08:55:56 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:8:450:cafe::6c) by DS1PR03CA0014.outlook.office365.com
 (2603:10b6:8:450::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 08:55:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 08:55:55 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 02:55:35 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 02:55:34 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 26 Nov 2026 02:55:34 -0600
Received: from [10.24.50.162] (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AQ8tU8d1369862;
	Thu, 26 Nov 2026 02:55:30 -0600
Message-ID: <4b4ebff0-9c30-4541-94fb-4e49edf2bd55@ti.com>
Date: Thu, 26 Nov 2026 14:25:29 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] driver core: platform: Allow drivers to skip PM
 domain power-on at probe
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>, <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20261123084218.673382-1-b-padhi@ti.com>
 <20261123084218.673382-3-b-padhi@ti.com>
 <CAPx+jO9LhihGLHYSFR4Wd8GhOu_AC7tE49OJxrVEVAJyEDHhiw@mail.gmail.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <CAPx+jO9LhihGLHYSFR4Wd8GhOu_AC7tE49OJxrVEVAJyEDHhiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|CH3PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: ce34b025-006c-4817-4493-08df4b9b1556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|10067099003|56012099006|5023799004|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	56RbzHwvrWjqjbsnFVfAs9sZRJU5EczhzMpZbwxbkL1YNhEdp5uqfdmkKZ3sF80yTZttfkWyujb+kw+M37NY3EAAu03l9gOhtg7Z4Pf+xnT/lVoE9hWH+tAe5mQChr+l8RD7EHRS//rQOiRJp5UV3S3WZuzi4PIZiZCHHXmatzFe9RdHOqeFwHi3hMpLdcn817/Cbmc8U2VnXzWiFDQT8JTAA0AAHZ/r8ZNPwPi6jj1e6W863zJgKJ1E+q4/pUAFhGDMufvbPYyhb/KkrVHYzl0dQEEe4yMHfy5hTWE8/QumUPD+C4V3PdT3tqgkcFfA32P9gyeCrKgbIagIbeySFgz4oDWWtwQU5MF0AGXTiVC22D4IIoEHYj43s8cf1TNQFaitKBrkwWnism6+hqXS41d9/+G645PRU+RqfqbsuN4BlQt/KAn3im2ENBknlPOWm9dgWeHigo9buBtdvjEnf4wuV8DabtaXoLRW3S8O37JPp2+NVY2JpoV+qJiAffaZPi1MtRtT70dHPw8RX+2WSCv8leiGsC6zMJlrGKj1bzLHMZZuGtzfVCf4ebC848ph2Av+aUqSPns7q/uJ/nD1okyzRa6++tFWev+mnyeQh6wOY/dUWpGQ/GvPmSDn2FNT2ui7okeXscgoJ3wuRnq13iYcolxJ/N66oE+C9LdttVQ=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(5023799004)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MlZQgR2D4qLJ+p8kg9yOVLEcug3za4LgkDr0Gdd0H5K1j/HQ6gPa6S1cYoD1OiGkU1wyQ3LKRAuGuqg24he4HZhFZK3L35JWnHE8nzs1aJSVb+Tzk8biB98wd/uo4CWTMAK33Qf8QltJ0IWIKUQrS6gZjU7/xUSwuZdr7VrGRsRPa+kh1vAklke3V5zbSyuer/MwNuAI9Zvcqm37Yg3yBs3Xr9ljnSF6cK0QkNMqdwywEg2+H42mvwVorHBCGdN5jEdhInc4ntUCjI8nm4mLuseoLFwpPUzzFkW57SqQ0kJc3DsOxbgwHZq/P6YoCi7QBmYv6xvRRcsA1LtRDRV+Yxzp9AAnayWgTaNyFoMSTkqKXwYBwEXxRSJ7VHshoDk57ItZ8PoJnQDFJGWuvUuRcEPj/4dx/Pw/NfxcmwKIQPA1BMMBkuPbXS6gROtKLuON
X-Exchange-RoutingPolicyChecked:
	kS+1B8W0vKsELckvOE5pd50+4ocTmaurfb/PQJtkrmrktNoMPdYIgFkb6FPySCRut9qgSWmosaLSe1KSBL20NecrPf8qYK/qhg/1tDRa+USugIlIMA4OOJPfzP4IYsCUVIqfORy7qPDEtqpjgbrP80mHOE3KaHhh2hTldoMuZeeqMmttP3T5JkN8rLUMK5lb+TEebth7KgDgZKTpgzwwH2cP5N9/ywW6JEsHnGwZet5C/cUB+ugdi20E8c4ci0JFl3JO4B+iImeuM55TGzr31W7sMqAi9rD+nqck9qfq3CIml55nyUN/RE4RBeAEGtckqN+uamqVZdjcKxmm/2KF0A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:55:55.9048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce34b025-006c-4817-4493-08df4b9b1556
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7702
X-Proofpoint-GUID: fr2f3vnI-M7gzeYDStmJ1JDvcsXPpEpA
X-Proofpoint-ORIG-GUID: fr2f3vnI-M7gzeYDStmJ1JDvcsXPpEpA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzNCBTYWx0ZWRfX+LXuENmcMpva
 kN6kwMfRSRtXFESZROGFqlXQhVItCXhpdqa8Ts4NgTiQumw2lIzdh9peR1lj0r+Cq68Gnff3l+B
 R9MY249Ecq1mx5amXShKwHG1y6rqe78=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzNCBTYWx0ZWRfXyfhmaua+3iZY
 ePg76wi9oMJND705Ji38NnWlH2O31wwWPyAawGHJOdti7ZgMnRNSZG+E6UMYzmjkQJJTKpd4wHj
 nOKZXVAXMcaDFXPNxgGCXpKDQO4ZgAFvUQjpa9GSgIMdxZh5KcnIlZNyBsG1m2D0ZsIcIFIUzQ+
 eEmmAKEwV1jUd7CW3RvSS8aJ4CfcWETYdLAN1XahwFk0yic/Aenq4dKY3pkGS/hd4p2UzX084sZ
 BjK/78rmLg6OU8b6fv4rXbflS720Ng4lhbH1PZwzN/umUBIBIAmG3y6Hs1l9b81Td1aEJV/ZTE6
 E/QJTT5K+4u9nYCKPwH/FvrhiTpXRWF51JiJad9Lf0WroQdyyedX1l6SEvC6jHE4HWIfFWK41zf
 CKvO7wzWZ4n8nxFeQOgDIw4PpeuQv4jH1usUeIoLMAkoi2qFB+BYe22C2OmOSHMbba1YW9Wh5lw
 hH8Dzfr9UyYhLNjIpFg==
X-Authority-Analysis: v=2.4 cv=Ss4Fe/O0 c=1 sm=1 tr=0 ts=6b07f41f cx=c_pps
 a=lexSm1xfraBw67q2grWtcw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=tUiGmE7SqUV3IHiY2B0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260034


On 25/11/26 20:58, Ulf Hansson wrote:
> On Mon, Nov 23, 2026 at 9:43 AM Beleswar Padhi <b-padhi@ti.com> wrote:
>> Currently, platform_probe() attaches the PM domain to the device and
>> powers the domain on before calling the driver's probe. This works for
>> most cases, but would be erroneous for devices that must be configured
>> before they can be powered on.
>>
>> One example is the C66x/C7x remote processors on TI K3 SoCs like AM62A.
>> Such a remote core's local reset must be asserted before the device is
>> powered on, otherwise the core can start running bogus instructions
>> whatever happens to be in its memories at that point.
>>
>> dev_pm_domain_attach() lets its caller skip the power-on by not passing
>> PD_FLAG_ATTACH_POWER_ON. So, add a pm_domain_no_power_on flag to struct
>> platform_driver by which platform drivers can opt out of the power-on
>> at attach. Drivers that set it must power on the PM domain themselves.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> No changes since RFC.
>>
>> Link to RFC:
>> https://lore.kernel.org/all/20261027140751.2465743-3-b-padhi@ti.com/
>>
>>  drivers/base/platform.c         | 7 +++++--
>>  include/linux/platform_device.h | 8 ++++++++
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 979593e5cca15..6e7b803a50ab2 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -1482,6 +1482,7 @@ static int platform_probe(struct device *_dev)
>>  {
>>         struct platform_driver *drv = to_platform_driver(_dev->driver);
>>         struct platform_device *dev = to_platform_device(_dev);
>> +       u32 pd_flags = PD_FLAG_DETACH_POWER_OFF;
>>         int ret;
>>
>>         /*
>> @@ -1498,8 +1499,10 @@ static int platform_probe(struct device *_dev)
>>         if (ret < 0)
>>                 return ret;
>>
>> -       ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
>> -                                        PD_FLAG_DETACH_POWER_OFF);
>> +       if (!drv->pm_domain_no_power_on)
>> +               pd_flags |= PD_FLAG_ATTACH_POWER_ON;
>> +
>> +       ret = dev_pm_domain_attach(_dev, pd_flags);
>>         if (ret)
>>                 goto out;
>>
>> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
>> index 3bd0f1f0d8704..4d1679c4ea78e 100644
>> --- a/include/linux/platform_device.h
>> +++ b/include/linux/platform_device.h
>> @@ -292,6 +292,14 @@ struct platform_driver {
>>          * to setup and manage their own I/O address space.
>>          */
>>         bool driver_managed_dma;
>> +       /*
>> +        * By default the PM domain of a platform device is powered on before
>> +        * the driver's probe is invoked. Drivers that need to configure the
>> +        * device (e.g. hold it in reset) before its PM domain can be powered
>> +        * on must set this flag, and are then responsible for powering on the
>> +        * PM domain themselves.
>> +        */
> I would appreciate it if we could be more to the point. We should not
> need an entire book to explain what one variable is for. :-)


That's fair, I can do it in v2 :)

I was trying to follow the comment style for "driver_managed_dma" variable.

Thanks,
Beleswar

>
>> +       bool pm_domain_no_power_on;
>>  };
>>
>>  #define to_platform_driver(drv)        (container_of((drv), struct platform_driver, \
>> --
>> 2.34.1
>>
> Kind regards
> Uffe
