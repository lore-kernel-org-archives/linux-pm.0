Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FA30F7FA
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268066; cv=none; b=jZT3z3Ll/bfm+omNbflEvVMpKDJ7FnfhPVanWCu9aLe3rvEVoZALcVVWw76cCTENJ94pEI91EYmj4x1EomlmtM1wATtYrXezvX0JBCTspjFBBZm/pkyAg7tESeirjMLs9um5hgM2RCd5TEtPKJ1GczEUTxLrtck7Uc4PIGVlc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268066; c=relaxed/simple;
	bh=ACq8O6kTrFDyWuzB9wUnBK2bCVmEEPua6raZFlQp/mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0yzdocOoOVaBlobGyZ9OYaOaJeKnItNohBhMGRXBhFq4rC3cUqmBXalttJ4muTNiDDLQdkuEvoZZAhN/2MXtrVhCKG7lrn956dHvosxpM3pF3++uSRragwwFQX3JyDHDs91MTUeNv4yT3s0/FbmcrqG4WJAcmqn3SEezJDH60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PW5BiVvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4NKclyy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PW5BiVvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4NKclyy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJfVw2494599
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 13:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=; b=PW5BiVvApoKbw9DK
	6y42INfOHSiEO8MVV8KcajnkDGwMGKy26Jufms5NF6j6VyWxpEmR8PAY6Fk4sO0i
	9ENz5JuYYIR9XMvFXbzSHyUyJj+JYH+tpraWuO9No2lmpA2dh+XwqwjJcyHpYjjU
	HcjTMLgdC7ynLTzeqavkj4Mn0cLhNCMc48zUFPNW/ng/Tg7t9o/BWXWAYzboYjD1
	oKN53pjUCKz9FhXITLa3lLD8C/1hKsJ7URnw2n0XgkDTR6SBT0+iSkGi1AFVTSpZ
	IQso4AHA3qMNb44hJfw5YrhK8deC+SpeEUlfxZQwqXpB7UEXb6GTKlktjjDHYZup
	N3uOwA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh26ca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 13:07:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso6518805a91.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788268062; x=1788872862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=;
        b=N4NKclyycAy4ULLvlJORdnoMTb0xIRs7B4II/pRb4usBtZbOg9P3EsoDj2nB+yL3ik
         +3+f2TX1ZvlDEuGwagseFZqf62sfnXgzrGWhOfo7KWBUuQvPb/KcSKBEdXaJWR/3OBI6
         fE73FwqEkwwr/jAoXYwP03eIv2kHVduGmWsGKjl+Zkeh89sY6QdXNffLoZYQhZ47fsrs
         7UEvBt9QVfIyb7D2aDSs22C5cSsBwPI7fzeEm/gtoFIxpVUxtToMr4Z7seaM4zQhE8if
         eybzU4I3P+kk4cjYt4zeEkB5akF7Gcfh2SNOjvpiCS6+abVq/wwWCfHxWMQIlXjjL/gi
         V+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788268062; x=1788872862;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fu/qT081YpZrS/2ylCLv9AxqLXBYVMrV8WDC+n6KfHY=;
        b=AQB0C7Bz7shrmCD1gb8coSHEDRqZH+FKeaCvKQ9a1DWjUv1zJxAAc61l/dtAfzugf7
         JhPaFY6CRXF9ZofxXi1jgT16fQkBCh2yZLluwB+48iPZXRqWl/QESWN5dGyrXLqGPHMI
         iTf0HBRHzzELQUSSU/P8vF1FPONgGr1WEl6+5Xj2MYimWT42uEfZ9SEsp83zMjfxsOQz
         BitRbvXEpthuWw9XTySf0FW0fpnDTe3UcV9n6/LycKZq4CrImOgy/n5aB4xnfHCK2mKC
         xS2Dx0FvVDCaTx7n86JrPb/NUY37Nv1Meqbrbb0OX0fCgYdzAU8FbZS45dATaX4jrBHT
         cuyg==
X-Forwarded-Encrypted: i=1; AKwUvBxRUQ8qYnkVaCINBNYtxmXN+IuZKF9L6XrMWEVZLBfsZWhh8ZWxCLIunEmNBnT5qjs4cUlbSD0/3A==@vger.kernel.org
X-Gm-Message-State: AFuF++lm43tKcjFcNB/Av3v6W1m8J2tJiBUBIIkd7BOlgHRe+vnVErzr
	6YCv2OBKVFUNn/FPvuzTUHhhhOeWgIz2PuIG/BV7jTErLTj926DxPXAv2MJf1xl4i9j0eVNxoRm
	lxJevcr0cbc4V4BXZvbrvS5IPf6XsfVkzn4jeXHKRl5SBFVeQeP7Jv8RKXgscKQ==
X-Gm-Gg: AYBFou3QOu3nENswELBm/7YUb40j4kR8Ndpmf9ZjHYYHa0fNq3DFOmP+zlmR59rdtC5
	C6FQyuKuXgKbRkU84MNea6gh/+9RBM8iR7hZfof3I0zuRsCKww/yiQ1O/OvEUy07Lbkaq/mB9jo
	jd5vgtarE1kaZfKeJrVaMwBYBHNLfqdNiFkEWnKGIIJvwCZOJPpcjhPa8rHCvlPye7h/gGswu9A
	aoEWSnoNtgCMPSiT69CjHG2fGyshAY+mEejpr1PvV+pG//5THHLV6pJFoxmE4cqf6oX4jF9DYc0
	3WMYuBu/1ghm0ivPBwflDzVY1oQkzlPF0+7xLKD76GZa3e76cdITk//tVUbc4MnFhXICa/3UxeZ
	fICQShi26lVBEAaTaTJwy9JwynM4vfLxCs45RfsJCOFVHGfhHxqrcD6dJTC5MnUUY8x6Ne40p
X-Received: by 2002:a17:90b:53d0:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-396d0ec7afemr51415467a91.5.1788268061701;
        Tue, 01 Sep 2026 06:07:41 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-396d0ec7afemr51415272a91.5.1788268060923;
        Tue, 01 Sep 2026 06:07:40 -0700 (PDT)
Received: from [10.133.33.203] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d7759bd1sm6750547a91.3.2026.09.01.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:07:40 -0700 (PDT)
Message-ID: <36d2a431-a1c3-478e-a001-936d25bcb9e1@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 21:07:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: initialize policy rwsem before sysfs
 publication
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jianhao Xu <jianhao.xu@seu.edu.cn>, zhongqiu.han@oss.qualcomm.com
References: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
 <20260901121950.3279176-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260901121950.3279176-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfX4tV6/QCXKW6b
 W5hXtzS/wKAArOsa7JRaJRJQb1ywhFLNvSmghXjTAcoN/g9OENu5e1CD2Ce6gXB7SyZo2l5eZqI
 9LYMjy7g2a4iV7lFd4535J1OEt2vkRA=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96ce1e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FxTtqrLrjwncoYGlF1wA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: JyfgCeoaiZAQu8fB93_9milQIonivPwY
X-Proofpoint-ORIG-GUID: JyfgCeoaiZAQu8fB93_9milQIonivPwY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDExNiBTYWx0ZWRfXwjLNTCjBqaID
 gj8J2uwyejI62llQGriiAIgTQO3nCy85WIwHESRsW66kj2VirEf5OFXnvMzejjBEWyLusU/P5DW
 XojysORaTND/g+q31H3LYPIq4rnc6F/ij41BQUL0wr00FujVS+NOyiqbF5f595h04+dtIBADwWV
 g3CEWMku3YMuK4k+RhhdhpjGqfJB81Lhy3cVl/xhc8JYXyPBpwL3hvkrAimUhvcU+rlK1x25o5E
 CHaMJfkSjuyalUgohPRVywl7YeTyZt5CIpyuvt/I9SX5WmonbyxozT55co5yxBWbg3opxgPz1km
 QWltXPjyZNAFt7FdNtXeje/nV6WcshYt6FnI3ITMvAZpftPOi2lqv4wgyXHOfLkeSvmRMC7zQpa
 PKQ7iZXXoZkrLEFI/GgvkxWjpDKGGnl+/xoxxnp/v9RL0eJnsdH9Fr7D0/bHuQT4cK9J+37Q3/m
 VEqRmy1Yljn3uTXIWSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010116

On 9/1/2026 8:19 PM, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@seu.edu.cn/

Nit: It points to V1 Link, but should be okay according by https://
docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: Codex:GPT-5

Nit: Sob tag should always be the last tag.


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> 
> ---
> v2:
> - Correct the Fixes tag to the commit that introduced policy kobject publication.
> ---
>   drivers/cpufreq/cpufreq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0d0df986f..9efbf5b17 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1258,6 +1258,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
>   		goto err_free_rcpumask;
>   
> +	init_rwsem(&policy->rwsem);
> +
>   	init_completion(&policy->kobj_unregister);
>   	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
>   				   cpufreq_global_kobject, "policy%u", cpu);
> @@ -1272,8 +1274,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>   		goto err_free_real_cpus;
>   	}
>   
> -	init_rwsem(&policy->rwsem);
> -
>   	freq_constraints_init(&policy->constraints);
>   
>   	policy->nb_min.notifier_call = cpufreq_notifier_min;


-- 
Thx and BRs,
Zhongqiu Han
