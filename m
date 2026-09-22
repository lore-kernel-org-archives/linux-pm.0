Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63633EC684
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051181; cv=none; b=RPuSOrsfwLu5wRszy+Nlm1iyAHf0DDC4vAqx5FVBAOlKGv+Fxewzo80fPrussqWjifwLtSFLGhTbriTRKMqa3N2lltyMr/swmXH350EPAR8FlbPFJj1KZ2tz+I1nXOYQFAM4pLY3g1kqF+pRcYLr8DmfJq3OrCxyjjk/FhRqHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051181; c=relaxed/simple;
	bh=5x6DgSrKV2/hlp0HHFPmrZvte+Zh2z1LZIewo8/NzLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUvrO6D4eYg7U580QPP2eZGQ1+B38E/2uB/ZXMLHj0RXE11Du3qkHz+rgj+JUWqF0FgJgvMt7GUNzT8LyifTz9/7rSO0myNbrUEaIE+FhE0x29aGD697Ngfcd/QQREJ/kyJMlrB7SWfWu5vT1Mwp3NK+FoRuGci2ocaoFsayvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=akvYb8nc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pooj9zLd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="akvYb8nc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pooj9zLd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00IRJ3676910
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REcT7GpoJk/zgvrjat3xAPdg5wUsQTnHiK/QOr1Gnhs=; b=akvYb8nc/xB1yOJa
	RjvETW+LBi7P8iCn3VFoiP8AvvD7mWrissADOaqLA4VjTzsTYQWaPICW3fOJ0sQS
	noBEAIXzEwIpP7oksvnCYdzASejBwMRDjYXkiTLGqy3OGe2VAGQoFJbM2ag2m6mi
	6e8SsLgdPMviNJbHzF7kmRkaA6wcrJ2Vtp8Ke5hTawahuLTUJ9bq9odf0hYXYESc
	k2NRcpLtM+o6odpMukwVFgS0rBDZTyvfcIjaDqEdwzKEvo7+f9Pkve8sRX94DUdL
	xRnTaOe/zHcJOVONzDD1f9vz8GVpQIWV8wcHpPDQuxYd9o/ckW2Vjzv+GKZ6ZAG5
	nE/e+w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu85vjbv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:26:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d9336581a2so64197985ad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051177; x=1790655977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REcT7GpoJk/zgvrjat3xAPdg5wUsQTnHiK/QOr1Gnhs=;
        b=Pooj9zLdVYUY87fVH6aOV2aiM4MAef8LLC8MmpYjN9UJs7IDsvujEQ4dYf0ZhkLvdI
         WNV8pDBrOY1xA5Gn5kC8cB9shuu5LjjXNaR6CVA9VrB6hJbCmvdeCeUhJAL43Tiu8UMd
         y84a2ab4/C4uYmJ0gqcFRPVJIj7TYYQ7ncWwzSU9KlzW/8vSvGgXVAJb/eKSwhruGNT6
         HB/VdxSxfp2hUVbNrNdmunbIOfg5+NOz4+0YSVMgVeesCYzaImaTBRIOoUmU5VtGcn5J
         hRCs9EYJ6R85mRL6iaeL5jEz2UeQeDD37yDqFwOT5kYAMn2M9DwtSVHHl01jxev52ieo
         yQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051177; x=1790655977;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REcT7GpoJk/zgvrjat3xAPdg5wUsQTnHiK/QOr1Gnhs=;
        b=vll5DZd2BiteIHABbJSb6d5JE1JPr094Rlut6iGM/zMnnaCrRlUVQQqx+g8W5ktHUR
         UAnIodIrWJ2LEqHfUNe+wEJmzqPuM6GmU8cs/rgapg9o98te3B7f/G9CJYF51C1w8zDn
         CvPDYXuWS7lUoOIAYcnPzbtFQZQ6E+6P9StftVKirv1qmuLj7hBJ+UEzkou11EuKWb5G
         PCyB51vnKP+aO8bF1VyFmwvMyBuCD1MFzAinFqn3beQJRRL21lOzjJTJd19oL4aK20el
         Z2H5B3cmrsLvKiVsybRXwAnX6/tmpzalt4Cc3Rin3YCct62ARGibsZEpFqUsODQ2cCbz
         UXHw==
X-Forwarded-Encrypted: i=1; AKwUvBxGwNn/KYxymEi2UOyBeVhUbS1oDYsuGbvqfDAgjvd1LzdIFA2oUknYWa4NF/o/9a0nhlrYJgrhFw==@vger.kernel.org
X-Gm-Message-State: AFuF++k4CKkOr9OZwRINuK51ZT+bEdmggyHudsFsdkJs2gWN4GzzwJth
	lYQXKonDYoTLyiqZtMeD9f416/1ux+QeJ7Tdb0svkiBJe6dRqXHDmv+m7T84qwqoGvBILgHD1zT
	TohfL2Y6Ixy0pKe6J8PdKBUMqKte5APvuWgKtJ7MdlRnGnhXydvjol5tQ5ccyJA==
X-Gm-Gg: AYBFou3xy/fQMhw8nVZaG0s0ANUDHzXxNwYRP+6y4wkarn29kdOGr0rxWuu8eBLM43E
	2f4+mi+w1vVi/ygaJELN7z6Hc9ie2CpJ3kTv5waXqR8OAIdaKleSRKMVReENnilxbE4Z/1nGN+2
	8mbqr4KL7UnBUhSYzU0tLavpM0WakWOExs35GYT9oO34XtX5bDteRFVszYlVO7rteIyAgKo4o9H
	fqB1VHaMZD7CrXTxcwQOChhGK0OfKeZofZYaRIoZcJuSv/Zf4dl3cvIOKJCazlRi9SBeuxkCW2b
	f8TfPUKrDrdVWrntcyF231uPIkzyS310vl9MicA6dlrge2xJG11WyrES/CPskCqW0vgeh839PdB
	C3PnEc743mz+mp7PEOOPeTy9caSVlr8ovV4M2oq+uPmMH4C+WRTtNPUyI3AUckAs9b4VwBK3f
X-Received: by 2002:a17:903:19e4:b0:2d9:2149:57c0 with SMTP id d9443c01a7336-2ddb1ba35aemr181420835ad.22.1790051177231;
        Mon, 21 Sep 2026 21:26:17 -0700 (PDT)
X-Received: by 2002:a17:903:19e4:b0:2d9:2149:57c0 with SMTP id d9443c01a7336-2ddb1ba35aemr181420605ad.22.1790051176726;
        Mon, 21 Sep 2026 21:26:16 -0700 (PDT)
Received: from [10.133.33.126] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d0308ccsm2592795ad.42.2026.09.21.21.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 21:26:15 -0700 (PDT)
Message-ID: <641a111f-ad07-4a40-9fcc-6af2f7f98c9b@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 12:26:11 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: scmi: publish perf_ops with release semantics
To: jaidevshastri@vt.edu, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260921-mb-scmi-cpufreq-v1-1-934da6400a26@vt.edu>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260921-mb-scmi-cpufreq-v1-1-934da6400a26@vt.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfX8Azfk1oqP3Lh
 1UxfSZ4a+IfFjG99mN4LrlLr7cgpzFFcws2nOTABPiuFpMwiFIz+kxr2mJ2C6mzJYPvml8R3xUe
 aay5EH77biR3ZTd0D+Nnp5Q2AWu1TIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfXwW2zav0CJWKw
 nNS9z8VjuYGJt4LgISzF7hlrWdg2JxKlpkyc6sv/l0DzbEWNdMMSLYTJ2I08VDqED2Y5BalOvjh
 omwi7JYvUyJrV7LIEZSCg8WOmMkIj3MrtrQXy1PdTx9xbGCIqbZhp5UgkBlxD0Pg+eDDC5nCUsu
 qvHl8nEUiVZL8Xfa6su0AfVdQ12ZqsEq1eNRfuFeOZVWYUXPQQ+sfThhbgQygMfLCbuFxb5545G
 T5c0XhQVMhskOXhRuNe0ZvzJ2uv2ix/bNyk17KvgJkLy9EEPEAw+fKon1fWBkFmMy0GKGqrAGEq
 KLg5cAN+e6yVDQts4KHKZHPp6qezNosiIi/JEi7cS77NJwdwxz3Srf94rlMC4o1t+Rqub5tgQGw
 cdhGgEfOyWDqs0l6YDG0xReQ0GFIFoEUPpNj1eF9SPMiKay9T6a2kEDj3d+UA5AlMWsxJIJQupG
 sx6+YACv47W9z/VjtQQ==
X-Authority-Analysis: v=2.4 cv=E8FYNqdl c=1 sm=1 tr=0 ts=6ab2036a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cw3u0DvnAL9Q_YTEX8oA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tkR3OsoIZG8z8f3kdAcm7lq_BOQDyimv
X-Proofpoint-GUID: tkR3OsoIZG8z8f3kdAcm7lq_BOQDyimv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220060

Hi Jaidev,

On 9/22/2026 9:19 AM, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> scmi_cpufreq_probe() stores the SCMI performance protocol ops pointer to
> the file-scope perf_ops with a plain store and then registers the
> cpufreq driver. The callbacks read perf_ops with plain loads, starting
> with scmi_cpufreq_init() on whichever CPU brings up a policy.

This doesn't appear to be a real issue, similar to the case discussed in

https://lore.kernel.org/all/495a47a3-ac6d-4002-abe3-23b85b2f2034@oss.qualcomm.com/

> 
> Keep the pointer in a local, publish it with smp_store_release() and
> read it with smp_load_acquire() in scmi_cpufreq_init(), the first
> callback invoked for a policy.
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4edb4f7a8..c394f63cc 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -197,6 +197,8 @@ static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned long event,
>   
>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   {
> +	/* Pairs with the smp_store_release() in scmi_cpufreq_probe(). */
> +	const struct scmi_perf_proto_ops *ops = smp_load_acquire(&perf_ops);
>   	int ret, nr_opp, domain;
>   	unsigned int latency;
>   	struct device *cpu_dev;
> @@ -252,7 +254,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   	  */
>   	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
>   	if (nr_opp <= 0) {
> -		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
> +		ret = ops->device_opps_add(ph, cpu_dev, domain);
>   		if (ret) {
>   			dev_warn(cpu_dev, "failed to add opps to the device\n");
>   			goto out_free_cpumask;
> @@ -293,14 +295,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>   	/* SCMI allows DVFS request for any domain from any CPU */
>   	policy->dvfs_possible_from_any_cpu = true;
>   
> -	latency = perf_ops->transition_latency_get(ph, domain);
> +	latency = ops->transition_latency_get(ph, domain);
>   	if (!latency)
>   		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
>   
>   	policy->cpuinfo.transition_latency = latency;
>   
>   	policy->fast_switch_possible =
> -		perf_ops->fast_switch_possible(ph, domain);
> +		ops->fast_switch_possible(ph, domain);
>   
>   	policy->transition_delay_us =
>   		scmi_get_rate_limit(domain, policy->fast_switch_possible);
> @@ -443,6 +445,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   	int ret;
>   	struct device *dev = &sdev->dev;
>   	const struct scmi_handle *handle;
> +	const struct scmi_perf_proto_ops *ops;
>   
>   	handle = sdev->handle;
>   
> @@ -451,9 +454,15 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
>   
>   	scmi_cpufreq_driver.driver_data = sdev;
>   
> -	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> -	if (IS_ERR(perf_ops))
> -		return PTR_ERR(perf_ops);
> +	ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> +	if (IS_ERR(ops))
> +		return PTR_ERR(ops);
> +	/*
> +	 * The cpufreq callbacks read perf_ops after cpufreq_register_driver()
> +	 * below. Publish it with release semantics so that ph and the ops are
> +	 * visible together.
> +	 */
> +	smp_store_release(&perf_ops, ops);
>   
>   #ifdef CONFIG_COMMON_CLK
>   	/* dummy clock provider as needed by OPP if clocks property is used */
> 
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260921-mb-scmi-cpufreq-cabfeb548027
> 
> Best regards,
> --
> Jaidev Shastri <jaidevshastri@vt.edu>
> 
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
