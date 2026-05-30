Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC873043DC
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151789; cv=none; b=qB8gfkdVv1ZC0amzR6h/z1baOBLm35aJxgbu6TpmOuvRZMjmKShaYy0eZniqdNsVCHfvCK9HbJi1S4tQC2jsak6LcatdmSRv3veZCr8sv5duEFwjjByMFNbL+ZUVGGajKy4CmvO3IihouKhqfWxXs+ciNCrZbGUl+0B4MiY+8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151789; c=relaxed/simple;
	bh=ZQvwa5QhqZ0lknUAWLawA2kfa2GO39ZYXWv5ZD1xNc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho0HDrd4TGMALHZu2PP/4u4f2nEuex8HhW7SSWZnvQZ91DzCfCYMXr0nKUhRHQVNJ3toPNrcxfgyqByIjd2e9uwK/2YABFsMWrYlTqavSCVq0Vdgy1+L+7MIlaOGdpaV2EpJN3Aq5bprgm7BtMbId2SY1jTTjvEDqDNLBXJS9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jrcTkCVk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NFMr584u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jrcTkCVk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NFMr584u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEP4k03121744
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 14:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MGZWr5Rpb2Y4avUOEBasFCxfAQKOCAbmy1aE3NQDOl0=; b=jrcTkCVkPRvYXV7A
	8LcW0QH8UaY4Gj/K5hOPYp4i4FIGxitekbNWjoFUH+/GenDjQwMv9kkDEuQLYb49
	tNEWqp+V4KVOksDtkOBSI+6DhmfbBhXBAKusJUHagOZk6qG0Moq9kmrcWhPlsVaW
	AlbalHsiwX93Xed2gNogTAAOxbgABn7+c9xESjOJ689HjGby1O8Ul08v7S+aSW3v
	z9SZbTaO/dj0cYRmeuD4xQVOT7OwRcBALwuvObDSdYIlC03wA69e5Tz7kyFNPlaa
	xBTdnMn2/2bmeaBvFedlA2+UrbkgTD3cqXUUEw23ueHsQcJRZUzW0VxLwfz4cmnN
	t/LtSw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7ra8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 14:36:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842278a630dso949766b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780151786; x=1780756586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGZWr5Rpb2Y4avUOEBasFCxfAQKOCAbmy1aE3NQDOl0=;
        b=NFMr584unBTOVbQ5m2eMkvFcYE1kmS/xKgEAN1A8CyybzN+He61tSL0BPQSGvCyGG2
         b7oJ/3u2jyQT3OMWF+iHPknCBww420eh1B9OzVfhFh6+hSIp9AixWCNVJUB1dwjoNJrw
         J2RqGbLxTGO05smIWUHgy4/qGFutl1SOB9IrVIWELJBQ+EiRSZTE6yqYnbgvrL8+Z3uu
         v6nON3xj1UnObixmwdU1XsGiQPCC1AfpXmdWXMOLEy0acsHj0CiTvqU0nSg3s09aDANC
         SDUpLcXkc5vdDn997Yj/u6ynAsOA6HbWjOG6JI6EW+fOWK+OPqyUSqocz44nEMRLCgzz
         x2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151786; x=1780756586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGZWr5Rpb2Y4avUOEBasFCxfAQKOCAbmy1aE3NQDOl0=;
        b=bcF76C5gvy28TvalvKPy2qeTHMo1ZiWdT62ZDEeZ7A6yS9dmpr88VPDOYK7uBGi6Ox
         FwrxsSPf/I8AxnaRYtiD7MwI28m79hCkEnKSmP7TEx/QHZc7ndl3we0SNlhW4nT/dfwv
         wSsfeuIowjyhSNCmlw015KdcNvcvD/ccEV0/Btu2HZs1JtVcpUWFCdqPkiyUzUnzoReh
         m2wcxxa/GtnVAxsBdIMaJpJjhq5umIvWcsWCbEmG0JDFa2kTBB9m/fWDXM3BcL630xvN
         GJ+59w0M8mtxU2Hkiu4z7Vj/9M8q4EReRqGN4ETJdWqb6uf5Su8E+zrTr+m3aF/OwX+8
         JvgQ==
X-Gm-Message-State: AOJu0YwLl3ZAAKp21h36M6K700TOGnLMQMqP6f3aKLP/PD8UaACbbs2k
	fXZ0h/wjdEpF2fG/zHLu+ey1LogFDnCitGNfmA/fyyPsmr/dMsBDk7XsC6nDbQ56C6Eqh159x3O
	7y7Lyh2cnecCi59zerj4f9DCtml3T3Ug1St+JoQXs0kpnkYbrew0ZylC+RP831g==
X-Gm-Gg: Acq92OHB5+Pq7qxvBAzxkCdOd1PlUzVcoCkgO7It38aDN21YVFQIwg53paMcUKcGvV1
	NPoFB/p2ieeECWiJmDATmgCaeQiNlxfhHAKpWkR782FxATa9N1Ynp3MNxP5JNIL/dZ9/ZU8suBT
	SmXqnv701jUPTROPaqLeqWO8VlTosa2W/oluLLwHdfu5XoSPx9N2RyojbYi4CXKM8eeltyzX5MJ
	+JBxB5sd5z13EmPE9c+jjgaNh4qv6YTnsM+Kcc2pLIvrWRtBlIZ8F4poSqIcASYpR1ugaETsgGN
	5258FiHBeGUUAPb4twr0oNQ+WEq1PvSoIN2v/AKFgQzz10o22VRKCV7tBBYDFjb9Wlm25CAH3aG
	zRXa3DzCBGdvfY9TikBGO0HVFD64xcAWlfmWhfF6WQw7+zFHMOBND2qY4Q0JS9+vSm8zCNieTgv
	H7HW2mMWwfFhB/uE5bRw==
X-Received: by 2002:a05:6a00:198a:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-8422543b832mr3803707b3a.27.1780151786036;
        Sat, 30 May 2026 07:36:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:198a:b0:82f:5051:f024 with SMTP id d2e1a72fcca58-8422543b832mr3803681b3a.27.1780151785523;
        Sat, 30 May 2026 07:36:25 -0700 (PDT)
Received: from ?IPV6:240e:479:e20:9ea:c59d:830f:a161:10b1? ([240e:479:e20:9ea:c59d:830f:a161:10b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c954b3sm5088546b3a.34.2026.05.30.07.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 07:36:25 -0700 (PDT)
Message-ID: <f598e862-8120-4922-9d04-6e3729187420@oss.qualcomm.com>
Date: Sat, 30 May 2026 22:36:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Documentation: fix freq_step description
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, corbet@lwn.net, skhan@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhanjie9@hisilicon.com,
        prime.zeng@hisilicon.com, wanghuiqiang@huawei.com, xuwei5@huawei.com,
        lihuisong@huawei.com, zhenglifeng1@huawei.com, yubowen8@huawei.com,
        wangzhi12@huawei.com, zhongqiu.han@oss.qualcomm.com
References: <20260529111122.3321645-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260529111122.3321645-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1af5ea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=i0EeH86SAAAA:8
 a=Zyhr3UL3YfEZVkCPdFoA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE1NyBTYWx0ZWRfX2zW/qepUovZk
 Gbeys2UvOb7qyKjXM7BLOCzyZ4c5HMzbtB/ujlq0zB1T2IVg2jGQTfuu5hf9+9tn6Vgony8hwKJ
 fE6oV2PLpPHNwRYarUV+jhDweL3rN6A/7LMZhBx2RqKUl3jgoDVCv+ghH8zuyAPf35YUAQODpOP
 wzNyQh6usIGqd0hHc4loWDlfjZFRp8dhhK4usvFI8nxpg+1N9QlGBPaE6P4CZ0jf64fJpeHLMbt
 pxIke9i+zDiZGBDGMiQ2lhZUMJ3HEeaAMPEj5aIxQAB+QpE7AtYjCe8lfDQN92OSb4U3P1S2U4l
 ii4htUzUwbgk8XDdxHDq5HagMNfWoQHvLD1BmBDS6HVN5WdKtO3iDYz24Pb9YqsW/EfPoYnbceH
 PJobaH1Yy7uCUqzpPpPUts1w5sgGmIr6fQ/bteEr53wsxdk4VoeqjPME/SmFBA7y7WWsT3H8dH9
 l6ka4dJE8Qd+esp+XNw==
X-Proofpoint-ORIG-GUID: BN1xEvKFa4y2M6BuhFWSg7Zy6OA_kPJA
X-Proofpoint-GUID: BN1xEvKFa4y2M6BuhFWSg7Zy6OA_kPJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300157

On 5/29/2026 7:11 PM, Pengjie Zhang wrote:
> The conservative governor documentation incorrectly states that setting
> freq_step to 0 will use the default 5% frequency step. In reality, since
> the governor's initial implementation
> commit b9170836d1aa ("[CPUFREQ] Conservative cpufreq governer"),
> freq_step=0 has always caused the governor to skip frequency updates
> entirely.

Hi Pengjie,

Thanks for the patch.

The documentation fix looks correct: in the current code,
cs_dbs_update() has an early goto out when freq_step == 0, which skips
the call to get_freq_step() and all subsequent frequency change logic.

However, the commit message's historical claim appears to be inaccurate.
In the original implementation (b9170836d1aa), freq_step=0 had
asymmetric behavior: frequency decreases were skipped (early return),
but frequency increases still used the hardcoded 5% fallback (freq_step
= 5 after the unlikely(freq_step == 0) check).

If so, would it make sense to remove/update the historical claim to
avoid the incorrect historical claim?

> 
> Correct the documentation to reflect the actual behavior: freq_step=0
> disables frequency changes by the governor entirely.
> 
> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")
> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
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
