Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3E3B8D5C
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029002; cv=pass; b=jRmVndItwdzAJQ2yVfsgqZNn3Civ6EeVkdPRmJgt4v5x7dwrC7smb9CAyZWPbJuSwqzSEWy80LSk+P7L8WtNLqCZdSulp7UWdQaZ1XXwmJnWM1hy5wwxp1iFG9g/gLpjoKrVVRdXDeidsqIefMAQr1IzKiyv5o53vn6gKVQky/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029002; c=relaxed/simple;
	bh=jYl3DK3BhBK+zFOv5DNY1Gfw/aQFs8lC3p6XWAnxYrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaUF7uwjJML48swB+ZDlRsJwX2vXi+OxMaGGUWtqGY5iaW5SLLfApSf8wji2pgitzmp3qxYbxsSa6RM0SOtQ52NPgtXWkT33lVfGT23dNFrTL6G1Ga9C2cybxK4hE0iMy5zkeZbJAD/SysKB5jqHdz79CTVLHGsnv/paaEkT3G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wnSWc+aK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wnSWc+aK"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so3804324a12.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 08:09:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028997; cv=none;
        d=google.com; s=arc-20260327;
        b=g+NSXb9VvYkYZw4PWZki2MF++EQObBUEf+MgRwFYuqdFdaUSSHB6R/jTLjE2RYhDGk
         4XSbX5p6lNhbHhNyv9NU7FlYs4jS387vYqXN2nX0KazLo/EzZOh0Bob7poiamZPsHkDZ
         mB2MWhxpLCMnLLFsRE06cMlV1oQVXJLpj5G6tQkXqchk6cK0Z7wARLoum5G82zIkl7er
         7nEORaGHNcxifaSMY2zJqBVb3vv15pUUDski1RLoJ+MXVpOGbru1FjVgrPlI0Y9FdlYP
         A8r9vEzrFHn4yMbpK6eSscv3FQOEFaoZ0e+SKHLPZgn3yXE1564NGUs7+PudEJHJQgNo
         e8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OxXOttn4/6La1ScFYSzgU2+AyGQ80Sk79RUTUfXbg7o=;
        fh=laopl8RZJkEEIld/mmKfDYw2zm+b49nfFYMMuGqov8U=;
        b=lV9sMzvjfinQWy+iUXGRqhSCbJOq+CCLY4SKUW5P/Z/K36te8zM31VbLJOJffAEw/m
         0NbDbwnbORjss0iBhfZ7e+d7w7p3eD2ybpt+CfTL7ZiQPUDML1vgpaz6Cd0rHTDvEPQZ
         vJVJdjyJMlCCDMTwDPyBUr4aq+Hkj5Ko7CJ77TnYTkxZlLIv66a1v8cUaKTAfZ+c/PsW
         johDl7jpGHNJryKa5QHWW7ttnf7HT+lgA1iM2Tjie/rqSc7R1I2LghF4lDAFiPbRtYvt
         TZIntj6c/9yJhE0Y6qcNly/bFZQtZqIT8v+1K07Hdhi0G8BLQhLcD6vTm9Mpf9XvfQbs
         cwtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786028997; x=1786633797; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OxXOttn4/6La1ScFYSzgU2+AyGQ80Sk79RUTUfXbg7o=;
        b=wnSWc+aKD1e/Nuo9a3hxDKWhykMYFg6XyEUOqI35qidiSvqc6xbzen/J3fbMo9nVzy
         W17tXru2Ov6XiJ23jIjkCJQOaLhj4vqiKfc6fdLZcPH06MwlyniVBxZjiiwiMbPhdgfV
         OFMPJUlvqNHT2assZ06VZj3hAPviyDktq4LfGGfmS4K/G8ryrPywUvAY6cY+FldfFTpb
         /URMrvVaL0GeRXooojdABi3+cOzUBZJmDKAJB/mOUAoHORej1XVOYiMPgHX9tzNg3PaT
         7eLsduZUx8uYOip2PY38RYkhkARRb3+mtSKVvKW3qorA/4hM/thm0O1SEkP7iVfFWNKK
         DdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028997; x=1786633797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OxXOttn4/6La1ScFYSzgU2+AyGQ80Sk79RUTUfXbg7o=;
        b=oZl0sLd1FPJSOtz50pHyNYq0tH+C4y4uohY43iKtGIkYLMZNPdVyqDN6iHayVqGuK4
         Bd+pvf2INS1FXfDHdcPFvRe2XFxUh4UmU5komZ6A6gjcrBjMtLeBeGdGka38ec4iR1oq
         n/uzHgMWh4apN2sA9IEi8FmqVjU8AxHyc9SKOwem6pULGqQvxG9c9QYuRkJdC5MC2KM4
         0KGU+zRWBq8rHCRlx6fHBR6BMwZyZ4qzD9frWv8Nc+vo+X6Fu+KyHBPDeI65nq1P1QtS
         v1rr0LEOBMfEVt7FWb6agTsrBT1fInNKnH20J96je3nBBxzJeU3qjU4D7QHqQ2inHojy
         aT9A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4mEtBKinrvV8GaEPU4UMsbVTgIMBD0RhVKLD6uQGRkHDIVsXAq9R/mWJYYAOuYdwgOn0MSATFKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCH73QXAZ0X5RlW01cldj7AGIy7MQjYEoVtE7gQpapgZBbMC4n
	9IvmVK6/ggg39Wt+IlriBuPQM4CaNeXQEj9rumsu9BCacclJSGDmszUsx94s4+exz3a8MmGg9u+
	1lAUtS75p1ST1liumNO6FXrdj1ZI15m9SudgduIenHQ==
X-Gm-Gg: AR+sD107KczcyU9fJQqCBtMcMiR3LlnGvi83S0gHAOUfTkq2HknFiTmojkGUhrbofcI
	a3OYP0OY5QBUlt4UJIDRO9EURX30gnj935mtdLPJJ+V//6w9tDZtRV3AWPMClu7bS7gVVLk+ojy
	eeCWuDdjQ3t2kFgXpbFSXvEQT1jv6h6sfwyS07so6pj7OaxZFvcX8d7ReoB8g07zpefvtHs0fNG
	2hedVkojyfawmM1Cr+GD8rk0ighSTlHv9RKLNos0PKFOBxk8wPWIbeCjIZByu8++TZ4TlWMJzd+
	XwEQG7abS9eQHseXmWNJXtGVHqrivMAUiGT8oG+50D+LZ+1m+ABRxE0+mQYxKUvOLMXCebNnKIz
	xQw==
X-Received: by 2002:a05:6402:52c6:b0:6a0:a4f5:f4eb with SMTP id
 4fb4d7f45d1cf-6a14f0a1377mr7618903a12.4.1786028996999; Thu, 06 Aug 2026
 08:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806044230.909961-1-sibi.sankar@oss.qualcomm.com> <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
In-Reply-To: <20260806044230.909961-3-sibi.sankar@oss.qualcomm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 6 Aug 2026 17:09:44 +0200
X-Gm-Features: AUfX_mzSIdwShrQlXVdrDq69AdNorYGcbP_qqXwCDVJZiJIbHEn99nHYEE157-k
Message-ID: <CAKfTPtDQ+843t5fgknAMcfkYP_ZLxxYU8D+KJtx8QzMy=qMoCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/cpufreq: Update schedutil's DVFS request to
 reach the boost frequencies
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, linux-arm-msm@vger.kernel.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 06:42, Sibi Sankar <sibi.sankar@oss.qualcomm.com> wrote:
>
> capacity_freq_ref, exposed to schedutil via get_capacity_ref_freq(),
> was introduced by commit 9942cb22ea45 ("sched/topology: Add a new
> arch_scale_freq_ref() method") as a fixed anchor that does not move at
> runtime. However, schedutil uses that same fixed anchor as the reference
> plugged into map_util_freq() which saturates exactly at capacity_freq_ref.
>
> As a result, a system with cpufreq boost enabled effectively never runs at
> boost frequencies under schedutil-governed load. Fix this by plugging in
> policy-max into the map_util_freq equation, so that the DVFS requests
> translates to the actual cpufreq driver ceiling.
>
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a1782755efcc..dcefbeaa0702 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -195,10 +195,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>                                   unsigned long util, unsigned long max)
>  {
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned int freq;
> +       unsigned int freq, ref;
>
> -       freq = get_capacity_ref_freq(policy);
> -       freq = map_util_freq(util, freq, max);
> +       ref = get_capacity_ref_freq(policy);
> +
> +       /*
> +        * That fixed anchor governs how utilization is interpreted, but
> +        * the DVFS request is free to target the current policy ceiling.
> +        * Using ref alone would saturate the util->freq map at ref so
> +        * use policy->max to reach boost frequencies.
> +        */
> +       freq = map_util_freq(util, max(ref, READ_ONCE(policy->max)), max);

But this is wrong because arch_scale_freq_ref is the freq that has
been used when setting the capacity of the cpu and is there to make
sure that the translation between freq <-> capacity is correct and
consistent whatever happens later on the freq table of cpufreq. This
ensures that utilization tracking remains correct vs other CPUS and
prevents or minimizes utilization oscillation, which triggers other
problems

Either we enable the utilization value to go above CPU's capacity when
we transmit it to cpufreq (and above SCHED_CAPACITY_SCALE which could
trigger a number of problem while computing pelt)
Or, you take into account the boost freq when setting cpu's capacity
and associated capacity_freq_ref at boot even if not enabled. With
cpufreq pressure feature and the policy->max (not  cpuinfo_max_freq)
correctly updated with a freq_qos_update_request when boost is
enabled/disabled, the scheduler and pelt should handle that correctly
as we normaly take into account cpufreq_pressure everywhere in
scheduler.

>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;
> --
> 2.34.1
>
