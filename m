Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13C3DC862;
	Wed,  3 Jun 2026 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471456; cv=fail; b=HDVCsNhi3K5/rsH4iU6iefc/sDj1MGdYgO2MxaY5KM/r32pVLxMh+a/49tz0hSflpVZV0X761NPNxT1dCLdoSKKD1lbm+6FfbksNytm5x1NHRTYUg84KddvgEZbCXsq94WC6G/P8bY6or7hiNh4YsSN7y0tBIkCjU+q/iS36T6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471456; c=relaxed/simple;
	bh=/j/q1ADAW/zgzJjKEVxtBdayC65bAExWloJUvmWvMnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iz3EyImQ++OcBKI9dbYnMpGtjzFS6fqp7749Rben+qnafrwZYVatlHTPOeg3F8Woehg/WoGV78mbo+CJw0QabGAse4DWuTtqaGikHKFyQ6pAE9MZPq8fH5UByAkE7+4tDpmVa8oxtewdMqzQEHYLyzZFj7481G45zuuPgSQ/3JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y8Gjc1CH; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y8Gjc1CH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaSvE2ob071NJbZJpWtasdNxfmWs1wccOE9CjHBhTu3gf7XOVT2x0/7TLU/Xg/6ZCVki3AaH3ZhdnhD0bO7s9f9l2176qS28p/9bW1g2AagGD2sjDoYBKPun6GZBGv9+P9aGocFpUcKb3HfNRW4K0wiCUuEAWdSA4g1UVszYWE70DKUuj6VcoN7QNNYWDa/trKqCgmXxtWsQxbMhfkvbjt1xAekfsND0AcyZfyQhHmY/XJMJyugO8HjB3+sHEjKMx6zMYB3WH5whgI6wEFfpjmPrvkhYJgW9iely9d2XEqlC2V3NFRrKQINw6Qhvk8M4HG61ihk3PwChbccl6EjYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z40zWa9mc0GZ/ZF69Gfv57uF4hhRgtwdPKQ4aJ0AhGc=;
 b=bhAeupJFu+M9ntXjShsRT2zpCHMMh2OhXDdQsOvWQhnfMLs9GXPAsaJ2t6V4QeM2JsF43XFK8QZpO7mMAjEqXflluD5xFqsHhR2S8Czt125iNNuhORS/V/nxRYFKiQ35EIY5G2j4Knvo71p+MUeUXdKbCekFytoLifoH/C4VdLgVicFVmFGgMd/Y922Oim57m0x7P98Od4nLb5K9JOdsWcyHjLit8zYhVcFyaD9DQ7IzPlisyzlavqAbPz9DYEqAjvP+MzKqPG14ki2tU7WBAcAxYq53K+LDVUH4LARbP7oSfo68Jyc7o13i2l9NRxMsFR3gUh6Lyc5XgihrGUxC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z40zWa9mc0GZ/ZF69Gfv57uF4hhRgtwdPKQ4aJ0AhGc=;
 b=Y8Gjc1CHKQvpm2hopaLRv3PkPKz1S9qHIDvDnrT5oXpjZC1U4Df1ixfS4kbWdaWYOIXQXE4dpm9dXDD8hVdO5uPcani521o7Ebx/+1xrO71ljlC+kAOnQBlbBzMNXbIxHwwcK3lQcyJahbrxwjclWrqRoOe7R6aQ/yxEwNe1Pvk=
Received: from SJ0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:33a::20)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 07:24:11 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::18) by SJ0PR03CA0015.outlook.office365.com
 (2603:10b6:a03:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 07:24:09 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:23:39 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 02:23:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 3 Jun 2026 02:23:39 -0500
Received: from [10.24.72.113] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6537NaRm1258231;
	Wed, 3 Jun 2026 02:23:36 -0500
Message-ID: <191fcae6-1578-41b7-b425-f93abc3b8be7@ti.com>
Date: Wed, 3 Jun 2026 12:53:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>,
	<nm@ti.com>, <vigneshr@ti.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>
References: <20260528090510.829513-1-a-kaur@ti.com>
 <20260528090510.829513-2-a-kaur@ti.com>
 <e033f55a-2cf6-431c-8c20-f08c98382136@oss.qualcomm.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <e033f55a-2cf6-431c-8c20-f08c98382136@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e59b5b3-4c7f-41d9-e8ca-08dec1411a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DEft1cBLyRiKPPJhNgEnvBeyvrMHK8JXgdjmcDFu8w05E+s4YHkP4w0WlgcXZjKFumZiC9j4790rBPkJhBEs5Xz+1xpso6D7AT2Fjmw+LEAop7UhwYNAn7IxzKXvt1NTBr7bur79k5Aytqq2jUCLT+NtrmBqXGwk4366LFjJ4j9x2BV+zDCJ/xnFnNHIfQoTa+kMiksgyKTcJFMhUYQ9W3/pvqTX/qbVI//LFOU/df5uEIAw3irFqUUv+yvXGT/vgrlMJdPVV5zGnS9Df/Aq1vUOQuwesz+8yN6ayU201BPxeo8SfmTgHJOAQtDhOfWnGVvX4qMdXj6N3kWNjHXP+iSfHzKCmRzZiC65NohG3grK7Z3NDrE6/Tu6XqifcN/zBvey82tHVCKN+8JUzkGfBwMOC4c+F8bS0FTg4+eqppCcjSmHLGaTPTBMFsRyqOjmWKMq66UBTDcruBVETb+b+4HRVlDOl+qBKc53ftTvDcgzVxeKEmN8SQMs1Ew2nHYebv/EBsaNkyQV5PDNqiQ/XENp/8wa7Fsy9Q8XVoaI6fzrJe7HFHSR69wyj82laNzTe1vaHcf7vbojpBbPW+1oCRJN1QGy3rWVu5Qvpowj80rsMFLRPlzON1FWlLxQs1Q3herxseGzIadbaXN9KPQ/p/N4YoMsMBFiKXrfHckUVadFGJ7wFipdZbJDXW2KgM8EGBLTW2mKox9LY3aZ1wBEMxxb/zB29L8ajwbRYXHuvK8=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QfIwKp6Ho1f1tsKAPWwTV7f41uYZtO1t+1HB1WiVzgqM9Wo00qJ58Y5DtHqYSDt+3dzQXetwmvzMfInpVOuLsMBrKjB6l8I0piPKGYVrGpoFcBMwz5Mky3BJs/d/sguoLLbPhb/XLknGbghhJTRCgQ3ezxL4StrzNr0e8w0Ig+03JBrCMQCdcV4XFuH3LT+SmCmUQEbPZ2GNaPjTG0IAEx98Ny61xQzYSLhCfa4QU9Lq/MzXMHvSIWgMPpYMrNGLbJrnQFwmEHsbzIFdlkNWMW6wXLtE2T0wN3ptkdJZBQABMdd17VJrZqgPCca3AkdETYvsf6baJodIpI9zSvEMdbT7Bvm903lwYUUVe+Pen/eZnkWMzCXyE9boYyb3YlC0Z4mIs40FMmQxiPHvqzo2x3Q5ounvKVopnbhN5aMDfpBeqLjDPKNaOyYIeJH4NS1i
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:24:09.2335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e59b5b3-4c7f-41d9-e8ca-08dec1411a6c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544

Hi Zhongqiu,

Thanks for the feedback!

On 01/06/26 08:58, Zhongqiu Han wrote:
> On 5/28/2026 5:05 PM, Akashdeep Kaur wrote:
>> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
>> device before soc_device_match() can return valid revision
>> information. If ti-cpufreq probes before k3-socinfo,
>> soc_device_match() returns NULL, leading to incorrect CPU frequency
>> scaling behavior.
>> Defer probe when k3-socinfo hasn't registered the SoC device yet.
> 
> 
> Hi Akashdeep,
> 
> Thanks for the update.
> 
> 
>>
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> ---
>>   drivers/cpufreq/ti-cpufreq.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>> index a01abc1622eb..8219751da175 100644
>> --- a/drivers/cpufreq/ti-cpufreq.c
>> +++ b/drivers/cpufreq/ti-cpufreq.c
>> @@ -99,6 +99,7 @@ struct ti_cpufreq_soc_data {
>>       unsigned long efuse_shift;
>>       unsigned long rev_offset;
>>       bool multi_regulator;
>> +    bool needs_k3_socinfo;
>>   /* Backward compatibility hack: Might have missing syscon */
>>   #define TI_QUIRK_SYSCON_MAY_BE_MISSING    0x1
>>   /* Backward compatibility hack: new syscon size is 1 register wide */
>> @@ -347,6 +348,7 @@ static struct ti_cpufreq_soc_data am625_soc_data = {
>>       .efuse_mask = 0x07c0,
>>       .efuse_shift = 0x6,
>>       .multi_regulator = false,
>> +    .needs_k3_socinfo = true,
>>       .quirks = TI_QUIRK_SYSCON_IS_SINGLE_REG,
>>   };
>> @@ -356,6 +358,7 @@ static struct ti_cpufreq_soc_data am62a7_soc_data = {
>>       .efuse_mask = 0x07c0,
>>       .efuse_shift = 0x6,
>>       .multi_regulator = false,
>> +    .needs_k3_socinfo = true,
>>   };
>>   static struct ti_cpufreq_soc_data am62l3_soc_data = {
>> @@ -364,6 +367,7 @@ static struct ti_cpufreq_soc_data am62l3_soc_data = {
>>       .efuse_mask = 0x07c0,
>>       .efuse_shift = 0x6,
>>       .multi_regulator = false,
>> +    .needs_k3_socinfo = true,
>>   };
>>   static struct ti_cpufreq_soc_data am62p5_soc_data = {
>> @@ -372,6 +376,7 @@ static struct ti_cpufreq_soc_data am62p5_soc_data = {
>>       .efuse_mask = 0x07c0,
>>       .efuse_shift = 0x6,
>>       .multi_regulator = false,
>> +    .needs_k3_socinfo = true,
> 
> 
> It seems that `ti_cpufreq_soc_data` is a hardware description–only
> structure.
> 
> After further consideration, may I know would it be reasonable to
> consider using of_machine_get_match() instead, for example:
> 
> static const struct of_device_id ti_k3_cpufreq_of_match[] = {
>               { .compatible = "ti,am625"  },
>               { .compatible = "ti,am62xx" },
>                 ......
>               {}
>       };
> 
> if (soc_device_match(k3_cpufreq_soc)) {
>      *revision_value = 0x1;
>      goto done;
> } else if (of_machine_get_match(ti_k3_of_match)) {
>      return dev_err_probe(xxx);
> }
> 
> Just a thought — you might want to consider this if it makes sense.
> Sorry for not pointing this out earlier, I may have missed it befor

The structure already contains driver behavior flags alongside hardware 
descriptions:

   1. multi_regulator (bool) - Controls whether the driver uses multiple 
regulators (driver behavior, not HW description)
   2. quirks (u8) - Explicitly documented as "Backward compatibility 
hack" flags that control driver behavior:
     - TI_QUIRK_SYSCON_MAY_BE_MISSING
     - TI_QUIRK_SYSCON_IS_SINGLE_REG

   The needs_k3_socinfo flag follows this existing pattern - it's a 
driver behavior flag that controls probe deferral logic, similar to how 
multi_regulator controls regulator configuration and quirks control 
backward compatibility handling.
> 
>>   };
>>   /**
>> @@ -443,6 +448,12 @@ static int ti_cpufreq_get_rev(struct 
>> ti_cpufreq_data *opp_data,
>>           goto done;
>>       }
>>
>> +    /* Defer if k3-socinfo hasn't registered the SoC device yet */
>> +    if (opp_data->soc_data->needs_k3_socinfo) {
>> +        dev_dbg(opp_data->cpu_dev,
>> +            "SoC info not ready yet, deferring probe\n");
>> +        return -EPROBE_DEFER;
> 
> 
> It would be better to use dev_err_probe() here and return the original
> error, instead of using dev_dbg() with -EPROBE_DEFER.
> 
> Also, the message "SoC info not ready yet" seems a bit too generic and
> not very descriptive. Which SoC is this referring to?

Thats good suggestion, will update both in next version.

Thanks,
Akashdeep Kaur
> 
> 
>> +    }
>> +
>>       ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
>>                 &revision);
>>       if (opp_data->soc_data->quirks & TI_QUIRK_SYSCON_MAY_BE_MISSING 
>> && ret == -EIO) {
> 
> 

