Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382C326945
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493544; cv=none; b=h3xikwqh6WK7DLncuJUdvUpQsZKZCFChV+XHJMo4jE3c8oH7MIEw6lIhmqC3vcTVaBzDokFtPY9ksY4CLmXU8JObUseFFwRHjOuUL32W9CspNbnGNps3j10kTQ4JfQePJlwrNLvY40hkrk+LLCAOtE6LxCLYmX+mRoAQBwNWaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493544; c=relaxed/simple;
	bh=nLwiq4xLtUJvJgZgyHsKU2B4tkPgwFhc/bYlFS6fzwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM6afpGh8Y7pxjVmw6sYhg8xJmEHS1l/KtPebkNi47vq6UPbeCDjbt/6ACYBCdxj8XIYNYSASXg3NPxVUYLFGau6z8IjPg2ZxlDKOAKE8hoVWSy5GF6jmI5bDQXKDuCeeKxGuKMK43a3du/j2cigWpDQ21sak0dOv8ifwUedVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bDXvSyam; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FCdol5jx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bDXvSyam";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FCdol5jx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653AAxQH3552128
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 13:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SY9USAL7RV9vl/lzt+LH5AuybCAQ9ymalWYSS6pIv/E=; b=bDXvSyamrgGSWzjq
	AnXHZpkLtP5xQ0WFs3KZq34u7+xbgIp5xs7fceduy7C/Ira9gtuETM1tZHJ7DIVE
	IocjDuTDHEAYK+/XxCYmoLfKcbrZChLO8KWpbyeoTZnFdcwfsc69Xfw+xWkvai+Q
	fWueQkKDidvqCLYkcjH5lryxZmKoWgxFaEaHZgSN8FTpCZaw37S8XHrtNJseZOQt
	almutLV0AmsqcP0DEUo5WUBivWvde7KVLDSWq7tVkWBM+T3U8T6jng97p6X6Eh2f
	ajPBkdxVQXlW9JPbnBq70F4VJWaW/WgfxnYEJUgs0rW3IFRVGqWyfia/rNuIUYS7
	fBXkog==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj9mrqqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 13:32:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf004bf8beso83224535ad.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780493541; x=1781098341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SY9USAL7RV9vl/lzt+LH5AuybCAQ9ymalWYSS6pIv/E=;
        b=FCdol5jxp+wct7bkM8LYT/MyZehr9HBaFio8V6aFHYn0Fz60DozNMyUAd06+wjmH7z
         U4jvd/NQ3k66fzXdbs0LcEEJURTd0tTyTAVMkLWRcH7iSFfdBRmpYVnxT4Z7hmSJSxzz
         pRwUixgb73pza8wZ9lkl2S/3vVxbsvN21w8QPFrcImDpQBE29BpdEIA/ayy/uFb/6Uyf
         VQ03FpTtog8aLnizvkgskuKp6tcZQHY2zcqzlV1B4EWy76z4vXs+zKBIwLzNTaK/CMiw
         KvwvZk3KQbrTMFhiWZgEO//P58N7ptc0rWdVe02A2HOkiv+x3Q3pT9hNWdsyqgiWt9Z+
         f8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493541; x=1781098341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SY9USAL7RV9vl/lzt+LH5AuybCAQ9ymalWYSS6pIv/E=;
        b=BjOA3iE6kZSFl4Q0qei71N2P8NVYNJ1nthZDQLuJ5SGdPKzn6zNgOtStsoJUInJSFD
         1lPz/b5ZCHP2X5uX58v9Tur2dZ1HxI1RmVg+Z7sju9CyCTzBbgBAG5Y7KYOasdVZMXJ5
         6HQcxb4NivAQjmmxiCil5BGeZhKoh1rouJij9BmfuooyHzQ0ea98UsJRjk64HgoVh6wY
         5tYiotMk71DJCvzRxv7+cfdJtiiD/UE8Err6Bl46hgMyEICPnoxrlOmSFz/l3818bIK/
         9w8T3waiPhFtUvLW8fe2l7uJMVOdnEyjTMFyl2aXVjGBGPmGzQYbjdlTUY2PpqR2F36G
         TxMw==
X-Gm-Message-State: AOJu0Yxy6/CMMnnF9vH54F+11Co5BpWhgCnbnU2wVDi9VSWVN1UM9dGZ
	n5+3UYbQSR1q4oM7Xr8mksYocrV8Qn3n2zxUeX9DzJHZz11V3s0cZZt/EblqAS6P/m8iHb1jVVu
	sbm01/Gbm23r6Qg5cSXzL8V5xDzwQkIa9erHZGH3RPUlyRHHj4jsQWAod+8Xuow==
X-Gm-Gg: Acq92OHtl9DOgmW0T0M15b42S/EXg8GS1zfbfzeDJxupLl+qELPBk7Q7+Y1lnD2Dzsd
	ReTRetFkLba+XGoHGUTeOfov/wwAENWBarexTw0GOpvjJwC/5d2BvspbdqrDHu0cg1ilPi3sFHT
	wRxYuK+l4M7W4cXR/Hv/KihzNtI5Nkx+O0+KClEqWV/LhcUvVkEZx4DgUI+pUndhRZMZgkquHUt
	FGRCJVRwnd8lCYLtDQACrENywssLB+Myher06DX6FG2Z/JA8RsE5imwG9oIevwbU751iNo6H4YW
	1epEvBwwzzlM8p+Vu44QJ7fEVvcS4DcmkGXyfYHghoeLDZoPn2zDeQcSoUz8OxIwcjTWP65ydXj
	sNgxiPNAlQRY1nxdZxDmEnCqdYfVgXYeof2M1MgnFTTEtw3ZQKZjB1vu89gB7IA==
X-Received: by 2002:a17:902:ce87:b0:2c0:d8ee:7d66 with SMTP id d9443c01a7336-2c1644cadb2mr32345495ad.36.1780493541377;
        Wed, 03 Jun 2026 06:32:21 -0700 (PDT)
X-Received: by 2002:a17:902:ce87:b0:2c0:d8ee:7d66 with SMTP id d9443c01a7336-2c1644cadb2mr32345135ad.36.1780493540949;
        Wed, 03 Jun 2026 06:32:20 -0700 (PDT)
Received: from [10.239.132.168] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm26663615ad.26.2026.06.03.06.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 06:32:20 -0700 (PDT)
Message-ID: <210cefc5-c9f2-49e2-b2f6-2a3c1a42218a@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 21:31:50 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Documentation: fix freq_step description
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, corbet@lwn.net, skhan@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhanjie9@hisilicon.com, prime.zeng@hisilicon.com,
        wanghuiqiang@huawei.com, xuwei5@huawei.com, lihuisong@huawei.com,
        zhenglifeng1@huawei.com, yubowen8@huawei.com, wangzhi12@huawei.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260603055635.1549943-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260603055635.1549943-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4cFMcbYxkJziJD1uMcKBfziBne0lirSQ
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=6a202ce6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=Zyhr3UL3YfEZVkCPdFoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzMCBTYWx0ZWRfX/puoleKDqnuN
 HKoaM0F8nAQG+pq0gNNWxYZazEFSaIX6gfz3/T8jgx6UEHHOfErKcUCrqjrd2hafeS9F2hVP5B3
 YZwA6b6oYzKBqtuFGRSPbUF1jWTvaKE5/sHs0mKaRBYOnKSIKvKt7V/fddjYt7JpCL8BTIrW95D
 Ty3/X3o/E48Uaiz/+9tYIjWQN3keJZtExMyiwX8Y7BuUhGM/abUSxiozvATund989aG/wtiJB1H
 OHm8UP9KXzWbg13+bk2k33DM6t74ndiLqzZKOC5uZteo2gcpRVL8R7dId0SLFe6o23IKNmCtqAI
 9f1UDoOEaKg2bspQdS7b6p+pCv03qQUbdxGm4nYR9qklVSPbbJT7wGJM4LeYKgcfgtmZlSy4pPL
 6J9S3MzrF+vAe8lDxD+pjwrmlYNR7L3hDPEzgLDCSGdd2BORhZ9A8gfu2JI7YCv9IJucVPIAc+h
 060O7O2PCRRBYhds+ig==
X-Proofpoint-ORIG-GUID: 4cFMcbYxkJziJD1uMcKBfziBne0lirSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030130

On 6/3/2026 1:56 PM, Pengjie Zhang wrote:
> The conservative governor documentation incorrectly states that setting
> freq_step to 0 will use the default 5% frequency step. In reality, since
> at least commit 8e677ce83bf4 ("[CPUFREQ] conservative: fixup governor to
> function more like ondemand logic"), freq_step=0 has always caused the
> governor to skip frequency updates entirely.
> 
> Correct the documentation to reflect the actual behavior: freq_step=0
> disables frequency changes by the governor entirely.
> 
> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
> Changes in v2:
> - Update commit message to reference the correct historical commit
>    8e677ce83bf4 instead of b9170836d1aa, as the original implementation
>    had asymmetric behavior for freq_step=0 (suggested by Zhongqiu Han).
> - Link to v1:https://lore.kernel.org/all/20260529111122.3321645-1-zhangpengjie2@huawei.com/


Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   Documentation/admin-guide/pm/cpufreq.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index dbe6d23a5d67..98c724d49047 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -586,8 +586,8 @@ This governor exposes the following tunables:
>   	100 (5 by default).
>   
>   	This is how much the frequency is allowed to change in one go.  Setting
> -	it to 0 will cause the default frequency step (5 percent) to be used
> -	and setting it to 100 effectively causes the governor to periodically
> +	it to 0 disables frequency changes by the governor entirely and setting
> +	it to 100 effectively causes the governor to periodically
>   	switch the frequency between the ``scaling_min_freq`` and
>   	``scaling_max_freq`` policy limits.
>   


-- 
Thx and BRs,
Zhongqiu Han
