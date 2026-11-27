Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803615;
	b=n9Y19xgIvOasN+fTLLx0lM+UA0AKPWfTYTIXEALsHYRNxyYEPQLQdzDvFD7a6//dVdbd
	 RQmsvBKaMMVPuKMSJtd5uMJBhqqhmDF42kGhRorrwxWti4KzdWf1m7iIkWyuIGGILzdgr
	 sB72KeMnTJP28se/C55QUiPjnsisJyRFRRCPzUKqCniPWy4CdZaRS8/z5lF2bQWs8+rMH
	 zNQ6lNky0mD50uF7IuXhEm0DZofLUmeC+gGVtCEYSYxaObgnaSdDYOBx3J1RVKLNPdpmM
	 TRdvWqaljaF0vaRMSs5hT19jA+pnrjHTns1GwequJ3jdc3kob48stcHgakN6E9v2u5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803615;
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
	bh=I7JgoCRXDV/ZBH9AjSa7vkQyFoBaULG1qsvBrofBNFo=;
	b=NAgoiEF1x9djRFIUAvwt5NGDqL13w1meAt/Q4gmd4dX6c494moRC1Ao9k7znYlj9eK67
	 e7m8ZKc7lTtyRdyZHNNVa+2AwHSJxhC3VA3HioLIlR6TMlfY6O40YWv2dFH0N9kMvxVKo
	 1aUE9RYHyIApHm1KmgVw6SsS1vMpysXpPsAYvVVNGJz7K0bHSf2XMcVUx78xQgpPrOHr4
	 cnk7yxjVcCP+O6GmqSfFLycJO2ZsuaDzh63VjoWHCWt8QCupUwrL3zm1t5icnnn2aZPEp
	 ymvdYYc2v4aAAnSS+pXcG3UHxfgWmPdSFm1sb/Php3kHxTw5B5qGCyLhh3+vdhoptIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Gy4UsoOc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.19
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6C606A331;
	Fri, 27 Nov 2026 18:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE6C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Gy4UsoOc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipyTow/t1V1JDjShnrhSi1WgBc4vL6QLE3fPPRk60VRIWz7zudHKSGqpN+HMPQ8Mavw95z/xXjTrq8pdgUnoVlNp+eLMrEeaoDrXlgBbd9C5J2HCIEtZWPVJ4EzlNcUq5F3ea4Cza7WXFwT6k7cjXNw6wqBtyAL1zzLqzLKxbzHl3XR4k2KlIiLo/hQCx3xmizlEoo6kfbC+xfWF3qlaIdIyRX2Xmy8w08XDMmooFYm8jHdzZDtCHR8XYp6TCHx2fru2/99Q/+Lm6LKkxJmfiZvzZajovWS/DJ+m31jzMabpw89vML4e7DgkbthjBjGWhXZXxGpKZ/QdQmH+CStWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7JgoCRXDV/ZBH9AjSa7vkQyFoBaULG1qsvBrofBNFo=;
 b=kBpC26j1MjIqCiqfPXqFShMRIzHCMiEgoBBrGu8xoU/DvKR9Dbe2Lm+cOxLFU/WsZ7nvVn/UjiJQ1Mq9A451CLk04r2KYCGZszPIdHJiABRRVouEcCAfgFieFPmneNLRKz25awZDgO5wPjiNDHeZvjLMAR8aAANxIHcGxIJqPgVtP3ruTBEoeVffL6QmHqGJhIkqj41fhnJNbn6I50FTNc77hUqOs9uxw3lVyXXX65RJpi+8OosRd3xcL6RsWTkspUaVM2KF/uiWV8nKVhrXbiLg1XYA8VvW+YgmdWg2s4JwbCn9GgsFgfGRwdVdL9Fr/7JQYZXDu9ACGpyDPbw9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7JgoCRXDV/ZBH9AjSa7vkQyFoBaULG1qsvBrofBNFo=;
 b=Gy4UsoOcMUbosA0R1qu1Hwe9/c15XDEuO6A3KC/zetTOJ//vAzZ+VNsrP2S1QpGgzVk+s+WGF0OVLB4fbkcewxz60CHHkKnpVR5G9+IBkaEpZ9RmUtof441Cnlwae/CFy2LaKqzItwzrKaSba2lgFasQCWm8UQGhax8Iw+I7eXSorBAca05QEP5viGh7Q1zRqaYINexibNDr1BWXKuQNO5rpFlQ+vqsrvCc2E97KXkW79bVw2gP6YudLUAn83m1AeeTlLVwhb+PjxrQ0rlBYkaFiZrN+l7+hd8oC1igkoM6pmtJhzR+ZA1vDz7ecbqBY2NSx0t3wlHhv87zAbfnzDA==
Received: from DU2PR04CA0219.eurprd04.prod.outlook.com (2603:10a6:10:2b1::14)
 by PAWPR10MB8138.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:380::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 18:20:09 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::af) by DU2PR04CA0219.outlook.office365.com
 (2603:10a6:10:2b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 18:20:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 18:20:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:21:15 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:08 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>
CC: <linux-pm@vger.kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/7] MAINTAINERS: add entry for ST STM32 power domain driver
Date: Fri, 27 Nov 2026 19:18:27 +0100
Message-ID: <20261127191823.v2.3.I878d261f7f2cd680f9b13e783acbf07b9c0c1425@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
References: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|PAWPR10MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fce57a0-0f34-460f-6bc4-08df4cb311a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261021121427099003|56012099006|261021123027099003|261022105027099003|261026121527099003|261026140227099003|11063799006|261102123227099003|261028144727099003|10067099003|261009223027099003|18002099003|22082099003|44046007;
X-Microsoft-Antispam-Message-Info:
	DG25bU06bjnpSROYWHtQgWqVEx/82QZH5sGRVvnxeP6Zi2YIqlE0BeJfOaM7T/Cs2csD+2sxmyjqLcyjNcnsfb0WD44AirGJDDOXspMBpBMzVXS20Rjj4nUsytc9OjuOVsUlMgRxngSN75SZCA7MGnsEA0qSBBAErAhBg3EaulXoqS0BcZBPcpw92lva5V3oYpecXMga2b04K2W7yWdvbdKW0lOf1pvnCrYztntRFaxoKDjF0nXLTsTbtdPnmiqZJj/allsj29PPIK4tkJ3HpCBzNIuFYwgW5TS7RRqMQdGkEh8hZQ/NB8PSOX+cdEIxIi172M7MNNeAJH6MO9nSfctsGCQuKlZTsw2O5CVtABAzapb+3uqkPsySvas6D88ACM9N9PUQIB2zcRapd/nFd45UlZPUJy2P5NrBc8SpbMwT2HcHsgllbYn6b5LzEOYwAvv0Y/t2jFSD3A6QG4juoQNjU4a88r16i0xaAxgMGpv0fL/ob6fIJNIeYBsYvMw9J41FAlG6/m/f05M1Q+oRKMRggu39u4/ho9FY1cOMaDeTTvuJEIlcrqfF74tW+nFRIcEdvayhSXr/UnIpN97k6ZX+QY8mLNsoeZzzeIXHhhRuBujNLfR1VKYrpW7Vcc2+8eNrczDMpzlpmtgvblqMh/aSt0y+Z3Bwd6xG11Ujbr2eN3ypx/Bey++oSFmWrCwFvBJuJIfsafkOAbCCt5fc0e+40MRRzMwmT9yKxmbT+wCN4tAw1wAw1U3UDz/xylaa
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(11063799006)(261102123227099003)(261028144727099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DlrqeByMDBDJ/gpanKK3GgY1vyDZic9J7vBUvrYyHsDma+frG/TDUwmP8IaXZKLQXg2c+5Hvo1txSwVwSmHryylI8dLv2AOVN/sYf0gUQoNfNmTNiy680cryL/i5EO5tBEGCB4KIClQzfEzh4GJzq//cQvsrTF4rsHL8b8N6226IlL4b1A6FpjLBzMyaJbOIXhA7Bf9GYNtfxVxYnAmJEOI3LYIkXfG9YDTrBcx9uXo9m/u5JZqy7+pSmRPncpknqlH3LVeK1vej9ymzXw/usFs8KIVrqqJpSNbIFMxMjI3CQtEsHomfFdN+aq+m7laJyHUZhdvSzS0Q8M5XM4Uvs8alP5IwduTI8RzGzzt3xUvmzNT/mPTROYwy+8cK6z91ISRhgcC8tYdGnbzFZQO09rEH0jB8Jwx6sd7149CyCTSrrbnGhqFVKWp19RzxShCV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:08.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fce57a0-0f34-460f-6bc4-08df4cb311a9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8138

Add a MAINTAINERS entry for the STM32MP power domain driver.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c72a281a8167..5a47f33e5267 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26609,6 +26609,13 @@ F:	drivers/pinctrl/stm32/
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

