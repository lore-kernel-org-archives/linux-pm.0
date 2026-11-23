Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795423759;
	b=39KMaW+w3oIKheaKKuptw6+0fh2ZQb5TBTPWYcV6gaBsT5PpIYch/lgwW/FSM03xjPaz
	 ihqgCc+O01JKrZiTk2a4WKtGskUq897yjvlyy3vSHClFMBxWuoTTNY33f/J1aMwbkRKVk
	 RjTweizIBerevS4DiAd3xmUr/Rjmp7NUL7/GDiW5v/l1sjxvEck3rrBver0uNWcSl06L2
	 60oOAuE+zlL0pu1DuRL06/VlPcNYMu1Rpp+bRWL9wn+H+XOkX3dS8L05Kx2oFjzFnygk+
	 39XI9zJuHDnVT73b+WniabsrQ7HOremGNFLvhYSrHds4xVwqrQCfZFRa1GUgEW4YvwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423759;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YpheeiXJ6apQ/kGFNdKgGTpvhRR9TFy/lr19zgicNGY=;
	b=ctbBTtld2H8x8dRctNPoGPc0mZJj79KzRL02HgjHa3N52aHP0DL9WmopHBlhjtoFjsfb
	 Mn9qnS2CImpJpEgw3aoLrZtgU62Ab9cshu+51aEQT4P/vUe0jDCrm/yXNyOU/REzmSVHP
	 q53v1hO9oLQCdIlUwtxBMGgHAJBVuoLIxMXG6RA2p12O2eOPJv9TNf5Q4/Wh6lk8Gy424
	 AQJ5toEjPJGGPI2dkFLWwWPr1sGqzGM8HW56tzsiLiXBfJ7B2OY2OVpkxruLO7Q+jbj9S
	 6H2T0Pu3ugpuHllLthyuVYPn57xvDhB0y+wuBn7ocUEY86dRXnXaSt+nNvPFST63+bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=iPAGqKuk;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eUScZ844;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D9606A31A;
	Mon, 23 Nov 2026 08:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 711D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=iPAGqKuk;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eUScZ844
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AN50vVU3036003;
	Mon, 23 Nov 2026 02:49:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=YpheeiXJ6apQ/kGFNdKgGTpvhRR9TFy/lr19zgicN
	GY=; b=iPAGqKukEZPOljX3Xu67xdp8CB0EzIXPvndg7Ejube7tPPb2eDVE+bw8l
	zkF+WYmJkJLzcFdU24FpcXwM5hUsJPYgbIF6BTHCoYdbk1dTHXKsysVKz2veQKKP
	pKnDvHq/W0Ezp4PDMulFdEblz3awC1Xv2ijxx2P0WvcwG+z+LiFkCL9CTumt62iX
	y36j7iCIxW5CzKifyoga2utA1JUGR5b57ZkdR7+iCUhOYnTxJsj9uI2T01IDuTbB
	6MSW6PqcIMBZgtfbhFUn8/3kGbwzalTw3t0s0XfGw/zMMBzw+PVk/inHch1nh+Tb
	w4AMJge6SZO/Pz2zzjuq/DGOj3zTA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by m0384305.ppops.net (PPS) with ESMTPS id 4j3x4sck9y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 02:49:00 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDojUc2VaVJCh4S/Qxjw4LsWbNBCWOtUlkTiPvAHZLTxKG6Qb0567EBtNqUJXGVMXkwV30WCp2HtgFwaRLAxt7FKnJILEs1TS2HI6PuGGiVkvtYFjg9AOf08Ht6oHdMNOg3JPxMStNHCpABWHA2RsZYse+sN1FRPjghzIGGo5bPR8SWD+EXFLT0GeBTQ6As5yqiU6A95OLxLtEyviNx0JXWP8aCxrNflpJ0BHOZx32hX3uz/lcgTPzNUqc5foXRHsaZL4qpn9wmLX40OqoevjZ7WiufTldaHe5AhkIf05PRg5SE2JQaa+f4Qv+KapoXufWQATZ0lwy0i1+K73RQHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpheeiXJ6apQ/kGFNdKgGTpvhRR9TFy/lr19zgicNGY=;
 b=uNFqnqlU6v2vfWTTJ00qJ0PAmFhPFSqVTe5+LBj9lumJ8gPLGcLX9anx7ifY8A9saULiL/vaB5dxLuNDdeBBdpE0VsNf2xSMNwgHrcCZmRSDDKUf6T5+svgUHGiur+6NG7F44vlikY2lkltrubQWGMrpkHcVto9r3E1Zkr53cVecgVAzSx2+1FbsxJOSGGpDNn1ZgaKbFsBuKJRHPpqvMpB5HWHrhPsK1l6a+Uz3e/9M5ERr0liGBJefDkcOtR3FFpEeqskWpB3maRNlJrEcTMJ9p6V0ZERLtE4kTMe0Dk9O/Wq07nVLaDhYcZHAXHUYlXk6fc2K49Z8zuRjRLlQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpheeiXJ6apQ/kGFNdKgGTpvhRR9TFy/lr19zgicNGY=;
 b=eUScZ844507Qt2G0JaYQEqgoGZYSq3kLszVw/g3PFnPp5c2xSbe7+lSvfcmb3STx0/1PRn5aBjWwMf0oyYsMyTguoBgiR3zVF9W/Ut5yeW3pHmvNQE7aNlZ8Yh/woDmlwdp6v8Gt8QOirRSmQDdg4OMo5SHWn+YppEjzK7nFFXg=
Received: from SJ2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:a03:505::19)
 by CH3PR10MB7458.namprd10.prod.outlook.com (2603:10b6:610:15a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 08:42:52 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::47) by SJ2PR07CA0020.outlook.office365.com
 (2603:10b6:a03:505::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 08:42:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 08:42:51 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:28 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 02:42:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 02:42:28 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AN8gIfl2298779;
	Mon, 23 Nov 2026 02:42:24 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
        <johan@kernel.org>, <pavel@kernel.org>, <lenb@kernel.org>,
        <ulfh@kernel.org>
CC: <sid9.karanam@gmail.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <u-kumar1@ti.com>, <b-padhi@ti.com>, <driver-core@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 1/2] PM: domains: Honour PD_FLAG_ATTACH_POWER_ON for genpd
Date: Mon, 23 Nov 2026 14:12:17 +0530
Message-ID: <20261123084218.673382-2-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123084218.673382-1-b-padhi@ti.com>
References: <20261123084218.673382-1-b-padhi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d85ec1-eb43-42b2-5da1-08df493dc293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|23010399003|82310400026|10067099003|56012099006|261021121427099003|261026121527099003|261022075727099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|261102130727099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	aDhti+dAOz0yDEQKxBwgiGAZDnn0TWAf+HC5Zmsu4/oQ8W+Obe2cgmYB1EEWI9wIJQDfSh+c2L4+5sKqPzi1wXlzSN7siv5doqpXVCQSZA1oDQjWDUvwet4LN5iBvJ/Gk0gThXFIWvL4e/6Ieeq04AyPy7eHw+vGBc5sUucmx/LvRQ/yfKkj/0p38nJgexYtFMxDRbY4wzi1PrUs6NbDIHqxM0k6f38+T/tuwWjr/psvc6HCNWx7bQW0u44UlKRA+mHydeoCjSeCtv0/O0s1GX5fKNy0UCRc46Jy/tXWV6MtSMz2EoV+i91mGJzuOSvoWzWJ6XKHujDAupzipQwwCXilvDVPMWWCDpiOzdOK2rDpn9qRyosiTHL/n24K+xa+81j2KoEDxzUau0gHx/z4T91eeXyc/jqZ5KwrGhmeoeETC4OOWfLNhsu3W8KTTIbsvEHogmE51/mll7Nn74LN7CXuKjiBeYWgDd4W0QfH43m/6/ELxBIHQtRRcVLcYWi62pacmii8sYqe60apD1jhrmJCPFTtStnc/FL7Fque7bCAIM14MCoscDR7m+F4qhPUCnQQZuGWrZ+BUzAdU0An3/Bsafi7ZRKhhkF6cXnC1mo0f272dn8aidyTxfnvKLOMMffUfrPvfimTrIadk4kNxQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(261021121427099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261102130727099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KuFwal4UybReuwSfY961qjZo7r42IBnCSZmayjUKNUdnfyXq1EEDat0XjP+/KT6vhmbnxr+90tKcgLOYrJWNisrlh6eAqk2vGwdYiFNgpX00yiutUaZFjUEJhDrHn3o4TLLTTTTJ2CQb5+7S+gQlidXLwc5HD9LzfqBDrSmbWrt/QwrleBIyITqnDkCRl2irZzWP0UmNWdb8Vp+CDd3pC22wWEA+D1Krp+cLo3zk30BYCwZH5qyQ/S7l/JpJe8v6xjzamzo8fdnWotqJqKV5J0pKJFddD3pNNdHnYxMN1KJ25xHD4Uq+b3tdgx5BQX+kxyHWjX1rfJoegD5vK2oemA0iVqjWTx+QFPt04YDC3EjQR4XU/fIdwWhczk9GXHtBF0+Lr27L7mFNAXJkeqc4XUXqU8RATuq+mHXQnp1fNK/xf0A5TA0sjEsGlonpVfhl
X-Exchange-RoutingPolicyChecked:
	NJf4/krWbX8StvwmJIHtPlkyq8ps/8QyJ0tXtDS0FATpIqkWBsCjBQ9jSpcNd3WmBeNrR3jWVAiBnG+srTcNHulFaQPxCv1N7hjfOW1h8U5cAEbdKffoY1phNu327nFa8bW8jW3tERLWy3LjsblmzAJUD5BxYHIIf3Ut3ISnKJfIDPQb1sjmLHSd2LiwhQ710OWkYREbvY+eCFjUzRfbUl4Z63kq8CWgjoFug3L7hMatvVYuvsJ87egJw4Zm/5aIRLEBqK5Ux9zkz/H/bUaZADzmWjtz2LmJo9hFRIQsJf8TnZR87aE2jTBRXzNXcWtx2oU2uCtDB2HSd8njZwzZuQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 08:42:51.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d85ec1-eb43-42b2-5da1-08df493dc293
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXyI4oBOtn3Hdb
 UKmQFAzHigOKW6kJAZaA9RlagnvvVPJH4qGV1YPm5hlCcbW7Vn6RBH0Gk+bauw+2Rzkt2rZp+HX
 nW5aZfYY6S2mSoGdb3EhNrwAP42Cub4=
X-Proofpoint-GUID: 4N9s7DGHqMy37xTN1awv_N9XpQJnBXuW
X-Authority-Analysis: v=2.4 cv=d8pgWhjE c=1 sm=1 tr=0 ts=6b03fdfc cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=FIy28u5QyFohgosMjyYA:9
X-Proofpoint-ORIG-GUID: 4N9s7DGHqMy37xTN1awv_N9XpQJnBXuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX1jLfziWKJIEK
 Qhzyb9gct8s5gL52UGf2fbJSiS5Ob4uYwStHzLjtgUiGIzWFGR8JzLu5E6UBzis+NGfbR/RVTtV
 B6ZtqkdH96VY0PFCd6sIUZum30fXBIPA2d56Qo6TspU+NA8db1J1K+wWgXxZjxpQHAAP8/ToFtT
 0ya4HVEra41fxBENSiG5vDuqf4fyH2+EvT/XneefxnDqbfNd3lZajZTf1Vv6IQrDeVbiEulXK8C
 xYaH3assc05Hfl7w72aLu286LUg7p3tu3C0dSSu8CL2Pnuc5ZGmha+To3lJGUSJn15p1vvLO/nz
 8jwK8gPdItuD8p1LmT97iOAxBc+394W4hurEpusWQOwCh6MROXcPmeNEjl84yeq2bFftW0M8VnQ
 a4RzCshEQMzkH1IScvPmUFsGbR0bMkGaG/TwElT+Zj8SNs5f+9MBZu0Ta6TdCUex75G30tWmgvo
 YyO4Csdv41xiOSUoiUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034

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
No changes since RFC.

Link to RFC:
https://lore.kernel.org/all/20261027140751.2465743-2-b-padhi@ti.com/

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
index e0bf30c59ccea..c73927ac07e2c 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3556,6 +3556,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 /**
  * genpd_dev_pm_attach - Attach a device to its PM domain using DT.
  * @dev: Device to attach.
+ * @power_on: Whether to power on the PM domain during attach.
  *
  * Parse device's OF node to find a PM domain specifier. If such is found,
  * attaches the device to retrieved pm_domain ops.
@@ -3566,7 +3567,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
  * found or turned on, then return -EPROBE_DEFER to ensure that the device is
  * not probed and to re-try again later.
  */
-int genpd_dev_pm_attach(struct device *dev)
+int genpd_dev_pm_attach(struct device *dev, bool power_on)
 {
 	if (!dev->of_node)
 		return 0;
@@ -3579,7 +3580,7 @@ int genpd_dev_pm_attach(struct device *dev)
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

