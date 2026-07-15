Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCF2F84F
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074262; cv=none; b=i6zH1M0tY+UylPZR8h3o7NpkmcxyekaDEqcwoIdhwVZ8pjRoAusSf05CRyNDJm9RKCKgLdfcEaS0FVfPBfxDPaAIDuYMBM5cTfRHtdAEqnMG+UatrWkON9k7xRbByVEnj+0Rdlulbm1XeBWWlIdq7PIkQJAtAN2xRxCcsV0JF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074262; c=relaxed/simple;
	bh=jyuIb9mUMhDLcJdZztNW/kggE4C4qT3I1JbKcllNvbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af5oRmambTQX2uRFEEg/sljEN+d1fjtHFUSZCripTV95oIM4x4GUe/uuIe09f/ygYxlMSiB/Uzoj9arcdEd+lZqgkLPAxC2+kN7fR4oO2qpxZXwCTOak9zSXW/hYL/pRdyVcyHMXnx9OI4UcPNQhlNqqMVrxl2tnwzLjAdSAI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcX++nky; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHBVfvjV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcX++nky";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHBVfvjV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EIwHtt1243139
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 00:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/0LJ9xDxqz4B6c+cfB3c1tEAaHQFTTe9Ptnd/5JugYI=; b=FcX++nky+6nttwcS
	1fmRDRruTiF9tAVKFfDzbeFXAL6ULDCdWlA5wiKPP5AuweEW7F6qGxUPPzHZINbl
	YDpUR64KjcCPF+tPkj4hM+vYKWvIo+miKIKTWkFwV5B2i1W0+sd552SchGt4nH+C
	bWZJRym20fmj1y/h9HVagYJ9Bg9pVx132noahPceJ/m7UvJLVExO8vDwNyMzugR1
	qtfCjOGkX69er+84c5t3xebI4urvLrE83/lI0aCJpZZuu8XgkOHvI8joammuOmZR
	bs0oDoayBBdFMwZTwiSNISeh8/BtLCFabEgHw74Wvj7AXayv3DBO6IEU3FXzNeUm
	wgxkrA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk2kd7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 00:11:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so1087675ad.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 17:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784074259; x=1784679059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0LJ9xDxqz4B6c+cfB3c1tEAaHQFTTe9Ptnd/5JugYI=;
        b=RHBVfvjVObL+oKPfxPhy5rIgsC1I6Sp12vIi4/cqRWiH7V7J2qfN4StyAT7/k6nAAx
         0Zy9sEFtlr+BD7iVmo9s1fxo3yCp93vq7E13w9DJ5Mo80Xluf85KCD3Cyh1KsWhqOl5c
         R/0bdJQDOKeDLpqTmWwSEWfe0UiIdArluzk90JyUTTL4c3OvLnG6puk1lFGdBoeQE7et
         UpPw6eSGdR+OB+gm1m0oviBpI2G7Nik3yjOIyeftm4udo6EqJc/79g0pl1f7/i8mjg9K
         Re7K2Wh1wo/xVAtuEp7nwS4i/jZeQJ33ZcFBnAKsrXuBBAruvKnm6thiD1rbPxdgcUFE
         9zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784074259; x=1784679059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0LJ9xDxqz4B6c+cfB3c1tEAaHQFTTe9Ptnd/5JugYI=;
        b=SS5icMQBT21ByvOgivP/9X+nV2BlUWjeI52tFFvLbHw+tPkuGFAZncgPzUZGVCwikq
         T0voNR4buz9L3wKmeduNqLwY7yAt0Uf0qrgBInpNp0tXqAtwEzlyVbuyArQqMGf6wuAg
         BfRzfOhXGpMVNPRlvwTCqB/SAU14K1XHHWrtkTjra8iCkQFyM0DZX15tlNhccoHFjDEb
         F97nkjciapG7iDBVCmj6qEYF9ekROo1Z4ELF5JlCyD9004iTz4Gar8UxGGl3JMCjBgz/
         SRrpckyvGZjvS5fSJp0oCSn44ezYsVLxuZR2+qLOHCw1cnmbK7UAhd9tRVPqs7llzc6Y
         fKUw==
X-Forwarded-Encrypted: i=1; AHgh+RqYYfK1NvbvOxwg7svE+fh/upn+w4j5XFyUqbKj76dh1BUCcfWlbTyXsQmwt9X4dxPRgGyyG36zkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5F3UnIs4Nc+84npir6+7P1rYC/s4MM76eTroUHJvDIPTyGt/g
	Pr8/oM9dArizKjPSiIe7Fu+cTM/wGY57JtLunxWqmYKO6MCYCy9HxbBuNTAc2tiiz55173yVS1Y
	7qMaBXkAVBUPDqGXbmcOJrm2hAWOvutXrcZDZPySs3YWIOGQQJwmU+ptRZ2yh9A==
X-Gm-Gg: AfdE7cm1020uZfzb7TeKgNVquYuBzXUSwcqu1VhyGWQT70pEM7R+F/4Bbt8qnUjrmZn
	nlfvMiKrwU36yy5hw9hfkkKoGWEVKyQfQES38UCFps92gA8xBrc1relrC4EUcI7PdOKP9GxvXMv
	Ou8LxNg24r6AKL4FXmkh33+f+cq426XBt7eE4ZKANN/0YNkaaRTCPo091jlJei4OmrUSZoB9B/9
	1U6FRktcOPiqzcyjbp4SdQcdJFAqwTqPrUFnxfSXoc7HUkBiQH6lGUOuJj4xgouaVDoIT2RSK7C
	qXrnhDEZOXi2V6Kah7yc6dDe+A19cmiwVEBe4JWuphe4O3oNNW9yWkJPr1fdwy+GWO1Lo+uTod2
	SuoRBFn9dTSQ5u5I/bU6os1Bd3SoRsn/LlCDSr+xw
X-Received: by 2002:a17:903:2406:b0:2c7:c385:c5a7 with SMTP id d9443c01a7336-2ce8297869amr179293265ad.26.1784074259340;
        Tue, 14 Jul 2026 17:10:59 -0700 (PDT)
X-Received: by 2002:a17:903:2406:b0:2c7:c385:c5a7 with SMTP id d9443c01a7336-2ce8297869amr179293065ad.26.1784074258759;
        Tue, 14 Jul 2026 17:10:58 -0700 (PDT)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e40sm124537915ad.75.2026.07.14.17.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 17:10:58 -0700 (PDT)
Message-ID: <a32691c8-e48d-472a-91bc-a3f4e9edb00a@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 08:10:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: spear: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
To: Dan Carpenter <error27@gmail.com>, Deepak Sikri <deepak.sikri@st.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <alZZzlY9rfdAvWac@stanley.mountain>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <alZZzlY9rfdAvWac@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pYZ4hqORfSAMpifiNSEYGCPHiD0npXFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDI0OSBTYWx0ZWRfXzIrwQ5B9rpkv
 RCbdXqyvk1lSC+0DCB7V0K8OMGkk8zVNU7c77E2+PhZfmjnrg0JXPF45qdycNH4h5ABLeXty8/g
 6R/EnUPEUk/YaZ/fEOWTxs6nfAlp8OzWSzYNDj051B/n6U2NnxcpwdhQtwNxQtNWPV4fFQJP8y1
 ZPJt1Lv/7WHHlI0klqKskEfdPBAsGGEqg/FSxW7oNyWIRZfIgRbIlBKORBZjLrjFkknjOCBMmcz
 +fEZ2d+g//lsgQ12Ua05DOog6UpsJcXhHHxSAcZ90SFNb9Z1OaRmUaW26H+uTIGJ1dMLZi0wAfj
 s6q5JdlV+Z09HStKxHn3mOlOC9BVAuPBls7j6fIFNd7vrm5uEfjvP3SYPOk4xWiiJf8hRkIv2fu
 OaEHGylN9Fo4UWueU6lYmQQckIbKu0y8tkVF5IOZtYauzyoqjn0w1dJ7o5+/EdTxYY5sXj7EsFc
 mVAN0twyNxU5KgareRQ==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a56d014 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=N0crexS4lfU0QNQj-gkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: pYZ4hqORfSAMpifiNSEYGCPHiD0npXFN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDI0OSBTYWx0ZWRfX0tyGl9oaPFPA
 Gsj5efWGx8KWCga5ypNmD6E8DwvPkGxkzijKjDg2DKWB+gYli9rRQdVZYLxVbXUFukFPo/bgCOi
 cSmEHZfP/4FvwFXo3Pg2DK5veXGmU14=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140249

On 7/14/2026 11:46 PM, Dan Carpenter wrote:
> The clk_get_parent() function doesn't return error pointers, it returns
> NULL on error.  Update the error checking to match.
> 
> Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
> v2: fix subsystem prefix in subject

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
>   drivers/cpufreq/spear-cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index 81a0780b2ebf..ffe5eda82f0b 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -79,9 +79,9 @@ static int spear1340_set_cpu_rate(struct clk *sys_pclk, unsigned long newfreq)
>   	int ret = 0;
>   
>   	sys_clk = clk_get_parent(spear_cpufreq.clk);
> -	if (IS_ERR(sys_clk)) {
> +	if (!sys_clk) {
>   		pr_err("failed to get cpu's parent (sys) clock\n");
> -		return PTR_ERR(sys_clk);
> +		return -EINVAL;
>   	}
>   
>   	/* Set the rate of the source clock before changing the parent */


-- 
Thx and BRs,
Zhongqiu Han
