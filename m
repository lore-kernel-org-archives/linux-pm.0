Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE68243964
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362825; cv=none; b=TBjYLskBYtig+vhN8xvSJVyyHnDkpAt01sFJ/tw9dca59RWv7tsS5EmYv12LXMKNfgK38Xc/3ZrYRMu/MuZDLbL3Y9IATvC9poU2S3vF4E8t2bzMZsm2EDojt7zKNHAiZTxpfheOhXE9eMJhNNlknpHEmBX5hltndassvEVa8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362825; c=relaxed/simple;
	bh=erKQosPIqdaOgd0Q0tA2hppl0d35KiNWcE7aZoeTRr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nwfuznx/mYBYjr85n2XzInftqLCziusx56kivQA9L8Q/ligAZ2nAUEgTR35n/baBBS6rbRP/dyc6kqT3XOls8ieTAeY/LdtEXI1D/YmR/TMYP6RlTXr86e/aV33uyKxjgmKQ+vNfaVGbU6/M9bq28ju8n/fiWmicXF98R74Oc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIchbEHr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gN5aboJz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIchbEHr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gN5aboJz"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DAwoAn2610222
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 15:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ngRx84rbTESR9X5O9KJfzCIqFTf5hrTxjIsBChnF2Vk=; b=XIchbEHrqfMcEWp2
	htoMnkp3IK5LlTU8WXS1tP5LDcKA+2LsdwFHTmvdeLaksjAxQmhPQjCzExUgFmqz
	p9lYPqliJC3U4gmfA2SOqk0+FRITRz+uShizeDZEjssGVKYA4MjyKUA5OyqqbsE4
	qvcp5+b8uOPORiFG09y1nCq/bqPtn57VZylZX85DE3wR18wmtcggcb8DSs6bRZvg
	q4oMJmnP49leDB0mibuuJyngbBEl8c1/9xzTAzQg4PYmZYDuFk7udbf6XyGjiC4g
	3jBntAhb5Wpb1gru6JV81yvottffuBZdbuLiKaf0GaYejFDWZzOs0+/4pF5Uy0Fr
	7Qax3A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery951b2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 15:00:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8424aac207eso2016230b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781362822; x=1781967622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngRx84rbTESR9X5O9KJfzCIqFTf5hrTxjIsBChnF2Vk=;
        b=gN5aboJzBN6DQqLchVTp2NaPUJgbPIK75q+3HMogiJWNqkxyUW6HBufxYMb8JSfpPA
         8VQ2s599BuxPkjQThTyn2VlBSY8db99sBqgxI31pD4AavyKoJFIY4aWj4juJOAWMHodr
         xmAb+7ipaO1XAu0+Kx/dlEPxhwFSDX7TrIybvwLikYHR+sBiSQ4tEcY2nmdEOVGtgm0g
         T0ModerSn1w0vGqVkMKpbkCSTwbEHkVzpixgF+/Yqy7QcsFb++l1vGtDQo0EYxK9lt1o
         7FNjsG61sj44c/868SsPwfv3xRb1HK46kN6v0x6PnCe0O+3Kw2156/euAtoAaC4iOm3b
         LrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781362822; x=1781967622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngRx84rbTESR9X5O9KJfzCIqFTf5hrTxjIsBChnF2Vk=;
        b=F+fpVIHxo4wPwXkHgBFMxqrlXcQz1N7j0GlngUGHl3vPDAa0jDFiTNyG+xqProdH7y
         lj7YIEaKEO+q9EiuXvkdQvuikCzyuvdXJUnc4L4FnEt1KKK4HR4ihV1n1VVhD9qG5nB8
         KubvkZHRct82zWpRKpg7CH0FQagjet5po4eLTJ95gIxIMevoZ8ck9/l00aUibIJTq7v5
         v5EB9E7CJ5v26M4IGCtsUBUTF8AvxSgGEFDGmylWOJQomQacYl4kYC7Q6uI/19YR9Xqj
         VRUdt+f6rQRhk15EtBcryswqj9S7XoTWyGLoC2cEPUPXRQcNEIcvqpsJ0ltIa44rV+/H
         ymLw==
X-Gm-Message-State: AOJu0YzTG5Kt8shiraUYO4ozm+6jcUSwgWTchm/vzia9hQ6PD3Cd0wHO
	9pbCZe9X1iLzShx6OteVIafglclC2xPTT1i5y9sXTxAh42+KI+ESOo2vJD6ilP+9izPokTV5QaQ
	/10Qc+FqpNvg+KxK8j1X7MolKsFvrUy7cdQtS3/2arFd1/svHWiz4FjVjiTatKQ==
X-Gm-Gg: Acq92OGCIDQ8Qb7AAuliPGHzLsyqD5jVrWJA3U5JiQVbJI05EWVU2PuwrMs9mu3et/c
	f/fEH/z55qQZ2qq+/6c+fRgmlknjgz0kmlAb12ZN/T8yv69rliRSFrbGQxkFgJQeqfxo8jfDbY6
	tAojAimXaSqyGCyaNHlWsaIZVDorNetB/ZhcCCL8pxH7ZRlx9a3uObIRxsND9U4y9hX0DrHpPi4
	9RaJ4J0kMTid6iF24rCGhLHowsObHIHmbuC/LE27Dq9DsZO3stxISgvqzQS0fQBg5kw+6qLLn4d
	87PMDtO4aE6LvRwRrl4pfmSCAsxElYH/Mbs/pVurJ+CkNrK0q+KT6W1+EoG9zN7eLUZYZ2gdjar
	XfzfjWq+S2tL3Hzqso896H35h+Q+kXHiuLGLuCJq7otGEx9bmgjwdsw8SjYsOjAYFxZKcAUQIM3
	hM7Fkh6OnuTc6rMBDq
X-Received: by 2002:a05:6a21:1519:b0:3b4:b26e:bab2 with SMTP id adf61e73a8af0-3b783b22db0mr8102214637.2.1781362821845;
        Sat, 13 Jun 2026 08:00:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:1519:b0:3b4:b26e:bab2 with SMTP id adf61e73a8af0-3b783b22db0mr8102152637.2.1781362821213;
        Sat, 13 Jun 2026 08:00:21 -0700 (PDT)
Received: from [10.133.33.24] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d156sm4733343a12.13.2026.06.13.08.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 08:00:20 -0700 (PDT)
Message-ID: <12116e07-040c-4536-958a-d55d04d163c8@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 23:00:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: powernow-k6: replace symbolic permissions with
 octal
To: Jack Lee <skunkolee@gmail.com>, rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260612231612.206356-1-skunkolee@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260612231612.206356-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ChlE7wmG2PmkjLsWH4rWYkdow9F15T_0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE1NCBTYWx0ZWRfX+1N2wc65s7g6
 GhvzlyZ/FM66ynvuSqhsMJPt13j8lcP1TtjMmV7nS2ggs2QobF/Ohcgd/oGlqhjENL3A2i7hQo1
 Ychg9ASVrZJj2I1qRMRKagYGmE6nQpc=
X-Proofpoint-GUID: ChlE7wmG2PmkjLsWH4rWYkdow9F15T_0
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2d7086 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=crW7i2NR9CvPMl2r3TUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE1NCBTYWx0ZWRfX3tQSAPcUUpBt
 H5TFclPPWwe4YLnyen7h+gOWflmTxCYW+J8Iv1HoDqHs+3y4tARnWPk0S8aYpZ9Zn7AzAeABc+f
 +0SvWNpKJvAQjrucsQ7RnCsWzOGR6ZpONYjCpbtwwfhONm+JeilJUuFT14JGP+im7QenG/X1e47
 WfMpVvdnY/G165OKvXkkOqkxi4Q3IejrO7S5emr/jGUrk2DsmNiuPG8C7FiF2byiMBt2yYJRPzD
 pGvXsJWiYhtBY4V0spiPcypoDjexXnYl6TMY2sDiJUqW6mLW6XG3S2ZQRuv1A2b71SCZKKmi/yL
 pxxugz6VXlDMoY+IayxgLqsXdAfEyaU77Hi6P3sxn1aqXLwhs6M6Ggk2/aVWiVLXMAj1+4XXKTw
 FBc2gq2CQMRFHMmbf4/zMovkhzjLiEEy/aV1K3wnHXxvPc6bh9O4On9xNSO3T0a3z4zAvCQs72M
 PhWw7lxm3B+/WQPlIyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130154

On 6/13/2026 7:16 AM, Jack Lee wrote:
> Symbolic permissions S_IRUGO are deprecated in favor of octal
> permissions. Replace S_IRUGO with 0444.


Hi Jack,

Thanks for the patch, the change itself looks reasonable.

However, I'm not sure whether this cleanup alone is compelling enough
for merge.

It might be worth clarifying the commit message, though — as far as I
know, S_IRUGO is not formally deprecated, but rather not preferred,
with octal permissions generally recommended instead (see
Documentation/dev-tools/checkpatch.rst[1]). Using wording closer to
that might be more precise.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/dev-tools/checkpatch.rst#n1060


> 
> Signed-off-by: Jack Lee <skunkolee@gmail.com>
> ---
>   drivers/cpufreq/powernow-k6.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernow-k6.c b/drivers/cpufreq/powernow-k6.c
> index 99d2244e03b0..764907b04c04 100644
> --- a/drivers/cpufreq/powernow-k6.c
> +++ b/drivers/cpufreq/powernow-k6.c
> @@ -29,10 +29,10 @@ static unsigned int                     max_multiplier;
>   static unsigned int			param_busfreq = 0;
>   static unsigned int			param_max_multiplier = 0;
>   
> -module_param_named(max_multiplier, param_max_multiplier, uint, S_IRUGO);
> +module_param_named(max_multiplier, param_max_multiplier, uint, 0444);
>   MODULE_PARM_DESC(max_multiplier, "Maximum multiplier (allowed values: 20 30 35 40 45 50 55 60)");
>   
> -module_param_named(bus_frequency, param_busfreq, uint, S_IRUGO);
> +module_param_named(bus_frequency, param_busfreq, uint, 0444);
>   MODULE_PARM_DESC(bus_frequency, "Bus frequency in kHz");
>   
>   /* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */


-- 
Thx and BRs,
Zhongqiu Han
