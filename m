Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB95318B85
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013969; cv=none; b=Ke/1CME0n3ks48oR+Nz1k6LesjoXgAImGvnu7WtysOUduzB+Hp8PXpVfSJVVShseyKz/ryrf0Wnjy8xoVzNpdBbkIMVkbAmgf7f2HKgDS+ZKOJT90MDAdyu01BYiew5V0CvNVh47DVDYO6Y6xtIe/zGQpM9C3YW4oSPt+4hWs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013969; c=relaxed/simple;
	bh=+JA44hGFxujuGOu9N44cb5QAbDdj4eN5FYBuv2SeAeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKEZntVTgHXyOifwW1n1Pvl297L7hJNdkWbbN6UvcMrliS6bwFcwOpQHVgJ6mwzFHYLEYOZKl1bxb/YE1fcxpbT9i5caB9Wn17HWMKgklx8ZE++6SbA6l1J1IMx8TZ9VlYoFmBbFbj8e5eD6Z+cOwuD70FuQPdIiTgPJHK7TMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p3aLDvpH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoilB1Q0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p3aLDvpH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoilB1Q0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6310s6Kp3103973
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 03:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=; b=p3aLDvpHrKuMqXrK
	Prk59awqUw2Rd4XMliPxGED1Zagn7TJCkEaStVOu3mwWuNUkW/RefgJOr22LBkYb
	LD3EMjxd12GRspFz/L+ll1xT7i/7L4IWMSDoVtF6DLVZiHEtfb5kCgVF8nO1GBQe
	RVMxZjytXJawnN9NFxcDsc/mdhYO7ZbgqurMCJ9TGqBz780RNDxdsvsSjWfeDze4
	/CLKD+n5bo2adS4NmyvhRuNcFN7nyOZ0qJoWkIvW9p1esUPj66yJ/x2XfST1EVHm
	nWgfRsh1ytZ2EKwWkE9Beg7Cd+TmYs8e9jGmOM0nC4Ml7w5F9oJgKeCqzxrOf+30
	yw7DXA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js2274y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 03:26:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adef9d486bso113664075ad.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013967; x=1775618767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=;
        b=VoilB1Q0fK97p07DeUB/g+K0xmjOsedY9EU/iKtiZ1yDFBbPS1M+3Zmesslhws67lH
         lO9BL6+L7I8WjeLpLs7tCL9OB4wH1L+kELHFdZ+sUGUxlmbweyp1yWd9I/O+FAsLRAir
         3WftfJCKUyVuCLEnPEGl8E2c0RhrizWFJ3c5kZjBT8zYHykvXhYtJsDg2Toc9POGlRp0
         viZ77YK6MfZInxMfVsfHrbuCI4gEIjOg2T0NoLmSm82RZnx32qKFg6TIqJe5lpEizm2h
         kCRawLSDJFcpqgtzjmKSfqvwB2ymi55t550qaAKAGJdvPNNqAJn5Dm0yMpnRnzMqvM9W
         x0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013967; x=1775618767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bFm59bSKTWB6QfcDL5i7O4Qbe5adgX1gyEfBxo1Yds=;
        b=nAViuOQrNiegfiVl3f9hZbQ3XfwENGo9dmf/jpu4Ms6eKTMW/fCZvKUKWchdW8c4FD
         BAmhtnqgce1CdFYHpTibYAOvid4gtVhfzkp0R+o7KlmlswYuB/Qw45z/57GAtObOWRgB
         eqK4hMcI697EX4jurZNFblPJhVgIjkcm+4pwK45zz6GX086Gp/N+/I6ByWU4l3smR/aV
         UKtBB4bijMHGNrV9rSjAXZQkDmqTVJm60AeptBa98qTtokkVkvLsbuMsKM+ZyMoBV3TG
         jgU8kcAKPfeL3t5l4Mn5S+Q3gS+Oz9OYuuWk9L0n2C+bVDzWALy75F07oio80StYeCL6
         qZGw==
X-Forwarded-Encrypted: i=1; AJvYcCXqJZ+H4lex7zpBMCPzrom5VHEXiYKQ5zouB0ytidSqXF3Pm+mhKnJBbULUJcaC7tAM5xrefxc7VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+TJCMr/nUEXGiCw5BNw3IESVVor7MtvTeeJrA67429fR47nB
	N9ol949KLw3IuS+JXkH3R+VtZeucZv5J9VKYWF3+V1ZgC39Hxhsz65XZz+HtirgIRDm1e6iwrDO
	8rYCLML0xrvQONUQ6XAdOzcuKUbPBcLyyFHM2a+9B48Ho9HPD3M8lh508eioieQ==
X-Gm-Gg: ATEYQzyOzZVMfpR8ZFfVjQJ6McDgdM8jfK8Hzg6EOQ9BPCNG2I5rUbQbD2qD9xNB3dV
	GPvTojGlgMc7oXonKlo6U60GWbflzRkedX/UPnq1C+2qPlEmUP6PRae/OZTLynQaN+/i0++FXAd
	ecJP80APGwfqTn5Dm2laUHIm8anPVwDqSNT91po584dVSQwxld/eqEjodMWPKyGBvudS1jAb4yM
	Jsa3vLmkDezvxid1pnQQF6ptGem0ckCk5WZOLjKdwT72A8OKDVUpx5HuHT+5x8pPuSgLN2Ev2eu
	M637Vx9CZQi7hybVqQKREbZ/5JOth2DloP6qARLzcV7bGV3K4E2NyQjXj1Tdm3hg3sbuWowX11p
	J9QKNFWt0z2VRtWlMUQckRZVJANrnVoTxrE8SZzaqpg+91XxsQJlG8BAgGANoE84r5T7hO2DvNH
	J3YyBA4QV5C1Qj5WW3BA==
X-Received: by 2002:a17:903:1a88:b0:2b0:c451:aea8 with SMTP id d9443c01a7336-2b269ad376dmr16365915ad.14.1775013966735;
        Tue, 31 Mar 2026 20:26:06 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b0:c451:aea8 with SMTP id d9443c01a7336-2b269ad376dmr16365685ad.14.1775013966244;
        Tue, 31 Mar 2026 20:26:06 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242643381sm138942035ad.5.2026.03.31.20.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 20:26:05 -0700 (PDT)
Message-ID: <d86bf817-dbc2-4839-a490-8e332ec3308d@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 11:26:01 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: governor: fix double free in
 cpufreq_dbs_governor_init() error path
To: Guangshuo Li <lgs201920130244@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Tobin C. Harding"
 <tobin@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260401024535.1395801-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D6RPzHF_Hicd-6dkNH0iFvXLqC41lw-7
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc904f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8TCDpgoCb24ZIsg9E1YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfX3j4oe8fZ4G01
 ZRlRSpEawTdxwArDX0BocPj3ZIqu3WFpfd897U+TtbDtV252tbQTop3ZkytSLgS3o6I/CT8gO4p
 lWk/8cAMMh9lagx0YFYsY++gCqnP1Ui+XxnJKvGYVxAXehX//9ipnS143L4wLPdNND8FgK0eab9
 IwRQPYEuOj8wkxFx6NCFHDY5s7RflBaDR09zVoJCxjqI5P8YTNfSefIfYApcYU6JwKZ0CG72ACT
 bF2BUxKLXlJ+Flwpq2P28+33udzyI7q7YAoQmBM75UDNCJPZ87+nIYN5sBY6+eJO4BQ4b4x+mBT
 eqdelPJTQcde9ViLgVRnY4YiD8SnWxKTUl5u6OUo1VK/Np3hp8HQ992/qrROdBqcRFvQkjtoJPT
 hbbwZLQIw2lLfesCvSheNeIT7r7RqeEEcnW3TIToSHihg/N1P4B87UfFEqnrViwmHwE5nj0ZIxZ
 wVkQlqSfO6Ujlq1eAEw==
X-Proofpoint-GUID: D6RPzHF_Hicd-6dkNH0iFvXLqC41lw-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010024

On 4/1/2026 10:45 AM, Guangshuo Li wrote:
> When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> kobject_put(&dbs_data->attr_set.kobj).
> 
> The kobject release callback cpufreq_dbs_data_release() calls
> gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> double free.
> 
> Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> after kobject_init_and_add() has been called, let kobject_put() handle
> the cleanup through cpufreq_dbs_data_release().
> 
> Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Thanks for the good catch and fix — this aligns with an issue I noticed
recently and looks reasonable to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/cpufreq_governor.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1a7fcaf39cc9..3ad51a986781 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -468,13 +468,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>   	/* Failure, so roll back. */
>   	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
>   
> -	kobject_put(&dbs_data->attr_set.kobj);
> -
>   	policy->governor_data = NULL;
>   
>   	if (!have_governor_per_policy())
>   		gov->gdbs_data = NULL;
> -	gov->exit(dbs_data);
> +
> +	kobject_put(&dbs_data->attr_set.kobj);
> +	goto free_policy_dbs_info;
>   
>   free_dbs_data:
>   	kfree(dbs_data);


-- 
Thx and BRs,
Zhongqiu Han
