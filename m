Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628943D4FA
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839810; cv=none; b=oYVgrVHd9ufetKOnTwAogtgHVLQH2lYX9o5a6rPG5fFC+yhvKWCEXuZZPeuss6XguD1PMvIumlfgr5Fyo+TFPbvLCKsammfmPIt0ZJYlcddtMfeSHkC3QmR9suBuKknbYi6qj9SUrNSVzdpUKoxSbd/Vrx9DwzlVjwegZ5Ml1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839810; c=relaxed/simple;
	bh=r119k2qqSvMGfTsUYPr/T3TtmvauMbPiahQOfS/2/Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnV7IPW2dEU/1gVatKyTevCl3nH5iPY2K54mttebdkW8zZPePvGOE+fmcxGXzIezjcnIxOPEMmVDZI+wgHiTlhokfb2fJuFfhk+A09JVoYnSwx9urEFnXnONvUUTwND1h7VEJOn3iuSoyN0cztcoUDVC03tPDQZbUxc9yN+KWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kx8BpcW5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Liwwskkb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kx8BpcW5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Liwwskkb"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5I4TP654903
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xiB3OnvSBLF2318DOoqhFlBDTm1gOmHvdH9fY8XWtYM=; b=Kx8BpcW5CCOyLqn5
	qPVO3Pg7IHdHtW8U9cVrC00Qqi8lDAW11Q1Hf5QcoAHzFatSVpHpoI+Xmo0KhVjs
	vcjKuzpNo+SqBVRHKDOopfcJePRTwrDy/RM31PdKkR5oWqT2LLpazXl350Gri+Li
	n6HCFyBsHP8Q+Nn2yjQ6286mdc+UC5pACubgd14eZQiDJAjj4J+0/SsSO1EJGeKx
	+SUBIlxr3xdRNKFPLe1Am8QwA9/mgtPaxC0hCNwPQ8SR7FTZSB8dfMqqBuJR640U
	wiBFXt+eT/lbUzO5IQFbu93ouufb70SBr9wxurFHKYLTOSoWwWQNHAlUVxhvkpVs
	TyXKGw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ptu5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:10:08 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b58ab2c657so27208806d6.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778839807; x=1779444607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiB3OnvSBLF2318DOoqhFlBDTm1gOmHvdH9fY8XWtYM=;
        b=Liwwskkbz4JRu8CuBB8Skq2nYGMPR+o5c4brv2Z+Xsjr2JkJCTGlDAp/LQ8aOXNBOP
         sB7JDwZC0hG97Xm9Red39sR0wT7JRJvxwUvRzpVEY9Y6v2qumhfNiTFp/EHhBRW67UJJ
         sie2cBurSXkkr4QNeRhLjZ7yOkxPDNAYwGg6pVufC32hEdzSxni4gMH6Pz2QjzfLe6g3
         yto5mnFn5ggD+9R6xxomfWXuKlsdKsCKPD6wm91HTjQ98qJt9U2gm3D2jMHjf5fhegpj
         CXWVu8FJkqQyha+J+8EFwha3RAeBJ7IRluyxOcXd9YaTeTIZ+VusS0+TwOUDGV5bhkhW
         p0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778839807; x=1779444607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiB3OnvSBLF2318DOoqhFlBDTm1gOmHvdH9fY8XWtYM=;
        b=PJeOdZ2xvfvBsQ84vxKp4FnW5i3qP9BPSWbWMgw1TDffLt1AoUJuXXc/K35MNmBc/5
         8gbDIZxJMLbkteWZqEKJT56jijNcAGC0AEmehvjhH6k9cFlkHgXrXi2+9SI6Ejdyb16P
         16gUFj7553K6qWAKFWIk8L0wAFvbOPuDAMh5zwU3kLxfQrVRDQrQyxLB95kB8L7zLkI+
         kyna1UwYSSHVDCVmz6ZeqdpyCvh7V48F6tvzjAj5g7b5vnOYEz/MDM8ReicO4rd4gP4O
         cH67mhDef/0uSK1bYISBzxJfm2Uc9927zFIgzL13VdyUKti3I/7ULquQ3XB534OmJ2u2
         J7YA==
X-Forwarded-Encrypted: i=1; AFNElJ9GoMteIYPwgdV9g89geO5Rxv5gC9i1irvSuCgQqeQyL485P8MSe+uB/zMqj4pSaGwRsZsQVEgNDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMb3p6yxQAcu9KXmzZuKx7xRgXVwNfkqlt9c6wLaOzPOHkMa9O
	OPlYbLdVixPyKPXE/Z4azfeGpR48B1tXtU+4y3M1EzOJG/ObYFSzrkxeSGtJqhQg39EG8va4nzL
	x0jkp/11zB1ozmsp9RVg0SL7Fha9zz9Sm5cNIf7wVKoY76sI3+1Kf+88m32HF2w==
X-Gm-Gg: Acq92OHHGVglhpX3z6b+JxBLd4z7E3q7ALID+kLU08QLus9Z115sUM8TTP5KLeSoxOM
	gDV2ZXqOlbR4YRHDsUGSIpmmzCYTf9sd9so7Zb0SYDolTBkTRomKqVJfjItwVW1U+ckoqPZE7/K
	npeXMCDTt19N78JyD7dwKKozK96mVwImBHjngoMjr03Z0VEnC73XixXv0qG3f0FvEurKjXlbN0d
	m82kNwhwEAaOLS7iJQ4fNkKci5okKt/TbcbFxx4jDN+D7xiVvNXAtXa/xQLaOBAd5hNVgI7mXX2
	nkKItiRXZxd+r7+e8620KgeV65e+rcy+A2XwofmkImDkK3GIHiCWndm01+/vQK2hG4+f08HpNI6
	HcCzxwvr/c6CBQ7EYsaaY8CagCRI/u2tyZosBu0ZT7MZh86ucGzh5lAOyE40VtvnhjbXpcTTOtn
	Qfl2E=
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr28649971cf.3.1778839807315;
        Fri, 15 May 2026 03:10:07 -0700 (PDT)
X-Received: by 2002:a05:622a:111:b0:509:d76:fe73 with SMTP id d75a77b69052e-5165a0dc367mr28649781cf.3.1778839806902;
        Fri, 15 May 2026 03:10:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68311879bb3sm1812289a12.26.2026.05.15.03.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:10:05 -0700 (PDT)
Message-ID: <d41015e9-c31d-475c-a88e-791351ed243f@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:10:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] interconnect: qcom: sc8280xp: Enable QoS
 configuration
To: Xilin Wu <sophon@radxa.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
 <20260507-sc8280xp-qos-v1-2-15135858cd98@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-sc8280xp-qos-v1-2-15135858cd98@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: aywNh20j0nRC0i2PsjJZ9bb2fYlfcDY7
X-Proofpoint-ORIG-GUID: aywNh20j0nRC0i2PsjJZ9bb2fYlfcDY7
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a06f100 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8 a=NfFXuZlUh8PrNxB2MeMA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=OIgjcC2v60KrkQgK7BGD:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMSBTYWx0ZWRfX4p2W7X3FZQHv
 xysCl0dtBq/LWZUrh1hbNzRmTDAq2a6MhVAONozrEGcBkoDiP5+kMscOfF+vWb+m6IFToHEcTer
 UsPryK86lsxm/TCr1uoT3doqZnHhw6ur2lzRjOCOJOa/nI4iRgEq3fHydQy0dOTaovZ/iMotjok
 7zmWHhT8kwjS/kIJPbfdwkPgy+ogKPZcT8mjtSrO6/b1oSTe3NxKVRBvAqop7aJPlY3206RHRIe
 TkNPXCDGV5Coqnt5tmmPLc7PMrejO+dT+Sqhg/gc4ToxvGsAC7qdlOOo/FmkD2iniyRFfg0zSrM
 4oItGmx32bw4qZmYPfWwuTkMr9HqYIW33cvPb184wlvXGwLc9RuBNgw49gAm6v/rORAf2bVkyEp
 VwnwmStm1OAMUStaCrnrGF4Ay5nGFaCzmGprOt34CMoSa10ACdCvpofekKbKY/JGD21gam1Nq1V
 XIvYJs8taP7vOXRhgEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150101

On 5/7/26 4:25 PM, Xilin Wu wrote:
> Enable static QoS configuration for SC8280XP NoC master ports with
> predefined priority and urgency forwarding values.
> 
> Add the QoS box data for the SC8280XP providers, add regmap configurations
> for the real NoCs, and mark only aggre1_noc and aggre2_noc as requiring
> clocks for QoS register access.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

Checked the QoS settings, they seem to match the info I have

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
