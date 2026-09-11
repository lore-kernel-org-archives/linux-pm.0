Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4DF488D8D;
	Fri, 11 Sep 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133857; cv=fail; b=s31I6W+jIQ56+Cq3Nf/2O0hzQy0yHgiUDErs5MOCDVAX2G2iL1PGKVLd4p0xaeT0bwjyisWx3QX222OuKOswEVwLgu/hqCgUb3N7t3DNfeQR1/NrOg2DIE0WcgN1erB0b7slJjiQXcVwP7Vj1kv1deI5REZfZWlzOqV7Llgei0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133857; c=relaxed/simple;
	bh=N1v7ZTzBS5y1iKpV7r0P4RYul/V9n1ONTE6hHl/2wn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VuoS9pxeWOSh9ASkwqRBDa9CY2PN++LKtfyec53R9AGiMrC+6p5DcRWu/FZZV4JV7F1vKiXxGEA8TThTkp8kveYa2RbepYuxuuSVUvmHmDtg12UfXQl6MWCjP6ui+I92kfS40Di5en5g7Uwe3leMWUNE22xzd4wlqNdZX/rbe7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VWi7CepU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A1Y3y4rP; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VWi7CepU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A1Y3y4rP"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68BCihxj3861772;
	Fri, 11 Sep 2026 08:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=EvosqubK7295LIfMXZEw5cQr9NFx+FmkfcK/HokhX
	cA=; b=VWi7CepULlL9Wz/aQchz/iAcMBo4bFr+9Swa9+8LKdiaeYmhpzpq0qdbu
	AsyI6SZFAdvT/SnITx7LkLwH/yTlLUpRqYF5iX35HiV1OFa8lUQDhKh9ctRq/qSa
	aPmVb6jkoUB4lRo65tEuvV8w0g8ZcrJartwG4Ocw1rFJIHRRIMVSdVlK1seyKGYs
	bAP+D9ZPG4icXZ+08RpYPPdBRtKLFtmVjzBQG0rMavvxaWiIwxk0st7zFnkK/1Hl
	oHtDbmVnZqfVKHU3oUoUelA/hHOW7oHqOIjEvCJ0Sjw6toT8GRBuiPN5YLeNbM4b
	5cSfPimLEv+lm6L5v686/FKI0isUA==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013021.outbound.protection.outlook.com [40.93.201.21])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gm3yyvrj9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 08:37:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeBfoT2Pwd6YejFfN4H5ImV/DLOtCB+qnXcxjPmX47f+0c6NZ5cWi2Cyd4ikx9/QySVZe8LGt9gZoMSR2qQKAeEgsLxnfEIlINfHiXdzoPg3dQSxw6pIwUdykOHdovcn5y2XQUjYnpvTjY1ywznHegK0d+zmw1XtaXKjpz74J8c1pXpNJNqrn1ucrQ1YrhBI1J5Bf1vfNLF+btGeZhAUlYfcvQvSBddY/tjL//EptYiBHyohEVP40tCRmvzNJkBumO20RGLt1Aev+RDHuw1Hz6dwEcztmkHcsM/7i80Tosdc0h0HaLKvAMGxCjTZZUHl9Gom0TTTFviaM0GaAg32Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvosqubK7295LIfMXZEw5cQr9NFx+FmkfcK/HokhXcA=;
 b=q4jk8vQ+TS6GwXMQRnYhfZ1Hj7BbUeWukauH0M+tpzslT8GFQd2dDYbE7+26TwGS78F7HLbli2rKZvl1AeFB6rBFbWpbQVJXqnJiMgkCuc6Uf/m/HqZ/pZEzV1yzn+nry6KJB8R7JrbQ2SJtiS5ZyYpJRwQvtJLNjrOL9bc8N5kRFMAZyt034QqGbddgDm23QcP2HTKDJZK19LZ+3+B3nmyoYtEkLLmjK1e2+00pUkMIg0qBBj4bX0OqOVHX3y+6u0JduKAwltPTbsbf6mI4ETe4YM+WltIfnyzpcZXcz3WCcZ8RRYf32o9zsCYcKTq9v6XbIvuM7FqDwBSPVOhVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvosqubK7295LIfMXZEw5cQr9NFx+FmkfcK/HokhXcA=;
 b=A1Y3y4rP9S+v/gt9EJE6hAiADnGk9M4s6dRIdSJ8iII6ZRPdjPH5tnyhQhBG8/AAQhQBqqojbUCjkUxBGv7QcLkEyPhzuZirODjvZ7RGry0qQcTmn0wORrxm/c4dNksB4iTYE2wtxAcoFglxtlM+fW0DGN3deZ+n1BTRTFuSRFQ=
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by BY5PR10MB4178.namprd10.prod.outlook.com (2603:10b6:a03:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Fri, 11 Sep
 2026 13:37:23 +0000
Received: from SJ1PEPF000037B9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d8) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 13:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000037B9.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 13:37:23 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 08:37:03 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 08:37:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 11 Sep 2026 08:37:03 -0500
Received: from [10.249.32.11] ([10.249.32.11])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68BDb25K204763;
	Fri, 11 Sep 2026 08:37:02 -0500
Message-ID: <6c45cfd5-ac37-4f8e-bde3-0391512df982@ti.com>
Date: Fri, 11 Sep 2026 08:37:02 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845-oneplus: use generic fuel
 gauge compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Rinat Muhamedgaliev
	<rinat.muhamedgaliev@gmail.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "David
 Heidelberg" <david@ixit.cz>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-4-rinat.muhamedgaliev@gmail.com>
 <20260911-relaxed-dexterous-hummingbird-72dfbe@quoll>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260911-relaxed-dexterous-hummingbird-72dfbe@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B9:EE_|BY5PR10MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec198e4-545c-4ab2-3a55-08df1009cfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|7416014|4143699003|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hX3FC7h6I2TmYGm0VEiKw3St/P5ZyWjMqDgvJmVurqyyScqL3TZX7oMFTYT+wbCD3Y/KNPb8OFXiUDQWwpHOCHzDGcH4wD5oMsYsO7AwN7RfT2Bq62mKZLG4lSZ1qNSvwe1Il/aeNfE/iF95OBwI/ViV4tl4EgAwQDulI2VDjmU+s4ILeEttrSdBB9VpbIcrec7nd0PnY6W5ouq/HnXHTA9Bp2PXidqVfxpw74ZMc7p7BpYYISkNW2CuThvVtOkah3ZCFmAaiU49Tbnrk9GJQqfKc0FojZcFC+D7867JQPjm4z15s26afEp2Sih23qLnQ2wqX+w3DiPuIgksI7Pe6ZOdkhItkPCnDBPv0iRsHEUV2WjuKaaDpVk7S22B1ln/iAEd6Sxb7Q5LFdnbmW/eqB23G9hhgqFJVhW4Wd035ExxYHfaFKE1uM5u+8rJiamQp4xYXA8Xz/kJSkTt+PCwwpcpJsA5eetbThQRvWWYEsJjzVbQXaRB8TjVG/ExhxQSjb2xcdc3yMXZy20OCN8gfdeQiAARzQb5F7saE331XBD4C4JqzzG0CT6J+m1w8tb4UGbm745c8M0HUPYcUUVWtgqYEKCkBIxoggQ1ehRixgOz1P8Zddsx1jKo70TBo5VmleylRDdTNSnrqmrVP5m6qdeGIBKWfnpeOMCXlDTZpkcD2WBkI+J1P99FMjZfBpD2QOuVYEZba4HnlR5XXN0W8w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(4143699003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1+X6rVUofWOIUdYQGi6lJW0SIxZY6ejV90wWHpIRan3NeOdF+9eCnpmOiOaFM0UpekTHU864IN4F+BrUHbGI7V3tn7BbVvbV+eZATPY2yB5oBpXtoo9uWG+Ez2OWxUk0IzEM2sc9foPYDHI8Rau8sYGFF83eKIVniBGA9o/de9FgN25PSHN18hb+/A3WJxb6MZVDeZSsYIXWouG6rMH+JC+coeLylXsVwHUyKqMk8W17L1uZsdYjBGd/EFtTw0JOTualvrlgLkdYX7koVopi0kxh8UdPu2YPo3KWm4F5wE17F9j2e3kyC807+lqG6fx/8PElSKc5Ph9pY2sHAYQIjlJ8VYe+rZ7AZOChYWyYgHGXw1GEcTHCuqwBnY22/kVJ737hp3w+4aKURstFhlmlD13kkEvFY5auodkYekANOdyUOdalUUKoJVXu0Nf4cDgf
X-Exchange-RoutingPolicyChecked:
	wfsnqRKedUOe7KtCO0JF5hcMxqceNNc5QR0X9lLHLHwkdmidTDQtFkyCma5ddxnuANteePpHoliQaj7gQOguY2A5TN4j160+3s5vonbOABQe6TMmXqJ4nMEy7SZ5UslYJwikg7S9jVEo0I+t4VnTMR402jMYJxT69Yp4YT3SF5c761bKC12ctoX0lxnCXxXo7oqJZURP/LiOfTAGu20nJwn+IwAq+tPMin2Oqb0+eV6AQSS4DzGYguElG1FV8pqJqt94nTvRHd6auaPNxWC/11GBeNcIfa7dTCgVjAJ+UBQrdH8b1RXFjkPUPgoX6LjjDjOOyHxATBpJjIkLHRHrzw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:37:23.6662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec198e4-545c-4ab2-3a55-08df1009cfdd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4178
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE5MCBTYWx0ZWRfX7SQmoK/aVsRZ
 1oyi30/EhLwHj0VW7VsDI5wW6qpbKPfKvEb7Zlcy4lCMJ6VLsg/rHIqtBfdIJiZ27NS1MRmzEoJ
 ZaObwR/9QXlmLw7N1vzQ4t/8fyQ5CEY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE5MCBTYWx0ZWRfX5M6QGi6LK08X
 VGx9g5cxdLVevfyyDB/F9IEMPEVQBQcZOGirONaP1FC2j20aq6sacfatXx1qvoYT6uumxyBLskg
 rO7tJHtObl8zve0BvkuipXDGFyKILchc/mSC4dm3DO1g/xXth1Nmx02gd2LNWEOGlliY6+RO0gs
 Kq4xzluKD6NFRIXGI9k1GOFP/XutsaWvf0rfuPhvkPxZXfAg9sedgSJsYafxLx9j7B/sdCCph8U
 QRuUnNqTYi9VvrYxqzYvqqHmmbbAQ9D+cJ9BWDWyGKie2CHqPm4pL2slyVid5lu092NFKX9puQi
 +JzIGDCCWnSqiGX52bTgIrzWx8wpYOFuVp8BVCLSENWW4gQK2dFbBBUeTUtyyI6byPdu6UFlpIi
 s6v9GpOPkQgR0q/O4DcnZXhFqtTK91/zDmCENgL0kadwPmhUU9l3XRATGQq4vHBRpALPFYBnhFr
 1+2EswjsWsB99o8PoSg==
X-Authority-Analysis: v=2.4 cv=Y8FtIReN c=1 sm=1 tr=0 ts=6aa40417 cx=c_pps
 a=j8DUK8/cuCuEDQ3LLq2Aww==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=pGLkceISAAAA:8
 a=TG_rDHHoWYbZdx3MxvYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IsXwHxM-12uuxBygZNJayK43b9tfGku7
X-Proofpoint-ORIG-GUID: IsXwHxM-12uuxBygZNJayK43b9tfGku7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110190

On 9/11/26 3:21 AM, Krzysztof Kozlowski wrote:
> On Thu, Sep 10, 2026 at 02:47:44AM +0300, Rinat Muhamedgaliev wrote:
>> OnePlus 6 and OnePlus 6T battery packs may contain either a TI
>> bq27411 or bq27541 fuel gauge. Use the generic ti,bq27xxx compatible
>> so the driver can select the register map from DeviceType at probe
>> time.
>>
>> Tested on OnePlus 6T (fajita) with a bq27541 (DeviceType 0x0541):
>> after booting the new kernel, the battery reported 4.360 V, 100% state
>> of charge, 27.8 C, and Full status.
>>
>> Fixes: 12dfb002ca01 ("arm64: dts: qcom: sdm845-oneplus-*: add fuel gauge")
> 
> What is the bug here? Your commit msg should be specific about it.
> 

Commit msg seems pretty clear about the bug (to me at least), the DT
says the fuel gauge is a BQ27411 but that isn't the case, some shipped
with a BQ27541 fuel gauge.

(I do agree though this shouldn't have a fixes tag as back-porting this
without also back-porting the driver-side change would break users)

Since these fuel gauges often live on the battery pack and not the
device itself, folks changing their batteries might end up with
different fuel gauges, so having some detection method is going to
be helpful.

Rinat,

I'm not familiar with the bootflow on these devices, but is this something
you could detect in the bootloader and fixup the DT before it is passed
to kernel? That way the kernel gets a DT with the correct and specific
compatible to start with?

Andrew

>>
>> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 4 ++--
>>   arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 2 +-
>>   arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 2 +-
>>   3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> index 948a0dd..8c5cd94 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>> @@ -790,8 +790,8 @@ &i2c10 {
>>   	status = "okay";
>>   	clock-frequency = <100000>;
>>   
>> -	bq27441_fg: bq27441-battery@55 {
>> -		compatible = "ti,bq27411";
>> +	bq27xxx_fg: fuel-gauge@55 {
>> +		compatible = "ti,bq27xxx";
> 
> And this is just breaking all users without any explanation.
> 
> 
> 
>>   		status = "okay";
>>   		reg = <0x55>;
>>   	};
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> index 5f01115..cf40842 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
>> @@ -44,7 +44,7 @@ main_cam_ois: main-cam-ois-regulator {
>>   	};
>>   };
>>   
>> -&bq27441_fg {
>> +&bq27xxx_fg {
> 
> No, irrelevant to the supposed bug here.
> 
> Best regards,
> Krzysztof
> 

