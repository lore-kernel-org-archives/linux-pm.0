Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D162C17A0
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774929509; cv=none; b=KGPqi5dCF5siXN8RZvA2XlXUGNABCeVZ2eVIuAol9OPPwe/thRaOmxkR1B3Zf8ujzlRrcco/6T1v9xauJjXYk5vQ3pEOVF+WmT/BmLFnDAep4Vk4osIOJzE/KTs95z1IbxAN7UVvyfzyrpBLSKP6i1Gd+tdqgJznGUEOcWIG7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774929509; c=relaxed/simple;
	bh=CKWUiaN2RiLETaEagraCv+cnm0hdGAQcNzxWWo0qR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvACJy3MvREVHsCHklnej5nlnlD3wnbvmn4S5qJpJbSMzCXbq5+1mPs0g+PnTh7AVHK9Mt7DExBrS8LYIdW+Jcpk9la574TehZjuE4qDeRwzfMI3c5oLnqCZQ/n0pisFjmOGA3wBzFqqGLE7D3HcR/aFkqb9wQkW8QpAEVtc0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iyX/tKcD; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyX/tKcD"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce09b4197so3397b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774929507; x=1775534307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5hKOFzrmuyT+Fo/rBHOrMU96jqQSTIXfDZlo2f/JTpA=;
        b=iyX/tKcDNDjRrRQtlVSgmX5YuHx3wXzvZjSGf3kH3AAl9BxtFI9+mgAi85D+biT58M
         00sZIrW0hkJewbZzd4Xs1pLjqSRIb1LMvGyZCv0V9RXmdGbqxsaw1of/VlGOfgg8Dh55
         DjRzVaJqxbGYTCjGarwFaBN/9FMTZlDkTpLKIpUjiAZxMMMg2tUL5qC81uy7ubIQnyrH
         Jb/WK5GpRfyBPLAmO9BGEzuAxz8BLu7jh31nh9hicGCNixU+LmFVCEOVmNvAbPm2+fcT
         Hn1IVbpTPAX1fa0vR+DCvA6LffjO7e02ew9MmCO1ES8wE5kydPDnk9x+29E7qKtkDwr1
         yrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774929507; x=1775534307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hKOFzrmuyT+Fo/rBHOrMU96jqQSTIXfDZlo2f/JTpA=;
        b=NYFFGYWFLTGYqVDeQcd5vdIXZijvpaQbC1yD2uFVEtXRPPUXshz+CdTGdtDivbe06q
         EkhyomFhsFBgz7XFEl6N/IYr/d0z3T1PrHW1Co+se41JgQ1TvA4rroba18JRcXoLJCfU
         M0eXxXcHywJjY7lZGmUL5AWYwae7bD3PAsVHyAgvqNBjZh2HoIFc0FgGvGFBXVQxHkw2
         ZJyuBTJMcTyCp+3bxt+OMkEbBb7+TY6PTLfj4JzUIyaklNd6krzq152h6ch5hmIbiSwl
         vb7SvddIRvesRALZUxIz6M0rD1gvDXQN8zQS/RR4itjhtoji559fwxRb0x0lCga/+od6
         HkTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0if5y/74LBZ3u8hxl5RdIQEJhc/+4yf2m915DBVLYky6qFB2jkQEmnyXRx74rR6verIo9I+yH2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQfaPCwgqxmEyfddRCr2nC7lMWs3OooR+7cBp0DWz6z/IPuW/
	R3yx/d/iNz15FlwUlvXBSdWJYZwbLea3k/cLUE9g5lW8FF2uQwSUj6WVhWi8+grg/os=
X-Gm-Gg: ATEYQzypYyAcnTqzQBlB4wWLje4G2gvCesfju1dJPBOX/Rf6BdS1dCvPojMq9syf/on
	va4W94EWxiqFt4A39VYwQlB/oSfbEssTD1kiYRbqcYFl1vATSzWzKCsbN6IpvysBcF0LDOsuTQQ
	HZrgeM4nZxyQFsYUWDrC2FZhQ1vYYtqnpzoVaeAmNVUR9yUWcL6Zc7wEHcRZGaBDnof8XWLDMII
	xYj+aB9TEB7y9gggULi6kub1pDod0iaV5zQ1gzcvpJ5d+GtixAmM0Em/N0KZ9ZIvWw4fvU7HdWF
	ovptvAPKm5wUT35wHsi6c0cbTq0BRfnfRO9lPrPpw+IkBMpAp2CFBSN0JDETDVgbDYYFzSCMdTu
	FOSYnmY8T+H9Eby8FwV3ajcTPp25/9j91/RUXudO53FISvjUt/Q3R9p26Suoy+wSSn2q1EtUMOp
	sEf8jytFpDJ96z3aVvHaLPcLAw
X-Received: by 2002:a05:6a00:3698:b0:82c:2155:5b6d with SMTP id d2e1a72fcca58-82c95d45bfdmr13481779b3a.12.1774929507167;
        Mon, 30 Mar 2026 20:58:27 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cc025659dsm4364966b3a.51.2026.03.30.20.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:58:26 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:28:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
Message-ID: <bi7zsa3vgtkebukepotewrh2xrbsej4gngnwmx53shn7pce3bv@px3gh4vp56tn>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
 <5syn6lnv4vfd3gapmlczkpkfob4oxrvfu3sozet2fog22mj5mw@mfyspzeruph6>
 <779ebbd4-d495-426e-bce1-020686c3f946@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779ebbd4-d495-426e-bce1-020686c3f946@oss.qualcomm.com>

On 30-03-26, 20:55, Zhongqiu Han wrote:
> Thanks Viresh — agreed, that approach makes sense.
> I sketched a small example along those lines for discussion only if
> needed: add boost_freq_req early when boost_supported, free the shared
> allocation if that add fails, and on later failures just unwind without
> freeing the block.

I have taken a different approach to fix this. (Build tested).

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c0aa970c7a67..f4a949f1e48f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -614,7 +614,7 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
                return ret;
        }
 
-       ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+       ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
        if (ret < 0) {
                policy->boost_enabled = !policy->boost_enabled;
                cpufreq_driver->set_boost(policy, policy->boost_enabled);
@@ -769,7 +769,7 @@ static ssize_t store_##file_name                                    \
        if (ret)                                                        \
                return ret;                                             \
                                                                        \
-       ret = freq_qos_update_request(policy->object##_freq_req, val);\
+       ret = freq_qos_update_request(&policy->object##_freq_req, val); \
        return ret >= 0 ? count : ret;                                  \
 }
 
@@ -1374,7 +1374,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
        /* Cancel any pending policy->update work before freeing the policy. */
        cancel_work_sync(&policy->update);
 
-       if (policy->max_freq_req) {
+       if (freq_qos_request_active(&policy->max_freq_req)) {
                /*
                 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
                 * notification, since CPUFREQ_CREATE_POLICY notification was
@@ -1382,12 +1382,13 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
                 */
                blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
                                             CPUFREQ_REMOVE_POLICY, policy);
-               freq_qos_remove_request(policy->max_freq_req);
+               freq_qos_remove_request(&policy->max_freq_req);
        }
 
-       freq_qos_remove_request(policy->min_freq_req);
-       freq_qos_remove_request(policy->boost_freq_req);
-       kfree(policy->min_freq_req);
+       if (freq_qos_request_active(&policy->min_freq_req))
+               freq_qos_remove_request(&policy->min_freq_req);
+       if (freq_qos_request_active(&policy->boost_freq_req))
+               freq_qos_remove_request(&policy->boost_freq_req);
 
        cpufreq_policy_put_kobj(policy);
        free_cpumask_var(policy->real_cpus);
@@ -1452,57 +1453,31 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
        cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
        if (new_policy) {
-               unsigned int count;
-
                for_each_cpu(j, policy->related_cpus) {
                        per_cpu(cpufreq_cpu_data, j) = policy;
                        add_cpu_dev_symlink(policy, j, get_cpu_device(j));
                }
 
-               count = policy->boost_supported ? 3 : 2;
-               policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
-                                              GFP_KERNEL);
-               if (!policy->min_freq_req) {
-                       ret = -ENOMEM;
-                       goto out_destroy_policy;
-               }
-
                if (policy->boost_supported) {
-                       policy->boost_freq_req = policy->min_freq_req + 2;
-
                        ret = freq_qos_add_request(&policy->constraints,
-                                                  policy->boost_freq_req,
+                                                  &policy->boost_freq_req,
                                                   FREQ_QOS_MAX,
                                                   policy->cpuinfo.max_freq);
-                       if (ret < 0) {
-                               policy->boost_freq_req = NULL;
+                       if (ret < 0)
                                goto out_destroy_policy;
-                       }
                }
 
                ret = freq_qos_add_request(&policy->constraints,
-                                          policy->min_freq_req, FREQ_QOS_MIN,
+                                          &policy->min_freq_req, FREQ_QOS_MIN,
                                           FREQ_QOS_MIN_DEFAULT_VALUE);
-               if (ret < 0) {
-                       kfree(policy->min_freq_req);
-                       policy->min_freq_req = NULL;
+               if (ret < 0)
                        goto out_destroy_policy;
-               }
-
-               /*
-                * This must be initialized right here to avoid calling
-                * freq_qos_remove_request() on uninitialized request in case
-                * of errors.
-                */
-               policy->max_freq_req = policy->min_freq_req + 1;
 
                ret = freq_qos_add_request(&policy->constraints,
-                                          policy->max_freq_req, FREQ_QOS_MAX,
+                                          &policy->max_freq_req, FREQ_QOS_MAX,
                                           FREQ_QOS_MAX_DEFAULT_VALUE);
-               if (ret < 0) {
-                       policy->max_freq_req = NULL;
+               if (ret < 0)
                        goto out_destroy_policy;
-               }
 
                blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
                                CPUFREQ_CREATE_POLICY, policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b6f6c7d06912..9b10eb486ece 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -79,9 +79,9 @@ struct cpufreq_policy {
                                         * called, but you're in IRQ context */
 
        struct freq_constraints constraints;
-       struct freq_qos_request *min_freq_req;
-       struct freq_qos_request *max_freq_req;
-       struct freq_qos_request *boost_freq_req;
+       struct freq_qos_request min_freq_req;
+       struct freq_qos_request max_freq_req;
+       struct freq_qos_request boost_freq_req;
 
        struct cpufreq_frequency_table  *freq_table;
        enum cpufreq_table_sorting freq_table_sorted;

-- 
viresh
