Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6233B3895
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242159; cv=none; b=OR8qI969QmPDZ/UO8QYbbLUNPWpDoo0R/twwKdYGSn1WFXRXf1c9s5Apv+b4v7mG5jMP8bqg8NYDcW0FERzjs23/w27Curj3zcLNrIVOhnJ4kbPVbTr6KBeybMJ8VbSq+DzgdNvGrN+cVQ0ipBWTFVgfBoNwzDK68t84yYlqmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242159; c=relaxed/simple;
	bh=9JXcMPi9klr0gVBugissvm3yubFoBeps+U+24lIoaAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOU9B9wSTQMcINeTG4p2gflHKCoOKxkOtMelziQ6aWCRHl/M+Y8ztpmP1qISI8V86w1yADmFIVTdV2K3ksSjKGi/tdxLdtexEB+BglBVovJag9/TSRqKKfRUnpPK5v/WZQF4NCUZAPbKE2JugOE/sp44sLDzGWW5/Sd0aAOS+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHZyhl9k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Am52nWj7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHZyhl9k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Am52nWj7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648732uk1062618
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 12:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gQ+VgIMQeKAABKdVWfr6IhkQcf+KdfW+45aLUXYfA9A=; b=HHZyhl9k9V1/66Z/
	+u16+1ckFqBBewZtAvFfgJ/Qo+lS8caKdHT16uAp74x4ZPmmkZTUB2Ti5ORjEYB8
	R1ViM4LV42S9z4wTSm+rMnbtaq03QZY5giqnlekfvWr7ZBtX9VKSsyPob0zv2mqf
	j5KHIwJvAJuqXWh6+wQNI/y7Zxp8ZMH3a7ReMgjScgKNn+6BiUE4l3YntKUaJGWT
	Z1SpdZe7E8atwILSNuHoN3Te/5waRbKCgrMUtyhJ/XLw10UyUrgUa4dNGGFI3vNg
	OV/gJ3uncEIvXQws9TA/b4vbxtpwxV/SJ66GpRakgU3/9tUA6dyqqJmt/I5TfecR
	6AiuiA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1b3fh4fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:09:17 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95cd67d9a7dso117259241.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778242157; x=1778846957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQ+VgIMQeKAABKdVWfr6IhkQcf+KdfW+45aLUXYfA9A=;
        b=Am52nWj72AHyDboZXbsEwHqV2KHcs/szowvPzBlmV1KNa6aBWkArEzRe9uClbWhYNw
         bgJIKitggV28bCSgYHBx1EiqU5xguZGEI2r08HFLpedeuWe8MRvKIobZti2BIDkyRqnu
         /p79+75YpGvg7kEisxk82Hu2SGShCX1MAsp4g1vOf5thjOR+14leNMEmYyJ3c743O4oi
         3kkzDmS88isnHF/qIvDp6rz2ZTY9Ab6ayZyF1cvRshuik/czqXFuwHq30xltyZXTdbZx
         ahHEXpYQPAF81JwaYo8ivU2c064VCWMuxOyJzmGsSjVgCiLaesVpM4PBpxVFt+0TRQy9
         SC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778242157; x=1778846957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ+VgIMQeKAABKdVWfr6IhkQcf+KdfW+45aLUXYfA9A=;
        b=O3TO5Y+N5vdhJ7sbK7qbNvaV7zAF8RgL5Z3lO6JLVg+oHQgYCuqNFQJRjV9vHaWG9H
         jHRnnZpn/G1oXLaYU6K7fboJHu2i87Cm7LnP6AsKyI+JQCqjYLYlEnGHCP8Qc4QXRb0I
         q2RhDuYbAMW0/BS/5kx7B1NFD98e+5Mo/I28GgWDKcVLCTmB3VhozW19M/upupZQ+wRf
         nGvQJzg9q5bq2J92K8Ngza3tKeEwQ7eC76zsABjYHtp6G3+KOwa3WKaMczCqIZTvItH4
         Rq5nLPCqRQaYIODB7EO4peb4JF3NuKYouriyH+btKLzzcwJsqq9BM8oc6tixDUUm6u4x
         TfsQ==
X-Gm-Message-State: AOJu0Yxw3rKnvVq2q2Tde+wmZUX2EeSGtCISqVfUZ7+5LP5rsJVOlD56
	YibvHoYwDiTcfxAoVrHAcccIiy3SLToOldby7dmDGxUM3+q1q7MTNZg2+8QEXJ+lh0ShOdn4mRu
	dj7L+Vek5fD7K7rHcf3V69cnelZqH2EL4z43cbD/FcxE8CjBL1Jqk5w+0WMoFcw==
X-Gm-Gg: Acq92OH8N4UAH1uxIo98FvERTja7vvrnM/tz79+wRoJ6McvHbnvxAdxDOPpnctDYh19
	uyPWC3qXSKhWEEbkDzZls+rBuEMGRww+xYjQJ8/bRKj4pXI1zKJJJnf4JEBdAnWiDLvvzdTCfN1
	7PLtolnX9n8GXQN+4bY8YuRZaeHqB4VjYPWP2KtI+w9pTgKrQYk0ysaYVL83UZH/W2sY6PUA10O
	6jWg7igf8IEMwUmN95znAeSLB/TDMs+g4tAMFk3gTyv1DTgUb4RpHtDnX/ltzCfLBw+U45gCI+d
	OYBg8j5IHftW41ozSHzAIoqIwEdu4aKStcYmA89ZXUbh6BxAnVyVIVs0UMEmbCs48xZT2pK3Z8g
	ZgrOmnz/Zog45iHQ1qQa0H0NOxPsnhEWSjczOow6hneN/h0xgDfZx9wqWHktcK7gFRFoYnL7URm
	pxZyI=
X-Received: by 2002:a05:6102:3588:b0:61c:7453:af7c with SMTP id ada2fe7eead31-630fad3a524mr2727059137.4.1778242156650;
        Fri, 08 May 2026 05:09:16 -0700 (PDT)
X-Received: by 2002:a05:6102:3588:b0:61c:7453:af7c with SMTP id ada2fe7eead31-630fad3a524mr2727050137.4.1778242156271;
        Fri, 08 May 2026 05:09:16 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359ea4sm73498566b.50.2026.05.08.05.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:09:15 -0700 (PDT)
Message-ID: <000ababe-5f9d-400c-b7b0-380ff25e9fad@oss.qualcomm.com>
Date: Fri, 8 May 2026 14:09:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260508100700.772985-1-priyansh.jain@oss.qualcomm.com>
 <20260508100700.772985-2-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260508100700.772985-2-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WgOJgLG3Me1KgW6AocxgOP3PtRpTr8s_
X-Authority-Analysis: v=2.4 cv=YMOvDxGx c=1 sm=1 tr=0 ts=69fdd26d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6AAB0q3k6GC94sigMGcA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: WgOJgLG3Me1KgW6AocxgOP3PtRpTr8s_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNiBTYWx0ZWRfX6yFDFmKzfoVb
 fZXpLy3WvfgLbe1jSKZRrg3XO6dJYnhDiM4xP6Z4SIgbJd8j6/0apkOViTITeDwDQCqP/D4e/pF
 q/uRyT+93wBajFisHFQyG5sD+4tgkkkMI6WfvlVh/N/ATtgvj+DQ2NHggxg5044xjzBZXT3DgBV
 8AhBlX4mttRClV10DDzT3stpstl/EubjKpjhijHLZaXgrwzA6KvxeokLCiGEwY1Gw75MOKWhC4X
 2hrCyBCnE6jk0NgEy+Uhp5JI4hJVSZd1S9+QQKjoE93orOv4pFfF5PDk5glSUeF+/QtV87AMeL7
 ohCQUHyYu946Asr+TY8UQHEG/Xz/+LtZgYGO8rryBqiKBL0qwXZa5e1XEd6knJgCgc6X1lHfpOk
 8l7++CnDgZsCRQutTbL5pd6msgPekVaePpYfPEua09GJgndTJIj/N5TzvPxh32Kto9aVBijKNYV
 J6dPBo9fnpF+IyznE5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080126

On 5/8/26 12:06 PM, Priyansh Jain wrote:
> The existing TSENS temperature read logic polls the valid bit and then
> reads the temperature register. When temperature reads are triggered
> at very short intervals, this can race with hardware updates and allow
> the temperature field to be read while it is still being updated.
> 
> In this case, the valid bit may already be asserted even though the
> temperature value is transitioning, resulting in an incorrect reading.
> 
> Hardware programming guidelines require the temperature value and the
> valid bit to be sampled atomically in the same read transaction. A
> reading is considered valid only if the valid bit is observed set in
> that same sample.
> 
> The guidelines further specify that software should attempt the
> temperature read up to three times to account for transient update
> windows. If none of the attempts observe a valid sample, a stable
> fallback value must be returned: if the first and second samples match,
> the second value is returned; otherwise, if the second and third
> samples match, the third value is returned.
> 
> Update the TSENS sensor read logic to implement atomic sampling along
> with the recommended retry-and-compare fallback behavior. This removes
> the race window and ensures deterministic temperature values in
> accordance with hardware requirements.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> ---

[...]

>  struct tsens_features {
>  	unsigned int ver_major;
> @@ -522,6 +526,9 @@ struct tsens_features {
>  	unsigned int max_sensors;
>  	int trip_min_temp;
>  	int trip_max_temp;
> +	int valid_bit;
> +	int last_temp_mask;
> +	u32 last_temp_resolution;

You don't need this now that you aren't altering the regfield
definitions

Konrad
