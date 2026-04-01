Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750F402449;
	Wed,  1 Apr 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041159; cv=fail; b=LJeufeMSAxKVG6r6lerr1l8HBSjHWx9dq+BgKe35YJpW0S3OGoJTpzqxylCUIE7MvMpBOJmwZ1eeG8SbDwicb7V8mfVMuJNC8L9egwcXgRxHBKy8e5phPvk3qeLp+vsXf9bb2QzDJxxXY2X/e4PZc/eD642oygM+UyVcUWGuA3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041159; c=relaxed/simple;
	bh=hkB8i6/fhyqd/TNQ7lAb6XJS6gxWplWG6DNkun4mRAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J5PCCTWfI16vmgQ5eQLfW/8GINhpOKKV0z2oWMtoNN6Z4+a5DzWM6aIAJGZtuODQyRCECKkdssTYZBM2j43Y5dEOlXq/EG8dV6/RLzxgM1SlWw6oyPq03JweJ8YT+C9r/zE/x32EkOK3srcbWvhVWA1+o99O3G1yopfX15OMOpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O/zwHBXf; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O/zwHBXf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtbZu5riXutThZ/ko+61fq5A4/M5/jkpvgaSER3osg5edZdR90L9XAUCfN8j01jXIvdIQNZqzhsUdYsmGcOzCfQ4wF7s0Gmg9jD+sdRR3YsmnJtPSqDixSaDuYLxi72W/BLt2HWcMTY2aHgvXJ7wegmLlKLYZEPIYxBwymvulRKWElfHFFR+zTe7g71/y2q9twg8rlQMuYOv0c/BDlRvlxInxNVfCEKVeemaoeqWljRp6vCI5lnMDKLSc0NRxllzNUQmrXVCjzTOwvu0LTc5F+phmDU1mnrJt/hoembCxhc8CsEwRreOY3flojvfj5QoVlIx/SfgpJq/9Tuyp5PHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsfG1dMeG0hhAXuMQ/NSl1g0hyNKoLGtnSe3H3JbBAs=;
 b=CIWRyIBXMt8+leRL0K0+I/0NU/uZhkRDOJzP0shwYxBSpSHeoIF+JMyWhsC9T5H73xAOmT75fonhdsdL1JcQy6+KkPyuxBc3LBegeigvIDU7v7DJZlK/6Yx94UDVxzZeJFA3QLFGCTUNVFrrZZ5p006uGbEIZCDAfRZrjKPI4RFC/ZJ/e1xnTJxQY75dpNJEwWHHD7EMOGURrS9IqBaS5rHwWXkfdW229bipfVeN1IzI1/LPWsSmNMSSfjmhd0HlZ7SLqRU0mQanieQJiDEhqk2ONoNmw//WM3mom0y0WV9gmf5HJ+1ugPqI9k2svsqlkLFqk7/+cymatSYdx5fpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsfG1dMeG0hhAXuMQ/NSl1g0hyNKoLGtnSe3H3JbBAs=;
 b=O/zwHBXf8/FDHLvHf/cswvELBfnDPlODzIsRZk1wyZI78ZXlBwqTqJdjjqV0ubGxGujTO5HBqQYYbYoePHcKzdKwkQ/0zDjZeY20jQhH97azZyynk2C2jacxTE/+Rr49ObSlTlZWVIpg2k8v6crwXKcNgWXDBuxUpq8HzhsdIu0=
Received: from BYAPR11CA0094.namprd11.prod.outlook.com (2603:10b6:a03:f4::35)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 1 Apr
 2026 10:59:11 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e9) by BYAPR11CA0094.outlook.office365.com
 (2603:10b6:a03:f4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 10:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 1 Apr 2026 10:59:08 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:59:07 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:59:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:59:07 -0500
Received: from [10.24.68.91] (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631Ax2u34137901;
	Wed, 1 Apr 2026 05:59:02 -0500
Message-ID: <f8937c11-1416-42cc-b5ce-0fd97e8aa53e@ti.com>
Date: Wed, 1 Apr 2026 16:29:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cpufreq: ti: Add device link to k3-socinfo
To: Krzysztof Kozlowski <krzk@kernel.org>, <praneeth@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <d-gole@ti.com>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>, <k-willis@ti.com>
References: <20260330120105.2985200-1-a-kaur@ti.com>
 <20260330120105.2985200-6-a-kaur@ti.com>
 <da225ab1-d659-455d-b3c9-e7ff4864119e@kernel.org>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <da225ab1-d659-455d-b3c9-e7ff4864119e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CYYPR10MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 0904af6d-0138-4a41-4338-08de8fddb331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+VlxdLbBI60DtOFJwYUQ7n1f47Syg0rUJHNm0Ft1xxXOt5mwr7Av6qx8vsCab2/DmRsoHHgJj66V12kKNYeKCqeU3qH1JP/yEn5Nxxtni+Q0Q3KBKYJhliVr8Vej2eVtzLRv2SERD02fF0xX9M5Rt4qVUYT9Zuec4rlFWFOV0N/8uRdbLF/zvwjuq2JT+v4/+7AloTcSMsLNbhaUM4/wS85ZyS/+2VfEInuNBUheOnXMSrN2YbG2wKscKr790xznzf2H6scb79NU3Aql4JSqJMk+REkwhBZ/b1Oq8B3LW2QGwmS2Kf4oANzHkzITsjuXqq9/H7pmoTdYtRq49ez5QbE9rcY+t5zHqb9BqX0WZM19LGyQbj0J9n2zdY1VDV/xUyhNnWRBgkVWgGDdKh9cKN2WPzkPMq7oMcPGCTx6LLRMe74kbCnCRs14+3eUFE5t6REUnp2GLpoZcoeW4p2Zs/zqR9hGIvrL4gzlA2BWg7BrbFOUbNbUigct9rEUKv6oQCNT9Jblg0GLb8dVhsP8NS2vwRCkOQx9H0Pk7jTnzmj7dNMmaY0Rlhs/fZaBr9yUisdogCh0kyFzMlg52BCn2ZzIys64VeBra50jYXZWT0mMG48hW3kKy1kxWrzFQtn0KfOApK1XiCKfHnv2DYWUuAT9s+pCkSeTAXFNuSU40uGvA7QCgWYu7QNolr3x7c2B9v4BDVe3lqqfEKC4EizsJb+e/2kCSiYaJe+YEXdcHCuJGQFVlCKHm3+wI2UQjwf9pIlHDpMJFs/KZ1LNROZruOEJsTKzKSN9eSk3JXcuSEnKSctb68ZvEOcsCcE5Rryl
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(1800799024)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QyYJHFZzmoiFvfEwMdlX+hdI/Av1fSillChzaFruWlYfUjFQHJALwqxWU1Tgh3Ze+cqMXiHg25jDoef9gjE5/v1k1w7frWlCDAvjuOfekZ6PCyFXCd016WiQ/O/mdPU8booGhueJ+xT1PTuKva0pqHs8i68Xv+ty7eYVsrvicZw6TJnm6DuvXJR1z1aVqs+8VpdBVC6aJAG0jwCVGrBywYefLUdSW57fFE4lIV49JgUSSdzHHMBaGju7+gFAVXpxMlxQgJUo6Qmvkm3b+OqphFbxuYLn0ronxG6bf7Tlk+C/UmiE8FguTmSQOJUcp7GQqKd/9L6+ZQJ/UWrboQYzbnn7azXpzPzqd199tOb9jhFNh4FCAWYidiKT3sFAiuA/0ekIUGW68kESw84+9/ikT49gURM9tJgsTfoAyUZrxlozrOAFYzrFyGHwNorJSDMF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:59:08.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0904af6d-0138-4a41-4338-08de8fddb331
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606

Hi Krzysztof,

On 30/03/26 18:52, Krzysztof Kozlowski wrote:
> On 30/03/2026 14:01, Akashdeep Kaur wrote:
>>   	opp_data->cpu_dev = get_cpu_device(0);
>>   	if (!opp_data->cpu_dev) {
>> @@ -560,6 +563,42 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto fail_put_node;
>>   
>> +	/* Create device link to k3-socinfo if specified in DT */
>> +	if (opp_data->soc_data == &am625_soc_data ||
>> +	    opp_data->soc_data == &am62a7_soc_data ||
>> +	    opp_data->soc_data == &am62l3_soc_data ||
>> +	    opp_data->soc_data == &am62p5_soc_data) {
>> +		struct device_node *socinfo_np;
>> +
>> +		socinfo_np = of_parse_phandle(opp_data->opp_node, "ti,soc-info", 0);
> 
> Undocumented ABI.

Added missing patch in next version, thanks for pointing this out.

Regards,
Akashdeep Kaur

> 
> Best regards,
> Krzysztof

