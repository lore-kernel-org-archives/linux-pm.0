Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24637A488
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996759; cv=none; b=G/6oiSoMTPnPIPVj/aM9egY947/QMlHRbG6aLWxhYHbmTUOOhEBic4i6DlppTGxDxhNltGvDGhjersZXfoUTyt9NywZUzu/aF1gSpaGcTRNDbNZSrYi4RmKaDGhhfZKPfPgEsLWPSUgq1Rr1NotGtBsgFfxFJ8DNpUFc7HqsLo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996759; c=relaxed/simple;
	bh=ybWeJlEs0SQvL7LasUvIJAjvAdyfpSTxML1sdFnlyX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HlJXI8ZCMDVEz8a+Y9Mw6KvCDWuSFSgaj8SvCeTLPYgLCWsPHEUnqLt+0r1O31p2ziIK2CnryyVjFI1gfRGtL6e6X9T8KTkCC1yAeixaYPlDL1Hi6ZC9O+CjTPoE1ynuYJe+hpP/hJajSiwoeXtIn7uJV5FWrS95M6wBIPAvlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MU/rxzIU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjK7h/Kn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MU/rxzIU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjK7h/Kn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DNnZ593051105
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 02:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sOsxDMhBblaEae9jbv+ofpw+VOoiwZaMJCLRamOs6LE=; b=MU/rxzIUhh5N8o8j
	dvG81aSGtYq49G9QcHJ6wnM58Q09ymnQwKom7XIagWIICAYykoIvnKycj39lTmC/
	L4/zQ5994+6p+ySkjWefjlb8v1udes0xatNlzH6hj/IOvMdvruMt1WGBf6anFSco
	IaCgvSIJUSt97U80oU3W6ZAUEAf9Kb9+o9J7Sfi95EF4v5n4bkSKsE3v0Da40UmI
	5OBHbhWOjzKowocthG+xpjzjNmw2A5Dybs7Q4isHMqQQ4aBAPyC5+gccokBT6h1D
	PRsYnW9Svv0yQ7jelkUQP2Sbs4KMc3Tmmk3hiU/KVzvZVrXWr30iTYvwm3Fiv/Qo
	wJ9Phw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd37x9vdj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 02:39:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848544a8496so624214b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783996756; x=1784601556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sOsxDMhBblaEae9jbv+ofpw+VOoiwZaMJCLRamOs6LE=;
        b=DjK7h/KnJytTAdo7WMN++UBhIZJ61vUtxyilmQVkcFOqaLzThguQ5353qlZODLjKBG
         VrmD+bzZiAh3cLZqzn0rLgUny6Wo7hAvrNhgSM+Sif7mHrxX1BRz+t7fRazXEif86kRc
         vesAYZxycJTHWjvrm815bif1T6oScuI5kaMOL0+Zt7SH88joEwrBNtJ8svIso5O/rVVI
         0f9z3Qhd4325XuT/jezIjJwMaRuQX7eX0Je2WDYJGQBebz3sDwe6WrPLveDXQ6j/z7tz
         LHlU6dGp7uSmweOzDg9PpACryaG4L6Qx0y9L3Ew7y0xKyRGFnhvaH54kaSsjISXqRuxm
         sEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783996756; x=1784601556;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sOsxDMhBblaEae9jbv+ofpw+VOoiwZaMJCLRamOs6LE=;
        b=Z6OapYNv7dOgE0zdZNjob/vzyBCrBHiig+qjaR4JQmjIdC32TLdf4qStNPnMEORD7A
         6O3qS6OdqVcraLA8tSu6s/MaswEQ49JGaSNQSlQOb+D3wZjt68G8lO0lRIJhZDnI5T5i
         qqYfWcibZ6r2za7mtuIP5Pke9Jr4of361peDnIJPLGhyFHEZtaQ49cU4kG9ZMSSsqROk
         mqQNa7IMzqKNHUhFs0CLO5m0NJfMWwQgQLYHEXMnjFHgHh81UyobtLXU2U0dw7KQbjoR
         nuQqQdIfyqAUDZGNxe2BtdL4dix7THTTd+Ai/i0QENqhemsTD5ybiqZSHIgUHplh9cp+
         bbYw==
X-Forwarded-Encrypted: i=1; AHgh+RrV+ojxCDAVh6xoN7SPuUGucrp66zLg8iD+4y7p/oNN4YlZXeD42w9deCxq+JNNe7cYmopbLqVgXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1SkVCAcP8izlUeWA49anJ/5l2DYYQDu+ts4XtoFj5fB1sGwu
	KLlbnzn9w1Bh7zOIJWjlwaKOkVNs+UeEV0u8JXSteM48KqWhA7oVg8HNlYFWflxQUF8NCN0mxWc
	NZwjMcTPZ1wr3Jb/JzKgC+pIFJ/1ospABFb4NkjJeD+SR2TB60B/q2/re+asa0A==
X-Gm-Gg: AfdE7cmrRUolVyxOqtevfSCfF9nRPtLx3p5ZnE2QJXmpt+uEB4nHAtNfBQYV4O7ciQ5
	RL6Qz9mhzWEq4xYsoUs/cTYfdanPqBbNBCBU9Kt0POaZ8d2bn7anYLd2a5StsufyxeBnofE8GCZ
	SPleV4ndkGVuTBmIhgxSwI0gFdrViO6AXFoxYS0cqrxGuRH3AJ1XvXOg95TKlqZEJNzR/iN5tIu
	EK+A1T1PvLNhGhoy6T9iWM8/1bTuJTM7xNMAWHwKmKzhMTSuILoWT8DzS7TagkjYr7ucyabHL4Z
	7KGlnLSRbYmUGzNmMO4rw3O8bNUPfR9n9gwoYkpaq9K/afyZRwmOh4VEao1y50oqhMsQQ0t9cP1
	ucC10nZN1tlFdCoXOu/zXkv9oGiH6tR4Nue+d3jkJ9f65ZC9BHRiNrw+av+Mm9zo30tlz/Tr+Ep
	cPxBLxag==
X-Received: by 2002:a05:6a00:2e18:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-848896bb075mr9871698b3a.35.1783996756506;
        Mon, 13 Jul 2026 19:39:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-848896bb075mr9871668b3a.35.1783996755909;
        Mon, 13 Jul 2026 19:39:15 -0700 (PDT)
Received: from [10.133.33.23] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f6be570sm656168b3a.34.2026.07.13.19.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 19:39:15 -0700 (PDT)
Message-ID: <247557f4-48d8-4cd1-beeb-3317cee58d0f@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 10:39:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>, Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        "open list:BROADCOM STB AVS CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhongqiu.han@oss.qualcomm.com
References: <20260713131131.313588-1-panchuang@vivo.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260713131131.313588-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAyNSBTYWx0ZWRfX6auhqiaRz77+
 h77FeuHPdnQaOSdJKzlFKa8PUBGk4+/iZZMB1MuQ430mY91nSm2yQfMZzvQNtb8ODniGgshalPn
 JRNR/q4e7BtS5NWHT5XslToE9J23a+LUQIdB1CMmYFfNc/vqSyKNQMxayUYUjJKX6+aatrahAr4
 12LJGCMPqq8rXn/lCWMzhh4bcGT3wGghXPLyy4vbwO4vaTqsb4chk6SNhbBLHeDy9zz8dwu2vtl
 dZtK/n+ExIRXJp3Hc24iFIe+TtyfYMiWxmyjl4ceOWLwBvWOfZfHJuoEPnY7xlmEYZfv6U768d3
 c4Ipzlj6ufWscDFfsiCg43uMFZyfGhQJp+bb4WX2Fw4Krjg7ecy1ZXXOSJwmi/oM5pWBuwyrEFN
 SflgVrSiWk5Jv5QpvVdc8JiGifh3UHoT2W76bEWWHbRfrdk6iuk+mKBJyVIjTo4ylKwuZ0jJCZN
 ZMjEtQZy00Ta0p1vx3w==
X-Authority-Analysis: v=2.4 cv=BNWDalQG c=1 sm=1 tr=0 ts=6a55a155 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=RSSRMnpZIPutH4-0OFoA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: P8pTYEX4PUCwUA05zAu_IfI1rTjaG7h7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAyNSBTYWx0ZWRfX3DF+LXh73Pk2
 PwCMYRvRjgDSS8tBmu16T3qmZ/MdT1RrFUAvqQ2OMpR51PyiduH1mI92J5VTcTNxq4YYe5LO9r4
 sYdfZTCa2hu+nQDNjqAZWFdR5weI0cM=
X-Proofpoint-GUID: P8pTYEX4PUCwUA05zAu_IfI1rTjaG7h7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140025

On 7/13/2026 9:11 PM, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Looks good to me overall.

However the subject is too generic and can be misread as a cpufreq core
fix. Please scope it to the driver, e.g:
"cpufreq: brcmstb-avs: Remove redundant dev_err() on IRQ request failure".

With that:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index 71450cca8e9f..7d902856ac01 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -584,11 +584,8 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>   	ret = devm_request_irq(dev, priv->host_irq, irq_handler,
>   			       IRQF_TRIGGER_RISING,
>   			       BRCM_AVS_HOST_INTR, priv);
> -	if (ret && priv->host_irq >= 0) {
> -		dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
> -			BRCM_AVS_HOST_INTR, priv->host_irq, ret);
> +	if (ret && priv->host_irq >= 0)
>   		goto unmap_intr_base;
> -	}
>   
>   	if (brcm_avs_is_firmware_loaded(priv))
>   		return 0;


-- 
Thx and BRs,
Zhongqiu Han
