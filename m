Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985634A3DB
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774501429; cv=none; b=o0MUQEJ0IkowFsczh6/yB00fBSPrnMdCb+RIseOJsp3yA6ZkR5WFOT5oBj6ni0TZYbGrw0+ooVzZwShETUiiAc01IFoXfK9E6uXGzInusLAtabPsbHjjf7XdFmMSd3LJUPeMs8lPQBh3rUnYkNsscCC8oSo8Z5O5ZoGgVMsWkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774501429; c=relaxed/simple;
	bh=vErxF3/rq1qZ6tk+nCKFGGxpkst1oFOTNCyaERRWmSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb+N4KTJfmswTK79X9NAtMbwxGva1+u2qyN7cTrSd91QJ+74chYLXqZLIAYLHIgYeer5ykOdRH1HFjS4d+Ql3hylU1DH4GRXiXnD0da0AXN0AFXjdYv3Ac3LTjZ6t6B2Hv0AdhvUIgIOYB2h7Mcl8QEWb6mnVt2ia/mH7Hjpsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o18S8SAp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o18S8SAp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso310251a91.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 22:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774501427; x=1775106227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0PU9EL9GILgYwHurRalTuEDLXZSjOnCkpGOKnHL/R4=;
        b=o18S8SApA/g6c6jEwmKdNHjogUZRRP5WPlUN7vObctBu29hA6P8JI1mYvolJ5Y1h64
         7A3H2Zdc4UNE0IJBd0775tXYXg+Rbg0U4jW1tRT3Qq/ncJFP0mwTVvcVe5/T8WRKk/eM
         jSTeHapSzexIwwaA+ZS2In9vTQjmP7iBxly7wR5nfjALLoUbHeuHx+JrNMphDHmkzNRs
         v9lDpeTMJ64n1r6FMVpoYtPeS2AGPY9XSswKGcaHME3cAEYWOqBOyNZAtuXlzkdeMrQm
         fPLxxwGhFoq5pB7D8458N4dBTK5RAaZWHAoc4PtzewzkAgNSqJlIWUURzlVNXFGiRLLK
         VC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774501427; x=1775106227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0PU9EL9GILgYwHurRalTuEDLXZSjOnCkpGOKnHL/R4=;
        b=d33mjt84TY/aCBBp+PwvNLL8bCRZvzJWImBQkHPt5sO3PfAQ2KNWOmP+89Wygm31Tf
         y7W/AiqT1cdp0DfaiK6zUWUyaQzSMFKP+9+Oln65fG6QJ1vyfUDJtWYbrQEH8Ba5ZTEf
         gaIRzmn314L71U6jxoNGZ+rYvNWUWsPUS+R9Mg5JtRHMwARi7CGbXTIDTbXnOZNNm7VT
         T2QWdBPZLa3q0TLCY/oc/qctoEH6jxAKIAtEJlRVCs5zg5m4c5TI5s8eNc50iG3ubif9
         iJsD2veqQ3HbH1+a11AtFfyCj7++GiO0gxE3JFQjRqSXfnI6lPJNvS7+jDFepbDWXhZV
         NbEA==
X-Forwarded-Encrypted: i=1; AJvYcCVLM5GIlPG1SvnaB8/5GeR5EiI4qVWK1Gp9Vzp9uNwpw6eYShppnQPuKHNuqFXxVzdILk4fXLVDrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+H/8vnIvzC511IRvnkNngAjDXGKFuGpGjRrK8sM7p517rNEU
	MPdiPS2f2UcJZ+ucs5G1wOaUXE1Dhr2xSHInepdeyaDtRlYzhqGE9CU4V9hgexDzNXE=
X-Gm-Gg: ATEYQzzAl5O0Cn6gqVbk1uIgWGxKeWMjP+qL64BV51WPWAljxG4WOAc7nDtIUqTrj/X
	kg9Z/XvvhhfZ7Ep6id6lbK3qtmZWuuPvTdNR5x0GO+I6R/ZHKCF5iebecSyIO7he7r0vkSxXajM
	vEpdiWI4ee89XXLwbxpeVDhEF3xnDfcxxotzjtDJWACa2Ylax8kfd166M1w5wWuDknYqDhiG7lx
	JhzEGVRd+b0RbjYFXj1W3rEx5XcfuHBf7TPonxZb2rQQWcD84Ksvxt0voaB3huvMHkq34rylevM
	cgziONX8YVX5jSZ7KUWcr/TQSo4y5EGw9ZxLDa9z/d3oexbirUDKYvBe/8bcgxp1xKKN8cSLr/f
	eZOYKXmFODvdOV7gybD5+WBlR6gUjBeL6LA8qBoslg/NgHiKRcuEt1165oCVxUhlkujfmB6vQy0
	N7uaHWFJwEviFN/oB1VXp9W29C
X-Received: by 2002:a17:90b:1d88:b0:35b:e4f8:7cb0 with SMTP id 98e67ed59e1d1-35c0dd40fbfmr5672552a91.21.1774501426959;
        Wed, 25 Mar 2026 22:03:46 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1f0459aasm359084a91.2.2026.03.25.22.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:03:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:33:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <6vfexdrwtftix7k4zcyftxxdzbxyrcisegrcuukyy4cbuuioo4@zi6qlmloj4kg>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325165255.386576-3-pierre.gondois@arm.com>

On 25-03-26, 17:52, Pierre Gondois wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> @@ -1445,18 +1456,42 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>  	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>  
>  	if (new_policy) {
> +		unsigned int req_nr;

Maybe rename to `count` ?

>  		for_each_cpu(j, policy->related_cpus) {
>  			per_cpu(cpufreq_cpu_data, j) = policy;
>  			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>  		}
>  
> -		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> +		req_nr = policy->boost_supported ? 3 : 2;
> +		policy->min_freq_req = kzalloc(req_nr * sizeof(*policy->min_freq_req),
>  					       GFP_KERNEL);
>  		if (!policy->min_freq_req) {
>  			ret = -ENOMEM;
>  			goto out_destroy_policy;
>  		}
>  
> +		if (policy->boost_supported) {

I would rather add this last: min -> max -> boost.

And change the code in free as:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 58e3839a2140..7f5d18da78c6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1358,17 +1358,18 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
        /* Cancel any pending policy->update work before freeing the policy. */
        cancel_work_sync(&policy->update);

-       if (policy->max_freq_req) {
+       if (policy->boost_freq_req) {
                /*
-                * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
+                * Remove boost_freq_req after sending CPUFREQ_REMOVE_POLICY
                 * notification, since CPUFREQ_CREATE_POLICY notification was
-                * sent after adding max_freq_req earlier.
+                * sent after adding boost_freq_req earlier.
                 */
                blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
                                             CPUFREQ_REMOVE_POLICY, policy);
-               freq_qos_remove_request(policy->max_freq_req);
+               freq_qos_remove_request(policy->boost_freq_req);
        }

+       freq_qos_remove_request(policy->max_freq_req);
        freq_qos_remove_request(policy->min_freq_req);
        kfree(policy->min_freq_req);


> +			policy->boost_freq_req = policy->min_freq_req + 2;
> +
> +			/*
> +			 * If boost is supported,
> +			 * init the constraint with cpuinfo.max_freq.
> +			 */

Don't need a comment for obvious code ?

> +			ret = freq_qos_add_request(&policy->constraints,
> +						   policy->boost_freq_req,
> +						   FREQ_QOS_MAX,
> +						   policy->cpuinfo.max_freq);
> +			if (ret < 0) {
> +				/*
> +				 * So we don't call freq_qos_remove_request() for an
> +				 * uninitialized request.
> +				 */

Actually we are calling freq_qos_remove_request() for NULL values. This comment
and other exiting ones like this can be removed I guess. They aren't adding much
value.

-- 
viresh
