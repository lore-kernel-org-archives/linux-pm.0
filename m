Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793110139;
	b=uPPwdgWDIyEIMbquFzeN9FalNmqhPioW0uguC1qgxtspAzIKl20q4MJyZUHmQNJrseup
	 G4QcsJ60r+x6ydY2Mw7HzScAHeXmOAXnq5nPpsXI/bLxogoM2xXLv39GMUertg5/ey4jl
	 i+hqJNsa6GJEWEvFvwLM2/UAVN93wm5OHqSxUhpliBSjD6S6MpFv3t0R3ADd3D5Zp6LQA
	 SyPBoixwsg3IbT5pFAI/Rf5LIWf2KAKHeh4kRHDQIn00AzUYp+cDJo7ipKU6JZ3+vSYKh
	 a/MfOS56gvshWYheiYNJDuPnN2XMMOxFt+O54Kj+7k+EnyXJ7hEmU5wwxYtZKXDXxkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110139;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9OTmmU6B03hcfyb8aae9UoCmyH+KvIFDIBaxH2Rx7BA=;
	b=1wKILlMqIFrp5Fd0knvRQo/jjz868UoZ1vfuMm2m66VaddCY5WPtHyM5pEW/5Ft0Lf4B
	 W0jl60+0lSEc5bOO51VD7qtdj33SwiFrKYlptH6Czf6vfe5Kv0QFGCMayJMEDwbDRqUys
	 +rM/8H5A/wjQ8dKR9bye5zy9sbMAPKkYaKB+ShCDW9/7njsc52pkZcBEfog6dKVScY4MB
	 mBUmOzArsXY44gWYXyFS+vA7GRIyN5ulHc3bz/DE0bqqIxKjJSGrPHUEvzYu1ifdfOXVZ
	 UftBj8PpBdOA3reipDxU9SLEHHxuyDXT2qH2nTVlma8Qg8Zz2zWoykf0O7hDjoa09nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AW9pQ5yS;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iBeV7ZFY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D260A263C;
	Tue, 27 Oct 2026 14:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5D260A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AW9pQ5yS;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=iBeV7ZFY
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69RDmDp51266618;
	Tue, 27 Oct 2026 09:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=9OTmmU6B03hcfyb8aae9UoCmyH+KvIFDIBaxH2Rx7
	BA=; b=AW9pQ5ySMkUANdZuWulPklHo09m9eWiTCI1nBHZT/L0gSmgcOOFJfztpN
	Pv+9GZAwmIoOR2lGeJLh4tQpv1kGLEd76Eh8Y1POxS0UgCffNWohDz0mb4tYs+9u
	VHIH6YOc4OdIMG+qIabNi93762RvUWQgFtSj3zgs32f2CL5Xl6EGAda4HtQnfXGm
	TaycDVLKunOBGEoN+O7Z3TV9l6Kr1fPbnuT2axiiXvNeKglmUS7VgqnDmoQgiuaM
	zRv2Us4ILAqP7pu1MNgpLxXpossQCgSzNsX4XSmuCP35ylUxW45J3QfnAt33P1dB
	/hOzo8faGjduAsTe6bsRD0l9ytz5A==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hjsbb9gua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:08:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5TOTFB7yWMm8DOJy8X+w/LWAfQA+7vMeUrMvhSpUU8Cy9Uh6Q3CR9oXjpjsUMmULPKrMX3jE+FrpyjCiN980UvdsIHgGdnv8SsXNL0oMmls12wMOzxOtczRlAJLbUWzQ5VRh2e3LC9VFOfhHd1n1sNExIlcGLu2PlAfMXRsd+EEbe9N7dGNP/z0ISJTKORZkVVmCOoUwyRU7ec/HD3Nu+71OQPJTm3uu0hJIEzjQcoPV3vE6Tdnk4hAzJhGeqXeS7S+NoQS2nL21Ger9wghdXGg9LQPKNQv/ow2VerXaGxxREXDbUWeCfpBzIM07KQGO7paxA9HzVqCCyiqIu7MBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OTmmU6B03hcfyb8aae9UoCmyH+KvIFDIBaxH2Rx7BA=;
 b=xwteDZGAmy2w8M8QojIuRSGZddnPoLV//UPeGkC+SzEtcL1W22RmcFiNZdvpPCry3QJhdaq5/k3+auGlqYtxIuIC4qLA11ga1hXAZIselkuzqQZC5f1xW0MdC9b2iOohmUfjZ2MKC7pDuDDQce6ZGXltxcKj7t/xStjuUYxMiipevZ44AcyIB4rwcDG4zIeFlC/Qq3BjEO4rzhOEzQMMray1Qe2gjmx5DnCDaaHYtL5XDqd/zgXUIhXjkJNoTTPQe7WYLsR9EbEiliTaL2maM1UsyU03/IxQkGTHwZocxI0t1ff7X+1thPCJlmhjdQZhJNERNSBp9yD+luNGQIlOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OTmmU6B03hcfyb8aae9UoCmyH+KvIFDIBaxH2Rx7BA=;
 b=iBeV7ZFYpGQRdJLx3xgZJImRmGVLMGT3K5SYi6KOs+ZEgD3IqlNokpIwOW+3c8my7JAJNM43om1/cu4c/TYLWAIagr9sqp27FU7oVFPLJXA4cGSt5W21scCSFhaZv7GcMOX7KIqo4P/SkCNw2S9L9vatvE7673CWRvFheywspYM=
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by PH8PR10MB6600.namprd10.prod.outlook.com (2603:10b6:510:223::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:08:53 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::c) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 14:08:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 14:08:52 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:08:01 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 27 Oct
 2026 09:08:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 27 Oct 2026 09:08:01 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69RE7pfg2040122;
	Tue, 27 Oct 2026 09:07:57 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 1/2] PM: domains: Honour PD_FLAG_ATTACH_POWER_ON for genpd
Date: Tue, 27 Oct 2026 19:37:50 +0530
Message-ID: <20261027140751.2465743-2-b-padhi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH8PR10MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eaa9be-a69e-4d68-fdec-08df3433d473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|261021123027099003|261021121427099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261009223027099003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v4TCFI57odh9DpINf9DRbP4PSo5lWNWtwPwfmNSTjgoJ25agKruojWMdu87uM0a5aVrChHPww0SDkbtE8cDJRBmwKbZHB38Me5gN+MGjucXGNsAnuHrfl3Y6V6yMsnaUkPL8w6OUIDNvOSej5qcQGcxI+TcEsGfOpSi1cs9YcctgnTqGpxPIIcZakYIk7So9Uhd8qj8HG6Q5DcCnOeXSMKoCro0pCtyxikyr7ecmHzP45GTciEUTRvYWg4lptU25hC3h063QS1MvbhR5ytIUatwD39zqti1qwcoL3MNgmNnIseoCvmg+E8VP0qGSSr1jKjSqWeeWL/JbhXtN5CllV0BQJ9qEOS5rxXJmBsnEd7s7D2xizVM1C8a/z4zWcU9UB5oqqRho0TKt+v21h4lSOVzl9WeObVZbCT2kpjV6GTG812Xz9n7779pgoHFmFkMpwoFxVlPTRYydb/kB2dAtlxJ0jeBRTJV115FtPPgL6+VX8I5paEduXQxIQAa1WJxO2NZPXpidpJAXV9f9ngyH0xV0n/JX80U7wYU7nPvhzUy7g0equ8yyNQBYEwchZdawOz6/SDbM2hJ2TTcT+buFfaJWAbFUT7RiGRAOswra54HPF2wn5BBzhL17NCDRyLD6gacFmnICKRDU19erDWt9jP9kjaPu2DGAquwQZFyfO2YbF7dPlIq4W2UJmJ4cM+64BXDS21fZ6po82WXy9aYhyA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YkfHoq/YPIKsJLvIMecnm5qtOpGFvoUoZTTufi+zRjC//dhp+Lw2NzsgShTSZJCvapYNBc//N0xOOwyJv6dvr7kkl2Y7jipX/9NCSRcpleqs0VkdOAor3rZlEotzIpTqEEEyVCwaBJYUzpJ8j+t8eHsRQOu53XeshSx8P0FQPKmjHrvpe76XktX+VoLeMatPFfrhYjlsYcNseY8MkCSitCHMs2A8SxmHEhDe1SJm342+cILCnwxxHLL35m/rIM2sJyzc3h5pzMVekbDl0zNCdqPiqUGuaFGofsagAo0KqMQEd49jROrPdZ/IKgitbVJ7WbSR+zcXbD7cqrdkzxCXiO5FmsCspIvo/e2oJwmqsDU1fOiKgR558kw3GCUTbBEKVAHEMylze59/TzIlkO/2MbmN6I2s3WzUrqgRS3IpjqAbEMQdS9zLSXjzrYs4soUu
X-Exchange-RoutingPolicyChecked:
	MK5xa5bEH2WpjW95wzsyUIJy35vvKuqRkKPRHJXKBeR2mCBQj7YQ8xd/D1MIY2KVwcMNGoddEcDuzgRjhppZbgULfrFLDlzcRzGZpDO6EBqd7ZK9JYIcFXCKbigU2LmcNU2fXNDXcczHAoQzkt0O1AsdERP62+s7Bxc8DvLzu0+mC4RBD9OYVlHrniUVdeqi3Pj3cR5zovrjK4AWxGwLaenfP0jo+YDi7mxwzLOd3lV916r9HF3F/WMkTd6HLZmzWuRuUt2vRSleVqXM9tjdroNmmYt9xqNMyPjbKhi8K1kh1Gex7LrgC+2QU4qQesmvjknmP5iXx9q71ahWtN22Dg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 14:08:52.0977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eaa9be-a69e-4d68-fdec-08df3433d473
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6600
X-Proofpoint-ORIG-GUID: 0bGZhPOM9jb4vX5VQKvf1wLI9RaGMsHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXxMkHOGs66F3l
 x8i6+37k1Au8i6YZcUCMNH+9ZuAGrMaQBcX2kKbFU3Mw7qSLkYfhFDsu9qCz+83ys3XDfbM35g2
 B48TwUZUZMk7uR/212rKlFg0gO9GEfHfqHugh2cSnAyIkfltrPjV6NDYmw5PBk1Ed1L2x8WB88L
 KRKKht4MU1GjUMQN2Ta4A+qNH8+93Glf19qVcNQrmwENhVd0Li0SfWFtkketa2zCrck8/AxGOTy
 3SNN3NZe9yI0dRP0OyEbmpNRNzuXK7IkZJjI4bg2Dc56eraigwGIIKUdSybNnxPuik69UJJdhbW
 fn8AQxuRf/4yVar0MfuHP/1R/Spw+TdfTFbu/LempIvGGaKzJbtbL/uOvOOWUl91Mht/0L87t4J
 kFCPeCenkLxTAxR+m5uB8Xtw5dkn0kt8/oL02SoJbVLHDyF1VobhNaBW6YGEpZV14DrJG8WjvG1
 gW9RGLaVK4/1DgpWmeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfXyIaFJmPTpGxB
 BWhP9bhtGY+Uga0QhqSyT1vWkoALuZNSV8qfJBYyq5e7Z1n/5lp/e0LR9X2y6ZhWpoUf/5Ua2iJ
 yfMe6qHPv8r7pPBNm9GXJtcqdmhihz8=
X-Proofpoint-GUID: 0bGZhPOM9jb4vX5VQKvf1wLI9RaGMsHJ
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6ae0b077 cx=c_pps
 a=Ftf85+eZhIav1RrYVnHJVQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=FIy28u5QyFohgosMjyYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270056

dev_pm_domain_attach() takes PD_FLAG_ATTACH_POWER_ON to let the caller
decide whether the PM domain is powered on during attach. But, only the
ACPI path honours it today. genpd_dev_pm_attach() takes no flags and
always powers on the domain, so a DT based device cannot be attached to
its PM domain without powering it on.

Add a power_on argument to genpd_dev_pm_attach() and pass it on to
__genpd_dev_pm_attach(), which already supports it for the multiple PM
domains case.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/base/power/common.c | 5 +++--
 drivers/pmdomain/core.c     | 5 +++--
 include/linux/pm_domain.h   | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 9bef9248a7052..3263659c58dc8 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -102,14 +102,15 @@ EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
  */
 int dev_pm_domain_attach(struct device *dev, u32 flags)
 {
+	bool power_on = !!(flags & PD_FLAG_ATTACH_POWER_ON);
 	int ret;
 
 	if (dev->pm_domain)
 		return 0;
 
-	ret = acpi_dev_pm_attach(dev, !!(flags & PD_FLAG_ATTACH_POWER_ON));
+	ret = acpi_dev_pm_attach(dev, power_on);
 	if (!ret)
-		ret = genpd_dev_pm_attach(dev);
+		ret = genpd_dev_pm_attach(dev, power_on);
 
 	if (dev->pm_domain)
 		dev->power.detach_power_off = !!(flags & PD_FLAG_DETACH_POWER_OFF);
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f1..785c27491aad5 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3553,6 +3553,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
+ * @power_on: Whether to power on the PM domain during attach.
  *
  * Parse device's OF node to find a PM domain specifier. If such is found,
  * attaches the device to retrieved pm_domain ops.
@@ -3563,7 +3564,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
  * found or turned on, then return -EPROBE_DEFER to ensure that the device is
  * not probed and to re-try again later.
  */
-int genpd_dev_pm_attach(struct device *dev)
+int genpd_dev_pm_attach(struct device *dev, bool power_on)
 {
 	if (!dev->of_node)
 		return 0;
@@ -3576,7 +3577,7 @@ int genpd_dev_pm_attach(struct device *dev)
 				       "#power-domain-cells") != 1)
 		return 0;
 
-	return __genpd_dev_pm_attach(dev, dev, 0, 1, true);
+	return __genpd_dev_pm_attach(dev, dev, 0, 1, power_on);
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610a..010fbfffee39d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -481,7 +481,7 @@ int of_genpd_add_child_ids(struct device_node *np,
 int of_genpd_remove_child_ids(struct device_node *np,
 			      struct genpd_onecell_data *data);
 
-int genpd_dev_pm_attach(struct device *dev);
+int genpd_dev_pm_attach(struct device *dev, bool power_on);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
@@ -527,7 +527,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 
 static inline void of_genpd_sync_state(struct device_node *np) {}
 
-static inline int genpd_dev_pm_attach(struct device *dev)
+static inline int genpd_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
-- 
2.34.1

