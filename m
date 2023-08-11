Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675ABC001B0
	for <linux-pm@archiver.kernel.org>; Fri, 11 Aug 2023 09:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjHKJkp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 11 Aug 2023 05:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjHKJk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 05:40:29 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF2D35B0;
        Fri, 11 Aug 2023 02:40:24 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d67c5e87cso279352eaf.0;
        Fri, 11 Aug 2023 02:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746824; x=1692351624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iES/w1U21fZ5HBN+a1vc2Ejc13Aw9VFT0tg5NlV+Wc=;
        b=eZV4fgZ66RP930FCuzwcb4/S+be3ulNemM2EMEKJKCcEsROL2cWu5I/LP6Fw5PVkV4
         q7gUEljMZeFxuPQpL8QiyRNKHaZO0p3/r3oZtMc9j5chtsLrA1k+5kHWMx0qMZKoNGxK
         kddpQoGYiGF/W3f2Vehs2Jm7YJAZWgTYg0mXQ8yGXiJcISsul64GycmooCPWCObB0I0K
         8d5KKLE131iEwdxkXf42Kgfg6t0vGyTYT3g4AbGsxJY02gw8b3e28h9rut9pmgt8+4BB
         d1MzBGAWXKBwbE605FLldHKSu6IxM+ja/L3eS5LSaLwYaFVk3jCzAHoBSKZVisYrxb6o
         bMzg==
X-Gm-Message-State: AOJu0Yz7X/PEh8QOt3GTnesH8d16qAWrVPP7UabS3NTCsMNDmtZEB5bL
        UzsHuA76UazLzHimuOOarM5fD5AXU70SzzZRLuLzYOFmgW4=
X-Google-Smtp-Source: AGHT+IFCoqy/OWF40MsgVJyjNdUTDpQUILjA9x0cZgb+snNVO8iNXm8RhMu4JnWMxconNZP+pGStsOEtv0PO7nmjuSM=
X-Received: by 2002:a4a:a3c1:0:b0:563:3b56:5dc1 with SMTP id
 t1-20020a4aa3c1000000b005633b565dc1mr869443ool.0.1691746824155; Fri, 11 Aug
 2023 02:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <2167194.irdbgypaU6@kreacher> <28e2d9ce-89db-807a-9d39-f2fcccfb2ad4@linutronix.de>
In-Reply-To: <28e2d9ce-89db-807a-9d39-f2fcccfb2ad4@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 11:40:13 +0200
Message-ID: <CAJZ5v0hY4F_XgSn0H0nKahBWEjwgqnfT+BG5BT45F-a0+wS7Qg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/3] cpuidle: teo: Skip tick_nohz_get_sleep_length()
 call in some cases
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, Aug 11, 2023 at 10:52 AM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi Rafael,
>
> On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:
>
> > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > @@ -166,6 +166,12 @@
> >   */
> >  #define NR_RECENT    9
> >
> > +/*
> > + * Idle state target residency threshold used for deciding whether or not to
> > + * check the time till the closest expected timer event.
> > + */
> > +#define RESIDENCY_THRESHOLD_NS       (15 * NSEC_PER_USEC)
> > +
>
> I would like to understand why this residency threshold is a fixed value
> and not related to TICK_NSEC. I'm sure there is a reason for it - but for
> me it is not obvious. Can you please explain it to me?

First off, I'm not convinced that there is any direct connection
between the TICK_NSEC value and which idle states can be regarded as
shallow.  HZ may vary between 100 and 1000 (an order of magnitude) and
this doesn't affect the target residencies of idle states in any way.

Next, the checks involving this value don't influence the
tick-stopping decision in any way, so I don't see a reason why they
should depend on TICK_NSEC.

Finally, it can be observed that ideally, the return value of
tick_nohz_get_sleep_length() should always be taken into
consideration, because it may influence the idle state selection in
any case.  However, if the target residency of the idle state selected
so far is really small, calling it may be skipped in case it is
costly, because its contribution is not likely to be significant.
Worst-case we would end up with a CPU wakeup before the target
residency of the selected idle state has elapsed, so some energy will
be lost and some exit latency will be incurred in vain, so this really
should be done when the numbers involved are small enough.

Now, what does "small enough" mean?  My answer is 15 us.
