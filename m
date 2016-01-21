From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: sched-freq locking
Date: Wed, 20 Jan 2016 17:39:14 -0800
Message-ID: <56A036C2.4090403@linaro.org>
References: <56984C30.8040402@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
 <569EE1E1.3050407@linaro.org> <2058083.HonoCMD469@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36807 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbcAUBjR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 20:39:17 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so13858201pab.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 17:39:17 -0800 (PST)
In-Reply-To: <2058083.HonoCMD469@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On 01/20/2016 05:22 PM, Rafael J. Wysocki wrote:
> One comment here (which may be a bit off in which case please ignore it).
> 
> You seem to be thinking that sched-freq needs to be a cpufreq governor
> and thus be handled in the same way as ondemand, for example.

That's true, I hadn't really given much thought to the alternative you
mention below.

> 
> However, this doesn't have to be the case in principle.  For example,
> if we have a special driver callback specifically to work with sched-freq,
> it may just use that callback and bypass (almost) all of the usual
> cpufreq mechanics.  This way you may avoid worrying about the governor
> locking and related ugliness entirely.

That sounds good but I'm worried about other consequences of taking
cpufreq out of the loop. For example wouldn't we need a new way for
something like thermal to set frequency limits?

thanks,
steve
