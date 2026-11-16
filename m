Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825676;
	b=jO2pgy2SkZ6C9pXGs/NPM6gDPgXej664qaNoqjl13NqfKby2Lz5xmQ4EKxspp5M6YRLi
	 S1EtXTTsgBX9F+kJtHlu4uezmB7fQ8JXZ92EzyhVdZMe+f9jdDvDueEKXpAT8xAav+40D
	 6JOnafCrfAViOAX1hGgLQQrt1u1yYzhWoGNkbzLFMl1Htn7k9maVd+PdlALHMX2kSs/94
	 dSFtLmF0VbEDs2hEZW6qkgBS9uiNgfrb/VHdDSLm2WxISojx4wOKq7sMsIQDGBDTpsoLw
	 apfZm5GcJRLrzT5BQe9944GYV4uVnKbE2EqSo/aSLEZrM3tKqJ0pCI7Flr/+kLQ7hzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825676;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gUrJFcHHS6BUrvDZ1VhomH2xb6Mk39SBuVLnuG6sYcg=;
	b=1+bDY1I5sWKD4L21d9JAIWtjbgNIpObbI4rmN7modDUJwZ2Z3c4ByVA9dCkXzm4+ncVc
	 LnXAa2p8RWOwUvyAiTlZJRlBAVi+dDQNFnVMmthj/7+QjrGB3CX44tuatKc3xrkIZnpzl
	 YYuxaaGaR2OWB1Wc4bo9iJiG2zJENdQQmPJGz8Umq0SfILPPgVbFSze5WvZgnVH6bQQZK
	 4Q2ynAVJXYV4s/m1Jnem8UOhwWuaaoFyl1ibFMQ0gY/CFZciaOy5N3YrkvZlz1oN/BhZo
	 mFsemjNlT8gz39bGRjM0l0K///6IK3xSTm72aYo2tyFsfQUyIHy2Z0lIUqialHQ9ZBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=dHebHoA8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.7
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B0606A8A5;
	Mon, 16 Nov 2026 10:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13B0606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=dHebHoA8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG3H4V5vKjWjv6T4n78t5bjMWwHdmrR1K/9rFBcYbqCYaNnzFg9h+Zi+ObUEIgOUu26+U8+g5L6FigvWRbyVR6wMpCCIC5fQVjG4/2TCSXKbIooP1Y49dzDt47LsvQj7SArQ+UKT+H78yxh4Vzur+/sBPH7pym2WGx+/7sjIpWxNoG8bvjrgE0bMIRV8cZfBgpVWFcUEPXI7Bpp7nwhUzm7IMznXrV+qu6ZFKTzcXBb5RgYHh+B5ZGqTciwtNtOC5YBDO//+yBunLZ8s+dfzgBKtjE7SU6wgRzzu8maXLmZwQF/ziu7Kho49ehRolyv+7jJyXXac6ObkBSDAoMESmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUrJFcHHS6BUrvDZ1VhomH2xb6Mk39SBuVLnuG6sYcg=;
 b=GTuOuArwzQyPPZfYxiPLBzcYRQxwL4f6gAiz09vHX6eBBlqi+UBLtJawinZjIm+EN1aqceTUJISjPMXEfZk0J5vJLvBg5jIgo1uZnmfdT8CPebND/LgPUSmmb8sCzxtIHnwEEucLSryEoe8U9lWbxwrfnfIQpKod/iJpvfUot2FFuvMwjUEPB13MhoG5ldPYjG9pSHwlHCEficp6oEwfe3LA7Q+ZMWWNPVLNUU1NK6UoE6nGhBYHRfiDQYS3w/b2xbbObvHEpYZAW9D6DFAEK8DI5cB4BBEzG1RFuucrJqisg3DSjQ9vOjKWdNd9lPLqZ2wN2fxi+Ep698qEFPKjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUrJFcHHS6BUrvDZ1VhomH2xb6Mk39SBuVLnuG6sYcg=;
 b=dHebHoA8mPe25pVRonYm/tIbtGKDBlMAkVbw/XywKXocDRiGhsXauWXsL+6iNErZz8OCI23X+CU+q2wcqfJGvbGGS1fchrKDXRdfPKaj6rN4/VLca2UmrKXLnHxGe2Q/Wa8GzuYephPSIwAZG17ovCzKrHQoEGezNTf6/wJ103quSewuRNVwhjcuSEisIPrmfrzCONjtRkxVe2JaH4657jiMna9zACuvLMEiO54r5F8fkBN+Gdjz9P8h+WZfhE607CCBXbaBJm5VKQHZNOmQVMNxp+5riad2khDoWwQXQsSvdSVkwQPqj7z7Mku0PH/CDnIoPcAuAvzG96ZehNp6TQ==
Received: from PA7P264CA0036.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34b::9)
 by GV2PR10MB6257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:41:09 +0000
Received: from ZR1PEPF0000E6AE.eurprd05.prod.outlook.com
 (2603:10a6:102:34b:cafe::a1) by PA7P264CA0036.outlook.office365.com
 (2603:10a6:102:34b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 10:41:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6AE.mail.protection.outlook.com (10.167.241.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:09 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:41:53 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:09 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 3/7] MAINTAINERS: add entry for ST STM32 power domain driver
Date: Mon, 16 Nov 2026 11:40:28 +0100
Message-ID: <20261116114024.RESEND.3.I878d261f7f2cd680f9b13e783acbf07b9c0c1425@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
References: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6AE:EE_|GV2PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9e1b02-2aac-401d-e4e9-08df43ce207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N4F4u0BEUySLSuSXaOYURlyIQGu7l7HSs33s5TGMwcvVAQBUPe8ejW9XF0bzYIRQdVsA3y6TfcslXqhRa0wEN4wTvRNclJRC+i9DxcoJ574gdil7NcocrG10I60K4fgB/YDv8HG/iKz+e0o89DC5AU0jYaTOvdDBrPQS/KAVtUh2JK4TB+2u5rAEo+FNE2Qkw6Hm0F1mkMrP23uM9KClohmq3bu4wVSLcA0AblBMjyWj16dmMntzuTqJ8ov/GZWtjt90wMumHkqrHMe2ktnc1K9cOsxT5xfQpqPnmLRaN23fGuEk/Dtm9VfmnIoUjcPtLrbYSe/JBYCuA6PmHE7SGsiLjFToWjut9XC5MtIuEEeqUMM3MvfJlWnybmYLsUPCO9AvHc0baSh+UU1SK2cVBm8AuBepYJToPBj2UxLCfVWT8a6ofsN6fYn0jU7q7vBLfP40sCKWafboe6cF91aM+/FRTg50fEoV+YgbMWq3zbTiEJECUmIh6cMK2cwfXrkWylRH7EW4KE4lNoJ6gy2RV27Tr31pJrDfCsVcorWuQ41+bUBh337Sqf3/on2X3jJoqQatWw+wtUkeeOFFnhKFKyIQRfn0NrAcD8+ghDoPZ0tFpNqaA4wXcQvVEGhW9b6mcqeHS2jMHUYw88d4u71eY6gY7eZfqWtcBdT0gN0Nf8TehOddPkWqTVQ5npazJA4E49oU2iWCRoxIM3EsouGoQQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CWnWZ2ZTrvILEATrncc3nrhsa88t/Q7Bt1dNsd7NbpkR+mHk5aCZCb2MucsDGihQDoXEKKyqfd7OeMt8XLokpJNk2n1G5qsvW1sO7G14+uxQotlN4w69kGyiaTpYxjytieUd07OjPyVI2sg0d9cji7YpCFS6R8Gx38JdcZn4spFnkfrJumzHboA0N+gX+R97RQYQY6Q6GvPOTBl1QULaIqTWgHvuG72FgoEwE6s2b8b7reQHVF4Oz2zKZERgrTh9FweORwGCaBu/+nxM6rY7lziLSFt0Er/34eIZmO5L9+1qpIqxHbILuLnst0qJMKfOu1TQ3hlQ00ajT2+VVyOduOnZrB/9TPq037rNuw7QkSrNV1CMpvheeKnzmKQDaKz86JQcWRznK3TsJlm8lWqTJ4YZhDaUsJC/wCpiq32Nhmf0eH8m4oWVQhqfsH4aPty2
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:09.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9e1b02-2aac-401d-e4e9-08df43ce207c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6257

Add myself as maintainer of STM32MP power domain driver.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9..b68c38eadeea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26643,6 +26643,13 @@ F:	drivers/pinctrl/stm32/
 F:	include/dt-bindings/pinctrl/stm32-pinfunc.h
 X:	drivers/pinctrl/stm32/pinctrl-stm32-hdp.c
 
+ST STM32 POWER DOMAIN DRIVER
+M:	Patrick Delaunay <patrick.delaunay@foss.st.com>
+L:	linux-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
+F:	drivers/pmdomain/st/stm32mp-pm-domain.c
+
 ST STM32 SPI DRIVER
 M:	Alain Volmat <alain.volmat@foss.st.com>
 L:	linux-spi@vger.kernel.org
-- 
2.43.0

