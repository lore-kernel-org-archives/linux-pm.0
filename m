Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456421;
	b=0Fw71FqVY7nS0vyOBl7TKITMCwDUphpA8SWJhF1s1eB8Xld+4F54ZrzPwh+g3HuFdI4P
	 +BY6uFRlnmvWARHcrtlzZ51mOOacOudQicYvJNWyzSbkpbCs0m/7BY+TzBwE1cFjGMTQ3
	 uePRDUFLmnn2/sv1X2G8SkqRdd132jeMfLuw/yymT1AFMwGLUH0exkHaambraEAbZcXkA
	 YsPTAoAEg8DIlLpXbl8EcIgmFszhwOAq5HuhHaZlzQcbZvJ8l5n83ya9/99E9/m0lUZ5y
	 TKIZqsRjH3O5jlJWAeHBpCRjGj0XH4rbTLN5xW6SLcnFk0TXv94nNA6hXOmBMD6U2lQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456421;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=8FbvJQyyxt3sYIM3lDbK047s3Rg+KLP80gisFASdZZ4=;
	b=C4O4jCLx1RRbeWf9UOtpnMGvAyU6sLkjtx7YeU1QjMFhGVvf7PF7pn+GQdMzH8XaVagw
	 mkPyF0/G47wimrekhkmRPwwT2yHYg2INd49CYwkKaNLvvPag7eDY14TSSrKvCZNATFN7d
	 p1MYBkpKQv0d1MXume5956oFTL0bGsKlvnz7V3Hi2JAXiYNrhyusYkKhDjAfJ0YE4FzJs
	 CqMBefHVVJFxcTMejz3dCb5Gut2iG/AOQIO6b21dCw05+wsGufwOlaQ2+k0Cqtje9THUu
	 XQAZi2jKsgyTA8ljAdt5l+VpnaNHT7DgVnx4a5I72pBzcIxU1kvSAJ07cpqf5eOfRJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RCUvTSAz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.69
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010069.outbound.protection.outlook.com [52.101.69.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D375606A31A;
	Mon, 23 Nov 2026 17:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D375606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=RCUvTSAz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRV5LA+y/ZcHM/ZyHuIAcYib2Bw/Odgdn4QSrwgbjMaOySJUI228reiZV7vp8JzN/Gtdpx4W3xIwa9Z8rYhBcefiiVyLbCg8aCWBvvfAWIZfST99LaJCoYYRnsToHugrGFz0UbGsKne0QlCyW5GJFiPYbUZZfWUxN3+2PoWh4U8IhpqC8UnbqgGmD7M1XLPLZk/Gt0fGvGCrsupKghtuwZzxaQL6u8seGbZZ9BGYIsExIOyz12rHMjoMFZTDEW3NuWck5yKTiACphZt+rbVHRp0sofsIg5swCJB9v/OqWlEuOjTYp4MHW1X1sZCHgIT1fAnLSI+SmF8GoU3vqUfPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FbvJQyyxt3sYIM3lDbK047s3Rg+KLP80gisFASdZZ4=;
 b=WOp6hUK3IdZZJxvGBvE7Rd/bDndfsI58APXa9GjSBuJ9NdtJNJemX4tNE6aoKAtPHr+NCUf8XtjDt/Y+6aEInZbQpEIhqfrGEfm7oUHN66KAYVckHpmoY5MTIt1Pc8YvBdbNMkEEISweu6UGnY73v1BEPdXvV0bV/QJEVVyRhNO2k0yicI3N3g7OlkG/F6mbtjaaihOXfetkTRwRjBZOORUGraL86D/EmdSc7uT45UN7ssV9niGHzH2CRsfAx2FoUpyMv/u0x/ginTGEsj5IKb5tmpOzvTjDKZhSjV07c3yc+JWiPCg/dLlDxUsnnUIXVdy8hDSAY98x02dwQmwkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FbvJQyyxt3sYIM3lDbK047s3Rg+KLP80gisFASdZZ4=;
 b=RCUvTSAzRTkEOENQAXryHfmeHtDcLYJIKdVVceJSVLQ5i8T9ASRzECJ17hHheGSLUB7CcM4KXvtuQLoFMQ6+lJpXekOeqlBBVLpNuUjdzynP6AvxVkHzOgrMn0zqZpAhlffqb+R+3LFBZ2nNcWjJ1fXs3O2jxPe7jCThO9Soub6Dl6QAGMlSuK2xDUyqLn/+uCs/ViD7b/jQ21ql2OxRWfglJdujPNOB4V5DOG3h3uSQt5/QkuLYmR3NaFp/sFAkuv4hPYYbUtdh2RUrF+jT5fWwGWr12FiEbbvd6ZmYFzBEAN6q7owpDVsfY7G2XEfBqR4vsrNxO2hTiyV75cfQTg==
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by BR2PR10MB992284.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Mon, 23 Nov
 2026 17:53:35 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::61) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 17:53:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 17:53:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 23 Nov
 2026 18:54:39 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 23 Nov
 2026 18:53:33 +0100
Message-ID: <7493faea-092a-412b-8332-8fd68d20057e@foss.st.com>
Date: Mon, 23 Nov 2026 18:53:33 +0100
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
Subject: Re: [RESEND PATCH 1/7] dt-bindings: power: st: add STM32MP PM domain
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
References: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
 <20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid>
 <20261123-pretty-strict-caracara-bfcaac@quoll>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20261123-pretty-strict-caracara-bfcaac@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|BR2PR10MB992284:EE_
X-MS-Office365-Filtering-Correlation-Id: d576ef52-45dd-44b4-7972-08df498ab20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261102123227099003|5023799004|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	+zdvSpeHJEKPjgLsCOy3eLtRbOH0xyZuFIHtMzFzsKD8/r3sJG6wbrZgN36WcXJQZNj8BL/EMBtXUCNILfMrMMaZ4dSxD50jimfa5yiKONjHI3wuIJTlviy8HJeXxgToHCdtWRZrwp26TFBdDw6cKUiTB3nx2DCK+qnBAZiiI3bWcznwIzXkAplv0q/yhUvOVT2mPaS+kZ7d8fAHBc9fxzWqm5CNcbo54UfB+ScrAKCRkUIQiBhoWtDbwTnwvnquXNC8xIHy1KQuoo4WZ/NEQD2IZZZmXZmPbu3fCEqj6YWRwVzdrc0s8pbTpm6sPDPTBpDX10fOJytSpTTFUmAo8e4JIPS2yQiyRHbN4tQ2TN/uXkInvUDunDY0ahDESdcUF1yQ7YESskgzDmv7q95+dQcr6UYgD/BhUD95vK3auuWnE5wQr5aWP4Wr5DnB7H544nZ1UWTrtBuEH/1uykYeOQgpk6pjAVSTZuFq7PBIfPB9Hotsg7Lbx3dsV3q5imDHlDwc2a5mb2cw4T+bqeZSbG05WJFMSvlng+991Ji106hRALZ7p5mEqbvkT9IQx5qzhc5gqzt2dcmUcayQ8NDJYIux7wlWR0QakSNQuv2MCvCwUsSJqxma2HEPOMZQ39AiZm6Es1js2deXXhbVnpcjdA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261102123227099003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RzvvuHLsZpJboDo/bpP2ThXCWcM7pJX3+ArO/VXssPEw02NMGyOByAbRiCXSFG6YRUauvUAJKCCbrZl5XJe8JtcRwSFvcHhf7eS+YizEENaaUrdLLTyGCw+GQVKo4XJeiw97XPygIN1KaBQmffJeLnSyfX8L/uGR9Y5lqODpZnhoNCOorxADLuLQj9tBCTG0WdX+ktF2WBc+5NMMgDuf0TjB+5S0IXohEThdbZ1Mm7kKK54wbm5FXVYCn49SoOLvu8DfYvvkzL0MOH+piDcwTv3cZxyuogt/NajP9pUVtJB4npEsct0WlzNcKCN2Hf/ORYOPvS4E+64GdsxmLzuviLiwkcvwoQAet+C35yiSFTMowCZOy+q8Ami2kml4RhEkBN6RBLT+486983P0mceoKmFeJKxva/ofZx4mMoCsepfmIE2ahDXEzEB30eygq3/3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:53:35.0112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d576ef52-45dd-44b4-7972-08df498ab20b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992284

Hi,
On 11/23/26 12:11, Krzysztof Kozlowski wrote:
>On Mon, Nov 16, 2026 at 11:40:26AM +0100, Patrick Delaunay wrote:
>>Add binding documentation for the power domains found on
>>STMicroelectronics STM32MP SoCs.
>
>A nit, subject: drop second/last, redundant "binding". The
>"dt-bindings" prefix is already stating that these are bindings.
>See also:
>https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
Thanks for the review. I will drop the redundant “binding” from the 
subject and
move additionalProperties: false below the required block.
>
>
>>
>>Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>---
>>
>>.../bindings/power/st,stm32mp-pm-domain.yaml | 46 +++++++++++++++++++
>>1 file changed, 46 insertions(+)
>>create mode 100644 
Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
>>
>>diff --git 
a/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml 
b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
>>new file mode 100644
>>index 000000000000..4ab477fb4499
>>--- /dev/null
>>+++ b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
>>@@ -0,0 +1,46 @@
>>+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>+%YAML 1.2
>>+---
>>+$id: http://devicetree.org/schemas/power/st,stm32mp-pm-domain.yaml#
>>+$schema: http://devicetree.org/meta-schemas/core.yaml#
>>+
>>+title: STM32MP generic power domain
>>+
>>+maintainers:
>>+-Patrick Delaunay <patrick.delaunay@foss.st.com>
>>+
>>+allOf:
>>+-$ref: /schemas/power/power-domain.yaml#
>>+
>>+description: |
>>+The STM32MP SoCs contain a D1 domain which defines the devices assigned to
>>+Cortex A cluster, the devices in this domain are functional only when this
>>+cluster is not in low power modes (Stop modes) with clock OFF.
>>+
>>+This PM domain node represents this dependency, based on PM framework and
>>+without wake-up path support.
>>+
>>+properties:
>>+compatible:
>>+const: st,stm32mp-pm-domain
>>+
>>+'#power-domain-cells':
>>+const: 0
>>+
>>+power-domains:
>>+maxItems: 1
>
>I don't get the purpose of this binding. There are no resources here, so
>this looks like fake intermediary (meaning: non-controllable). Why the 
devices cannot reference
>final domain?
Regarding the purpose of this domain, I agree that it does not control a 
power
switch or any other hardware resource. It is an intermediate genpd used to
represent a functional dependency. Devices attached to D1 need the 
Cortex-A35
cluster to remain in Run1, with their clocks available, regardless of 
whether
they are wakeup-capable. Wake-up events are handled by EXTI1.
This SoC power domain allows STM32MP to represent two paths in the 
power-domain
hierarchy for PSCI OSI:
one for device functionality (clock availability → cluster_pd) and
one for wake-up handling (EXTI → ret_pd).
Currently, GENPD_FLAG_ACTIVE_WAKEUP propagates wake-up requirements 
through the
Linux power-domain hierarchy used by PSCI CPU Idle. As a result, the cluster
domain cannot be powered off when an associated device has an active wakeup
source. Consequently, the PSCI cluster domain cannot enter the 
associated idle
state (Stop1).
In STM32MP SoCs, D1 domain is a hardware concept shared by PWR and RCC. 
In RCC,
kernel clocks are supplied to peripherals only when the associated CPU is
running: each device is assigned to a CPU through RIFSC and the IP blocks
associated with CPU1 = Cortex-A35 are not functional in low-power modes when
the associated CPU is stopped in low power mode.
When a node is present and enabled in the Linux device tree, its associated
device is always assigned to CPU1. If the device is not functional in 
low-power
modes (Stop1/2 and LP-Stop1/2), it is implicitly part of the D1 domain.
The added SoC power domain makes this relationship explicit, although 
this may
not be the best solution. If this intermediate domain is not the right 
way to
model the dependency, I would appreciate your guidance on an alternative.
>
>
>>+
>>+additionalProperties: false
>
>this goes after required block.
>
>>+
>>+required:
>>+-compatible
>>+-'#power-domain-cells'
>>+-power-domains
>>+
>>+examples:
>>+-|
>>+power-domain-d1 {
>
>Node names should be generic. See also an explanation and list of
>examples (not exhaustive) in DT specification:
>https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>If you cannot find a name matching your device, please check in kernel
>sources for similar cases or you can grow the spec (via pull request to
>DT spec repo).
Sorry about that. I understood “power-domain” to be a generic node name, 
based
mainly on the pattern in /bindings/arm/psci.yaml and on node-name 
patterns such
as power-domain@[0-9a-f]+ used in the power bindings.
I now understand your point: power-domain-d1 is not a generic node name and
it is not a subnode of a power-controller, as described in
bindings/power/power-domain.yaml.
The PWR device, which manages the low-power modes and the power supplies 
for
each domain (including DVFS for the CPU and GPU), is handled by PSCI 
firmware.
I added an SoC power domain because I did not want to modify the PSCI 
binding
or driver; however, this may not be the best solution.
I also considered changing the PSCI domain handling to use a wakeup-source
property, but that would change the behavior of existing device trees.
In the driver drivers/cpuidle/cpuidle-psci-domain.c
static int psci_pd_init(struct device_node *np, bool use_osi)
{
...
/*
* Allow power off when OSI has been successfully enabled.
* PREEMPT_RT is not yet ready to enter domain idle states.
*/
if (use_osi && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
pd->power_off = psci_pd_power_off;
-pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+if (of_property_read_bool(np, "wakeup-source"))
+pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
} else {
pd->flags |= GENPD_FLAG_ALWAYS_ON;
}
....
The proposed STM32MP251 device tree becomes
-d1_pd: power-domain-d1 {
-compatible = "st,stm32mp-pm-domain";
-#power-domain-cells = <0>;
-power-domains = <&cluster_pd>;
-};
psci {
bootph-all;
compatible = "arm,psci-1.0";
method = "smc";
cpu0_pd: power-domain-cpu0 {
#power-domain-cells = <0>;
domain-idle-states = <&CPU_PWRDN>;
power-domains = <&cluster_pd>;
};
cluster_pd: power-domain-cluster {
#power-domain-cells = <0>;
domain-idle-states = <&STOP1>, <&LP_STOP1>;
power-domains = <&ret_pd>;
};
+d1_pd: power-domain-d1 {
+#power-domain-cells = <0>;
+power-domains = <&cluster_pd>;
+};
ret_pd: power-domain-retention {
#power-domain-cells = <0>;
domain-idle-states = <&LPLV_STOP1>;
+wakeup-source;
};
};
...
exti1: interrupt-controller@44220000 {
compatible = "st,stm32mp1-exti";
interrupt-controller;
#interrupt-cells = <2>;
power-domains = <&ret_pd>;
...
}
Moreover with this PSCI change, I could remove the need for the D1 domain:
-cluster_pd would not have a wakeup-source property, so the wake-up path 
would
not propagate.
-ret_pd would have a wakeup-source property, and EXTI1 would belong to this
domain.
psci {
bootph-all;
compatible = "arm,psci-1.0";
method = "smc";
cpu0_pd: power-domain-cpu0 {
#power-domain-cells = <0>;
domain-idle-states = <&CPU_PWRDN>;
power-domains = <&cluster_pd>;
};
cluster_pd: power-domain-cluster {
#power-domain-cells = <0>;
domain-idle-states = <&STOP1>, <&LP_STOP1>;
power-domains = <&ret_pd>;
};
ret_pd: power-domain-retention {
#power-domain-cells = <0>;
domain-idle-states = <&LPLV_STOP1>;
+wakeup-source;
};
};
>
>
>
>Best regards,
>Krzysztof
>
I add Ulf or Sudeep to the To: list to get feedback on the PSCI domain 
hierarchy,
particularly regarding backward compatibility.
For this proposal, I could also use a negated property ("no-wakeup-path' 
by exmaple)
to avoid breaking backward compatibility (property name to be confirmed,
perhaps need "arm," prefix).
If you think this is an acceptable proposal, I can submit a V2 of the 
series
using this approach:
in code:
-pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+if (!of_property_read_bool(np, "no-wakeup-path"))
+pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
in STM32MP device tree:
cluster_pd: power-domain-cluster {
#power-domain-cells = <0>;
domain-idle-states = <&STOP1>, <&LP_STOP1>;
power-domains = <&ret_pd>;
+no-wakeup-path;
};
the cluster_pd domain can be powered-off even if on device is in the 
wake-up patch.
Regards
Patrick

