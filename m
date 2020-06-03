Return-Path: <SRS0=265P=7Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D6EC433E0
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAAE20772
	for <linux-pm@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591194255;
	bh=pbnM7kmAfsGqcapI9++XcifnB0P2CPRt32liEq1tdFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HvGlOUnFxmhO3NAoOI86G8X4JHrUjpScsz3wt7pfsTYeJ4NHBQL8Aj8GvXcLg5HVk
	 fjpgQAqmABFcWU8z+4Buh9jVfpzuwK999ZDj8d/aEor6oZ5lfoBTc1U2QOW9jiP+Yy
	 KVFjGwQfZGuiU++VXQtWHlzebH34VgA1qReWM5eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCOYO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:24:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39650 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCOYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 10:24:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id g5so1988859otg.6;
        Wed, 03 Jun 2020 07:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgK8cHZmw8249VNtqMSwdN+a20DMUemCHkqYDe9eooc=;
        b=CoYyIWlStEhASO6eByEi3X/u0jct+Xpl6X0UzmJVzmDC2N953JJmnlXE7lK9DD1yqE
         NTQgCrspVdWvJccsQQ0/p+cjlKHabXRAMAG+gZ5XQjYaeUnTrf9yyf9K+gQC9CV1wE+R
         wS0qzr1oKDPcxWwXZrukUmba5AEw3hRIB1/87mHHzIrURG6kLVH9jf3r9JBXQt3gSf34
         xM2d79S5d8UqHr8FfFKzBi3i5xOImBRUpB5JBHVMDL/vEoydQ+WcAns/RX/wNFDI2TRx
         WHcdxi4Y5HV9AtfYkNwbI0KO7N3oXEKMTk0JG9aT7jj1ZY1KHFAMKDRCcNudcVjD0fjx
         aMzw==
X-Gm-Message-State: AOAM531f+5a8ARfyOeTOxHJtGsIGwn5T7lrrSYyEQSSG2w4mscgoFPZK
        I8vbSbzVYdztxiWqAYhlI993bO4z2ZhNsSl/k9Y=
X-Google-Smtp-Source: ABdhPJxQoAI/KzNKYCbAOBsLlc3IPnFJfFbobSXu2PHlh4RWb1e+uSIsYxNVgmVOAwVbljX8yy++9VK82oip8qJmR58=
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr149194otq.167.1591194250393;
 Wed, 03 Jun 2020 07:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200531182453.15254-1-ggherdovich@suse.cz> <20200531182453.15254-3-ggherdovich@suse.cz>
In-Reply-To: <20200531182453.15254-3-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jun 2020 16:23:56 +0200
Message-ID: <CAJZ5v0h8dWv6vzJ5k+Fg68s7M4UN1KrNvJ96ordG2MBh2A9M_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] x86, sched: Bail out of frequency invariance if
 turbo frequency is unknown
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
> There may be CPUs that support turbo boost but don't declare any turbo
> ratio, i.e. their MSR_TURBO_RATIO_LIMIT is all zeroes. In that condition
> scale-invariant calculations can't be performed.
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/smpboot.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d660966d7de7..fe154c8226ba 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -2001,9 +2001,11 @@ static bool intel_set_max_freq_ratio(void)
>         /*
>          * Some hypervisors advertise X86_FEATURE_APERFMPERF
>          * but then fill all MSR's with zeroes.
> +        * Some CPUs have turbo boost but don't declare any turbo ratio
> +        * in MSR_TURBO_RATIO_LIMIT.
>          */
> -       if (!base_freq) {
> -               pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
> +       if (!base_freq || !turbo_freq) {
> +               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
>                 return false;
>         }
>
> --
> 2.16.4
>
