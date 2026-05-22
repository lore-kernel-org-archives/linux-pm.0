Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0825487C
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428431; cv=none; b=VHX5TEEc4ydsX8MSPLteCfiLIzqMzB17srStG8nNtZI1MYXa58eTI/RVRmP8YjUIRwudok9InnW6SPItRsbMUcJV3pGluX2fgjiA3kdZBgJXlZYi5BRD31BSEEthiTBC76Ji/PgJd5UFCt2vDLpz24buLIFFsGsDr9Dqa2av+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428431; c=relaxed/simple;
	bh=0cPudROcNvFUmJnOoptTXlofQ0YAHPJEaiTCOFtv/iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAUCveB6m22Os61JPE5I1E/Gefa7KSqBqIQhT5E/teoah53D4VCd/F7Ut5K3PNkOPfLeWTMAEWvcQFAy7c75YFcDYr2wLOp4MdHCdsNWhKHLaGuyu+92XWdKUO0raCAgHuLIm3HuBZ+E66gRb2hPWL3jKfzhga4xZiBwFVwD/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IzZr0hZj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKcZNpJe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzZr0hZj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKcZNpJe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M3gZtI186257
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ngxnF0u9afi5oKExZod7l9Sw9Qq4rEIs2c7zolCqfWI=; b=IzZr0hZj+g/7eYVD
	5b0HwPyCdVZ02Zj9+N8LwInc3H5OSHBatPiAoa2q0Jc1VvotLtklzZJ8bT1Li91D
	IxoP4wGLC/y4AFsoyvzcvOHoq6z6g/p22EcpBVzO9ZYGHaMZuiRieyG37rk1zepq
	37kzYREDgyTPgwAC/Y8SINDjeCM8m3jRAAgVoTWMumEBJBKEqNUp/rzACjGr3dHz
	615moKUjwt1NlYooBmKUtrIXaohEM8hVeavCvr0v38jFMJy1HUVUbJ9kYQRqjWSJ
	w6KzE6WQtOcVZxpDhwLn7FmlO5DehFFkgJuKBUWrt8OlLrHRj+2dYsDgUtIh4et1
	Q52x6w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahw19x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:40:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b4530a90fdso125551315ad.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 22:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779428427; x=1780033227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngxnF0u9afi5oKExZod7l9Sw9Qq4rEIs2c7zolCqfWI=;
        b=RKcZNpJehPJh6wAB1BfG9PrYPhB6C9cRTwdj63VFbJKM6485kRO0MXgNfPz22/xYQq
         WW+5SwqddtFPv96sG7hyulLvk5nBeXMLK+p2nvabRExpFzbGLzp/bStb8aEVJUg4YerG
         AUrryHSDAQuzSFZL4jhEpJvRDx3oYEAt6VnDHmO+gYx6VcgKTwHI+ufw6kGyZo4RxhVx
         ZYS1EVgLcSqtZtTzGOCljDxsmpKUPGmecInnSXiudcJeLVAJK1I7YPeTTkgYBA1Gh7ad
         TvkKSY7AJ5o+Xmmgjj8YBrbv/b9KegWwFpKB9VCBr04nMiI8m02jdijksilc1BdFigNU
         T8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428427; x=1780033227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngxnF0u9afi5oKExZod7l9Sw9Qq4rEIs2c7zolCqfWI=;
        b=Q0Wb9Z0A/WABQZn7wNpPW4q2YdOutgTjFZjNAAp9+lMz9a/T+KfKQDcbmJJXATfRqK
         x5yTy37Eyf6X2M4j99/sQoKZStn21V2BDPcpXXAu1w6F33qA+2bTqXqbMsRx4+FJrTAw
         7A+lV4RpecqpuhXsoWfdy2ccpPJTeKNILvu6NBzQqHnuffVf6bemj9pO56ZxOK7be0pl
         T0O+FbCSEGctbfvz0w9p2rArBzcW4E53uu78AtDVWIbSPSmebn+YiTyp1f+pWt2jB0Yt
         6e0WWK6OjARc4K34lLZvqXHKnqyU5vQNCY2jVNKUJ0zrl1ggnHuArGFmYxY4tyukA97b
         mbag==
X-Gm-Message-State: AOJu0YzdfQLTM/nDgTnTMYKIV0IfJsyN6++3cmNsF5UoQYnKwrkGMiP6
	B2tnQB1ylHfcCM/c35dyRY9TxvTetHYq2wc+BGo90MoDCOvQuFt0VFge7ahHeqIYwkoZJU0nowb
	G7/w/hRVX4YOkVjl7tgg3LfnNL9X3GJ+m7ogtaS6ypKw3/rz+YjyBuiqKMUXUyw==
X-Gm-Gg: Acq92OFRXiuVrn9cwPoXEXuS/KDnaHhuwvQ0f31ynDRXxs+O+p542QEbY2QMQGFPwnB
	EnLTPSpFtp4SQtA8EJTd3mHscX1T7dOwtKJm6X3rRcHjGmESiGEvOPhOzHrOL8Wg5e9P1kbS4AN
	ngjA6ngcp/Lcs4Ar6/nJz6s1H8QkqQL0N34n/ZZK+XzDOf2aXKHbMWGi7zCgMn6ZI4FSAaXmMoi
	2sO9kD8vpgz9xV7SKVMD3Ksou8xB/vJnHM805gMQPsqKCzKqEopm7O8PJ3Y1JvFkdK3B7OlDtVL
	wXF9QWWekMC9fqdLU15PBXkLWSgW57liHAhhx/uYJJRFE4vU8qjgjrsVD9S9ZOWD6+wY7ldqU/7
	nDxJDpGiTLTjqDvGGB2OptmRGhIxDO/BY9lX8086ts7mEWLlhws+NkqZHTHjLUq6lvm7YJtxJrI
	TbVDRW7WXfjgKqj59akw==
X-Received: by 2002:a17:902:e88e:b0:2ba:6ca2:bd9 with SMTP id d9443c01a7336-2beb07032fbmr22494415ad.41.1779428426732;
        Thu, 21 May 2026 22:40:26 -0700 (PDT)
X-Received: by 2002:a17:902:e88e:b0:2ba:6ca2:bd9 with SMTP id d9443c01a7336-2beb07032fbmr22494065ad.41.1779428426246;
        Thu, 21 May 2026 22:40:26 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695b2esm4120785ad.4.2026.05.21.22.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 22:40:25 -0700 (PDT)
Message-ID: <73d4fac8-9b49-4872-807f-8a69219aee7a@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] cpufreq: conservative: Simplify frequency limit
 handling
To: Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stratos Karafotis <stratosk@semaphore.gr>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Lifeng Zheng <zhenglifeng1@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <cover.1779423281.git.viresh.kumar@linaro.org>
 <292e6d937890f135e30ec0d2107eaad47cb9a976.1779423281.git.viresh.kumar@linaro.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <292e6d937890f135e30ec0d2107eaad47cb9a976.1779423281.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1MyBTYWx0ZWRfX/OvMuKIzEIPj
 xnVRW5v/LYVpItjn8pS9yqU65Zy+ZEHyLRO4WvELT529B7QCxBSgEms0qESsCml4ySWZ/UbIDvl
 nOmCq8ThdnP9ap677BOMAZPdG7AX6CeBbv/mPiFN1PoxsUDXXVZCQ/Wwsbd1CEFlIYizSLqCYoo
 5c270F61Q1GGGwOiGI1T5obbVzQkKwJfnc/LdmsfpY+cD83nGJAMnwf751xcZ2jCz6jOg/EmHj7
 QGHwzDVraJU4cIBfsEWRb4bS4bcGR0KFjsNwqxVcTX2ZEPqLXsAKJ6QHqRhbxdWTacWNeIn+8gz
 +JBK019qIlN+581wnc0X0eiXWh3GIEmKBOw48ieu0EuGL+YTsWgLd4WulmDQl8zkXUyK6682/vg
 ZK5VN83C+6sSFt1JD7XD5fn/yQzcIfqU+Fm4ZbdmvA5j3e4hKRvOefpep3rOkS43mRujaxngJuJ
 2i968UDwTFIswxn/W+A==
X-Proofpoint-ORIG-GUID: G5qcnAfdXdv1V0Om7lU51-m-O689d561
X-Proofpoint-GUID: G5qcnAfdXdv1V0Om7lU51-m-O689d561
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0fec4b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=xinJjMVPPjMSk5ikLX4A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220053

On 5/22/2026 12:19 PM, Viresh Kumar wrote:
> From: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> cs_dbs_update() performs explicit checks against policy->min/max
> before updating the target frequency. These checks are redundant as
> __cpufreq_driver_target() already clamps the requested frequency to
> the valid policy limits.
> 
> Remove the unnecessary boundary checks and simplify the update logic.
> 
> This also fixes an issue introduced by commit 00bfe05889e9 ("cpufreq:
> conservative: Decrease frequency faster for deferred updates"), where
> stale target comparisons could cause frequency updates to be skipped
> entirely after deferred adjustments.
> 
> Closes: https://lore.kernel.org/all/20260421123545.1745998-1-zhenglifeng1@huawei.com/
> Fixes: 00bfe05889e9 ("cpufreq: conservative: Decrease frequency faster for deferred updates")
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Co-developed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Thanks Viresh and Lifeng, this looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/cpufreq_conservative.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index df01d33993d8..0b32ae28ec85 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -103,10 +103,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   	if (load > dbs_data->up_threshold) {
>   		dbs_info->down_skip = 0;
>   
> -		/* if we are already at full speed then break out early */
> -		if (requested_freq == policy->max)
> -			goto out;
> -
>   		requested_freq += freq_step;
>   		if (requested_freq > policy->max)
>   			requested_freq = policy->max;
> @@ -124,13 +120,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>   
>   	/* Check for frequency decrease */
>   	if (load < cs_tuners->down_threshold) {
> -		/*
> -		 * if we cannot reduce the frequency anymore, break out early
> -		 */
> -		if (requested_freq == policy->min)
> -			goto out;
> -
> -		if (requested_freq > freq_step)
> +		if (requested_freq > policy->min + freq_step)
>   			requested_freq -= freq_step;
>   		else
>   			requested_freq = policy->min;


-- 
Thx and BRs,
Zhongqiu Han
