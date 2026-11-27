Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803611;
	b=VuA89eNxvJSZOS62ulGbMIKYhSytNHpSuGnVCcOeMDrcImNiS9YRii4/+gAG6dw1xXJ6
	 7HNjJnQYPgez4femRXPpSq5nAiz2dvHSQ9L/PTyBglc0mk//225GN9b+zRVqaOLql+mJ+
	 b7YIQri7gdRI8upCTS1F7gSNH6Zudf2F1UmOdbKvfbXksPZTW6gbh7fNmS7yrD59nxvx0
	 dE7t6v2+42uiL9CgYH+tvTZkL5s8DUO0UNTHo+0MlDh21xAa53mVGQnvnyzmLzDr2NzOE
	 xYoUH3xiEtwsg1k3nMSiG2kX1WtkcMbfok8TINHIO1ugxtgl6CW0MI8gXXO1/gKOGzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803611;
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
	bh=l1C604l7JVQ+7I7wptpOppXM9brK9j3GEotwn5f6Cfg=;
	b=fXhXQMYmqNiB6XV7CZGdEZ9yrXHvWOl8cZvWPyI+OhqayrZ2y5OnnkEpN2jhsakFdBmj
	 OXHqFcuRO6KDN1tpkQz904b7ZAN8PPq/d7Ge67OeI/canyqbvHIEP3N6SgGuUoJxGXG0S
	 1lp6oZbUXFX9sQtf45xj9S184aVGByY2ezXHD6uRpNNcf00pUSdAfzVLiVJdtmetpzIjO
	 tKaybpf/XJ/UHaqSi2U4Utn1rmYPBTTUu5DcyHCgKn8Tpd0f4ZEPZZmb2E+foI4J5sa5l
	 17kjI8omnKdnBLkgS4i3hyzHfAt5wNHyDrJ2gmpnW58avNaHPc1yX+NdQfSFcVX1yvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=dCOtb1hf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.5
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F649606A31C;
	Fri, 27 Nov 2026 18:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F649606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=dCOtb1hf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMRqcQpeK7Xd7jHRr9MNo+uC7m81ImKW4Z0QudBODzqx091fHwQMDeWJzv6ylMY8fVu6O4ERnCvt/6y5qTXwVNz56gJa5R9lNIZ9Z/aSMXSW14ir+JL8r7menqllKXPC2jCeRee+N+zdcyTgECcV2KKZANM8Hi5rWuWdoWKDEIj9vAvL/R3mRI5ol967hWmXEX5i1qBeRGNg72c6pUEBoDbP4APw+fhN+qVK1J6reEVZngBc7vPXgtJ+aKY9HRYZJvdDBFdDOzaJobDxJ9So7P7LRKvVNytasMwvrKbkLXPx2nvbei5C1TuqqJdxUKxmG/SM+TUTPPnxJUd7FWEsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1C604l7JVQ+7I7wptpOppXM9brK9j3GEotwn5f6Cfg=;
 b=ZP99i8UF64AhwTqamoL7g4pjgdBHnf1FRUMUBZgWhGi7rXYbDihXuouKixgoKfNm8/TKoDgecVBypLWc94RBSm3vz6rvv4VP9pAr05rFjedrURJRAFHPlD6fsln3FwnNby1Ve1ZElXZq3eyJrK1W3BbnJMM6MYvRTeFOLx4tvM207IXeXYRZqGyqT4dayhsA1iGp6LP6OA8MGs7ujrr6bhhVjBISce/Y51bWm9gICGuFwvUBwqqmbR/WXa7q46Foo5ej+7/O/MuHz12Dwuf4Z+XJDAWk46aELy5gV2LOhlACliiXBktCPmlt2nGu/bw/FjryYG6JXpaNavo13SCD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1C604l7JVQ+7I7wptpOppXM9brK9j3GEotwn5f6Cfg=;
 b=dCOtb1hfsAgmw18A/4m9O3HDNI3S5YW+77HMdAjXZyWOJV7g65YDl4iTRhW4+9r6SPdrXX+WYZVDmMi7Eng7mSSiSmYbLwzGOijbCxRmQd9yfirGvM9diSlBnUdq1Eb4CG9wVnvXlhRY9SMXbuN183yoTfVg+fqJv4H1DfBIN2l7EJof42rFFq84G6wgT/p+omT1BnAuS+U5ArYyw5DFm/hsJXSNnkDSocxIMzAwgf72VfG/kCFH24CZR5cSCkHSV1PXgGW8HThcXxPWSpuwjEqVlYUuXmrFH0SUlMfRFHAnkfWPvKOpsUgPFyMTz8hrQkWKUAno8e+OOl3qf1TFZg==
Received: from MI1PEPF00000D69.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::499)
 by AS8PR10MB6198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 18:20:04 +0000
Received: from AM7PEPF00000054.EURPRD83.prod.outlook.com
 (2603:10a6:20f:fff8::218) by MI1PEPF00000D69.outlook.office365.com
 (2603:10a6:298:1::499) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 18:20:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM7PEPF00000054.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 27 Nov 2026 18:20:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:20:54 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:03 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 0/7] arm64: dts: st: add STM32MP2 power domains
Date: Fri, 27 Nov 2026 19:18:24 +0100
Message-ID: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000054:EE_|AS8PR10MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 366585cb-d59a-44ff-bfc6-08df4cb30ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|18002099003|18092099006|13003099007|56012099006|11063799006|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fS11f0kZbQomdzKvFg551Dat6/Z0fTdDceUy5Gv6h/q7HqE2g/aqSGyILhppZ4AsbrWd94rf6dN5JTf1VvufPuaV/KCM8ntcCykDUsAUmqMzZ6Ie79KgdRXHq8Rfpu/d/mRXeRPQnn1hKE7+Dz8o4I2BYcMbs4hFMgkx736AVGg6r2+HhJulGNmSGxfZ02jtrcTddZtEy68rLxyRItfNs7hWfUhXaXeHdBW87BeCjmQ2rWPfyjAE/iXTxzbzUBXw37DHTIRF+8qG5sXWijhO7gRA5MFDGeo3cKy26qzGXGKJXBjKj4KFlk35CmU5inbCqDqq35Xso4VMzKgqiXaDl55mfUprkVzDtrxE5ZwtW29spSlnltRei2XaXY6CKuzxRwStJPKvyqym0SwwoRpg/A+e9NnI6+/zm/cZiG8+qlJDjyAX3u8xOfCUR27CpZofoPshtf1A2nUtyoq5hq87Dvi3q+bPN6pRppvrTHo+HtmETpRd/TVRTZ7OSaRB03Y/GqRnXUadTxVINouzlzGUmivzEcFyVrstgfrX2f/W+eMEDAzWGHa1j3h8s8AJQNhaB2hnVfmzgBa7kcN/d/AO8JQtGkBIuXUWw+QbVj268CoBhIUjRvWRfj8Boza8NsM23oWVvh4JyUkavQnDt8cWNf62/M3fmrrEPBTf9XPG6yQ=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(18002099003)(18092099006)(13003099007)(56012099006)(11063799006)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VQ3YIr2xvQzBz6v5+FeszjWLgdFwIfs3cUdtJ6SuL0ulSraADpZTKYPwNHLqD6UlRQXn9FnP9duetG/KWhAnbE60X6O/k6K9ZsIMgO57tJNW+N3Ue0rL/5QcRE6TdT7grDnb4qOn3HxiOAM1peQ2C1dpSEXpCScrW1MdgUj1evl4ofAsBF4LYgbuXtHKY9zzUYifT+GRbbjtTMPQgImK+98meLteV+jZ+Mzkbl+nvtG8BIHrWyuzmGRnHqUKFfcaiRRbDofzCcTAzHpS3c6LrCo83c6hPh+kOGItqAkcqoi8KpuVxtRcJPHMQCbNUlye74MteSMKvE/9bz7j44bcsVO8jEvTcwmSi/VNSdSZyFkQky2Cv76+3r0I8V1VzGbIcaH019+V8vArE3AWsbU9DUSv7N2QWhAzyMO1VxsOkEInaYc3KTu8mNGsrAQlBty/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:03.9182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366585cb-d59a-44ff-bfc6-08df4cb30ebb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000054.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6198


Hello,

Version 2 of [1], updated after review.

This series adds PSCI power-domain topology and models the STM32MP2
D1 functional dependency for STM32MP25, STM32MP23 and STM32MP21.

Some peripherals in the D2 domain, powered by VDD_CORE, are assigned
by RIFSC to CPU1. Their RCC clocks are available only while the
Cortex-A35 cluster, powered by VDD_CPU, is active.

The D1 domain describes this SoC restriction (see the PWR table
"Functionalities depending on system operating mode") in DT rather than
requiring individual drivers to know about it. This domain is placed
below the PSCI cluster domain so that active devices prevent the cluster
from entering an incompatible idle state.

D1 does not control a separate power switch and does not model the
wakeup path. Wakeup routing is handled separately through EXTI1 and
the retention power domain (PSCI domain with GENPD_FLAG_ACTIVE_WAKEUP).

The series adds the DT binding, the generic power-domain provider
driver, the MAINTAINERS entry and the device-tree changes for the
three STM32MP2 families.

Regards,
Patrick

[1] arm64: dts: st: add STM32MP2 power domains
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1201830
https://lore.kernel.org/all/20261104135604.907283-1-patrick.delaunay@foss.st.com/
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1212599
https://lore.kernel.org/all/20261116104054.94115-1-patrick.delaunay@foss.st.com/


Changes in v2:
- update commit message
- update binding description
- move additionalProperties after required
- rename "power-domain-d1" to generic name "power-controller"
- remove "generic" in binding title

Patrick Delaunay (7):
  dt-bindings: power: st: add STM32MP PM domain
  pmdomain: st: add STM32MP power domain
  MAINTAINERS: add entry for ST STM32 power domain driver
  arm64: dts: st: add D1 domain for STM32MP25 family
  arm64: dts: st: fix power-domain labels DT coding style in STM32MP25
  arm64: dts: st: add D1 domain for STM32MP23 family
  arm64: dts: st: add power domains for STM32MP21 family

 .../bindings/power/st,stm32mp-pm-domain.yaml  |  48 +++++++
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
 12 files changed, 355 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
 create mode 100644 drivers/pmdomain/st/stm32mp-pm-domain.c

---
base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
branch: stm32mp_d1_domain

-- 
2.43.0

