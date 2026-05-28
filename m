Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAF3BD224;
	Thu, 28 May 2026 13:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974783; cv=fail; b=fVFz76IOcUJ5End+A0XZaO/aDBMs4/u4GH/2UNBhbouOF0s99pvHJY9YUW+4de3RvgeRy6u6mHPqQ2dO/qnLajXRKnQrCZaUB6tQ6XWak/KC8Hg7VMzviFdJmZIwao8IE4yYvPcAWVnWPyf8vdeMrGOD8RqcjmqmCbmrJLl+Qq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974783; c=relaxed/simple;
	bh=TmVV0BpcV+hZ8aa70pxJSdveYuoaVd50IIswolU+lmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SqnXpI7OtYLPx1SLoVxSDa96EOxw982YsV5v4O1bbfMSEykTQJkZM2KQAevIZWSSix5BowUfQNMT9n48vFF3GKkI1QHobMBTGqHngvvm/BXiKT9vk5jwfxfHl8FLbQyrfJS4JwXOB7/QjGayq1zSM8i7Y0Gm+p83+XRuUom5Iu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f/p1jaMQ; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f/p1jaMQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6mVWNFt9vhUDgxIJpmy5PkLk/3Zz5420qfTsOq0rSZAagqiKnO3H7bm8RON39jqVmT8VHqYIa1xnUYBlWKdThUe4VFtCESZA29sAGJK2d2027hlyUMaqMbkbSorLCRw5h0dLJV4MtMnJlkQVmMs4V+Ghy6YO+xsBQQpB+MKrOxji4UJ0GC/pjrvwW9Hn+hpSKhtjgW3pEgLd+vNWXLA2L7mK9n483HbouDQywl8QuoK+vFIfqVF7ba6QK7R4px7DIBwdWftjDvwagjpxHrTYm8nAZz3qO9y+eU+Dr5uHKBL0curf3mW6Uo/ieC85B0eBOLOVyL84aDlwSCuyiZWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T+x5BOQrNg/82LR6KMWwcasb3F2lvj8JFT4WpahZZY=;
 b=cP9jV79kVcBGeCIygYbDfOTWBumF0N0a/fBZnP51QeY4v5XtCJEDeUDifAFlaZtUniYUPDktUBV73siOj3QsrxLfGyfpHrzLGm8+YIP2mKVrlOvyu+ZundEx/qN2h8AehPxAPLPLmCIY/BlZ7zyLHB4COCOji02iiKULewnsJAYeWVZiUZZfFaP7BBse1AMWFNkY9RfxuzkdET1+ySwGDgAvvtdHHNZijLpGKI5tMmJnYirPxtZhQXdhElShzblr0vRcEHyM6ozwqgN3LdKP4GK+9S+xbUz1Liu8W4K1vGQREYOdPzRtJHOqs7+z1Vmd1Tz3SuX3+PfBzY5QW1Xyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T+x5BOQrNg/82LR6KMWwcasb3F2lvj8JFT4WpahZZY=;
 b=f/p1jaMQU6bw2wEvykRgr+9meHN2HCYqJosV9gX5f5G4GdA1ASnx6S7127/0XFgEmdJxEpr+s1UKAdShP7trfMvYbw5oZPmM+rq6zIycJOjGLdMScjpVFBYXgZAiWVuIk5nISIfO00EvSe2BOXSxKwOl147ZrEVqLiDKXi1Pd7c=
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 13:26:14 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3c) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 13:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 13:26:13 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 08:26:11 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 28 May
 2026 08:26:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 28 May 2026 08:26:10 -0500
Received: from [10.24.72.113] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64SDQ7vV2129448;
	Thu, 28 May 2026 08:26:08 -0500
Message-ID: <9e5b46b8-cf04-4b9b-9e33-2cf27802690d@ti.com>
Date: Thu, 28 May 2026 18:56:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, <praneeth@ti.com>,
	<nm@ti.com>, <vigneshr@ti.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>
References: <20260527062534.1808422-1-a-kaur@ti.com>
 <20260527062534.1808422-2-a-kaur@ti.com>
 <c1214419-1f29-490e-a553-8662b08de2c1@oss.qualcomm.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <c1214419-1f29-490e-a553-8662b08de2c1@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SA1PR10MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d17669c-a20d-44b5-2d06-08debcbcb0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	x2HHxDYCNut/lDV3Q4aZ43YRpjuFQblktVKE8SuDO8lAGcAhJ3DU21EP0xcMcAuy8qSdL/hrf4BltWuAFNPfyCu2Ik7OlUPBDG8u620GbU6rvyWA8nKDNqZayU7/uI4UpCP67x1AK1ZsQqN61gfQ42FTU4F6HYddrCSovZ6bUOL0qc9V7rPkvLvH0a9W2i8SMp+MOTE2BEF2gmm4H460Pg0pltKKKmfu2EpsbmRpORSLD2oZZBtGnRHMbdcouHUBxg1H+6WrvIW0UCBfURhvHbC7xWQ6Acl70s9ubwJIm8SY1DZWSXyScrIrrSRYjUftORLRUzQSrZssjQH1gu1jf+nutvd31BP8m/VIfOzHIvYfCt0Uv1myW5mbRrN8BKSlmO4ak0BwtaODV1XIjXTeSTlysBkUmaBiKdphfgHgkNxw3zeecXzVBYe3Jk+U73v3eH1Xv37Vg3xuZMpaBzomw6qVZDFCBIZC4IMfcFLG/WcyAtq6km2MfTYSlhRm8oQvt0zlUt1IhXBUqANZkRBsF06VSF4swp0Gpc9lbxHSXWF3cIeNVk80+rZ1HsPoaOkveI0rWMOaUFV08sNcbHcditLDbgxGIc3oj1cpJ/spzce4mELlw1qvxwGgyBsZduJth44mjB46LoC4o2d59lHbbp67qt9dTyxnYXrGh53Hw+sxb92Fi3fnZGsNlozCcMDJEQ/L/3E7FzzFPDesp7emG1zDm9+51xbgHF1m42MsOuc=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y7C/Lfs+bW7sY73MEf9je7Jfl3ggFiv0wONXX1RZ//gRw66uT8lfxsGnJ7EE5wwU3orRvk+Cth3Y4PU0DM3/mkSYnDsrP71d5OwReL3/BWGF8LQ6Jta/QbhKFWEfu7pPIEmov1PiD4G07W7c25m1HYjwUM8/aN7fp63/hMQndhzGxsMfEXtGreAUdcB6V9gWM8qi7vHLEP+hh4oomboWeAUcirgBNyGXVpWejv21YSZmptUUp4+IciznQBAcrvw/W8xpLvx27im1VltvE8Id027ZHM1rC2i2nf3wUUIs4gyFSSzjfPZWxuTRnji2v+wyfouDxSnTWgNEG0BxusLrWRM7vsF5sHlqWMzsPp72/y/DPpW9HoBc08jXpOElmfz/F5CbxlTTpzm/LpMGnpE0AhWtiSqofCdlhZYNptJBJkOSXTuuUcYb1nTHysBIv9tv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:26:13.6280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17669c-a20d-44b5-2d06-08debcbcb0b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7634

Hi Han,

On 27/05/26 13:29, Zhongqiu Han wrote:
> On 5/27/2026 2:25 PM, Akashdeep Kaur wrote:
>> On K3 SoCs, ti-cpufreq relies on k3-socinfo to register the SoC
>> device before soc_device_match() can return valid revision
>> information. If ti-cpufreq probes before k3-socinfo,
>> soc_device_match() returns NULL, leading to incorrect CPU frequency
...
>>       u32 revision;
>>       int ret;
>> @@ -441,6 +442,15 @@ static int ti_cpufreq_get_rev(struct 
>> ti_cpufreq_data *opp_data,
>>            */
>>           *revision_value = 0x1;
>>           goto done;
>> +    } else {
>> +        /* Check if we're on a K3 SoC that needs k3-socinfo */
>> +        match = dev_get_platdata(dev);
> 
> 
> Hi Akashdeep,
> 
> Just to double-check: here 'dev' is 'opp_data->cpu_dev'
> (get_cpu_device(0)), not 'pdev->dev', right?
> 
> In that case, would the 'struct of_device_id' match data actually be
> associated with the ti-cpufreq platform device rather than the CPU
> device?
> 
> Do you think it would be reasonable to add a boolean
> `needs_k3_socinfo` flag to `struct ti_cpufreq_soc_data` (similar to the
> existing multi_regulator pattern), and check
> `opp_data->soc_data->needs_k3_socinfo` instead?

Good catch!! I think the approach to use needs_k3_socinfo is good, i 
have respinned the series with this approach, please take a look.
> 
> 
> 
>> +        if (match && !strncmp(match->compatible, "ti,am62", 7)) {
>> +            /* SoC info not ready yet, defer */
>> +            dev_dbg(opp_data->cpu_dev,
>> +                "Failed to get SoC info, deferring probe\n");
>> +            return -EPROBE_DEFER;
>> +        }
>>       }
>>       ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
> 
> 

Thanks and Regards,
Akashdeep Kaur
