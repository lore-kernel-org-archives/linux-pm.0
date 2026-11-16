Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794841888;
	b=CdilW3ebokKuG1ygi6pT1PAIOyItWbHPXQODcM1gVvM8EdyMTbcszk4V5GT/EXO2k4Pm
	 bXLIwiFv48hej5TLF3DDdoXYGqHphrQVBY5oPu21fKnNcRn7ZUA034L5S3slTa187ufBc
	 pPkDu4YRUo964OCm5uhw8Kco8gzvCvnkyb32LbJTGYvevVSnl4PU1GgDk0iwk2FMp7WUQ
	 cD1uok+qbANoKzl7HJS0i4gcOowi6XHFoj1dTQT+eUlgANDO4dnbkLX3yrheCDS1JW0Iq
	 Ly4LsAqpG2rY85jKq0I7JJbk5YhDbvrGA5MJmRfSrXTBkV9CNrQpnwbxXnytXoe/oXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841888;
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
	bh=cLBiiKmsf9Y+tJBhUJ3aEf8ysBOv3TOP83ASz1o7Vqw=;
	b=wM8+GDA/37t8ms7bFK2tY1+eIJfz191mOaHaPzlFA2cV1PCaUbOCHUN/8YRsc/tmJsoA
	 VB1LxgFSFjNxxLfKFkh4iJd1pykj+8M4X6I4l052KwZonDu30V7rFZEg1/usShWUj15kf
	 b1EiuuyL5mSsfvEjVmjdzofo8q9XQXr7Kn+9oyfgSOKpo9AGTDMex8ordFuint3giGpaS
	 R33pVkD1SLpfTnyv0jecPP+Urhd9ISvzMtUWEpmpHpmOGlaU1TAsmWZT9HAMf3kVO9poY
	 6bv3UMAifZ+zLXZpqGkfJa13/KcSjzcb1Hkbq5od2euErxKuhoxtSID2vZzMxAHV/SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QhjABNko;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.70
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48E606A883;
	Mon, 16 Nov 2026 15:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F48E606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=QhjABNko
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=su5GDY8LKw+wQ1TutyNjHgX5PiYUyuwqgtGrKwLsJlzAmeogTXAgTosNuR4pO4JFiNOrMHJTYW9c6IE5cd9KpROcFQSL36W0Y9jE3fDL2qQFBrdgixHpcxT0r68Ral2DbAWcJr/6PvkvKmoprfz8kp0ZUnNZHG1Zx9vQQEWschQu0lBJpUg6K28MbTSoJs3WU5USTFHkEc5ewzG7Iy1xbXxQI0s3DXP9Yd+BteVB1JhhcYMtWZeKha6ytxK7oJpol7KrcCMQl6kYw2ahBP37Ini3nGsVr50fOznvfdA7/gEZqFlhSOl/2zOy0rYTAuJz+CVkLGnbCe3GsezqgHKq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLBiiKmsf9Y+tJBhUJ3aEf8ysBOv3TOP83ASz1o7Vqw=;
 b=CbCjUv8am0lgg7mwmagtb9hUpnAUZxts6/FfAsN6jwPL9lbZGkvfMeQeJyoQTBfd+RcRCj2s9ZjS/0x4ebdYESZcDizKCsVxGDZZCUR/0UhPF8fvNtgzFdJYifPH3duVoP8OTB7e9fJUUJfJZmH1uBvG4RfHit4uCsnzTWihUpOQB12L0JHsel2cNVLuRpqKJpk5Oq4c/E285gS1pkOzlsunhZ/qWBXDr5+zABPkFjod9qO4afu8Tko8hLWhirvIj3fybrQRn2O5mKCzkVQ27ZHds4Z5HrAXk3UhqITWp2/bigcV5PpdyfgadL/USTVos/YA4HX6xHF4qq3sTDnYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLBiiKmsf9Y+tJBhUJ3aEf8ysBOv3TOP83ASz1o7Vqw=;
 b=QhjABNko1ciIlGRGKw64L20efOqvzasbqyQYicymJrdghDBX5pd8GAsIek4KyQM+l47eWkzNPco5oUL4mtmfMFyK9/fUlXS3+7mh5ui1OxGvK1izrtNfQWONTd+SN7OCHB5rJMHQXXn9ZnToXGaW9y6vRR25GB/PxGOl7nR9uueDhVHoUA1fXPUYIa1sGZjHeJWdM7lLpF5m3A2mc1bxj/fpwPnj9AL+ZivdKrWK5xDiPPBY3oCDwKsnV7RCHYETKKuzbEJPuPVLZ+kCfOtC/dKlUniTNPDVMiZzwFCZCZEcirKrR68A8Zte6CUH87yDsHC58ZSOcKLizO1VVgHpxw==
Received: from PR1P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:347::10)
 by AM0PR10MB019897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:7f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 15:11:21 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:347:cafe::1f) by PR1P264CA0170.outlook.office365.com
 (2603:10a6:102:347::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Mon,
 16 Nov 2026 15:11:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 15:11:16 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 16:11:44 +0100
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 16:11:00 +0100
Message-ID: <cc9c816f-eebe-4f29-a8b1-32c967c27722@foss.st.com>
Date: Mon, 16 Nov 2026 16:10:59 +0100
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
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Antonio Borneo
	<antonio.borneo@foss.st.com>
CC: Ulf Hansson <ulfh@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
 <20261104145502.2.I59b2ea87f07947037b772c49c277092c887f4310@changeid>
 <CAPx+jO8_gCHgkeTB4aQDRjs1xwvXCB=zFjFBHB_UwqeOWSUEZQ@mail.gmail.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <CAPx+jO8_gCHgkeTB4aQDRjs1xwvXCB=zFjFBHB_UwqeOWSUEZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000849B:EE_|AM0PR10MB019897:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cfa5a1-a086-48eb-3b4f-08df43f3dc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|22082099003|18002099003|261009223027099003|13003099007|56012099006|11063799006|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hS6U4RzMLo8nV182aUnDICgJX7ydM5QNPeiI2UYTvEyKF+HyIWoW0EXx2IBJwK2HN+fcPJG8gRTBf+a3FUprTOWYIXjgv/3SZLv3L+ikMa1IgdUtNAApUxoXKDm5QJz2iUMAcS+fWa5XYPmmdX1ypinO02XUEC8mSukJ6x80LeWib8GE63EYr+cARlIkgk3JFKMrCFXOqgI6kTcBrVnnBRBMxHqAcNKYCPfzU4MwlZMjwoRFavGhDvctpoJhaBznZVoAO8lSqov/Wbc76W14T5fazkMRkSD+jF9q+su30vcqInOK4UBN3MDGXKknkGISRFxnITTYBC2p0iET6E1jqoYGf10j3ZQI3w7qlyNvKK1ZSyvUmek9o7q8bMHxRD1XLeAV0OE79ErM5+Khjji/eaJXETSXTQFb5unD6zC9cki6LlnC9OHHvjcBmS7dFxiaX9eaq4HP3KYtZscIIlNM6Mh/BN24Ss6yfmzwt6+DH6rH+r1+7y6JANPW5JESpLu0M2sUnsfzdBy0ENLJlqPLCZeGPrn3/yqtSqOMvIuZjHZ36x/DEIdyMHc0I/Pjxn5axIK0rWcbtT/qjd0sqfzmTPUtXxJT/bqt3K7ROEFiAIG6SeqehCDuHzYxS+MOt2JOj6E6P2ToyFjNY/FzK1tNBsCto1vDgM9rPjebBx1LankGuEIA8XPPUtmVegQrCLT9CEEncUeWtnVtZ9TzL0gNfw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(13003099007)(56012099006)(11063799006)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p5wEMy5MuP3LPKaSykQ1ArxJXWGfKOhYahKkNoxDjTCWwOE80I1ZCaY1nO3iR2yPFlcho9UoZ5+P6DAqCKZD14mGDWviXkvbecYlS2GDymrSjeaSnq/Q99NWLWcDBcuv0ty/Kvz2nTWOiMkXMbonJACVaOfDZ+AZbQokQrOB6H16dmTJft5WeDuusEdDuclYu02hL7j08+8h6bBuMafpKBKTpUjnib40Cpr0MFPz10QqSdBxkSMUgaZZIegNzHPXLJz59EM8EEAUQiuQ+Jjm3YDS98vi0HNfyX1veYfqEk1VsgtuMrxs3iZpzwXryVoKhTdPeRfB1Yzfod2mm9E4h5YKwyqIJSM1yBM61GK5OWjbPoF+kQuak0uX4oTSmW9SSvTlRzX31/Yp4XJnf2KFHdx3GqszKEENe+ugYyxSlBfDR2vmOJEqBKcqs7y5nHCN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:11:16.2311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cfa5a1-a086-48eb-3b4f-08df43f3dc5c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB019897

Hi,

On 11/14/26 11:40, Ulf Hansson wrote:
> On Wed, Nov 4, 2026 at 3:02 PM Patrick Delaunay
> <patrick.delaunay@foss.st.com> wrote:
>> Add a generic PM domain for the STM32MP D1 domain, using the PM
>> framework to manage attached devices.
>>
>> Make D1 a subdomain of the PSCI cluster domain, so active devices keep
>> the Cortex-A35 cluster in Run1. Do not set GENPD_FLAG_ACTIVE_WAKEUP on
>> D1: system wakeups are handled by EXTI1 through the RET_PD PSCI domain.
> Would you mind elaborating on the system wakeups a bit more?
>
> The devices that get attached to the D1 PM domain do they have another
> PM domain as well, to support the system wakeups?


Each device in D1 domain use

- D1 domain to allow any low power mode  (Stop1) when they are suspended

- EXTI1 interruption to manage wake-up patch

For example for UART:

             usart2: serial@400e0000 {
                 compatible = "st,stm32h7-uart";
                 reg = <0x400e0000 0x400>;
-                interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+                interrupts-extended = <&exti1 27 IRQ_TYPE_LEVEL_HIGH>;
...
                 power-domains = <&d1_pd>;
+                wakeup-source;

                 status = "disabled";
             };


Then the system wake up for S2Idle  is managed by EXTI1 device wake-up state

  when interruptions are activated.


Moreover LPLV-Stop1 is not allowed when EXTI is "active" for OSI, i.e 
when at least

  one interruption of Group2 activated.


To explain deeper, when  OSI is fully activated  [1], i.e with full 
upstream for STM32MP25


- the PSCI power domain Cluster Domain allows "Stop1" and "LP-Stop1" low 
power mode as CpuIdle mode

    - D1 is part of Cluster => the device is D1 domain allow low power 
mode when they are suspended

                                           => active Wake-Up for device 
in D1 domain device is compatible with Stop1/LP-Stop1
                                                 the wake-up path is NOT 
propagated to parent domain


- the PSCI Retention Domain allows "LPLV-Stop1"

     EXTI is part of this domain (not yet upstreamed) [2] :


         exti1: interrupt-controller@44220000 {
             compatible = "st,stm32mp1-exti";
             interrupt-controller;
             #interrupt-cells = <2>;
+            power-domains = <&ret_pd>;
             ....

         }

the Group2 wake up sources are handled by EXTI1 and but they are not 
functional when the LPLV mode is performed.

We handled this restriction by EXTI patches no yet upstreamed [3]

     - activating the wake-up path in EXTI1 device when at least one 
interruption of group2 is activated  for S2DIle mode

     - with EXTI1 pm_runtime state for OSI mode


So the "ret_pd" domain can't be deactivated when EXTI1 interrupts are 
activated for runtime (OSI) or

part of the wake-up patch for S2IDLE


[1] 
https://wiki.st.com/stm32mpu/wiki/Power_overview#STM32MP2_series_power_domains


[2] 
https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/arch/arm64/boot/dts/st/stm32mp251.dtsi

  https://github.com/STMicroelectronics/linux/commit/d216f8439d14e0a11475495cf5445e05cc4a9da9


[3] 
https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/drivers/irqchip/irq-stm32mp-exti.c

irqchip: stm32mp-exti: Add support of pm runtime

https://github.com/STMicroelectronics/linux/commit/4a4a20f5c5aae461a7a14c98efeddbc9cd08c672

      irqchip: stm32mp-exti: Add support of wake-up path for S2Idle

  https://github.com/STMicroelectronics/linux/commit/1d3b854e7b95318b67afd2dc16b8ff5fc060443a


>
> Just trying to make sure this gets modeled correctly.


I hope that follow the genPD model...

and if it is the case , do you need update in the commit message to 
clarify it ?


>
> One comment in the code below.
>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   drivers/pmdomain/st/Kconfig             |  14 +++
>>   drivers/pmdomain/st/Makefile            |   1 +
>>   drivers/pmdomain/st/stm32mp-pm-domain.c | 128 ++++++++++++++++++++++++
>>   3 files changed, 143 insertions(+)
>>   create mode 100644 drivers/pmdomain/st/stm32mp-pm-domain.c
>>
>> diff --git a/drivers/pmdomain/st/Kconfig b/drivers/pmdomain/st/Kconfig
>> index a77a70211f61..da8a54d44158 100644
>> --- a/drivers/pmdomain/st/Kconfig
>> +++ b/drivers/pmdomain/st/Kconfig
>> @@ -1,4 +1,18 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +
>> +config STM32MP_PM_DOMAIN
>> +       tristate "STM32MP PM domain"
>> +       depends on ARCH_STM32 || COMPILE_TEST
>> +       select PM_GENERIC_DOMAINS
>> +       default y
>> +       help
>> +         Enable support for the STM32MP Power Management (PM) domain driver.
>> +         This driver implements a generic PM domain for STM32MP SoCs, allowing
>> +         the kernel to manage power domains for various hardware blocks using
>> +         the generic power management framework. It is typically used to
>> +         control the power state of devices and peripherals on STM32MP
>> +         platforms. If unsure, say Y.
>> +
>>   config UX500_PM_DOMAIN
>>          bool "ST-Ericsson ux500 Power Domain"
>>          depends on ARCH_U8500 || COMPILE_TEST
>> diff --git a/drivers/pmdomain/st/Makefile b/drivers/pmdomain/st/Makefile
>> index 6d8b617eb834..0e8131b7fe9d 100644
>> --- a/drivers/pmdomain/st/Makefile
>> +++ b/drivers/pmdomain/st/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_STM32MP_PM_DOMAIN)                += stm32mp-pm-domain.o
>>   obj-$(CONFIG_UX500_PM_DOMAIN)          += ste-ux500-pm-domain.o
>> diff --git a/drivers/pmdomain/st/stm32mp-pm-domain.c b/drivers/pmdomain/st/stm32mp-pm-domain.c
>> new file mode 100644
>> index 000000000000..1a6393840f56
>> --- /dev/null
>> +++ b/drivers/pmdomain/st/stm32mp-pm-domain.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Implements PM domain using the generic PM domain for STM32MP SoC.
>> + *
>> + * Copyright (C) STMicroelectronics 2026
>> + * Author(s): Patrick Delaunay <patrick.delaunay@foss.st.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +struct stm32mp_pm_subdomain_link {
>> +       struct generic_pm_domain *domain;
>> +       struct generic_pm_domain *subdomain;
>> +};
>> +
>> +static void stm32mp_pm_domain_genpd_remove(void *data)
>> +{
>> +       struct generic_pm_domain *genpd = data;
>> +
>> +       pm_genpd_remove(genpd);
>> +}
>> +
>> +static void stm32mp_pm_domain_release_subdomain(void *data)
>> +{
>> +       struct stm32mp_pm_subdomain_link *link = data;
>> +
>> +       pm_genpd_remove_subdomain(link->domain, link->subdomain);
>> +}
>> +
>> +static void stm32mp_pm_domain_release_genpd_provider(void *data)
>> +{
>> +       struct device_node *np = data;
>> +
>> +       of_genpd_del_provider(np);
>> +}
>> +
>> +static int stm32mp_pm_domain_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct device_node *np = dev->of_node;
>> +       struct generic_pm_domain *pd;
>> +       struct stm32mp_pm_subdomain_link *link;
>> +       int ret;
>> +
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       /* The OF node must specify us as a power-domain provider. */
>> +       if (!of_property_present(np, "#power-domain-cells")) {
>> +               dev_warn(dev, "%pOF lacks #power-domain-cells\n", np);
>> +               return 0;
>> +       }
>> +
>> +       pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
>> +       if (!pd)
>> +               return -ENOMEM;
>> +
>> +       pd->name = dev_name(dev);
>> +
>> +       /*
>> +        * Domain based only on PM clk framework, no GENPD_FLAG_ACTIVE_WAKEUP
>> +        * support, the wake-up path is handled by interrupt driver with its
>> +        * power domain. GENPD_FLAG_NO_STAY_ON as domain no required sync state,
>> +        * domain allow low power modes even if devices are not probed
>> +        */
>> +       pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_NO_STAY_ON;
>> +
>> +       ret = pm_genpd_init(pd, NULL, false);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to init power domain\n");
>> +
>> +       ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_genpd_remove, pd);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to add action\n");
>> +
>> +       link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
>> +       if (!link)
>> +               return -ENOMEM;
>> +       link->domain = pd_to_genpd(dev->pm_domain);
>> +       link->subdomain = pd;
>> +
>> +       ret = pm_genpd_add_subdomain(link->domain, link->subdomain);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to add subdomain\n");
>> +
>> +       ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_release_subdomain, link);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to add action\n");
>> +
>> +       ret = of_genpd_add_provider_simple(np, pd);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to add power domain provider\n");
>> +
>> +       ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_release_genpd_provider, np);
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to add action\n");
>> +
>> +       ret = devm_pm_runtime_enable(dev);
> What is this used for?


This pattfrom driver is part of power-domain-cluster because in device 
tree a power domain is associated to it DT node


     d1_pd: power-domain-d1 {
         compatible = "st,stm32mp-pm-domain";
         #power-domain-cells = <0>;
         power-domains = <&cluster_pd>;
     };


This power domain is used to create the GENPD sub domain "power-domain-d1"

but as side effect  the associated platform device is also in this PSCI 
domain

so it must manage correctly a PM state.


Without this line the runtime status is "unsupported" and the cluster 
domain is not deactivated


$> cat /sys/kernel/debug/pm_genpd/pm_genpd_summary

domain                          status          children performance
     /device                         runtime status   managed by
------------------------------------------------------------------------------
power-domain-d1                 on                              0
     482c0000.ethernet               active                      0       
    SW
     482d0000.ethernet               active                      0       
    SW
     40130000.i2c                    suspended                   0       
    SW
     400e0000.serial                 active                      0       
    SW
     48220000.mmc                    suspended                   0       
    SW
     48030000.dcmipp                 suspended                   0       
    SW
power-domain-cpu1               on                              0
     genpd:0:cpu1                    active                      0       
    SW
power-domain-retention          on                              0
power-domain-cluster
     40400000.dma-controller         suspended                   0       
    SW
     40410000.dma-controller         suspended                   0       
    SW
     40420000.dma-controller         suspended                   0       
    SW
power-domain-cluster            on                              0
                                                 power-domain-cpu0, 
power-domain-cpu1, power-domain-d1
     power-domain-d1                 unsupported                 0       
    SW  <<<< HERE
power-domain-cpu0               off-0                           0
     genpd:0:cpu0                    suspended                   0       
    SW


a other (better?) solution is to remove the linked create by framework

as it i done in drivers/pmdomain/apple/pmgr-pwrstate.c:288:

with:


+    pm_genpd_remove_device(dev);


I change if you confirm that it is better.


>
>> +       if (ret)
>> +               return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id stm32mp_pm_domain_matches[] = {
>> +       { .compatible = "st,stm32mp-pm-domain", },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32mp_pm_domain_matches);
>> +
>> +static struct platform_driver stm32mp_pm_domain_driver = {
>> +       .driver = {
>> +               .name = "stm32mp_pm_domain",
>> +               .of_match_table = stm32mp_pm_domain_matches,
>> +       },
>> +       .probe  = stm32mp_pm_domain_probe,
>> +};
>> +
>> +module_platform_driver(stm32mp_pm_domain_driver);
>> +
>> +MODULE_AUTHOR("Patrick Delaunay <patrick.delaunay@foss.st.com>");
>> +MODULE_DESCRIPTION("ST STM32MP power domain driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.43.0
>>
> Kind regards
> Uffe


Regards

Patrick

