Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE932F740
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998344; cv=none; b=l9jEA0Wos9SENU5c7lo5Yo5+B6m1P9ggYU9mBSXPCBp7sa8vpfSuAgGhQ305bFiBPW5bWszQMzlRo5Oqqi4x6MyQlB970YRNNgOLMbbbmIdu/Tm4W6ZyH0R965Q/wl2Z8EAv3eCkHSjgdZ3jNY33r2pvj0VZ2X/Tmug/QOePxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998344; c=relaxed/simple;
	bh=rZQTu8BpQRO0kenAnmeGACVcgGEhX6HZJ3rkGeAgvAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR6TN1LFeji3EATJUFTfV6i5V8qauoslDWX2BO9wm8Hf0MknwygnqtLPlikbfZnSoTmYMMVuI0Kymcom2yMZzXV96DmPuhLTrVJneX770EViGw8b/jr281FhKcQYa8R8CO/5kYc/yf3YOQ/s2eiEYRzE/96peeKi9cxDvnkqhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IuOpp/AG; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IuOpp/AG"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so1255733a12.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773998342; x=1774603142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNzCa4knkipxoGQ40yGebNVctSnxZ3mjOA50rHztKvA=;
        b=IuOpp/AGO8Z1bCLK14HvcMBELDwqNvDLTZOkDTypawxB0jDuZnscsn1nVdhzBvHTbA
         zLjLLSsDQ9lNWOnvB9Xh1qthldjOpgFcK5FGN2sfarjnoGpvciPxNfYqQAgp6mBVBGnK
         nOowU7SAvX+kVC/yTF/6CNhqwyTsJVCLhgdv4ULika+8SoEBAxdXgRF1GF1tolYiYpa7
         5jQppqhJmXdICK5fSZaMLcG7L4wRpJTi3I1SXmCDtHA+C3THcAWGdisC8xmg31FQaOr3
         Z111ztfETvQNB9TteGCAD8/L5oKxAQunsP9g5GPRrJYkZpj0mIwlX/43Nm0miZbHH5lo
         S42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998342; x=1774603142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNzCa4knkipxoGQ40yGebNVctSnxZ3mjOA50rHztKvA=;
        b=B1yZtqoBRyQR77aCQ7Xx4mKHkgDtIUGa8Y8Tg3F/bii0R56bAksiIbnbxrcN1Gnxrf
         DIlSxiOZR44GvEBB8Hn5ja/cBLt/MgsWF/kDKdK/YG/r3DmCoDmezSKmBulT45CuKe99
         t8RSauavMPdZU1uPY61FjQufqJZKzGbQ04G7YIMqeaSYnkEPE6zasx/tHIFmKFRTHd1p
         PtQkl0POkEjYXSFY9Hx/1iCp1H55AkMnrgsixhejw6hacq6hJ2ahK4vpOhYbR7jFw6Mp
         I+fTZD7gVZBt1Bdpd0CYVmBFnzLoS2KkqFmb7eTgnmwKuRQFVyv2dlc1AY9dXt6IQYK+
         QTUA==
X-Forwarded-Encrypted: i=1; AJvYcCVMseIGvakmH0/aXaVrvxf5BRw4/J+1t6VBoeIpGd4cpvd+IrznLbfd/mr0gCS9rom3aKrsTDAK0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgRFzjAPsh0Uxh5yKWKhT26QwytF7h/VOzg8bMccXpVPiabaZ/
	aUHNDHsCi9KSF4uh9i4qyJHWrA7E9QtUMQ9GhFc7XdXXLvrjBbFg2PwRkfAste3dPp8=
X-Gm-Gg: ATEYQzxyH8y9hpkHfa2ML/a4zyC5H/0nLa8H2d50ioIDMjIHMOrK+vSUpEYs+ahPr52
	wbTt6cTg+JaXz5qOOManZ1f1+Y4UzEjAEGJL58BOd0fplR2oY6K1rqtPvMw/Hzwjq6+g81D98m/
	FeaBoWgs3mnXF1dVl+uxG4/zduDXhPR4KBTnAC03/B5b4AjCsM03YKEmeZIhM5eVNaVSDzjLpHq
	KRcNgXRqC7/sPOcrliRIksC7Hb3hyzwgRnRYkSCBsWGpC0CwgRr+kxd3tDgydXowV8djEiltYyj
	HcAif1+9WSC4plt9bBIV5DIHewJs/GFxJ+jZUc8Jra0JjemdIxhdk591Pl1JrhrZJUf7nvMFXTP
	D8qCGEOoRfjE4u4DvRjwlyQzmA/zDJzMLFWj8vU4oCCapCSKUEQ5jCYC7Blsz9Ar7Fz3LFn7Q2S
	CMxAsKnpb1lMIWnYMOk0x4+ikX
X-Received: by 2002:a05:6300:210a:b0:398:970f:eac9 with SMTP id adf61e73a8af0-39bcec4dbbbmr2226408637.58.1773998342221;
        Fri, 20 Mar 2026 02:19:02 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da438sm1505742b3a.43.2026.03.20.02.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 02:19:00 -0700 (PDT)
Date: Fri, 20 Mar 2026 14:48:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
Message-ID: <5ulxqpnblsbxhcg5m2rfscrvkokd43wwg5sihml4oytcsswh43@lqdwn5tqopf3>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-2-pierre.gondois@arm.com>
 <46wu76e25pscn5tkes6uabtgsqxev6wvi5pihrlozobyadmuqq@ffvqv43nys23>
 <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad23c89f-776e-4788-88ee-08583c0aadaf@arm.com>

On 19-03-26, 10:30, Pierre Gondois wrote:
> 
> On 3/18/26 12:13, Viresh Kumar wrote:
> > On 17-03-26, 11:17, Pierre Gondois wrote:
> > > policy->max_freq_req represents the maximum allowed frequency as
> > > requested by the policyX/scaling_max_freq sysfs file. This request
> > > applies to all CPUs of the policy. It is not possible to request
> > > a per-CPU maximum frequency.
> > > 
> > > Thus, the interaction between the policy boost and scaling_max_freq
> > > settings should be handled by adding a boost specific QoS constraint.
> > > This will be handled in the following patches.
> > I don't think the above is required anymore. This patch is removing stale code
> > now which isn't useful anymore. It has nothing to do with a boost specific QOS
> > constraint.
> Yes ok
> > And it would be better to know for sure why this isn't required anymore and
> > which patch exactly fixed this issue.
> > 
> On a kernel based on 1608f0230510~, and replicating the
> process described in the commit message of
> 
> commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
> a CPU")
> 
> I could not see any issue regarding the values of:
> 
> - policy1/cpuinfo_max_freq
> - policy1/scaling_max_freq

The commit message (of 1608f0230510) is confusing. The issue was discussed
properly in the following thread.

https://lore.kernel.org/all/20250120082723.am7rxujmdvzz4eky@vireshk-i7/

The problem is that policy->max and policy->cpuinfo_max_freq are incorrect after
the sequence mentioned in the commit, while max_freq_req is correct.

I think another commit has fixed that (incorrectly and unintentionally):
commit 6db0f533d320 ("cpufreq: preserve freq_table_sorted across suspend/hibernate")

@@ -1421,9 +1421,12 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
                 * If there is a problem with its frequency table, take it
                 * offline and drop it.
                 */
-               ret = cpufreq_table_validate_and_sort(policy);
-               if (ret)
-                       goto out_offline_policy;
+               if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
+                   policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
+                       ret = cpufreq_table_validate_and_sort(policy);
+                       if (ret)
+                               goto out_offline_policy;
+               }

This skipped calling cpufreq_table_validate_and_sort() completely on online and
so max/cpuinfo_max_freq, max_freq_req are all in sync.

That change should be fixed with:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913..1f794524a1d9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1427,12 +1427,9 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
                 * If there is a problem with its frequency table, take it
                 * offline and drop it.
                 */
-               if (policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_ASCENDING &&
-                   policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_DESCENDING) {
-                       ret = cpufreq_table_validate_and_sort(policy);
-                       if (ret)
-                               goto out_offline_policy;
-               }
+               ret = cpufreq_table_validate_and_sort(policy);
+               if (ret)
+                       goto out_offline_policy;

                /* related_cpus should at least include policy->cpus. */
                cpumask_copy(policy->related_cpus, policy->cpus);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 7f251daf03ce..5b364d8da4f9 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -360,6 +360,10 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
        if (policy_has_boost_freq(policy))
                policy->boost_supported = true;

+       if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING ||
+           policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_DESCENDING)
+               return 0;
+
        return set_freq_table_sorted(policy);
 }

-- 
viresh
