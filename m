Return-Path: <SRS0=udh8=ZH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA55C432C3
	for <linux-pm@archiver.kernel.org>; Fri, 15 Nov 2019 14:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AA920730
	for <linux-pm@archiver.kernel.org>; Fri, 15 Nov 2019 14:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EW8AUeKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKOOMQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:12:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40968 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfKOOMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Nov 2019 09:12:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id m4so5911582ljj.8
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slql22Lvz46WLUa6lndozAHDqOw1IKVDi6n/pS/xzmc=;
        b=EW8AUeKskgrRYNROo8Qv9VIP+RzHnB5xM/iAzMi0TB45huCydBA8sKyiW3/xypqRe3
         MEFNXYMqPlFSNcDTGdyDcObMzjMJXbJB+9q9h+tQJb8I5yIfPb8btv23xPZPqjxtnJbR
         KnNe3ZXBbtkiKJJCcvUfLd4Sfm3QtlKQB+aVrur7uO48Iw5DqCHlf5lXixhLJFEG3KU/
         VYoGQfkfClEqRZolI0iryVZf0cdDj6sHqaZSZ2XH5ogiGujNqbJTUZc5ZOKFVi+RK24R
         9SSZI4KHRdHz4Kf5VWOZh7hvTK/qpW317qhtZXXRZqmvOoJb8FGRuR/dBjT7iJPX1s3C
         Cr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slql22Lvz46WLUa6lndozAHDqOw1IKVDi6n/pS/xzmc=;
        b=HmzR/DhLZQjEXl4za1zSMepVjkK30oKMUKpxLVsE5pedFt1Awiw+2EDDD2PR8307HY
         rVLK6CUEF4HtypBE1pTmDRW4R1NwuMhbUppRncCsyqH/VjSevj45pEL+djiM8gv5o57k
         ZFlDcyNTvno5qYMqKxmHX6Wo45f+BQ/V0kPVCx19qTvUQFxlrhyVt4ygNHSC/RbA09GQ
         OmMSYwKd5S7ytdssQIWS4Ln6l4ug0TQuPdu1Ba7vsiuSyq0tLp26PAlDuH/I1nsNLaXW
         BucaPCdKTHRRgAiYz6kYhnjl+IM1SZ/1CTIDBCFAJTVM6eYI1WyOKVeuHXK7e3GGl0z6
         A7Zg==
X-Gm-Message-State: APjAAAW0A9aa3BWYDCMIhBUj9hyi2WTMZxvi9gbvWLE2+IzFU7Z1+6A1
        IIrANS+zpYUBzk2NzeoEy3v8OK1iO5NAXlEdrtpNjw==
X-Google-Smtp-Source: APXvYqyhDaYL80Ahst62ZZPsU/jmvGG4mTPUUh0TSUDWU4odSDAqEYSLIBo3opQCvc9EMgd5iDZQUbFmIkUAEE4+TeY=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr10978072ljl.193.1573827133905;
 Fri, 15 Nov 2019 06:12:13 -0800 (PST)
MIME-Version: 1.0
References: <1573751251-3505-1-git-send-email-vincent.guittot@linaro.org>
 <20191115132520.GJ4131@hirez.programming.kicks-ass.net> <CAKfTPtB4UGmZ53iVRsOV+k4MiS=Dzqw2-6_sBhko0bHRMAed2g@mail.gmail.com>
 <20191115140555.GL4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191115140555.GL4131@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Nov 2019 15:12:02 +0100
Message-ID: <CAKfTPtC97QxWRM=7MFMoRBjTTn+iLO4utL4DBoBnpyxTOeTfbw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/freq: move call to cpufreq_update_util
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Doug Smythies <dsmythies@telus.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sargun Dhillon <sargun@sargun.me>, Tejun Heo <tj@kernel.org>,
        Xie XiuQi <xiexiuqi@huawei.com>, xiezhipeng1@huawei.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 15 Nov 2019 at 15:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 15, 2019 at 02:37:27PM +0100, Vincent Guittot wrote:
> > On Fri, 15 Nov 2019 at 14:25, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Nov 14, 2019 at 06:07:31PM +0100, Vincent Guittot wrote:
>
> > > > +     decayed = update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
> > > > +     decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
> > > > +     decayed |= update_irq_load_avg(rq, 0);
> > >
> > > Should not all 3 have their windows aligned and thus alway return the
> > > exact same value?
> >
> > rt and dl yes but not irq
>
> Any reason for IRQ not to be aligned?

irq time is not accounted into task time so irq_avg use rq->clock
whereas other use rq->clock_task
But irq is also not sum up with others

>
> > But having aligned window doesn't mean that they will all decay.
> > One can have been updated just before (during a dequeue as an example)
> > or at least less than 1ms before
>
> Bah... true.
