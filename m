Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12D23182D
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394707; cv=none; b=VGEe4XjPLWJwL2X7gd5KngMXGGkD5PSHSUTaxkuis3Mfu8i5IKT67ZlJ22FOyVeMMVswrli4fWwAjlkn7oltlURDgnDHoYlWiZgCHOwpQHh4H8dy/tkgx4yJk+PLanTbKF9Osjy0rZzW+PqzgmkI8r33GQApUuoFTxnjyCr/gpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394707; c=relaxed/simple;
	bh=62to3TH+mBHW0dnXN3dXec3rKXpDVFxoin7Rci6S2sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhD0BO5RtDsW8cVjaTDfHxbR9yd/x4M+/Gm0pVdekrk0s4S96ctmOyQdfFhVOP8S14hWCVLyWwB30HPMZIebkY3iVqYmD6Hx4xUMrVmmct80vcPLmbAQUybDgNw52mgjCQauQ8k65MG1G6pSgfzUgLuZFls+B/4maMsm+N4HyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEv4THGz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEv4THGz"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a072db915so1697157b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773394705; x=1773999505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xh1m5Jxie0Szwqq0ZeM2vfuZe65duDSTn+5ZSarHxZ4=;
        b=FEv4THGzvP6POYS+cBvcsjn+wpdNwxNbP+NVwM8WGfNGKmgLa6nrTMlMd3YlmS3ECk
         QI73TwS86PZU55/iKDV5z05VqagIG6ItHoVFSf/NPaIQOaIyzFcNGjg0z9H0tpLz4aJI
         OJ3QAPfgD3PDMkygMtUZoYsRkT7rUdezWRASTHXqZjayQlVdNDtZXyogWmMrlKIP7VB1
         NWkbdSpujGqXrOU3UHR0+hwKVO7dGQYQUjkoO7R/sQe/oQ1yBzj5IyhDxWNwO42WY+iO
         B8xjmeIISYbCNQP2pQdYBCs7ijb9f2FUptWMDVVhN96PAsn8IzMba8A+zycgtb8ClTxr
         K/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773394705; x=1773999505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh1m5Jxie0Szwqq0ZeM2vfuZe65duDSTn+5ZSarHxZ4=;
        b=sBG+KytIEb/kZ9xGF95EoYovTNhZe86hxawIQjIZtoguOywR/f1dbEuGr7RaWjhLVN
         bwaZFk1hEBYfb/WmQTnhY66Mio8xgeRbpcnEtMnwpu5ozsAwA1lXrfCa+BAaJEtSp0hc
         KAwnUvCS19HFzjf3YC2vDuW/P3ii5fPSLvSiwJaDHOW85zPmLLzy+YjPqDbSxkStYLE/
         u3y6ibrRA23fhNO/Yi/C3JPS1nX81zZIA8UY3NrosaHNTpfzf7YBdU4aIgtluxPFJtsz
         x0gxVZR3h2mcLncs2yIdPjkAUCeJNacpUWoxl7lgmqN+XZIsKv7T6bksDDqbPSDt67NV
         81pg==
X-Forwarded-Encrypted: i=1; AJvYcCUU+uD3/PUDAvETskCy9UZC/LJXknEe3qXVgR6gcyAkuPmW3NzbfvcQTdM1XwFuJTxQBhs46muREA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3jgZmN7by/Zl+4dRkQ5Co1VNnrkS5cniGP3hPQtIp6qVL/Td6
	8vx1hzNO546Ijnyf4jwLjKP9mf/wsmzTqdFIjEmJa9l0c88Kr+mgThVldysT4lNEiUw=
X-Gm-Gg: ATEYQzz42wi90HJio1VdkNKAGs/lcWXUpDYeS97VfYg1CdMUPWY2hwbJcvnjuRacD1a
	4v2YU7l4/tnpcJippP1YcSMnypDL4EwKU4J/y0VS4GGddC7ckbC3GheWMFsAhlFtWOVx+x8/aAK
	4I1QGXaXsZW8tmyE06UlTxZ1X20bgKGto96iADj/mFOb3jhWZ/x4IGFpnCrcTMqJS0V4ikf+lxy
	O+vs/mt2WBzKEYSs0gTjdZd8eZOe3JL42ot77il63QGzBXGYf9oGNEhniv1xMkXQK6z/swcXhpe
	EsIK7pAyb8FRxzkB2wjOkYb3qKWVjw+K/vwFRw0W/CLgfoHbYkS0HgOijQ4Z70L5YcgorN+CL3g
	QyNqwpkjCsZ269fsQdjmMpkhhlVXljyzFmW4Fc94li9FncwfaHZ51kXRrKtVkHNKUlEkLh9y7M/
	cInEm6ckdkhG4wR+cQnuXx48A1
X-Received: by 2002:a05:6a21:389:b0:398:8321:7499 with SMTP id adf61e73a8af0-398eccc0027mr2358513637.37.1773394704906;
        Fri, 13 Mar 2026 02:38:24 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb62f0esm1425352a12.17.2026.03.13.02.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 02:38:23 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:08:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Christian Loehle <christian.loehle@arm.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 4/6] cpufreq: Update .set_boost() callbacks to rely on
 boost_freq_req
Message-ID: <kz2xmjoq6ckf6hykougeimo2fdo5tbjhmffsgk4yfgfwkd43yg@uiixgymot7uw>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
 <20260225084930.1692228-5-pierre.gondois@arm.com>
 <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jMsphO=tcHWMeJXE74Xk4HZyCqyMDRU2XZ+HrfxoVZbw@mail.gmail.com>

On 11-03-26, 17:19, Rafael J. Wysocki wrote:
> On Wed, Feb 25, 2026 at 9:50 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
> >
> > In the existing .set_boost() callbacks:
> > - Don't update policy->max as this is done through the qos notifier
> >   cpufreq_notifier_max() which calls cpufreq_set_policy().
> > - Remove freq_qos_update_request() calls as the qos request is now
> >   done in policy_set_boost() and updates the new boost_freq_req
> >
> > Note:
> > cpufreq_frequency_table_cpuinfo() is also called through:
> > cpufreq_policy_online()
> > \-cpufreq_table_validate_and_sort()
> >   \-cpufreq_frequency_table_cpuinfo()
> > which relies on cpufreq_frequency_table_cpuinfo() to set
> > policy->min and max initizalization at driver init. This
> > regression is solved in the next patch.
> >
> > Note2:
> > acpi-cpufreq.c seems to be the only cpufreq driver not
> > setting cpuinfo.max_freq. Populate it the nominal frequency at
> > driver init.
> >
> > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c |  1 +
> >  drivers/cpufreq/amd-pstate.c   |  2 --
> >  drivers/cpufreq/cppc_cpufreq.c | 10 ++--------
> >  drivers/cpufreq/cpufreq.c      | 16 +++++++---------
> >  drivers/cpufreq/freq_table.c   |  7 +++----
> >  5 files changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index e73a66785d69d..6a6e26e1be14a 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -857,6 +857,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >                  * governor from selecting inadequate CPU frequencies.
> >                  */
> >                 arch_set_max_freq_ratio(true);
> > +               policy->cpuinfo.max_freq = nominal_freq;
> >         }
> >
> >         policy->freq_table = freq_table;
> 
> This looks like a fix for acpi_cpufreq that should be sent separately.

cpufreq_frequency_table_cpuinfo() (called before this) should always end up
setting cpuinfo.max_freq properly and so this never broke earlier.

> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index c45bc98721d24..310d5938cbdf6 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -756,8 +756,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
> >         else if (policy->cpuinfo.max_freq > nominal_freq)
> >                 policy->cpuinfo.max_freq = nominal_freq;
> >
> > -       policy->max = policy->cpuinfo.max_freq;
> > -
> >         if (cppc_state == AMD_PSTATE_PASSIVE) {
> >                 ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
> >                 if (ret < 0)
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 9eac77c4f2944..4c46c7ea318eb 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -775,17 +775,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> >  {
> >         struct cppc_cpudata *cpu_data = policy->driver_data;
> >         struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> > -       int ret;
> >
> >         if (state)
> > -               policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> > +               policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
> >         else
> > -               policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
> > -       policy->cpuinfo.max_freq = policy->max;
> > -
> > -       ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> > -       if (ret < 0)
> > -               return ret;
> > +               policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
> >
> >         return 0;
> >  }
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 42de32488f422..20266fb42d18d 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1500,10 +1500,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
> >                                 goto out_destroy_policy;
> >                         }
> >
> > +                       /*
> > +                        * If boost is supported,
> > +                        * init the constraint with cpuinfo.max_freq.
> > +                        */
> >                         ret = freq_qos_add_request(&policy->constraints,
> >                                                    policy->boost_freq_req,
> >                                                    FREQ_QOS_MAX,
> > -                                                  FREQ_QOS_MAX_DEFAULT_VALUE);
> > +                                                  policy->cpuinfo.max_freq);
> >                         if (ret < 0) {
> >                                 /*
> >                                  * So we don't call freq_qos_remove_request() for an
> 
> Why do you need to update stuff introduced in the previous patch?
> 
> Is that because policy->cpuinfo.max_freq is not set consistently
> before the changes made here?  In which case, wouldn't it be better to
> make all drivers set cpuinfo.max_freq consistently before making the
> changes in the second patch and fold the chunk above into the latter?

Since cpuinfo.max_freq is set correctly earlier, I think this can be done
earlier only.

> > @@ -2818,16 +2822,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
> >                 return -ENXIO;
> >
> >         ret = cpufreq_frequency_table_cpuinfo(policy);
> > -       if (ret) {
> > +       if (ret)
> >                 pr_err("%s: Policy frequency update failed\n", __func__);
> > -               return ret;
> > -       }
> >
> > -       ret = freq_qos_update_request(policy->max_freq_req, policy->max);
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       return 0;
> > +       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
> 
> This also looks like it belongs to the second patch in the series.
> 
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index 7f251daf03ce3..9b37f37c36389 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
> >                         max_freq = freq;
> >         }
> >
> > -       policy->min = policy->cpuinfo.min_freq = min_freq;
> > -       policy->max = max_freq;
> > +       policy->cpuinfo.min_freq = min_freq;
> >         /*
> >          * If the driver has set its own cpuinfo.max_freq above max_freq, leave
> >          * it as is.
> >          */
> >         if (policy->cpuinfo.max_freq < max_freq)
> > -               policy->max = policy->cpuinfo.max_freq = max_freq;
> > +               policy->cpuinfo.max_freq = max_freq;
> >
> > -       if (policy->min == ~0)
> > +       if (min_freq == ~0)
> >                 return -EINVAL;

why are policy->min/max assignments removed here ?

-- 
viresh
