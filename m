From: Steve Muckle <smuckle.linux@gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sun, 13 Nov 2016 11:31:59 -0800
Message-ID: <20161113193159.GB29583@graphite.smuckle.net>
References: <cover.1478858983.git.viresh.kumar@linaro.org>
 <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34241 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934461AbcKMTuO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 14:50:14 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Fri, Nov 11, 2016 at 11:16:59PM +0100, Rafael J. Wysocki wrote:
> > +       struct sched_param param = { .sched_priority = 50 };
> 
> I'd define a symbol for the 50.  It's just one extra line of code ...

A minor point for sure, but in general what's the motivation for
defining symbols for things which are only used once? It makes it harder
to untangle and learn a piece of code IMO, having to jump to the
definitions of them to see what they are.

thanks,
Steve
