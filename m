Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC931717C
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311274; cv=none; b=VUGnki0ZXn7lPxqv1rVwmvcjZLhMIX4p8gfMWYNwZD4wGD/GOv70gyPQxJTFUlk/HBN1tUPOVfSOLSRrcHreYx0yT/4ZPdPtX1N1Ap7PUb4Xb0uyp/bKbcu6B/yEtuVsKHgnOXGnAXKeTZ8rindyu522pGnjes30pjiPLvSw6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311274; c=relaxed/simple;
	bh=J1xyOkEmiOAjdiWjT1Vd3Vh/fiDoVKIED4h5yAZ2DWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi8lW2O+1im7MMG0P6nDXBeeDjSgGAf1Yhy0ybDYIpEAJK6pYpMFoUUsYWC/ANyi1oVZ/J6YMWWRz499SsmfLq8VA9NoJt0jDLIZp16LCfm/04ohcb4PM7TYwSb0TxRHEyxeevr0extaxDYTo8svOsAm1/ZvxbPTwaB4SiD0kUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VY8mQmta; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VY8mQmta"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae43042ea7so11028485ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 03:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773311272; x=1773916072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEV4nPJqXpdGF5L8MbJx/3cKslIIA/yVZckWmA+Jr1U=;
        b=VY8mQmtaKO6DYeSyYBu+obhQccAySNYLfhaiC9NkMF6rTUFgnrhQgBokNTLKsMxQUV
         sJrWYPOUo2XeWW77hym9WjVEbvK5fFzolTNKRIGutPF6LXqh1pL5L5c4jprkpVC+oCYj
         nEjU1QXCcFLqv1ZPJdUjuuLcZkSM0vY8MQS2VDh/awAeWzXpHxt9CW38DG5sL8YMKGUM
         NHpHYK2x79ol2wSpDcoM6GKthVSeNp5HtY/lx7epXF3T99V3mEQTkaOc7GkRcRDaV7rg
         v1X3HSXxAxJwmpD9IElccU+kjRmVJSOJo1E0oD3a/0/ug/iWjre4RXr6CCt0jPoiEu3a
         7PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311272; x=1773916072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEV4nPJqXpdGF5L8MbJx/3cKslIIA/yVZckWmA+Jr1U=;
        b=KFDnll2YDFjK+3vTMwfru1CEeRgDUnr+4dlal2d2p0AFL082FmVUxxAJsyO15tUEZc
         flrTq8S9HsSCpGh56Jop4s86D+ljXSVF5rBRy0FF8zpJhtqY1mzryjU5U8ub0ZZv3x5J
         LEb/1XEBtDSkvNyxXizN3MpnnwxT+J9wenSApFhAD+fH/1tlCh8BmggG7RXfLemnNwLn
         623HuHfrZExIW3g0p+Ejy0E5ESCij5MkIT4Q7/BaK3pRVsrmp58AjHk6OzweFKSdxe3t
         4oo9woqdIcH5uFvMzUn1M6kp6K341u8vIFXlPi9vYazyF4mAfM1QBuU5l1IfiuIKdCUE
         cLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6HqsMIZlVCrDlCHHzzrrMukw0XrvdVFhugs6JRBi4+jHCrBuGJBMo0+HJn63iCvYB+UcP17zNiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzACYMggpdpBDkdvYd5+thY4xPImhrwZ2THxGHV8r33BMpfXUyQ
	oWG4RWNmhbvBKSSg8hVDqJDvo5/RJrjpSK2pFd7rK+lybasOas2qJ3pFXCdvfLAzmLQ=
X-Gm-Gg: ATEYQzy3aNbphorfrorj7DewAh2Ael1yv2oZHQazrpBovZnvKX5/LZpn8hmElRNq6XB
	fHJM3QtnqzQeCFrjh8TahN11dzLaUZ2Sxl32a2TETyz5Cwlzx+DH46ohQmdVYae9J7zYqcCyyiQ
	IblULj50bj0jBjTPXsdsmzZvgIsTOWxwaNcNeDS//JHzCXDlDrw7FwzArgNovOGaP2uUj5xSGJD
	HPOvzR9P9ppvzxvjWAeVHWhwQ6xgwR9ttCLvnM94xWXi1U7b8O0L1Atz/CkXfXl7AkjryuXch6a
	TBHqp3XtbwSRaVdLNfYV2e2VR6sNK7GQZCQ84pdKvdqgyGV1WwxQS4dNZqq2WG6cR0fdNz0EpR/
	SDoF9j+4w0noPm4smopmJH76ht83unCtBFhwp+eN5EoTgXUeM5RMECng5lHw6XEwIHulylfGdqE
	xOCkN4gZ4Ch3ESTtk5OA+MtRdn
X-Received: by 2002:a17:902:e892:b0:2ae:483f:b23c with SMTP id d9443c01a7336-2aeae85b1f6mr61731285ad.36.1773311272182;
        Thu, 12 Mar 2026 03:27:52 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222900sm54831785ad.6.2026.03.12.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:27:51 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:57:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: conservative: Drop cached requested_freq
Message-ID: <u4k5z6yilgjqajy6a4zxyt23tgmtp5hxqm6jlc55y2ize4rs46@3czv7uoybqbz>
References: <c3e22128e6619d24f3fc6ac07d1c854c664a7f1e.1773124395.git.viresh.kumar@linaro.org>
 <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05feb9ed-3257-452e-98e9-89637431a347@oss.qualcomm.com>

On 10-03-26, 21:17, Zhongqiu Han wrote:
> Thanks for the patch. The fix looks correct to me for the reported
> issue. I do have one question though - should we also consider the
> interaction with commit abb6627910a1 ("cpufreq: conservative: Fix
> next frequency selection")?

Thanks for pointing this, I missed this change.

> However, that change was subsequently reverted by commit abb6627910a1
> ("cpufreq: conservative: Fix next frequency selection"), which noted
> that using policy->cur directly broke the algorithm when freq_step is
> small relative to the distances between available frequencies. In that
> case, the governor may not be able to stay within a narrow range
> between two consecutive available frequencies and instead jumps through
> steps faster than intended.

Its the opposite I think. The governor stays within a range and never
goes to a higher or lower frequency. This is how I think this happens:
- Lets say frequencies are from 1GHz to 2GHz with a gap of 200 MHz.
- Lets say the frequency is 1 GHz now and the step size is 100 MHz.
- conservative governor will try to change the freq to 1.1 GHz and end
  up selecting 1 GHz only (due to CPUFREQ_RELATION_H, highest freq
  below 1.1 GHz).
- With my patch, we will keep resetting to 1 GHz (cur freq) and never
  change freq.
- With a recorded requested_freq, we will move to 1.1 GHz (actual 1
  GHz), but a subsequent call will go for 1.2 GHz.

Here is another idea, once everyone agrees I can send this formally:

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index e0e847764511..df01d33993d8 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -313,6 +313,17 @@ static void cs_start(struct cpufreq_policy *policy)
        dbs_info->requested_freq = policy->cur;
 }

+static void cs_limits(struct cpufreq_policy *policy)
+{
+       struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
+
+       /*
+        * The limits have changed, so may have the current frequency. Reset
+        * requested_freq to avoid any unintended outcomes due to the mismatch.
+        */
+       dbs_info->requested_freq = policy->cur;
+}
+
 static struct dbs_governor cs_governor = {
        .gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
        .kobj_type = { .default_groups = cs_groups },
@@ -322,6 +333,7 @@ static struct dbs_governor cs_governor = {
        .init = cs_init,
        .exit = cs_exit,
        .start = cs_start,
+       .limits = cs_limits,
 };

 #define CPU_FREQ_GOV_CONSERVATIVE      (cs_governor.gov)
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 36eb7aee4bcd..acf101878733 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -563,6 +563,7 @@ EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_stop);

 void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
 {
+       struct dbs_governor *gov = dbs_governor_of(policy);
        struct policy_dbs_info *policy_dbs;

        /* Protect gov->gdbs_data against cpufreq_dbs_governor_exit() */
@@ -574,6 +575,8 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
        mutex_lock(&policy_dbs->update_mutex);
        cpufreq_policy_apply_limits(policy);
        gov_update_sample_delay(policy_dbs, 0);
+       if (gov->limits)
+               gov->limits(policy);
        mutex_unlock(&policy_dbs->update_mutex);

 out:
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..1462d59277bd 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -138,6 +138,7 @@ struct dbs_governor {
        int (*init)(struct dbs_data *dbs_data);
        void (*exit)(struct dbs_data *dbs_data);
        void (*start)(struct cpufreq_policy *policy);
+       void (*limits)(struct cpufreq_policy *policy);
 };

 static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)


-- 
viresh
