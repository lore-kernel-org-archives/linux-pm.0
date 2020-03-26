Return-Path: <SRS0=yWkS=5L=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B400C43331
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 19:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0625B2073E
	for <linux-pm@archiver.kernel.org>; Thu, 26 Mar 2020 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585250088;
	bh=dApfC/BGFaA1bhwnJYqIGGbxr9bhUJ1IHIm0PEL1xaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1t8dJdFIL7YzEM/S4/AI01o5bXHBlAEuLMx/KMRTOZsn4DoJB/yQ3Dg5I0NvAmnAR
	 DkOQUHpI+0d9nNtRO4aAlAt29jR4atOVmjhHESuU9Tf6gb9Z8z9VtP9aqL+b82Uk0X
	 yAIg8M02tjwI/oObH0CZvsaFSX6MeMHf9SxikrSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZTOr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:14:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38475 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTOr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2020 15:14:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so6592464oic.5;
        Thu, 26 Mar 2020 12:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXEle+ZD53+MFHWcLgdRW1ZIu+1OkbpjksE2lr+1gKg=;
        b=WNF38S/M/dFbhm+YapzzoP5MEt1c3ageOc5gu4bQMXKoeRqwopcFbc/5AqfjBfrGDa
         NVUdWFairNhwluzfIHXGGgqOGujiVE6SzivgmkQWy6j+rDEuNsPya2IQ2HiW7PXK69pG
         vve/OJyoHD0jVf4/+attRuADZr7l3kDedXxT2r864xOBa7kEIxN23Q9f+s7EJuZld56/
         8Imf3xW3lw1p+n/L9wvITImNYbg7Veo4J59vUQhRfv6rJ0iarhK3t4hEKrgeBO+cpeMK
         zn6YAcjUWAU3W4K5zv+8fgBKn8eBYCy8tTzBmQrVI9RPMRFGCzrVunDP4FnTeuYu9P6v
         /cnQ==
X-Gm-Message-State: ANhLgQ3MV4WHCesfQSvo62CMpS2UnHRu4cgqjkO4qrYj/do0KHjcTH/b
        Ry0S6yML3XkKZRGIfJy6wRPfqC8nlYxI6TRjCSA=
X-Google-Smtp-Source: ADFU+vsfTSr1oKjoNtVzFV6kqJLSFnimlr7Skrn5pUSOrTjmvEX49Crb7bSqm4rySP49deJhBqwBJs2Mm4RbPbj6rDQ=
X-Received: by 2002:aca:5155:: with SMTP id f82mr1398128oib.103.1585250086360;
 Thu, 26 Mar 2020 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200326144630.15011-1-daniel.lezcano@linaro.org>
In-Reply-To: <20200326144630.15011-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Mar 2020 20:14:34 +0100
Message-ID: <CAJZ5v0iDuv0doOzFd140A17fhLKsdgZXbc_XMOuhUeDt70Jz+g@mail.gmail.com>
Subject: Re: [PATCH] powercap/drivers/idle_inject: Specify idle state max latency
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 26, 2020 at 3:48 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently the idle injection framework uses the play_idle() function
> which puts the current CPU in an idle state. The idle state is the
> deepest one, as specified by the latency constraint when calling the
> subsequent play_idle_precise() function with the INT_MAX.
>
> The idle_injection is used by the cpuidle_cooling device which
> computes the idle / run duration to mitigate the temperature by
> injecting idle cycles. The cooling device has no control on the depth
> of the idle state.
>
> Allow finer control of the idle injection mechanism by allowing to
> specify the latency for the idle state. Thus the cooling device has
> the ability to have a guarantee on the exit latency of the idle states
> it is injecting.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/idle_inject.c | 27 ++++++++++++++++++++++++++-
>  include/linux/idle_inject.h    |  6 ++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..15e6f9b8023f 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -61,12 +61,14 @@ struct idle_inject_thread {
>   * @timer: idle injection period timer
>   * @idle_duration_us: duration of CPU idle time to inject
>   * @run_duration_us: duration of CPU run time to allow
> + * @latency_us: max allowed latency
>   * @cpumask: mask of CPUs affected by idle injection
>   */
>  struct idle_inject_device {
>         struct hrtimer timer;
>         unsigned int idle_duration_us;
>         unsigned int run_duration_us;
> +       unsigned int latency_us;
>         unsigned long int cpumask[0];
>  };
>
> @@ -138,7 +140,8 @@ static void idle_inject_fn(unsigned int cpu)
>          */
>         iit->should_run = 0;
>
> -       play_idle(READ_ONCE(ii_dev->idle_duration_us));
> +       play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
> +                         READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
>  }
>
>  /**
> @@ -169,6 +172,27 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>         *idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>
> +/**
> + * idle_inject_set_latency - set the maximum latency allowed
> + * @latency_us: set the latency requirement for the idle state
> + */
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +                            unsigned int latency_us)
> +{
> +       WRITE_ONCE(ii_dev->latency_us, latency_us);
> +}
> +
> +/**
> + * idle_inject_get_latency - get the allowed latency
> + *
> + * Return: an unsigned int corresponding to the latency requirement
> + * for the idle state
> + */
> +unsigned int idle_inject_get_latency(struct idle_inject_device *ii_dev)
> +{
> +       return READ_ONCE(ii_dev->latency_us);
> +}
> +
>  /**
>   * idle_inject_start - start idle injections
>   * @ii_dev: idle injection control device structure
> @@ -297,6 +321,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
>         cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>         hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ii_dev->timer.function = idle_inject_timer_fn;
> +       ii_dev->latency_us = UINT_MAX;
>
>         for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>
> diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
> index a445cd1a36c5..b573fee589b9 100644
> --- a/include/linux/idle_inject.h
> +++ b/include/linux/idle_inject.h
> @@ -26,4 +26,10 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>  void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>                                  unsigned int *run_duration_us,
>                                  unsigned int *idle_duration_us);
> +
> +void idle_inject_set_latency(struct idle_inject_device *ii_dev,
> +                            unsigned int latency_ns);
> +
> +unsigned int idle_inject_get_latency(struct idle_inject_device *ii_dev);
> +
>  #endif /* __IDLE_INJECT_H__ */
> --

I would like to see a user of idle_inject_get_latency() before this goes in.
