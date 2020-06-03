Return-Path: <SRS0=265P=7Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59FCC433E0
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C503820738
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591195902;
	bh=MWiSHKcEDoFmLXcn0l2hLsXb589lxoVYrPuEr2KKSPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0MUoe+cj6oYZ46XUcF7WYw5jDXi/EGnvFSCfWG8eseqXmDZ+QeFf8YLsfthzU0s+q
	 53bnSPt6h58v7ItchlL55ZwIEm78l6mkhtWwcxY9YvFZicXtgcgwYgoFT/XrYcv4oq
	 KZsnpHf5YPgeR0I87c4JdRoe4CyeX3v3AL3lk5XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgFCOvh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:51:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39396 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCOvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 10:51:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id g5so2069432otg.6;
        Wed, 03 Jun 2020 07:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IFxkwdJki1WIWWrFUItKHxjWSf4ueSBqfwRQQudi88=;
        b=tMR8MNQ3Y2eCFDh4CEbiq7m9U3AmQ8uElTDhB+WiEofCYQ062bEdcCeb5bKX1a00Ax
         N20KlQSzK6AarYZNvo+OuknoB7BzsUlwnY/W/IZmIWkInpE/l8r8tfd30B17UhV5kU+/
         1Sdt3kkRLB3sq1KrICnvfDk+4mNUqSjUsyvqVlRpOMXr3/rtb0ZkfgWn8x7g5QckhGHl
         fxsWQl8QVYV4IPJYblLmXpt/1GCkqhKyV57gqBj8Kg9iBsD3XMYoDHiuj8sa99qXeWrO
         yJwIh+OuRIqJoCzJmsVfTP8eHzWFR7BoA1KN6ifkgTylNTzOPWAi3+cGisonDx6M+oKJ
         DqXw==
X-Gm-Message-State: AOAM5309TkeoeYeWil9LGPWKSNjQ2FbR2gGrDy9ms0wM5vDPh0ujWvI9
        y6Ik6h1ujlzsfmcsJk5zr4vb6IOerDaAJOtVUsE=
X-Google-Smtp-Source: ABdhPJwIEcy/bVF3SW/JRia20NXxWrHhYWn8UPD0KO/W61cy6Dhgv1+6DhN8aYGYhoVFdS0tesZTDuB0tYuKIXrjXiU=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr272952otc.262.1591195892184;
 Wed, 03 Jun 2020 07:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200531182453.15254-1-ggherdovich@suse.cz> <20200531182453.15254-4-ggherdovich@suse.cz>
In-Reply-To: <20200531182453.15254-4-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 16:51:21 +0200
Message-ID: <CAJZ5v0iNFDjt6rqXfiwn_UwiKgJDgAUshChVh5YoOCXF9hy=_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] x86, sched: Bail out of frequency invariance if
 turbo_freq/base_freq gives 0
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 8:26 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Be defensive against the case where the processor reports a base_freq
> larger than turbo_freq (the ratio would be zero).
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/smpboot.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index fe154c8226ba..f619007f46cf 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1976,6 +1976,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>  static bool intel_set_max_freq_ratio(void)
>  {
>         u64 base_freq, turbo_freq;
> +       u64 turbo_ratio;
>
>         if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
>                 goto out;
> @@ -2009,9 +2010,15 @@ static bool intel_set_max_freq_ratio(void)
>                 return false;
>         }
>
> -       arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
> -                                       base_freq);
> +       turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> +       if (!turbo_ratio) {
> +               pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> +               return false;
> +       }
> +
> +       arch_turbo_freq_ratio = turbo_ratio;
>         arch_set_max_freq_ratio(turbo_disabled());
> +
>         return true;
>  }
>
> --
> 2.16.4
>
