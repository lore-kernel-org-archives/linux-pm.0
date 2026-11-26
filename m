Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689659;
	b=0jLse6EmVeJiggkZKKdkV6nj02m4Jnkc2q9jQ+OKA6VeNl3Kt5zA9U7TqW2s/eqNYqGT
	 YL7Bx7mBUxPAIZJt3jiTZzThtWJIlyRZ+vdZYM5tr0cUDerTw+LkzMV8pQkOxZ7rW0MYf
	 lEBez+xd+/qqeD+XITiA+PdJQ0YVZBON07DIz8GnVIOt5uIFQS44jn2qDmdoiy+DSmLYP
	 O94NB/r7fEM+URyI9/P3I0DDnRUgZQtclC3tSxP14sRY5OXXE7eN6PWyoGWAqd9u+8xHO
	 TiqLNphYOqswKaKmdjUNVQGlu95JeWWxa4uwwuWC5LfI/1FRDhySAa+2v+hNcc1I0tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689659;
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
	bh=qwhGRFMXAGIMN4YqlTKwZA/5IhVtdApN1bmgZA8NG7Q=;
	b=el4W0Ap1RZz3E0jYB5W5p6U50omU0dEn71yy/c1A9K4onYXfY25Y0qUQOdCz0H4UMu/I
	 SYRT/XGdyvcCg8dAS+Z5mlMm+dgOJryW7Uh/y4ysIxwOI9F2XBdsIncwaolrqCp5M6aWf
	 fXPXdvcgVpzpydgeEdGisMv1pRC20eabwwGxETxxTXtrRrE6h8OsRjUV5tlBJVoXZzBTx
	 mWMN/VfsYpp4L+slXDFgPy2ZTtg2V4FCpXWWX+UVzAkTHQVhBTUphgBwbxpBGJ4MRYHi3
	 DVNXFdAAvvCzDsgkUjxLBUjBaP2xtD6YO7xp1PXWMjnT2CCTkKA6Zi0qFtEycBKP2PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z8SdmYAD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55042606A31C;
	Thu, 26 Nov 2026 10:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55042606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Z8SdmYAD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw3emteUkwoAw7AkbSCCb/hMtHfKlJp37ip4y2BCsgNGtVz0zLVVohuGEBzLT0E0aCQBntWGJIKZS99UD1bdRi+FcpSXgr/mYKtbG8n9+I8qKClrMBHECNCtScSu8n69mQCkoe+Rixr6p8PQ5/EDkT2hZCjKLXJTWDiPzDknmumKhc6ef5DTvkdfLLJyUW+Wu/8fcNR7lVyKhsCEbjhPoQUwiE8guK/9t+caXMfZWhLoXTq6zTlofBHjdFRJlRIieQdYgQrsKi60BbN9KKM0EmUYqCynhlI1QzARQNQqKi0+tc0AhbOWZhet3sFTZ/X8znd1iTniNnzGlbOXfCbCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwhGRFMXAGIMN4YqlTKwZA/5IhVtdApN1bmgZA8NG7Q=;
 b=ABfrav2ruSl7dazsmCJzdGPiyGpbo7TAeloXylj3BSGoD9bqfArZtCjPy5Jy97b2r1ybKRAYEpnQlLf47km6iA3vb2XWb0AFbY5GrQhjNUQuiTqZG7c36MjKUYfKFA+LAv/Kh2F0/wjxtT05rHGKIj5cC7Y1neH/VhwMgkDKaoGIe+gsf+7muMXqrlRb9t0sY6xpO4tNFU4FpVkTSanBv7CT6c9WetKWhluA2/zhHpTbTn7vssfBAUuts57xzCH50hVvZh9hgTU2doSayinsERYIu9jVbE1LRe4OHnFxdEVRYAUbCTqtfkAI1mwxrDTphAGwcK10dSTuFkzm0LihoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwhGRFMXAGIMN4YqlTKwZA/5IhVtdApN1bmgZA8NG7Q=;
 b=Z8SdmYADLv0BHJ1/QtiL9EjiN5ms9z1HxnkZlWO3CCXrhaST+L/cQP6gBfS//3Xg9gA+GhH0533VPPwHeLI5BHG+QzqIxwO3RL4NaAubqX0TPg4R5/Y+HqGKsCflPKrAa4wzSriGz3f799D1gHu4YFcka/iQvLD+5eDZBQbxZ5gSXcLJ7Vpz8lVcK1tN8aKHYsmbi5Rquq7Uur+8pNCWTOYvJkL4jcV8Zh9zIedDcgypU2EY1pGWpAW8QqOQlFGy/4cVAnZbVo0yDXh31mDR6HKuQDzPff1IkpQoOrrL8EwdBQtqgrLfcevLV/qnCnUpY0ZMwXK285zoe9PTZdmL9w==
Received: from PA7P264CA0350.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::25)
 by AS4PR10MB6230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Thu, 26 Nov
 2026 10:40:52 +0000
Received: from MI3PEPF00008555.eurprd05.prod.outlook.com
 (2603:10a6:102:37c:cafe::79) by PA7P264CA0350.outlook.office365.com
 (2603:10a6:102:37c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 10:40:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008555.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 10:40:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 11:41:18 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 26 Nov
 2026 11:40:27 +0100
Message-ID: <47a78147-8504-4186-8e68-2d20d3832541@foss.st.com>
Date: Thu, 26 Nov 2026 11:40:28 +0100
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
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <CAPx+jO8d58tCoEL52baYMzjJ9VzyfpVNhruKAhrHrnEwuOoJig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008555:EE_|AS4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f39c32e-d364-4464-d801-08df4ba9bcea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|13003099007|56012099006|4143699003|261022075727099003|11063799006|261028144727099003|261009223027099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	voHy8/XXkc+8pA1o6zdz/2dk4AUkZbmeiO36wNp8zwfFZ+FNcK7ZLS70tI4cQdqNy8gAXX0EG1V21YneYVOVsuruYuyzAo+ykOtH8Qc3gVI6Lxmw2iCaY8AN6/SvwdfAwb0QmW+G45JMLe6RORWAu3j/m/hFdslmbABXh8OFLcQmBPLuTdNg8ZRe2Z7UsIvGqPqA9A4YPpY5DcvqNmOzdkkpHdfhAFfQ/tNgB6OeRTnlEU2co6oF93K5t6R4wCcOHj97xCB3CZii42mGAf7gmXl55225Hx6pJOwMT6G9wdVSpFNSB0i9ESQwM/dOYtlYO6KcqzVYvtwO6aMizf8Cax3LrN2Gn8BL9211Bzs6Ef9gkC5J98RphF96HBEvXmtBi4p6V2UgX2GLGZrklIPs+h71pfJoOIPEhshPDilUSUibjAwIDncIOo3GQhgpiu01FNkqVX6tDccMT51nHEu6zuJnM2/Exlzt9lkmmav2I+i4G55eJEbwQVX9WnRaIgkMfXQFm8nG8pInfCgFCjEXPNGefgu4VJyH9EHo0vlRovrsU01oi6pMD7Se3lOJHXznAR6wy/Zy9z6Cmu2VdWdBhzVDcgPhTXiuIM+8MWPPMHi+qAMuYe5gLM644kiun5bwrSMhBg15CNYBCvU/SW4PnA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(13003099007)(56012099006)(4143699003)(261022075727099003)(11063799006)(261028144727099003)(261009223027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RWF5kaG+QsP57IYNpcqqgWLRxLssBDrlOdKX5Z3OhmKRPxel3731VgRtIU87BRDEMJoEFzxm0P2jaDhDuRq/e1sv5pPbLAqYi0b9m++7+P5I9zrwCjM9EomA2FCclL9hFrsP9+Rs3TpiAdTmP0m0Yg49pntCamQ40kTt5mEaVBGA+MnybFSyQYwTjzTskrG5Iup7cpiBulgq4QE3fvTyp+DFEl5MqcC1udX3brWbmmNhlUVlvTvG7iz5TADDTc3Ol+rt5gQLJjxFHuCfRovoVPFy5/5+ccM1tL+cwgY8a1eE3oCzubwTBVrF+AD3d3JTjgT69X/+U5L0zJ7LzzScD0JTzq1yBuDmhNCnb3Ki8Q/0q0XzzRekO8JUA5S1H1VorkNuc3aIHA3Uwa/J+lHOsDQeksLv3C1ewK9y1fRylFDoNS1FoM1bIMKYqIee2h+M
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:40:50.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f39c32e-d364-4464-d801-08df4ba9bcea
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008555.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6230

Hi,

On 11/25/26 13:35, Ulf Hansson wrote:
> On Mon, Nov 16, 2026 at 4:11 PM Patrick DELAUNAY
> <patrick.delaunay@foss.st.com> wrote:
>> Hi,
>>
>> On 11/14/26 11:40, Ulf Hansson wrote:
>>> On Wed, Nov 4, 2026 at 3:02 PM Patrick Delaunay
>>> <patrick.delaunay@foss.st.com> wrote:
>>>> Add a generic PM domain for the STM32MP D1 domain, using the PM
>>>> framework to manage attached devices.
>>>>
>>>> Make D1 a subdomain of the PSCI cluster domain, so active devices keep
>>>> the Cortex-A35 cluster in Run1. Do not set GENPD_FLAG_ACTIVE_WAKEUP on
>>>> D1: system wakeups are handled by EXTI1 through the RET_PD PSCI domain.
>>> Would you mind elaborating on the system wakeups a bit more?
>>>
>>> The devices that get attached to the D1 PM domain do they have another
>>> PM domain as well, to support the system wakeups?
>>
>> Each device in D1 domain use
>>
>> - D1 domain to allow any low power mode  (Stop1) when they are suspended
>>
>> - EXTI1 interruption to manage wake-up patch
>>
>> For example for UART:
>>
>>               usart2: serial@400e0000 {
>>                   compatible = "st,stm32h7-uart";
>>                   reg = <0x400e0000 0x400>;
>> -                interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
>> +                interrupts-extended = <&exti1 27 IRQ_TYPE_LEVEL_HIGH>;
>> ...
>>                   power-domains = <&d1_pd>;
>> +                wakeup-source;
>>
>>                   status = "disabled";
>>               };
>>
>>
>> Then the system wake up for S2Idle  is managed by EXTI1 device wake-up state
>>
>>    when interruptions are activated.
>>
>>
>> Moreover LPLV-Stop1 is not allowed when EXTI is "active" for OSI, i.e
>> when at least
>>
>>    one interruption of Group2 activated.
>>
>>
>> To explain deeper, when  OSI is fully activated  [1], i.e with full
>> upstream for STM32MP25
>>
>>
>> - the PSCI power domain Cluster Domain allows "Stop1" and "LP-Stop1" low
>> power mode as CpuIdle mode
>>
>>      - D1 is part of Cluster => the device is D1 domain allow low power
>> mode when they are suspended
>>
>>                                             => active Wake-Up for device
>> in D1 domain device is compatible with Stop1/LP-Stop1
>>                                                   the wake-up path is NOT
>> propagated to parent domain
>>
>>
>> - the PSCI Retention Domain allows "LPLV-Stop1"
>>
>>       EXTI is part of this domain (not yet upstreamed) [2] :
>>
>>
>>           exti1: interrupt-controller@44220000 {
>>               compatible = "st,stm32mp1-exti";
>>               interrupt-controller;
>>               #interrupt-cells = <2>;
>> +            power-domains = <&ret_pd>;
>>               ....
>>
>>           }
>>
>> the Group2 wake up sources are handled by EXTI1 and but they are not
>> functional when the LPLV mode is performed.
>>
>> We handled this restriction by EXTI patches no yet upstreamed [3]
>>
>>       - activating the wake-up path in EXTI1 device when at least one
>> interruption of group2 is activated  for S2DIle mode
>>
>>       - with EXTI1 pm_runtime state for OSI mode
>>
>>
>> So the "ret_pd" domain can't be deactivated when EXTI1 interrupts are
>> activated for runtime (OSI) or
>>
>> part of the wake-up patch for S2IDLE
>>
>>
>> [1]
>> https://wiki.st.com/stm32mpu/wiki/Power_overview#STM32MP2_series_power_domains
>>
>>
>> [2]
>> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/arch/arm64/boot/dts/st/stm32mp251.dtsi
>>
>>    https://github.com/STMicroelectronics/linux/commit/d216f8439d14e0a11475495cf5445e05cc4a9da9
>>
>>
>> [3]
>> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/drivers/irqchip/irq-stm32mp-exti.c
>>
>> irqchip: stm32mp-exti: Add support of pm runtime
>>
>> https://github.com/STMicroelectronics/linux/commit/4a4a20f5c5aae461a7a14c98efeddbc9cd08c672
>>
>>        irqchip: stm32mp-exti: Add support of wake-up path for S2Idle
>>
>>    https://github.com/STMicroelectronics/linux/commit/1d3b854e7b95318b67afd2dc16b8ff5fc060443a
>>
>>
>>> Just trying to make sure this gets modeled correctly.
>>
>> I hope that follow the genPD model...
>>
>> and if it is the case , do you need update in the commit message to
>> clarify it ?
> Okay, thanks for sharing and elaborating. Even if it's not entirely
> straightforward to me, it looks fine to me, to model the HW like this.
> Although, in the end you need to convince DT maintainers to accept the
> updated bindings.


they are not yet convince....

But after Krzysztof review,

I propose a other solution to handle the needed domain without wakeup 
support directly in PSCI topology

see detail in:

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid/

https://lore.kernel.org/all/7493faea-092a-412b-8332-8fd68d20057e@foss.st.com/


I hope that this modification in PSCI domain (code and binding) is 
acceptable for you.

to summarize

in code:
-  pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+  if (!of_property_read_bool(np, "arm,no-wakeup-path"))
+     pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;

in STM32MP device tree:
cluster_pd: power-domain-cluster {
     #power-domain-cells = <0>;
     domain-idle-states = <&STOP1>, <&LP_STOP1>;
     power-domains = <&ret_pd>;
+  arm,no-wakeup-path;
};


>
> However, there is a fallback option as well. I think it should be
> possible to drop the D1 PM domain altogether and instead hook up
> "usart2" (and similar devices) directly to the cluster PM domain. To
> allow deeper states for the cluster PM domain even if there is a
> system wakeup configured for the usart2 device, the corresponding
> driver can call device_set_out_band_wakeup(). This informs genpd that
> it's perfectly fine to do a power off during system suspend, see also
> genpd_finish_suspend().


If the device are move in cluster power domain, it is OK for S2Idle but 
it is not valid for CpuIdle

For example when UART/SDCARD is not suspended, the domain cluster will 
be powerered-off

with CpuIdle and with pm runtime even witthout S2Idle system suspend

when sleep time > latency of idle state


So Stop1/LP-Stop1 can be dynamically request when device are still 
active, even if device are

not functional in this low-power mode.


>
> [...]
>
> Kind regards
> Uffe


Regard

Patrick

