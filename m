Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825672;
	b=sB2tNOZaq5MY1nuNTFu18w8FgsB0GV289E4UMVEs3OeXZ+7bWStnIh/7j/gy5kwt3tDr
	 P8SFQPCzvrtk6IxGgX6zYNEEWOUziXqsi5gAcbmcajf+0lTpurPzqCDvBn21shZ5cChjw
	 8AVCJrPvkhH7G+M3qkaMCHF3jhnWIUj+DCd63iPggOEGLFCaEDI7KeszEzQFSnBP1huph
	 ckmnBJXGgXvMZEtrY5ANt3uB4J7eUFb+CYqijNPSbK9GZI+YTFfG0MmLNvhG6DMftSB2V
	 CD8Fbd6AURI0KO2Mqp5ZlBnS2xmR2niGn1r9q/QqZkf4YwEfPlKlKPJgS0OgwTCxA/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825672;
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
	bh=t48+HPSKKzv1gSO8Ec+EGwiKC5tC9mGhqxMloqp3jKw=;
	b=PVafIdxyohy9k6JArmf999Zg8xaWQX/wUO27l7DJcr3kJ/dBjVQeJcNBGIvUiHy+ZVwq
	 gMQG7TUJ9HPhcdQamV18PruJE/DIas99Yhm5leN31FhMYUSkQ/PHwLfFnJ7h5kVa+FqNw
	 PLtUJrxC72BtWF+LNvjIjs9/3zeoaJ5rN7Q3IWixDRSk6CcP5vDO3Za/zLeWDx2atcR7+
	 +8zkoyg/l1RPUr8M2gm+GZ19qDSyArewT5tg7BGbaBBLl3oJnbF/aBSBW+eWyi243FA+5
	 6Wm0IIHaVUFh6Za5VX2MqiwxOFrhwpNozFc8zJbDu4+/npXpuRurzvXuvZiViTvX7EQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WZVh9Xct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.43
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF20606A333;
	Mon, 16 Nov 2026 10:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DF20606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WZVh9Xct
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB0yW2xV2hEWvLxdum17Tg64V63Ao47V7aHqfPPvu2LK+BkoY+G1Zl0zrT1jvEdwP2KutnRGOKxQ2Vt8tttdxDFD8isUyjrGmuhc1QfxyAjiPkBM11frZChOCJYCOacPUXGUIrfFv7epYcZq8u8F/tt0rnY8NcY2y//W7VB/pLTTo/OlZMrE0QI3wY+tXK7ldQvs77qeYptTM2Hkl8kweDBElWsEs71H7C+scIcAj3qv8leIEatKiju1EdqFkkKEWLDWvAZwqCJcvXc+5CmG545+WE0ZzDfNF74vbhx/ImHEzjpbviJmPJgPt8/lPdBW03RRpaONvUYUFJjRgfEREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t48+HPSKKzv1gSO8Ec+EGwiKC5tC9mGhqxMloqp3jKw=;
 b=ON9PmWzXh6UikvZyvd3Z/KWoqtwmBhjdCGK4gcxQt120x6GxvGDBId1x0NoIzDIa9QLDRUj13oSbmgx2TCikbIBVAu/wXO5iy4G8x/NfQqqQVC+NaODerB2B5gU3AvO+82GTOcXxcoRE5ogOKNt7R6d1DGTFiNrxxbs5jcbk+HuTN2O85cnZeQHsbsuhzRjHgA0czKm+bwOhcrpuDiNv5RLardtJ1sUVWkQdoXkh/WIM8x9jPGkLpUOOGclf1m55yaJQQhC3IyHCj3Kl73r300IirUUDYRnUmccckbniIrKUsX/OucFpWwGsMGn825DhV6ipIsI8XmOCUafcDS3zGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t48+HPSKKzv1gSO8Ec+EGwiKC5tC9mGhqxMloqp3jKw=;
 b=WZVh9Xctk79epihhVEFh8UHf9MiE2mSxQOaA4Q6FIlWAc7KDS6SpUGBYCQ6sFuOLuFiCvM4cObEypfYmnFAgxB5K1gJxYshpXNKImg8D83yOaDEbHKb5ekhn+GWimiY2UtVvdPXkKTSko/Lw6Rk8pkEuHRTGK8StZ6zebxseCUdQmWKEAaNGVk/Ulrs8zhVqinMyAm+U0nArfLT/eVMsYGhiVr6gSJAkyMMQ6nRsep6/D5TYAfHSt6lrXSWJ8Ai2r9+tTnE1eBUPLHdm4BZPLCONpUXi64soqfW12yffr7Y+KKOU9breTHcID1AhVxPPW+LgDk6jqCuOAc86Ai4XHw==
Received: from PR1P264CA0125.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::12)
 by VI1PR10MB3646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:41:06 +0000
Received: from ZR1PEPF0000E6B0.eurprd05.prod.outlook.com
 (2603:10a6:102:2cd:cafe::c) by PR1P264CA0125.outlook.office365.com
 (2603:10a6:102:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 10:41:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B0.mail.protection.outlook.com (10.167.241.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:05 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:41:48 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:04 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 0/7] arm64: dts: st: add STM32MP2 power domains
Date: Mon, 16 Nov 2026 11:40:25 +0100
Message-ID: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B0:EE_|VI1PR10MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: 98133b0b-8ba0-4463-5c36-08df43ce1ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261102123227099003|56012099006|11063799006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	KMHfWolga1bwgYuL0tM8cND4SBdP61ysfuRbLpxVgVUJdBCASGipKTb0yRyjnsMtVfgg7R2iAlQkVHuuP5a/ZvxuEIRVS/+UMBEBZPh+zUOeDIVu1orEhbY+94yk2vdzd8gBthMje89tiiPkmb5jQ/5GIR1hw9xEYrB4NqeI9vZlxKoUzyxuWjyBfEYwY7OXzKyLBG6fHxY5SFfcRkAEULEj6hoYI7fD/NP6h0KTrLlaCJPMy1LOIGav74qfEzLxJktYBHl1hYgtZU3v2We4jFa++MJX7QYpKuLJnei0t70a2bXNBgSCETXj53WDm3XEHdtbDp5D2nmwsVMX3AgxSXiPhIUjxhm9/pYwB527zLUOSFj1gCb4Ju0iXnL7MWgU8GomjS2z1hiBbcyBfvp1Q7Yhc8xLWD1/L8l8C/P7aXi9qi/stZUlIY7XtUlQpsvG2quXnX4UCx+DtIL/SICYCjd0/m0QOVT80OpG6+CHBUHqD95+8kXrivZY6TVaMS/DN9nsugC6BhJ3pniVMuHg3Qo7YCMfTKSPahvkmds+U17YmpQ5jIJs44DlWZBnmg637M1SlIXBhLQunVWxFHd8nXNkkPNFDjDpS/hHlmwbqNUesimPUeTKLshWjXqFmsb0bXrsUCTyScFi80KwAii8ICFq7NATb4YkU3h7q2vn8YVV7UK+hTXiyKg0IG1u/yPmewIfeARKMgGE+8vw3AQsTA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(56012099006)(11063799006)(10067099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tomaogD2jTeCVWh9T3Relfby+UPOavePsDjca0I6CGI+P/ioY/Qufm4XPapA717CBNPHqiOib+qdEsaQAB0cBHhHpTOYYui8AswpVutF8Js8TsUF4LiM8UlqamI7LUOpjzr7C4GCoyiUAHEWSTiZ5TK+mC4oqTKyuCROtkuFgd8caNjKYrRAxtOgRzdVfYn2wSYIBhEzRuG6g8jKRoWuD30SU8B6wkUGJJ7UP0i7WFGqLE3MxzE2Mda+uHqPgeWnFha6+SukOzAHmFAvh7njjXlNLW98fYQcuTkT3v1OdsCJ2f9WNyByOSsM+GAsBjQpWl3usgxa0D7xEW6ddctDaW57lkBMjMnM4g+/lfKedhb/F1eCGEtwwunXHhC1qrjWB9iaV/ChdHcknjDpfFx1mQklqmLd5okV96/+gdwAhZhPxe+jMy6cLzpuP9IWHPWN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:05.2800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98133b0b-8ba0-4463-5c36-08df43ce1ddf
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3646


Hello,

This series adds support for the D1 power domain used by the STM32MP2
families.

The new power-domain driver uses runtime PM and the clock framework to
keep the Cortex-A35 cluster in Run1 for devices that require it, while
S2Idle wake-up is handled through EXTI1 and retention PSCI power domain
(RET_PD).

The power sub-domain D1 without GENPD_FLAG_ACTIVE_WAKEUP is required
because PSCI domains manage the wake-up path since the commit
bfd5859709ee ("cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with
OSI").

This patch is a preliminary step to support PSCI OSI in STM32MP2
platform and the same power domain will be used also in STM32MP1
series.

The first 3 patches introduce the new power domain drivers.

The next patches add this power domain in device tree for each STM32MP2
SoCs: STM32MP25, STM32MP23 and STM32MP21.

Regards,
Patrick

RESEND the series to linux-pm@vger.kernel.org and ulfh@kernel.org


Patrick Delaunay (7):
  dt-bindings: power: st: add STM32MP PM domain binding
  pmdomain: st: add STM32MP power domain
  MAINTAINERS: add entry for ST STM32 power domain driver
  arm64: dts: st: add D1 domain for STM32MP25 family
  arm64: dts: st: fix power-domain labels DT coding style in STM32MP25
  arm64: dts: st: add D1 domain for STM32MP23 family
  arm64: dts: st: add power domains for STM32MP21 family

 .../bindings/power/st,stm32mp-pm-domain.yaml  |  46 +++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/st/stm32mp211.dtsi        |  37 +++++
 arch/arm64/boot/dts/st/stm32mp231.dtsi        |  54 +++++---
 arch/arm64/boot/dts/st/stm32mp233.dtsi        |   1 +
 arch/arm64/boot/dts/st/stm32mp235.dtsi        |   2 +-
 arch/arm64/boot/dts/st/stm32mp251.dtsi        | 126 ++++++++++-------
 arch/arm64/boot/dts/st/stm32mp253.dtsi        |   9 +-
 arch/arm64/boot/dts/st/stm32mp255.dtsi        |   2 +-
 drivers/pmdomain/st/Kconfig                   |  14 ++
 drivers/pmdomain/st/Makefile                  |   1 +
 drivers/pmdomain/st/stm32mp-pm-domain.c       | 128 ++++++++++++++++++
 12 files changed, 353 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
 create mode 100644 drivers/pmdomain/st/stm32mp-pm-domain.c

---
base-commit: 525321e50394ed98760cf9eeb4f7a35db1c78b12
branch: master

-- 
2.43.0

