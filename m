Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5C4DB571
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527031; cv=none; b=NBP4gtrbxQ6ofIOe3jYJY++2lIlpcjyDtZwRg9L1YhVmrc1ArmX5UP4zScbAbFNTd7SorUQq2ovA0XvaWVz/M79JbkGKkcgLONASeQ96EKtd+NPXNI0g9gHAdmndsCAHqVHiT6PuLUJuJ7WpthPvnT4o1AoHueNqIboWREQdqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527031; c=relaxed/simple;
	bh=a7KAIbcdTWgMluL6cWR+pQDx4ZaQkwMAIAuYfXQ6F94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKMPiPq+WUVt0qrvKH4B6pI84uidVzg6YaV9gSRFujieZbfkxoqZNMMMNOxRbcQ0rDRa2zNd4fESI9jASMNh3acNo+Mr89+0DV1fLXPlHWrT0C83YcQ2EQG6CC1klNYtAWIMw9VFS0mwpkat1DnEy07JhVQOCh8vGeAmPagI0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WLlgWh7z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PmTWIfHw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WLlgWh7z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PmTWIfHw"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653Leq8d3240997
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 22:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cNObVBNLEg+eZ9cz3ROctZYYJKCbvCSf2jNLJlucXDI=; b=WLlgWh7zOGaJ5nwR
	2cH/abLdEw2K/aSn4qg3xkAMqrvi9AEhdqNWZROF56pGuZarKWndS1SxI37Z7ZjW
	paOdd+HPFmXlpipFxR69nOsaDVbv/5rW2WXFsQyqaoP1L0ysrllYkLDB2EoT81j3
	IiwT93spaJtl9FAsA0vrOut4z19/3AdaUjKftqs7tdNsbLnIfCCp1DUYDmMqduZY
	KAgohzu7ljeHntxyZU2d2rC9s6apIcLzyq3/c5eHGZ93Bu2roxtcgXvfY1fcF/Yi
	86nbqE+4tK3I1pgnIw9v8E0fbICfKul8HnxSzIOsuWiRVZsbhZ9q1F3uXQV7J3fM
	hfppmw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd086bk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 22:50:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428384f31fso44621b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780527021; x=1781131821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNObVBNLEg+eZ9cz3ROctZYYJKCbvCSf2jNLJlucXDI=;
        b=PmTWIfHwj/ZkO5vkJ/N7oOHYIa9uHex8JO9cx55QIYh3oe2olyW4oJJPcnBnjzTaBk
         VHLE7rkRz6Cv87IYJkNhzKL4QZdHTo8gnuZSPOAwJactXkM/BR4vFPuC/xXhcwc3W/lk
         euud7TyyePxwaMRmOBLZ4Dtfbit+MH3Mg8tMi5JESCV8k+yszXUzEp00v8SCkmPBwZGJ
         A++AkZUSxImeaz3ItOfQSj/VmzzMz5K5eEgwEOlDsCf29riAzFxw9B3DhG8rRPtx6k9R
         5sRxWgiaN1WYGqVsN8GCHajcof4zJh71ii3pvYZRSb35xOnIiT1diQvFj2i8v9r9vNTv
         Vhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527021; x=1781131821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNObVBNLEg+eZ9cz3ROctZYYJKCbvCSf2jNLJlucXDI=;
        b=OhEjVZRxqODID3ixOyiQ4YSGg4Oq1h3gu2OpZq9gGiI3TyBilYxY1sHH/NEK7+ROjY
         bz4iplQbCdjjzKVS6XR1OS5E/tJOaZY2+nomWMHcKG4UZXanozsa/0YVgWS7OjBI5IHZ
         T1fbess3yZ15zpvMkSrjU+2THh2SDkuxOXfY9C/MNgM8kseYHJ36l/3uqg5tN1Ue/Jzs
         sNPkOEpQISc6NgMc7n7xerNUWvryYr2VNEgqBJl+iwtNWLoRGjozIqMCZozvRPhd6jnk
         SSlLYYKCwS5wELvJuxdM08O1XcSe2EXEmlXVBQRDfwyssySQwVhouNA0O1YH4C1ClecR
         CprQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m3z86ErzMb6xdGIvje6t6/8R2X93zHufjNzm5Vhyb1zTcdU2zw+goyvay7po1sirNS0iX5jf9JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+wP7VxO4bL5bHGTQzctgszgIR+JBTrdk/iuRuGuVCZPbc4xu
	gg4uNFyphFJ/wWlRYugX1X4SYG6y5GyITJbijeZaJ0MbAtn4mBruYfUs9a70P1zHRqO5/jM7cB2
	YuvxsO2wrDpqCHNVf7RVvbCTRUTV8QKP/i5hqffFyavirFXdF5/c18vepaDaQNg==
X-Gm-Gg: Acq92OHMub4WXVMJtj8W1/FtI4RFt4Z4CYBJMkW4rPdwxEC5qrg+G+mtXbw9uxMR/Za
	2jvfz02oWpElAyte4NwRqJUhI3CeEoK5jIFea6OLjPwx5A63grgSGcZIEPR1qFCH1pw5ZYo45Tm
	qIIiWCTs2/QDf1yOLaGhSLdb/5GGcqUDBVEkinFnXKZhVextOX71uv9+9M/JcvNb92yfGOpXK/F
	EYbK0kjVcBXJ8G3+UFNBKlqJQTzx/6r5ATFNnItssLcGpAqVT7TIwMEHU3Lw1UToOLLtV+OH/ei
	UyqsHJH/NvCBCA6QCcjhhrI5KIru8cSuIYn09Emz8gbABmbuTquCEw00LyDjDdpfTrCvOx6wnJF
	G0UUZLoDXJMFUhvtZ2TDlVo6wS/m9sIMIsWWs5suIEcRiKJQUicIktH0TdTJttceUyRz8KxZM4O
	kISxNYwlD0eMdPeQi45hKgaw==
X-Received: by 2002:a05:6a00:4b14:b0:842:2f3d:dff2 with SMTP id d2e1a72fcca58-84284fc0529mr5182365b3a.34.1780527021065;
        Wed, 03 Jun 2026 15:50:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b14:b0:842:2f3d:dff2 with SMTP id d2e1a72fcca58-84284fc0529mr5182342b3a.34.1780527020523;
        Wed, 03 Jun 2026 15:50:20 -0700 (PDT)
Received: from [10.133.33.141] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882170sm4518711b3a.30.2026.06.03.15.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 15:50:20 -0700 (PDT)
Message-ID: <e1c53e32-a777-46ea-8843-1f143706e762@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 06:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] interconnect: qcom: add MSM8x60 (MSM8660/APQ8060) NoC
 driver
To: Herman van Hazendonk <github.com@herrie.org>, djakov@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603163410.2312712-1-github.com@herrie.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260603163410.2312712-1-github.com@herrie.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: USIXHwqDz1FcpWYOObvkwNmDlbNyUIZ6
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a20afae cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=cTwmTnRGAAAA:8 a=4LjftOisGNAN7MZtn1oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=GUWCSGlMWfG-xDt5EnV5:22
X-Proofpoint-ORIG-GUID: USIXHwqDz1FcpWYOObvkwNmDlbNyUIZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyMiBTYWx0ZWRfX4ryGoUbDmp1E
 AcyFvVXbjRuUNWNbUaoAc0PEtLmPjokmTHB5vZshd6rB2MKbCDHO9r9U9PWHoYqxuO4A+zRSIA6
 +RSzb3MY+2mYKwlhMFYmlkbxhHYjIr4xOgCVPgiEZQx4AH1ROpwNCR03r0lQ6zsQ/o0rK/bMOpj
 BjEe2Upy3hXPCjjhLeAWiKb6JujnjCWrzXmU5hcDFsYshx2XFYrq78u1TY26Hlt2CxQ9mWAKjTA
 ZVcx/vlcqVJyXjJAitZYJ9iAw2vFaveVGF0r7grk+eSkwMclAFvZvvah24RySzuFK6bmn1AjQoJ
 6/C82blQv0MgptHDbr3JMXcXWNkKzcladTQPOBwrer0dMwgamtoDUTxHNExrNvUPjsLPinyDSIl
 biUE2jpOQFNYWCh810mtrIxbvc6DAAPa7T7D97Mp0nHa7al8GNmfD1gMaejxANAb2dZ3nlExnrE
 lDhg4eAcNNeyJC0/5NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030222



On 6/4/2026 12:34 AM, Herman van Hazendonk wrote:
> Add interconnect support for the MSM8x60 family (MSM8260, MSM8660,
> APQ8060) — Qualcomm's Scorpion dual-core SoC generation used in devices
> like the HP TouchPad, HTC EVO 3D and HTC Sensation.
> 

Missed dt-binding doc for the new added driver.

Thanks,
Jie

> The chip's Network-on-Chip fabric is divided into four sub-fabrics:
> 
>    AFAB  - Applications fabric: Scorpion CPU + L2 cache, paths to EBI
>    SFAB  - System fabric: DMA engines, SPS, USB HS, LPASS, MSS
>    MMFAB - Multimedia fabric: MDP, GPU, camera (VFE/JPEG), video codec
>    DFAB  - Daytona fabric: eMMC/SD (SDC), ADM DMA, USB voter
> 
> Bandwidth requests are committed to the RPM firmware via its shared-memory
> arbitration tables using the qcom-rpm driver backend; each fabric also has
> a bus clock whose rate is derived from the aggregated bandwidth.
> 
> The driver includes a 384 MHz bus clock floor, replacing the previous
> 266 MHz minimum that caused USB starvation on real hardware, and careful
> devm/device_link lifecycle to handle EPROBE_DEFER from both RPM and
> clock lookups without leaking clock prepare/enable references.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> 
> Herman van Hazendonk (2):
>    dt-bindings: interconnect: qcom: add msm8660 fabric IDs
>    interconnect: qcom: add MSM8x60 NoC driver
> 
>   drivers/interconnect/qcom/Kconfig             |   14 +
>   drivers/interconnect/qcom/Makefile            |    2 +
>   drivers/interconnect/qcom/msm8660.c           | 1147 +++++++++++++++++
>   .../dt-bindings/interconnect/qcom,msm8660.h   |  156 +++
>   4 files changed, 1319 insertions(+)
>   create mode 100644 drivers/interconnect/qcom/msm8660.c
>   create mode 100644 include/dt-bindings/interconnect/qcom,msm8660.h
> 
> 
> base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff

