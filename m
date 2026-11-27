Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795788658;
	b=No7bRdRaMJQ3co8LvSbCkJhU7gxGRr9MWqzIpbIZUbwyyfP3Yh9IMJylUx1YaZMJBoIq
	 ks5OlPBsD7yfw4yimshimmsz+6UYv0uJ3DeZbW6TkrEHQtWhrfkIteQJ8ooBpxLHRdjGN
	 cUw+QoSW2WJOn8gVqyGt2z67nLxPalCPWZVE8BRS8hkbcL1pLW7XEW9hPRUv0y7qiMu+r
	 2ml1HeKH77hNIOHE6EpKK/joD/JgyggXl2WhDM3e//3AttuAqva7QA9nuNx5V+GKU5NKS
	 OEX6JtCaNz00vRVYoQFS9ugbQ25H8FrmPA/dfX/SMV6G7kcV7im7dmFYsqWNmDZ5l1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788658;
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
	bh=vF2fgrRC3itVgKgW3wKpLeBPZMg9LKxsHxKDvIuayYA=;
	b=06l+pZP8n+HXTYPB0tG2qkptr+AJ9+c3NXl7DAHrSKUo45luZo2Dq3KOdGz44fH2NcyD
	 qwE7fjg9xhauV7+ivets2adsFGv6qZ5pDUIebqHOTEyLqxAwq3QvolOGahY89P3kMqgEz
	 8Q/8nVUCel6vohroU8EOFGt1qf2dunpi3wsFpz8ITMFga1yeDTH7QVWr1lBCK4sRQ7esY
	 G4ghkV8b8qip6TSFoHkBy949dn8Cb+J4vUQhRswbt8BHMad1PsLJr+1b4j3Ouace1/2TU
	 3n8lMUW4gNKpLN+Mm8rRhPJCtgWcMfI/eCm1uQebeRgLnNdsWsRe+8Ihz1GmbFeAlFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LqV9zKdm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.55
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936C606A336;
	Fri, 27 Nov 2026 14:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0936C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=LqV9zKdm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcNBIGfWpQAGzxqnflnAXGsZ69B9/xDrPTZSuSY//G2vocblUoqp/CfuCzY2/hvSjJ4pRAyKP8HEWIoKjiI6iYqYyptkOCpx7sQLUbVWiln3pXccgi+A3CqIwL4BFA+jysvsn5cH9IWISZ0Dv0pidzh6TMFXEZxh0v4sxE9ZUErIKdlDzu3SfVNXdhrdOs4fAaLZmowdrQEh5mqoOEuh+T9UjvF+UqFlMY58P5bt5ZkhByYPQHodLTOItrFAE/uiMYlgOhKCXbdQGdp1fif27o2lSfI+qaj0Ph0a/uQogIEPfxy/uaJ0/xm/8utleRrkNU9Vq6FGIinqpNt93ncjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF2fgrRC3itVgKgW3wKpLeBPZMg9LKxsHxKDvIuayYA=;
 b=eCf46JvMayHeDbCLF/pNHB5JnY74TIGKY6/COVl7FaKj74XebgSs242zLiqJwyFbqqG+skdcfNUiZoDFlQZ29zTn8LKON4qu6ZUm2dQNK6g/KfWFvRb2ZwzCcSwdOeF3OCTiUa2KIxFa3kRJcrvTCO4r+jdFUmZMvHPKFVh7s5uQDA5d75tAn9BWCW170IK7RU9pMEsjnxwFvBaPFIn9DOBJORK1I2SuQ0tDFDCiZ1b7ifM4Esl1pW//qYi2MGkBUP/V/WKhnos2kU026EbHOSVWlIK9ovOPOqRIRim9GjjfJbc1P/hefVIq5Lgbex1ywuM8hctFdWJEw94JeeJtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF2fgrRC3itVgKgW3wKpLeBPZMg9LKxsHxKDvIuayYA=;
 b=LqV9zKdmC8aFvLFB6vSTCTuWAuhuZz9Kasi3843hfRa4bGRL9BW0X1I1WKSMPKr+HVYYPv5MlAiNI5kr4Xi6uH4VVzg5UFXk5YFe+8ap8qONCFt2qHoL/XiEu5GKS4zWBTA5vUWWhyLvj31xSVqpOEqYlC71XPYPbKiTlXeWluhKlTEbUV2VYBx/RTPCvUiAzKPfxJzUSva/p4YlfT6jUGWmqIfMkwanaZflgJaWSx7b4XYbm0qBIc+Kloc/UHK7BQJzFVfs2sTyrto13ZTmxPC62M7v5fWDDn89eHiMhPGPaEzIuZo8hfvDZmmD5XTJLOQIF4VN35Lpnu4kUPUoDg==
Received: from PA7P264CA0085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:349::11)
 by AS2PR10MB7084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 14:10:46 +0000
Received: from MI3PEPF0000847E.eurprd02.prod.outlook.com
 (2603:10a6:102:349:cafe::a4) by PA7P264CA0085.outlook.office365.com
 (2603:10a6:102:349::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 14:10:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000847E.mail.protection.outlook.com (10.167.240.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 14:10:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 15:11:50 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 15:10:43 +0100
Message-ID: <900d21bb-f87b-40f0-80be-d21ce96ec202@foss.st.com>
Date: Fri, 27 Nov 2026 15:10:42 +0100
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
Subject: Re: [PATCH 2/7] pmdomain: st: add STM32MP power domain
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>, Ulf Hansson
	<ulfh@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Linux STM32
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
 <20261104145502.2.I59b2ea87f07947037b772c49c277092c887f4310@changeid>
 <CAPx+jO8_gCHgkeTB4aQDRjs1xwvXCB=zFjFBHB_UwqeOWSUEZQ@mail.gmail.com>
 <cc9c816f-eebe-4f29-a8b1-32c967c27722@foss.st.com>
 <CAPx+jO8d58tCoEL52baYMzjJ9VzyfpVNhruKAhrHrnEwuOoJig@mail.gmail.com>
 <47a78147-8504-4186-8e68-2d20d3832541@foss.st.com>
 <CAPx+jO-XcHTyAxdZTDQ6skJxdYRa8z9T5Nz2+naL8ZqC6pakag@mail.gmail.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <CAPx+jO-XcHTyAxdZTDQ6skJxdYRa8z9T5Nz2+naL8ZqC6pakag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847E:EE_|AS2PR10MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: e12a62d4-e91e-4745-12f5-08df4c9039ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|261022075727099003|261021135927099003|261022105027099003|261028144727099003|261021123027099003|261026140227099003|261026121527099003|261009223027099003|18002099003|22082099003|4143699003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	Kzs6pviwFBCESt29yySR2NAF0lQ29W3gW7Ip0ZnpvzZoqIcZ1c7AOwNvzVzka7KZkiguhEsXxo/H+VbNN2aNTiJZu6VHXQxsa3w10R++gwTkR/90zmb+dF36hWiOKsgllGWAnSQ0tpd+BmXL8gvHBPcrhthUZxkVrWGYczCB17tB8nJHi0JzJ/QLEQmpQRuE67BRtrWAGbso8jECCFZSwhW4UyzZusCFtZQT9BUESHQi8kziXMpcGx2PUVCs9+nSwp55gVwk0IwoyTOURRKJy7uvyn58h1dfYqiHwLGP0gmpujLAWs8tih9We8IYYCQVhjnAxvk2wasRewNkoI+H+bGYphue5ByHdDi7lIis48apfdIku4qiH2m8Kewen0pYELav6N+B4TkHpqjB6XB13ZVYXmLI2ogoIiDbIA3spRTOK67AVv4sKubgIBQcdXWyu8POQsN15D5m/iBlXu2Yq/MLB7Cgo2CSFH3ERehW5LfVGCcjPaxGCOkm72I4LNWEr8B0gOSLkz34hMQfJ6JgKTSHuAxr04kWXfrGVV4sRzo+XYSsu6gvKyJgNA52s2flv6gQasA4A4PAh3EsVzNkk75/gQQT8Belln+8nukASUc2mFUe55ePTSAcLcSwYP4/OL/Hk+jhc21GtQuj+qCl+w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(261022075727099003)(261021135927099003)(261022105027099003)(261028144727099003)(261021123027099003)(261026140227099003)(261026121527099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zj2Y619tGkEbcD6dOMQW+aMsYHJ6orz29+xNO6NpWFH0aATpvCFBYa2zRgXlQdSBdFktkcqyu+W8l79H+zX/kT30YDLwaapjBpso6yUbqXdsu4r3UGYuga2Q2owwDnLeodWT7VoTX6UG5yjgTvea+hTbqapEREi8/vwxXLG5FrHNV4kip9b4HG3ajxvfO5257ImcPxTcmJcenzAYGWeTxl8PQi7XwPtfVHeQfx7JdhyP+qHXMJ4vmBZBAb9zRd3q7XSobEoCuVHI+RMGCA5WcJmn9X82xmeijpiNRam3ve3DVNhl5/daIalZaxOYmh6V8cY0542KBu/V/pslT2cou0Sx+30c5fwJ2Wwo7Nd34TfXkTLoV0aRtzMvffKA7kkH6G8UzRPB62CU+mtx/0djDhj26zYz8W3d8lyfogPaiUj3+DciZNqEPgiutIwarFs3
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:10:44.0441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e12a62d4-e91e-4745-12f5-08df4c9039ed
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7084

Hi Ulf,

On 11/26/26 12:20, Ulf Hansson wrote:
> On Thu, Nov 26, 2026 at 11:41 AM Patrick DELAUNAY
> <patrick.delaunay@foss.st.com> wrote:
>> Hi,
>>
>> On 11/25/26 13:35, Ulf Hansson wrote:
>>> On Mon, Nov 16, 2026 at 4:11 PM Patrick DELAUNAY
>>> <patrick.delaunay@foss.st.com> wrote:
>>>> Hi,
>>>>
>>>> On 11/14/26 11:40, Ulf Hansson wrote:
>>>>> On Wed, Nov 4, 2026 at 3:02 PM Patrick Delaunay
>>>>> <patrick.delaunay@foss.st.com> wrote:
>>>>>> Add a generic PM domain for the STM32MP D1 domain, using the PM
>>>>>> framework to manage attached devices.
>>>>>>
>>>>>> Make D1 a subdomain of the PSCI cluster domain, so active devices keep
>>>>>> the Cortex-A35 cluster in Run1. Do not set GENPD_FLAG_ACTIVE_WAKEUP on
>>>>>> D1: system wakeups are handled by EXTI1 through the RET_PD PSCI domain.
>>>>> Would you mind elaborating on the system wakeups a bit more?
>>>>>
>>>>> The devices that get attached to the D1 PM domain do they have another
>>>>> PM domain as well, to support the system wakeups?
>>>> Each device in D1 domain use
>>>>
>>>> - D1 domain to allow any low power mode  (Stop1) when they are suspended
>>>>
>>>> - EXTI1 interruption to manage wake-up patch
>>>>
>>>> For example for UART:
>>>>
>>>>                usart2: serial@400e0000 {
>>>>                    compatible = "st,stm32h7-uart";
>>>>                    reg = <0x400e0000 0x400>;
>>>> -                interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                interrupts-extended = <&exti1 27 IRQ_TYPE_LEVEL_HIGH>;
>>>> ...
>>>>                    power-domains = <&d1_pd>;
>>>> +                wakeup-source;
>>>>
>>>>                    status = "disabled";
>>>>                };
>>>>
>>>>
>>>> Then the system wake up for S2Idle  is managed by EXTI1 device wake-up state
>>>>
>>>>     when interruptions are activated.
>>>>
>>>>
>>>> Moreover LPLV-Stop1 is not allowed when EXTI is "active" for OSI, i.e
>>>> when at least
>>>>
>>>>     one interruption of Group2 activated.
>>>>
>>>>
>>>> To explain deeper, when  OSI is fully activated  [1], i.e with full
>>>> upstream for STM32MP25
>>>>
>>>>
>>>> - the PSCI power domain Cluster Domain allows "Stop1" and "LP-Stop1" low
>>>> power mode as CpuIdle mode
>>>>
>>>>       - D1 is part of Cluster => the device is D1 domain allow low power
>>>> mode when they are suspended
>>>>
>>>>                                              => active Wake-Up for device
>>>> in D1 domain device is compatible with Stop1/LP-Stop1
>>>>                                                    the wake-up path is NOT
>>>> propagated to parent domain
>>>>
>>>>
>>>> - the PSCI Retention Domain allows "LPLV-Stop1"
>>>>
>>>>        EXTI is part of this domain (not yet upstreamed) [2] :
>>>>
>>>>
>>>>            exti1: interrupt-controller@44220000 {
>>>>                compatible = "st,stm32mp1-exti";
>>>>                interrupt-controller;
>>>>                #interrupt-cells = <2>;
>>>> +            power-domains = <&ret_pd>;
>>>>                ....
>>>>
>>>>            }
>>>>
>>>> the Group2 wake up sources are handled by EXTI1 and but they are not
>>>> functional when the LPLV mode is performed.
>>>>
>>>> We handled this restriction by EXTI patches no yet upstreamed [3]
>>>>
>>>>        - activating the wake-up path in EXTI1 device when at least one
>>>> interruption of group2 is activated  for S2DIle mode
>>>>
>>>>        - with EXTI1 pm_runtime state for OSI mode
>>>>
>>>>
>>>> So the "ret_pd" domain can't be deactivated when EXTI1 interrupts are
>>>> activated for runtime (OSI) or
>>>>
>>>> part of the wake-up patch for S2IDLE
>>>>
>>>>
>>>> [1]
>>>> https://wiki.st.com/stm32mpu/wiki/Power_overview#STM32MP2_series_power_domains
>>>>
>>>>
>>>> [2]
>>>> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/arch/arm64/boot/dts/st/stm32mp251.dtsi
>>>>
>>>>     https://github.com/STMicroelectronics/linux/commit/d216f8439d14e0a11475495cf5445e05cc4a9da9
>>>>
>>>>
>>>> [3]
>>>> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/drivers/irqchip/irq-stm32mp-exti.c
>>>>
>>>> irqchip: stm32mp-exti: Add support of pm runtime
>>>>
>>>> https://github.com/STMicroelectronics/linux/commit/4a4a20f5c5aae461a7a14c98efeddbc9cd08c672
>>>>
>>>>         irqchip: stm32mp-exti: Add support of wake-up path for S2Idle
>>>>
>>>>     https://github.com/STMicroelectronics/linux/commit/1d3b854e7b95318b67afd2dc16b8ff5fc060443a
>>>>
>>>>
>>>>> Just trying to make sure this gets modeled correctly.
>>>> I hope that follow the genPD model...
>>>>
>>>> and if it is the case , do you need update in the commit message to
>>>> clarify it ?
>>> Okay, thanks for sharing and elaborating. Even if it's not entirely
>>> straightforward to me, it looks fine to me, to model the HW like this.
>>> Although, in the end you need to convince DT maintainers to accept the
>>> updated bindings.
>>
>> they are not yet convince....
>>
>> But after Krzysztof review,
>>
>> I propose a other solution to handle the needed domain without wakeup
>> support directly in PSCI topology
>>
>> see detail in:
>>
>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid/
>>
>> https://lore.kernel.org/all/7493faea-092a-412b-8332-8fd68d20057e@foss.st.com/
>>
>>
>> I hope that this modification in PSCI domain (code and binding) is
>> acceptable for you.
>>
>> to summarize
>>
>> in code:
>> -  pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>> +  if (!of_property_read_bool(np, "arm,no-wakeup-path"))
>> +     pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
>>
>> in STM32MP device tree:
>> cluster_pd: power-domain-cluster {
>>       #power-domain-cells = <0>;
>>       domain-idle-states = <&STOP1>, <&LP_STOP1>;
>>       power-domains = <&ret_pd>;
>> +  arm,no-wakeup-path;
>> };
>>
> Let's first see if the functional dependency PM domain can be modelled
> as you already suggested in the $subject series.
ok
>
>>> However, there is a fallback option as well. I think it should be
>>> possible to drop the D1 PM domain altogether and instead hook up
>>> "usart2" (and similar devices) directly to the cluster PM domain. To
>>> allow deeper states for the cluster PM domain even if there is a
>>> system wakeup configured for the usart2 device, the corresponding
>>> driver can call device_set_out_band_wakeup(). This informs genpd that
>>> it's perfectly fine to do a power off during system suspend, see also
>>> genpd_finish_suspend().
>>
>> If the device are move in cluster power domain, it is OK for S2Idle but
>> it is not valid for CpuIdle
>>
>> For example when UART/SDCARD is not suspended, the domain cluster will
>> be powerered-off
> No it will not. If UART is active from a runtime PM point of view,
> that will prevent the cluster from being turned off.


Sorry, I misunderstood your earlier point. I have now looked at
device_set_out_band_wakeup(), added in v6.19, and I understand
your suggestion better.

For devices whose system-wakeup signal is routed through EXTI1, this
API could let genpd power off the relevant domain during system
suspend. It seems straightforward for STM32-specific drivers,
but may be less suitable for generic drivers such as EHCI and OHCI
if they also need changes.

My reason for keeping the D1 domain was to describe the SoC-specific
power-domain topology in DT, rather than requiring individual drivers
to know about this hardware restriction.

Nevertheless, I will use this API if the D1 power-domain binding is
not acceptable and the devices are attached directly to the PSCI
cluster domain.

[...]

> Kind regards
> Uffe
>

Kind regards,
Patrick


