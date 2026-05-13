Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD8428468
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676794; cv=none; b=PaV35oP955+qbz2h5hC3hstz23ECkyYbN77Bb5GqmWvcPeCaf/MbR976WUBINo4M9I/zAyewNWpSKZjGkuwKIKxsUdhyjyc83GgPG+P+0QJWptm/IV1/M6YD5YwJArkZzOL9QlgsKN7QgvyTS8PqTPOKF5MAJJKww2YjIufy8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676794; c=relaxed/simple;
	bh=/HH7haICvL607AxS8hNW9kSpLZhGR6SydcI2RJVfWCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtDITzThYpddev4LTWNxy51S8+zj+RGm9md2oYab/Ub1P71lM6TSc5nRKCZVWvdeh9wQXqgpdK/l0yNIyClwmt2L//WCkpWXxo79XK5ajCs9mMONwhHCm0DT5w8dFrz2c60Up4XCSZyLwuqbe5rO0n37gTRydMUaZr0DcMXTtkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AqiSairY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UU7Oue2J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AqiSairY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UU7Oue2J"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D9k0W33008285
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aTLeqmMmfK12s4Sze+pZmjyLHuMZbfIZnuitTDsnOuY=; b=AqiSairY52agx2UO
	eVjuap63L6tTx/GauCDW4xJdqb+fclI9bH3ImGBjaUisyy8Qlp/qP7hdlY0idlY/
	M2DvLTvldjKK1GsrRt4DfkYEDmS7cqbi3XV03Zo1pAf06KR4cv8nWez4pJ4Mwez6
	G0IjagL8hTQLnAxh+BeH+esKtbfJNI3h/OSbtTmwU48wEh4RtZCvsgyUFqzM5PFD
	NDtUfQlpiVcf3xy1wGz2IXTiuVQEFyd2qNv15myxvQ2WJzY07tcOIpsfcVUoZsPp
	gIOHOLEI0b1QPjfpKq453c8kfnhlgl8daSvM8ys5IWaT3xU7Ie7s0CKovqMJOsaQ
	mVWAiw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0gmqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:53:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso4399020b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778676791; x=1779281591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTLeqmMmfK12s4Sze+pZmjyLHuMZbfIZnuitTDsnOuY=;
        b=UU7Oue2JGTyMNnjjkyaED53TpVHaLWiCMU5SSOXmhITEVNiLs5wonrNmphd8LdZYXy
         wQXIpY9nwcjQVuUZkxvtJUCmYggxkmxV9qPk+XZTfogUoNXCDF9W+3cJ6dVGFLcuN44d
         9DO6MPBs6RTCOAu71HsBydcNEaZL/wuQb11vIE8pKQ6ukZxDodOJqJpqZFGgMyS4zLDl
         F5QNpyQITdbSbrJ4AV1UwotBdyy/fHuUc75EZMPu8Kouk7vbIbdyCDCPJnbax4o66Y4P
         6EOeU/2ZjHRYysoOW5HoFrt2/eV8eJI/1ckHuGgn3JpK/B7b15i6yn/YDsA/OGjkEgS3
         xsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676791; x=1779281591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTLeqmMmfK12s4Sze+pZmjyLHuMZbfIZnuitTDsnOuY=;
        b=d2BPz4Nh6FrbepcJ5IxM7aWpQI95MJZ7OCyMw40+525t8wd2UfoIZpWrcqhqmtUldN
         wx18WF0Fx5udXV1z+cbkM2CcV3/gqrzYjWAqGqXGzbMoDNhrpX3wBFAowFkj1znW9fno
         9btRoyvG9eefVOfhMDDfHgI9ORO+YGc/zDWR/oL17lq8tuyEnnu0A1GYrRm3ekSLenZ3
         5DAV1wkwZy74+aZd6GIas0c/Rn4oesyJKEpBDureTR6GZoaZlXXbWN8W5gPXpxR8sxyN
         kC1LKnK8h/X7+5DDuELm0le3pR4sWijiB/PvarlPPSYDgRrurYMkRuDDDIo4oze+NyZ8
         5NDw==
X-Forwarded-Encrypted: i=1; AFNElJ8VUj+ZhlUY0f6+IQXu+ooOf72lVzdi1XvfhUCQ3g5MdHR0n+EaX+SmDYjvfvu6al5EE0KyzIEaLg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8TIM42kwwpszbxhAdZ8lv2eYN3/X33D5PLW1zop3Bq7EDnBW
	cjRN+3X3MHtUWw9ax5BRUX98dYqgCi1sa4qOZ4fD2/0YipYEK8KBuBT5E9N+E/LjxUKBjsnbBFL
	e5oXsoIZStgfNyca9Nq1N6k28aATZuIHe5EnXC9KD7IaGp0mRZgW1LFFLlZCGHA==
X-Gm-Gg: Acq92OF30UOV8NIYTWGwY0w/eAAaB9C4rwFfmGvnAic/nfVyRwf2rPaZXjAdEa3jlU5
	iFoGk9p3GmhWD4Lj/T43TGGLVVarCtnoflC7zwY3ok7Wqqoz5DrGQrvi7icCb3P+zVpKulCZKv9
	1Q88oLw1V4xSuCktXezFl2GqB3jylhmpq+zkJ2w0rdd18acocggkhVlMVT2SBI0utVVqbB6lLNZ
	AtY55Ng05OG60JWQ6w95CII+QsgRuB8yOF2LZmvmeuQMtX9D4Ga9xYrdxPWvN3s2Wx1zZuHAAsN
	VKHXWdhIQKKv9K1AI4S8p/JyOimXdzPxNXCPRmKpQTTWdmMyNbqCZ23WV1odM9ZIsg9eE1LuQY8
	emeZgJsNnDtwi94G92NIAmbh/hnPAr5DXM9m3thwQ42ExzMMbq9pRbbxTmQYOliNjgtQusDJWQu
	fVenv+Utb/dPy6ghdoXw==
X-Received: by 2002:a05:6a00:a227:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-83f04fd7db0mr2661199b3a.0.1778676791364;
        Wed, 13 May 2026 05:53:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:a227:b0:81f:ac81:d597 with SMTP id d2e1a72fcca58-83f04fd7db0mr2661165b3a.0.1778676790867;
        Wed, 13 May 2026 05:53:10 -0700 (PDT)
Received: from [10.133.33.247] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm25421224b3a.57.2026.05.13.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 05:53:10 -0700 (PDT)
Message-ID: <f45aa954-fce3-474a-a2de-916b4bfed542@oss.qualcomm.com>
Date: Wed, 13 May 2026 20:53:06 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: pcc: fix use-after-free and double free in _OSC
 evaluation
To: Hongyan Xu <getshell@seu.edu.cn>, rafael@kernel.org
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
        Slavin Liu <220245772@seu.edu.cn>, zhongqiu.han@oss.qualcomm.com
References: <20260513120639.894-1-getshell@seu.edu.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260513120639.894-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEzMyBTYWx0ZWRfX3XcqvOuio8nj
 Azq7lwqfWYb133J1hGkgKjCaSU4nAKRVtTQP+pbzQixlP5DKQQUxJAniAb/BEcrSsIaeTC2c+c1
 WYEGCDY8OL9cvafKeJEOj7zoNwCi5xh6Yd8cqXm48oOZvsV30YX3DttQCZTeKKQxEKqb+KontWU
 +P136kkMade6V7TvSE4HjGljgNkxdOcxZsJMjmou0g17NUWl2FYco0UOoMPbnAD4tRpRlDFCRJW
 dGSyAGLjIGFySc4Btoor36ysXxuZqeR0frZ29hvBK/ZOZc7bLuvIl24lGAYxKmNu7GuyCM9BrYC
 Eb4njwSnBo5yQrjaGJXyS0eKkLG/bEtunBdUs2INRfJ3g9mk5QFWSbOaZRdmlqgqwVFJuy18YMG
 KMfKzWgXrdW/fqImD1y28rN9NSGDfvHDh8LwcKESL09R/SBCLyNOgdQa4Bx1SYCqz3cV269uJSN
 mP6OvBVE6JHVKDhHuPw==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a047438 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=6qQVmtZs7bol9fj5NwoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: eU5MOIy86zj8WGj1T9E3n8SBCMeRaY80
X-Proofpoint-GUID: eU5MOIy86zj8WGj1T9E3n8SBCMeRaY80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130133

On 5/13/2026 8:06 PM, Hongyan Xu wrote:
> pcc_cpufreq_do_osc() uses a two-phase _OSC evaluation and frees the
> output buffer returned by the first acpi_evaluate_object() call before
> reusing the same acpi_buffer in the second call.
> 
> However, output.pointer and output.length are not reset after the
> first kfree(). That can make the second acpi_evaluate_object() treat
> the stale metadata as a caller-provided buffer and write into freed
> memory. The shared out_free path can then free the same pointer again.
> 
> Reset the output buffer state after the first kfree() so ACPICA
> allocates a fresh buffer for the second _OSC evaluation.
> 
> Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
> Issue found using a prototype static analysis tool
> and confirmed by code review.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
> ---
>   drivers/cpufreq/pcc-cpufreq.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index ac2e90a65f0c..a355ec4f3dd4 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
>   	}
>   
>   	kfree(output.pointer);
> +	output.pointer = NULL;
> +	output.length = ACPI_ALLOCATE_BUFFER;


Hi Hongyan, Slavin,

Thanks for the patch and for looking into this issue.

There is already a similar patch under discussion:
v1: https://lore.kernel.org/all/20260415165139.14113-1-dbgh9129@gmail.com/
v2: https://lore.kernel.org/all/20260416144621.93964-1-dbgh9129@gmail.com/

You may want to review that thread and see if your findings or testing
can be contributed there.


>   	capabilities[0] = 0x0;
>   	capabilities[1] = 0x1;
>   


-- 
Thx and BRs,
Zhongqiu Han
