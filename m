Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB34071F3
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818221; cv=none; b=WkQt53dUP/ntvDuCSf198dp/OG43FPr3MFxndfxTDPR3DIZu37XvTUKOlm3qSoQ/vQ0PDHRoaeJPRVRB3y7qu9R2cYuvlh69cXreSSKbzj3qg+sNzDC0HkNPJSDc5OkXtB4GJucSduF3SzESIp0FaAJCmvQ4APCOd7XEiL6oBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818221; c=relaxed/simple;
	bh=OwoxQFMmClVp/FKnrr986wU7zxRGgnUkDUDrvAla+tA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pNSslz3fxSLv3hWHFcDITMFv+jFlGVbSNgHQSd6fDoDAkcZdIXe4Eq5ukYY7ZI5ZX6CGm1Yx75uNZwIVpHJAPPZzpP5Kui0WIe/3BdHNuImkhPnM+2LflaBFq/tnGnmGBR2JgjWIYdW6WUy3ACevqUf8rnc3/hdACcWT4FkIFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GnritBkM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZzorpN8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GnritBkM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZzorpN8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9moBH1542046
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 11:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YdXz9hXxswV0OTamUlM5tpOj2E+z/eG6vCXO9g5umPA=; b=GnritBkMMjF25Sog
	oGHudo5jn6aCGkjjEQhuhcvdJ9EYUFShicyiT+7vBTyKY1ITR1PGCK2avYzJPiys
	TzAR0pOTUG1uTpD4fdC0cFGCymuivBn1uEJZAzjUee9fD/F48eQCczSiEWXzP6ZH
	kNKscBEJeOKV0L1HI2AaCXERflaRRotlVEx3KJ1XgnglzY4E9ye3FZv6ze0uDAds
	twPeRMJYiESW5h54l51PEcwephVCqMEblCLOZyvxQtA3c8A+XGXOScyi/rjvjh9O
	rS8sBqtRaaBC2U8IbiWICLp3koRG9wObz9IvOA9QGeNJULpufqImlSwKptAYc01N
	AbHyfA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f44v4j4n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 11:16:57 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-13980b6561dso13407819c88.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2026 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782818217; x=1783423017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YdXz9hXxswV0OTamUlM5tpOj2E+z/eG6vCXO9g5umPA=;
        b=RZzorpN8cemwFBJymzSbr1UiaJC/D/awM81DFPVakXFGHd8beoiZAkUt1P4IaYbSM/
         o/3pqFyf/iIrIQfvKM+YSzBVIlrBR6TTi+1SnzQDZMcFEOATe9sTx6zczO0QggF0QGRS
         oU6D3eHCZR/7d/BjePSxnqZ4YlAecXxDZlDYITq1YdX6T8N04JUEuIlRvmI2UMqO9N2d
         yk92Pz4thfhqYQkf9FDwMuz7qDH+nCNVsgNs4QaTQqJOA3V8fW7jTL4khFX6Fd18YyKX
         3m+D0Hzg06QO9AfY5E1J3Zpf7KFrT9rTDnzVrcvqqa1lZnvo/RhyQ5VSYrDqK/DyNRMz
         ueRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818217; x=1783423017;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdXz9hXxswV0OTamUlM5tpOj2E+z/eG6vCXO9g5umPA=;
        b=lRMJl3BPfZWvd5HRFxlAi+GRWca+6BpIMN7oAbgJel65EiY9uD+UjIj7sb8serOlFj
         MUJ/YKUtteXf3EZNiZqkBinb1MZv8Kd1JOYJpv/eFD43SF5KRXTxiiBEof+/BcViPxpe
         krVfTb/G4VNBgjqulhvZun7VJJKlQXvcS/lqJJCy30c61pXX7Gzo3/QnzJK0U1ZdX0xh
         NcbGfQqzwt6CxAuXihJYeHRDGKmKaAc7IF//ahJh6gRTEoKTCUzC0BhYpAD3JtfenLKz
         0UmXiEqCjJqcsrFjEQW56rMnPJfPXcBR7/lyWaqR0PgREOeK5b2KZfmJWCbgsgnh+AnK
         etBw==
X-Forwarded-Encrypted: i=1; AFNElJ9eonAhMD3LcXp6d5PBLVmZ7zK44wmBd1I66b68rzdoswwgrsaiezifBOirJcm7SXCFc9iuCXpRaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQhVMagwSEQdNKF6tdor6ZoWt3sb6XY+hvVsVJw9AwBm/TSGwC
	AIFcqbSFP+V7DupBbbEqufEeNRiuPgWQkU27+K/8+Wdwh5FS8MjzDWNEmqgJYi+DDSi3hhIvhNI
	3djTxPxt5uJmzVi0M9VeiDHUEpBvz2u+qLBxORumbWmvg1QBmJFPdF45/sZyZJw==
X-Gm-Gg: AfdE7cn4UymvpN6uDc45bG0rRXKb9ifD8MK8be9PlavMi/kC/S0VVY1Nx2iLyDvUcZQ
	M1ZgJ0L2X7ap1uuW++dwWgyi4adESBr7btZimudtLgOaYll4TA3oQaGHywizUsrf91MlRyKNS71
	z/PZrHLlMKcSNM8Z5wgV+8nMYjzXV5IJOgiRclfp4n4dmXDvxt9wqTeKPQo7SlVTOFYizEirT9y
	Aq4hPi6AxpGqgSXXJ6pO6ScKR3QuFqwY24jrKw+mZsOV/k+mg43ZgIo04zgouCOYALL4xwVfk9g
	3Eoq16/dI6J/qnJtOTkTaIOVhJHV5uX5hd0wdTHwrioa32DhdQP3PmDI3vXehnHCuQtvtx9o1+d
	aH1KAdXWBnMADIzvvpNsVjx4rYYiTn3yzOwR2xeFfoNA3sleTgs/w9MQ=
X-Received: by 2002:a05:7022:239d:b0:137:eb21:eafb with SMTP id a92af1059eb24-13b2a1762edmr2044174c88.13.1782818217287;
        Tue, 30 Jun 2026 04:16:57 -0700 (PDT)
X-Received: by 2002:a05:7022:239d:b0:137:eb21:eafb with SMTP id a92af1059eb24-13b2a1762edmr2044152c88.13.1782818216728;
        Tue, 30 Jun 2026 04:16:56 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b309476e9sm968932c88.8.2026.06.30.04.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 04:16:56 -0700 (PDT)
Message-ID: <1d54d968-abb1-4fda-9faf-fddda7d318c7@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 16:46:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Enable icc-clk support for Qualcomm IPQ9650
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
 <e9d687f4-0280-469c-8729-cb4ded09dd84@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e9d687f4-0280-469c-8729-cb4ded09dd84@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vpxP7u6UdOIPRBxUQYPF-jdMdzlzYfIX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEwMyBTYWx0ZWRfX0qbS6mIePg3y
 z4+CuCvuxR8bNesv7u6KPM3ovF32lwSSqSMdEqMP4WtCdLNmvKhZklVJAmB+D+tERdwrhgbBWMy
 owGHBIq1lPQCqW5JTbbKRyqkvrcJdh0=
X-Authority-Analysis: v=2.4 cv=JI0LdcKb c=1 sm=1 tr=0 ts=6a43a5aa cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0RSEAuWrFl8F25onPCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: vpxP7u6UdOIPRBxUQYPF-jdMdzlzYfIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEwMyBTYWx0ZWRfX1Pu4sX1wrYrD
 iMqpPS/2Icq/H9l/AQQ49LCLop9lNKWXkYvvLc4IwsrC70fF/nJdDNapTMXI+CK0/0he/QK/hAg
 60CeHU9C0JXhdUpKsiAl87bTm59mmqhAeVjiOMD/EOV2NcT/V0sIrGQNqOUBti+VWTKnl/CaECZ
 x+XEnlg+vioZD2woLHpi/+Z1J1I3hG1Te/AucHbvnPn6jNrHisx3Ulzn+oI4rDbNWSLzWXtMkJo
 ISha6oMD7JgSBF9D13qjv4vXKAj/hVr6QFYhHDA5T8Hf1HQDynShkQ2AbWHqc+zr9hYOl2Llwus
 tlHr4MkZR2JbMH+FlcCVtfAmhOy7jua38vCu6+d/wjn2f7H1SQP7UblnImzE4N8PsXD6BRYlZuk
 wb1wQncUzYi1LN4eMnampk6fA9zE7NiKdqzBn/8Cd3rdoNml0sR9TaLj3UvTfgw69Oemfa3dh8D
 6d2oFAJM9MjuKn8VsDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300103


On 6/2/2026 10:38 AM, Kathiravan Thirumoorthy wrote:
>
> On 5/19/2026 2:17 PM, Kathiravan Thirumoorthy wrote:
>> Add the master and slave interconnect IDs for the PCIe and USB
>> peripherals and enable them in the GCC driver for the peripheral
>> enablement.
>>
>> Signed-off-by: Kathiravan Thirumoorthy 
>> <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Kathiravan Thirumoorthy (3):
>>        dt-bindings: interconnect: Add Qualcomm IPQ9650 support
>>        clk: qcom: ipq9650: Use icc-clk for enabling NoC related clocks
>>        arm64: dts: qcom: ipq9650: add interconnect-cells to GCC node
>
> Bjorn, Gentle ping... Can this be picked up for v7.2?

Bjorn, Gentle ping... (applies cleanly on next-20260629).

