Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500604;
	b=IM34b2eXHyGWe9ncna7X43YFqZG4KBwAfd+/8UyEVht9vW2hGZcKzdWp8dC7tqjh5XrB
	 sGrS5tHQi/H7CMVlquFw2tmOBBf5kbkdi0THxOFrvOrT4W7cebrcX0o6b2LUA9+Lm6YJO
	 M6KStIIWhRnopFvC0DzEHkc7dQBj4TGroZ08rktL66z0fgYxlA0wp8mPJFQecUukOneug
	 57lIKMNQjtGyIEiLehlAdQE0wLgTP92pdbinrUXLeMCtZKXgZFji4L/tcq/UtAI6QG1fd
	 jTXdqivp4bzct49A4coyBegU/YklGkShB67vOUcCVF53oqLOVvYCzgZPFxXzzHH2ahA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500604;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Sg+KvGZYhVzYOkLqPIQhsfe/5idg5NwqYT0AfUXheas=;
	b=vxFUnQtRBclbbnoztelXvvoYS/e+J8Rsa4S0/j3TCDUHazI10W69w2KChCai1xQW1STI
	 mmkmMToLG0FFZRUza22rXeWumgJgtrQV7kaRcbB2cssXbHX990ZfElCsY+7mdW8ecsFR0
	 2QGQLZlZKQU8TNOtK3HLQabPWXKPJU3BwU3F6As/OB5rmLC3o0jfExm+n/piyjCFoT0BZ
	 8T9whfw4ybsl2z0b3pLrVnejrfJe2uoshOtz1DnlMO3M2yvO1lN2BCqthLwL3URKscb5w
	 SlWgqRJLv+FvSWi/ZCK2bVAvTAz4dhk0fE9tj5MxghFo7qow3fGF8mO9XMhHH6uahyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=bJQwmF1H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.42
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE0606A321;
	Thu, 12 Nov 2026 16:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AE0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=bJQwmF1H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O57N6PFvuEOYa91l9oqgZ+y//i/WB5kWAHnDEE60gPcZBn60tNucAv5f2yTF/ASWthWY6MkP+OYpMLCe9y/BngNoTpWNYtHVZU7QwaQAsVJFHogBqST4y+iPDfW/mwQrJcCNuSWtbiB6SNAxKk7EwFxRXhG1uZxBcVgMCfhzeRUfmjhjLgYJIgXmGbs3I8OAeUcipYx5mSqHbSlzwe98DLO7mfiBXfjjsl91zyoIHrEH8Ushv56kT+R7cW0307Bs6czt0Q1x3cWBIQECXTBh98uEjMjWpfZqAXKIN5Pns/wrX7HFtZWaDKQUAk3bw+jhXWevy+4sw2zGydhP2hAiEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg+KvGZYhVzYOkLqPIQhsfe/5idg5NwqYT0AfUXheas=;
 b=lssxlnGn+vicS/gPfSBHNw4WzKhEUt0fIxsgerrHLS0CNLyh5+VViZLsce84CRz1MAR65DwVYRXABIoALatRdbUTOl65G2hwPpXu8HerCQ13KVNKaO/WQbFtCZWugR57vRWAN7TpcMFAf5YiySx8xG4GGyvj33ma/maMIfuhAc0cxOf3I89twmS0F5PCGhSnahrPodEtcs9jWD+3mfgNTkD2QsJ7Xrt0KyhHx3DmwMlfAYpEwHiCMLlc/m+O8l/kVqCMWCRut6/ua2P6kki3Y+PH9ds/sr97F9Lhx7fXEZUTvzAgbh7xgQOgHlgZ20Fyg/uOe6eS9EXVEuNFE1kllw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg+KvGZYhVzYOkLqPIQhsfe/5idg5NwqYT0AfUXheas=;
 b=bJQwmF1H9gPhl9YON8Idd2oXLd7O/o8MzKdwphbVqZP7EbAKWfsGw+AnHAhMdeMi33WmEwvloU3AI4wcDq9BzD5ydxwJtTaZzcVXzhPmLtJ/KLb9kML+euap0CR9zkEDmzyslbBNf34taX3M0LBxgsHz4FDIrPrGFftKF6r7URySPDjcly1o8kN/05K6hKds62lYBvkWPiRb8Psljse0B3Tg/4gcZW5wwJJZe4aJo5KYtzIPpCmHxucfToMyzofk6BX7OS/+UjZY/f+EQdkWk3uL4rR/0cNetJNO+qyRmoUgum+hFpzSPymhm6ro4WjrIBUYjb/rTetl9TWQBW2pfQ==
Received: from OS6P279CA0106.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3c::8) by
 DU2PR10MB7743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Thu, 12 Nov 2026 16:23:20 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:e10:3c:cafe::1a) by OS6P279CA0106.outlook.office365.com
 (2603:10a6:e10:3c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 16:23:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 16:23:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 17:24:04 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 12 Nov
 2026 17:23:05 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle
	<christian.loehle@arm.com>, Maulik Shah <quic_mkshah@quicinc.com>
CC: <dario.binacchi@amarulasolutions.com>, Linux STM32
	<linux-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH] cpuidle: psci: Skip SET_SUSPEND_MODE when OSI is unsupported
Date: Thu, 12 Nov 2026 17:22:42 +0100
Message-ID: <20261112172241.1.Ibe6dddf06a4b7e5b24af24dc85d053e36f940549@changeid>
X-Mailer: git-send-email 2.43.0
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|DU2PR10MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a012e4-9f5a-409d-a3d6-08df40d943a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|23010399003|376014|36860700016|18002099003|10067099003|11063799006|261102123227099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	wdxGxjGUSrvKR8BJZUi2x1qLwUtSMIIWjrAPnQaohIOekktThh0zh5Km7WiOs1IM5e8fg6hLIZkbxyQj7rFyiztVrMCWpZm4GHM9mTG50A6qUNaVXiJeU07yexkg3eFQBH5tCgvZem01yMS2a3oTGOoa+NC3lLPQmnQlOspqHEHCxka0fQ0K2P9XCtDhD2Ht0R4zVpzAcFmg71ZvvRWT0Y98Cihp0prfNQ7n4w2QDJJU4fPGQBE/KTHi3i+LiFFThoGYhDxX7J0c5y2PEE5XQ+FDyXQ4n2uIDDICh9GzNDiyhSEosGhYDAVxndnXcaGySu5upm1VICyptxE8/YUAephNyO7TgOWoHT/5vJ2RZgsO0YUkjWQvlSI3zwJfBRV1pXyCTLPZzflfZr42KXm+gi9H8IxBl+B8OE8e3/VFejE8Gc31ggcHgp23ykHXcBHFsttv+E2KhncC/hzraeASEOPMN5rk1Xqr/hfJtgKQblPofDW9kuuHb3P+pgSwYFFZzucK5p0M+RSNFi4p9hgNuVeeJA+vVFnSQiGAsx8ARgOEig8SRVbU08EngqkMBZ2YaZggASomQ08qtsckO22gqBrBEBGGJggn33/L3q4ww0QsFovG0SpKfdR07rWG+cfu1IbFo+pWvNDfgisriKE0e8VxbVlJfzgGIJ82L7X1/bE=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(23010399003)(376014)(36860700016)(18002099003)(10067099003)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TNdOyRVOS74iH6U4QyNpJsyNtgTKta0Rr7HRML6Lr8t8gYyiETPtydBlLsz6+DrMgRwetuVJ2ikT48gen2U9LBN5qaeTTpLX7JkH3Wxm0eVgHUVODbWe1K3uwAKIn/avGsAbKdtWDgZOdE43ua8epYwiATZU2Pp1CR371wxfy183UlCatdeOlsCyoJinQx9lbRwd9gRgZ0Dhxst1lnA3ks6/6rBooiEpEO+egZcvyC4S55qKmc/Nx8+S9U6KNyC94bMaIbXXMhW7Wd/4HD3OWhxTIEMxgCyT4I2TJXkobMiCielR0+n4govLHdvhOrVUaZe0FUo57PbDKz3DxBlu5W+T+ANKr5S2hdGRhtgLFxXa99+T5rSqrCJklW1/tDvo1gbaJNga8FKWE1nibgWr5wh+PLVgaDV/WYXNsDaOkzfsQiIveGrYba4L1YIhNV7k
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:23:19.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a012e4-9f5a-409d-a3d6-08df40d943a6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7743

The PSCI cpuidle domain probe calls psci_set_osi_mode(use_osi) after
creating the power domains. When OSI is unsupported, this still calls
SET_SUSPEND_MODE to select platform-coordinated mode. Firmware that
does not implement this optional function may return NOT_SUPPORTED,
causing the probe to fail with -EOPNOTSUPP.

When OSI is unsupported, the PSCI specification allows the OS to assume
platform-coordinated mode. Skip the call in that case, and request OSI
mode only when psci_has_osi_support() is true.

Fixes: 12acb348fa45 ("cpuidle: psci: Move enabling OSI mode after power domains creation")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
Hi,

This patch replaces the previous patch [1] in SCMI lib

The PSCI specification v1.3 describes the PSCI_SET_SUSPEND_MODE with:

"
5.21 PSCI_SET_SUSPEND_MODE
5.21.3 Caller responsibilities
The caller must be able to cope with the following error return codes:
* NOT_SUPPORTED, in which case the calling OS can assume the platform
will work in platform-coordinated mode. In this case,
the PSCI_FEATURES feature flag 0 for CPU_SUSPEND is also 0.
"

This patch implements the expected behavior:

PC mode by default when OSI is not supported, i.e. CPU_SUSPEND
(optional) are not supported; PSCI_FEATURES(CPU_SUSPEND) return
NOT_SUPPORTED or return psci_func_id Bit[0]=0 for OS-initiated mode
not supported.

When OSI is not supported PSCI_SET_SUSPEND_MODE (optional) can report
NOT_SUPPORTED and by default the platform will boot in
platform-coordinated mode.

[1] "firmware: psci: handle unsupported SET_SUSPEND_MODE in PC mode"
    https://patchwork.kernel.org/project/linux-arm-kernel/patch/20261029191624.1.I5f8f3d75a566b72250d629ac6f43cf0d387c0218@changeid/
    https://lore.kernel.org/all/20261029191624.1.I5f8f3d75a566b72250d629ac6f43cf0d387c0218@changeid/

Regards,

Patrick

 drivers/cpuidle/cpuidle-psci-domain.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index 5722365b943e..eed9ad94659a 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -159,10 +159,12 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_pd;
 
-	/* let's try to enable OSI. */
-	ret = psci_set_osi_mode(use_osi);
-	if (ret)
-		goto remove_pd;
+	if (use_osi) {
+		/* let's try to enable OSI. */
+		ret = psci_set_osi_mode(true);
+		if (ret)
+			goto remove_pd;
+	}
 
 	pr_info("Initialized CPU PM domain topology using %s mode\n",
 		use_osi ? "OSI" : "PC");
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
branch: master

-- 
2.43.0

