Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFBF35A395
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739231; cv=none; b=FZ0ebACAX3DHG0yk8rFD6vb4RPv6Upb8Uete88eVwKeiUIPLWABKFsVzyo5mNTWr3+s0axmDURCV27DDcrCM2H3Dv5fHCbbV0HNMuirJ/kaFXT+ic9l2r+B8SoWgEt7gzWw1kQZfvte9SyBUl8eA3ggNDm32ehSLHjMyMzi6KZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739231; c=relaxed/simple;
	bh=iBniWLLZnukifzCJcu+oeWa0IDqnSCjoESx57tYs8JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8niiudt+f/wYhAIJi3K+XLYTcwP1N5bIMNY04E5umrouFPykiAbmV4kBszr0c9/mvbMYCJrb0el/3pHUna5pdof1+v2pgRZ6sdRafaqbwCpaW+3eLZ36C/f1PAtnpspR4P3pOZXe/cm+pA20oQQjCpI0IzAUKdZ7Zfvzr6JSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctOeVfXf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UgNKGPel; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctOeVfXf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UgNKGPel"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7NM5Z1639254
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 09:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nB8yW7oBg+ycexCmqJuKCMGqgJI/XCsDm+XFn5tPwmU=; b=ctOeVfXfm5OPrUt8
	gpnCJeHMFjzsRsfwApv5JgkdVC/nvQkFZFYkfGkzAYCDS4YUjOfOhrBc1sbiWuoX
	mOzPiqPvBRFCWOF/pPZKHdQarUvM8Q8WOqpFbzVPbhnyejdKoyTYFzrwt+ESmFY+
	CrwAleZipnL4LJ8wELa8EC4cH1X3BtKGNBTZBbAgptbTtHYMkhi62NP3o9Gf3idg
	sUnsXcSYAYRV+bvjLaNGpSx/Cm1dPlLnjdAGcrPJTmcpE+35PNj4wMgSVUSJ+kxG
	hpkhrYFPijZaGO5KaFpQFk67Ws1mFQIAj0cQPC3szM32WjEZvrgowOrBBjAoMVk6
	yq4wIg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke0bjqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 09:20:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b06395b8deso11192405ad.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773739228; x=1774344028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB8yW7oBg+ycexCmqJuKCMGqgJI/XCsDm+XFn5tPwmU=;
        b=UgNKGPelcUCktwRFuaE1RH2Sn2WmgMTChsEjMild5nyrtadv5Cu6+0aBa2wMai1zr3
         815sI9m4keLkGgKX/0sYp/Cz6v8QCl/BE0Dv3xpjzQR6w6YVzfH12QrOmZdrWegjPHXY
         TErjJiqYkUsOyjoxJ2ysKIKtZmlM8WOAzBRaOcH60KK9NiSRUaP7WfqX0uavZMsyQEj2
         NOZtbHftWesyOcPQQ7lp47ahT9aDlxHDQc9lUJrBuKnRS3cKkO446TO8EgMaI03291Ve
         TkwfX1Rv+C+EEiExWz1QJNWF3JXBdRdpQEt2d4ABUo8puTTF2WwRiRehmV9lN6XisFgE
         aIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739228; x=1774344028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB8yW7oBg+ycexCmqJuKCMGqgJI/XCsDm+XFn5tPwmU=;
        b=Pcl1y6Sw7HTT/CXZ3EhfhQqJUlwNfVAVbZwZ3JDAJfxBZuZ4+pYfnwC4KbT95O1CN9
         ZfKF3lRwifyx6Gck8zh1YA+ZswlElZS8P89U9fwykSPfCVlZxN7kC11zQjOnRs2cDWkC
         Of4QHwFPE1hNBl46ra4lP3CvJ2uuMVlUYedZa83EdxQUGgM2v5oUsRu4as/cK9IQ9BgY
         cjgInr7TKMY73Kabl4LJPq7KUtbIXDGPfFWgeRYHaJOtE7FAHK36tM6KI739AjTNvCo2
         S4i9p+eSnyyE2bMXvGVYZPvJ+ceeD5D7ncvYFsEvyAOGEbRFxXBP+rBb90QvWKMFnwo+
         09cg==
X-Forwarded-Encrypted: i=1; AJvYcCXXL1OqlGvNX6qZAXp16l3j/2PCXd2usvDbIRvI+XMpCSVDNI+YlHudwI3VmRbbFquA+SFc1rqB6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI00reA3xOfvJq/wX4YFnEkV8Xvj/6GgYfJmmO2us1hn9D5Q//
	aIUKJE4LVf7pyIwZNucotsHPInSEQ0tySMrC6TXtvsFewqtjkc2WRlQKjvlPvdQLqP3Bv4/jjFS
	vSqZx3ta9KRAEYUCLEz8UYMM3UgSs0S9XXMlbIfFYTCuBkEGCy7sYqoFqRX5U+Q==
X-Gm-Gg: ATEYQzwVlI9yQbh6ZNYIepStzEyy/o+k9TUUaIBOOTvxNIJcDJzqW32u2Dkdj3/iJb+
	2ahZGNd/y8sKz07ulhROSNsjFcuao/L7SMxOlgGq2lKD92nWy7myMmFAyK51TO0rGBuu2YtYPEX
	+81ox3wAlMIZa32VFxiNuY9g5c8f/TKtBZ/zN7BndxJDFU6QLMFD+3hOurT0qppcdIYogawt3hU
	98ozX9nG8uQgTEZh/j/eWJ7+QEyKs9Np96Rrg4+j49GvLP7ijcnQ3baDkwNyM3xEOkY2o3j6gwW
	/IxeOXV/6xORUMntX8+zy7NlNX2IJMML3l7tpao/OfHdxKra9XvWfKlk2oiEW9/boFD3qzsJXf6
	NoZ8A47uf5Bs9TtZ3qvI3cQDWzkDN9rSJ5amnJRwCKRrvlTk8eJrcx+XflMU6MCpDWsMpwmtIXR
	cH8bKO5k2fyAAGtnk/Lg==
X-Received: by 2002:a17:902:ce10:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b06b985bdamr41225ad.34.1773739228456;
        Tue, 17 Mar 2026 02:20:28 -0700 (PDT)
X-Received: by 2002:a17:902:ce10:b0:2b0:6b98:59ec with SMTP id d9443c01a7336-2b06b985bdamr40945ad.34.1773739228006;
        Tue, 17 Mar 2026 02:20:28 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04e5cb3dbsm105952865ad.25.2026.03.17.02.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 02:20:27 -0700 (PDT)
Message-ID: <e2f6637a-93b0-4f6e-9867-8accf6aa940f@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 17:20:23 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: optimize policy_is_shared()
To: Yury Norov <ynorov@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>, zhongqiu.han@oss.qualcomm.com
References: <20260314192544.605914-1-ynorov@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260314192544.605914-1-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Zrj_-D_BJAnoHdjDMB5jGEV7jQfR6BOB
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b91cdd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=QQo5Q8axJbk09mazrB4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4MiBTYWx0ZWRfX9Wc5Vxd/2cs/
 2N6Vi6alAIKuZVuzbY60UF9aPmCYCz5lSrGZEGXUOnQF2SYTMeTwv7YaOkVan+9wJmpqsnZVgBA
 6lXEW3R1z/Y8MZ+i9QuPJ9W+BkqnqVRNPZ1cgXQSPffs4MMp2ro/EkXld+YG302QB7N+gUD+yQc
 9DyCeJLqtuMHiHZrb+VpA1QRYAigSpED5TqlrDrlj0JpwcS5cuEu0aeokGz90ERzbbVWUJKrWrX
 heiV66FtdRf64/jrU2Fnc6ghvINAuL0kbVjI4+J3tHwXXJzBnQJUZ0RyeN+3JsDmhooAT356JOV
 DCCbMZGh/D4QGLjEUMLVSz+cSLDId42ry/dYqjyuKX7/YKAOFqMEDSVRqeuvEGot9g9g32DROIr
 wbepkBYX+yprhkvialiKzT4iHjvkn+2CSZAJC2PVKOKsrfI5MppS6M9vvUnalYQv9n7voQgYEJd
 BK9p7gIGkVa3gAsy0LQ==
X-Proofpoint-GUID: Zrj_-D_BJAnoHdjDMB5jGEV7jQfR6BOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170082

On 3/15/2026 3:25 AM, Yury Norov wrote:
> The switch to cpumask_nth() over cpumask_weight(), as it may return
> earlier - as soon as the function counts the required number of CPUs.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   include/linux/cpufreq.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..8ca2bcb3d7ae 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -232,7 +232,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>   
>   static inline bool policy_is_shared(struct cpufreq_policy *policy)
>   {
> -	return cpumask_weight(policy->cpus) > 1;
> +	return cpumask_nth(1, policy->cpus) < nr_cpumask_bits;
>   }
>   
>   #ifdef CONFIG_CPU_FREQ

Thanks. While I had a minor readability/API-nit earlier, I'm fine with
the patch as-is.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

-- 
Thx and BRs,
Zhongqiu Han
