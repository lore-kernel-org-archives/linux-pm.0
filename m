Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B96E2E11C7
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783544; cv=none; b=czT0uWIDYi8Mzri1ccvLJj4XUsM02h2TqrbfrNpz2l/Jpql/xdLxqhOTD55BREZHjjEhg6haDwBx96P2o92m7kHkHSKUIjilm05OLfIKvZg3SHLnMWsZCWFGsW7TCBXO4sa5JK+sfDgNgRqWsnaL0uEiGgSM3kGebXTwnjtwE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783544; c=relaxed/simple;
	bh=rJLA6cH5k8wkYSbeqVGi+qmnb45xgquJNUTKvf9Ltfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQCMSmCRzJXyoCJc/pJTxJkrrbRjSkYArYoSphBUfs6heaXvsPBZYMBci59kKJXjPCwux5R56VwgCJVOj+OAHMi4PCK9OoudL6aQzgQIYdiuLRtf1ORz+kaInVq6nTRLY9rwjNHRP9ZkzdYs0t1K6/m5ZyAnrqEjwnkzkWyeQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lRmXonB4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JfESZJXi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lRmXonB4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfESZJXi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEOHNd3871358
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 15:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vHMuzOF/E7LJXY5/0s8/KcxzKly0C3RXJvgtavb1Eo=; b=lRmXonB4GBUKFvyI
	QADBqdivzcKi5e8q6cbs+f9PtLTlh3E2bPM+rybMxa0NFcjxHlAMu+QuDhJ/+sZV
	5IuiPfMH4OqreAm3dW1+JH9+0t93sHNgo0qXQ8ifkBzoGy31ibB3c5jjpTbkp5EQ
	gCxecWgqP7tNklYbVRugUqf00rTnvMbxeoh+18gelRYruWjE2Kin8ncqOe/+/T4C
	oMRqvvJd6HrfQtI0OV5giYj8McSlo+Y3oSRgEfkhGzOaKGGguIbZwo+sxa8Gv8nF
	G5u/HPg7alYS+M/g49VNbVFX5TojmfQ1mRUSdAG5PexdBl0gysLgtgwQcIIdCf+Y
	i1g/Cg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbf0ggywc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 15:25:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eac2620cb0so23036196d6.3
        for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783783541; x=1784388341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vHMuzOF/E7LJXY5/0s8/KcxzKly0C3RXJvgtavb1Eo=;
        b=JfESZJXi9Eco/KpIEh6PyIzDBJAxgFkjMA9rnLBE71Lht/hnMcoBB0GuwSBRfeXZXW
         WYQ4Sxajqw9+7lsOzXDbVZULR6B13QXtEbs+PdiYKfW/hWwDcSHtr1onZOHlOzAx+dBL
         muzDWkZGjkYGsvWa+pOb4oNqNTxKVONwncZ4FgJB219m2dkxQM8D4BOja4E3JVjf7JGS
         SgUpq0jIkoedU7OaTTMqxXEjw4uH8e0zwj0LVK8wjsk/uKd4mE6ocV80hvHJPAHrTQe4
         kcu3l6XswjVJ4TGinowzaMPzdABWZg0V9Lok0o2Q3d6Vcq2eUMr7YUlXcq8rPl+k+RqI
         OIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783541; x=1784388341;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vHMuzOF/E7LJXY5/0s8/KcxzKly0C3RXJvgtavb1Eo=;
        b=o5h5kguKNFjs5mwhCXdAZbTOOjQvm/pbYvc6QZO3m8u7OMIhGAXSjV7az7qxQxZmZX
         FvFHpm9KVHOaQO74RoBLgGclcbKXBmqqYIOET1pbntuyve3MLMXAYAbuy1vqQnXPPQGO
         UmUZ3WwNzMjaoFUd1yKvWolRDcOvzhk386fVO7HmJe3k//t4QuP++/dJM1V8PP4WcA2E
         W5wy/6D0h2j/JpDOPpg9GoXzqHpvyJz7lVZ75xTXJQIWs8mwYnzJoWX0Yg25pLftGV++
         jsswFkd8L+j5jMwQ3vsmJZabtiS5qO3p+on6sLxhk3e5FUCZSuQnVf+YtzcfDDoN8Jco
         9SMw==
X-Forwarded-Encrypted: i=1; AHgh+RpFqpu3BkO3juwSuHAQXzfOEORUTdUc5i5QbMoXzUs37fcuqKOzDG0wWjtcvWD51vg/s/cMNWtzQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwldPT2NFBUdcx0izgSFJH/hfuIurWWyXlK40d1Rs2j+1q4NkHs
	ZZnVtf+xVjnLYmeQGv5x9fpwV1ifSCAgPa1GWb/wVPxU+pX6kRfkRhM77m+Ab1VwU4sQW09ehmy
	+n9ht2TaokiC+OOs9Qh+CmJKw4RoDB7CIm7hhpjiFtMTq0/Ij7FIt3IVAarCu4g==
X-Gm-Gg: AfdE7cl+NUq5ZpXHfDLhDS3bR7RDCdpm52sZNtknbbglp75apFY25GIPe1XkFeBzpIu
	JmadSsrOxWuPI/LsERRdQ/uF7DAYEn+1rk1giaLeSz+0htuOPhXRtm07eVxeDBvZ2LCtKStGvrM
	gzsGi/ggaaojbXSRVOPt7JqRcnvDMZ0F/Ahj0KWn8mqqgPjGGO/jyZF7RpQPhhASZXS1HtexyZr
	y3mjaevhpc0B58tIQxSjXuvOHjFr8EUIDXS51mJqdQ0PIVtnLhOIu5+/bMW0/Gobm0BMMNE9CSt
	0s8CH6Pv5QpbO/nrQw4ZWGaJIMSa81bSd8KJbkUk8NDwoGbw0BK5A/vW756vR2qPCnT++YWGeSx
	4/zWu7iqsHd8nFDY2ifPfWglm7UvXGo/oMeiHIDFi
X-Received: by 2002:a05:622a:104:b0:51b:9873:e379 with SMTP id d75a77b69052e-51cbf23072fmr30304101cf.36.1783783541155;
        Sat, 11 Jul 2026 08:25:41 -0700 (PDT)
X-Received: by 2002:a05:622a:104:b0:51b:9873:e379 with SMTP id d75a77b69052e-51cbf23072fmr30303791cf.36.1783783540689;
        Sat, 11 Jul 2026 08:25:40 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb73b161sm200528975e9.9.2026.07.11.08.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:25:39 -0700 (PDT)
Message-ID: <8e8a5244-6df3-47d8-a8bf-f1a367e46b34@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 17:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] soc: qcom: Make important drivers default
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
 <20260711-qcom-soc-kconfig-v2-3-4a907e064281@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711-qcom-soc-kconfig-v2-3-4a907e064281@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a526076 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=oiTh_mz6bHpUs43kViQA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: q2nT7q9s2aHNNssqU-z2x1LMrWDlRVtv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE1NCBTYWx0ZWRfX+BSAXSqlAFUD
 R1mCrwZ/2XWlxL51vqUrJgLbk9vRrjMjaWvo/QSGqeDcVhIT0jehNn0aN10pCW1l/4kc4RhKSmr
 +TgBCMQifwNBSS4T4NuKn+H586wACa9avntFtpvMgZsXDoRoa62tjhkStGlHr+2uXC+39YkzW7i
 3v9F+t0q/pESn/NwL+XKBdKd05rTSdy5WvG2cJbh0i4CTW3dMdJYVQqw+C5lN9TcT8lyYyBs7fP
 41KgjYq4vvArLxWEK45wl8WMU94ifjll6f0jOTVU6oScxgWxuRXQxeuyT3zJXkpStCj8L4Qcnbv
 GYaBdK2nw+DAIYq3C/KL3UYdJm7KiO7408kh3IeWbQag8IIBMArodlKOip0nPVm8ee43sJxKcEF
 Ei76oUBxloHicDnpl3FToUw/0LUUo5QT09/f10661Nv1+unNbrzVStCjkLiTMIg/ImJONKKBagt
 tELVrmxO99cfxsHpe+g==
X-Proofpoint-GUID: q2nT7q9s2aHNNssqU-z2x1LMrWDlRVtv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE1NCBTYWx0ZWRfX4kwt5XBmqHI7
 LjeoNam5iNoY17ivDLfgn7DtJZXoDHhOEDgIwH3NfwT36GsGY0ReyjzGQQO3NNAVHogtSWiFVof
 ET9eVPyz/WDL6p1F6qMgKRLfrpRJOUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607110154

On 11/07/2026 15:25, Krzysztof Kozlowski wrote:
> Kernel configuration should not ask users choice of drivers when that
> choice is obvious and known to the developers that answer should be
> 'yes' or 'module'.
> 
> Switch most of the Qualcomm SoC drivers to a default 'yes' or
> 'module' for ARCH_QCOM, to match existing defconfig usage.
> 
> This has no impact on arm64 defconfig, arm qcom_defconfig and arm
> multi_v7_defconfig.

Oh, that's stale message...


> 
> multi:
> +#define CONFIG_QCOM_PDR_HELPERS_MODULE 1
> +#define CONFIG_QCOM_PBS_MODULE 1
> +#define CONFIG_QCOM_AOSS_QMP 1
> +#define CONFIG_QCOM_APR_MODULE 1
> +#define CONFIG_QCOM_LLCC_MODULE 1
> 
> qcom:
> +#define CONFIG_QCOM_PDR_HELPERS_MODULE 1
> +#define CONFIG_QCOM_PBS_MODULE 1
> +#define CONFIG_QCOM_AOSS_QMP 1
> +#define CONFIG_QCOM_APR_MODULE 1
> +#define CONFIG_QCOM_SPM 1
> +#define CONFIG_QCOM_LLCC_MODULE 1
> 

and that I forgot to reformat.

I see this was already applied, so let me know if I should fix it.


Best regards,
Krzysztof
