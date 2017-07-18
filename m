From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: schedutil: Update last_update from sugov_set_iowait_boost()
Date: Wed, 19 Jul 2017 00:16:13 +0200
Message-ID: <9392750.bmStGLhEbp@aspire.rjw.lan>
References: <4927469221fa6b2ea7efffb2da923dac930ab313.1500353473.git.viresh.kumar@linaro.org> <20170718112550.GZ352@vireshk-i7> <20170718113552.v7fzhghp6oxwfoq4@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42006 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751963AbdGRWYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jul 2017 18:24:04 -0400
In-Reply-To: <20170718113552.v7fzhghp6oxwfoq4@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, joelaf@google.com, linux-kernel@vger.kernel.org

On Tuesday, July 18, 2017 12:35:52 PM Juri Lelli wrote:
> On 18/07/17 16:55, Viresh Kumar wrote:
> > On 18-07-17, 12:20, Juri Lelli wrote:
> > > Hi Viresh,
> > > 
> > > On 18/07/17 10:24, Viresh Kumar wrote:
> 
> [...]
> 
> > > 
> > > It actually belongs here, IMHO. We update other fields (util, max,
> > > flags)
> > 
> > Yeah, because they have bigger roles and aren't specific to iowait
> > boost.
> > 
> > > before looking at iowait. Why hiding the time update into a
> > > function dealing with only one of such fields?
> > 
> > But last_update is very much specific to iowait_boost only and so it
> > should be updated from sugov_set_iowait_boost() IMHO.
> > 
> 
> Huh, I see you point. However, I'm using it also to deal with stale CFS
> util values in my patches [1]. Sure, not mainline yet, but I guess I'll
> have to sort of revert your proposed change for my next version. Or
> think of a better idea. :)

Yes, so I'd prefer to prioritize your patches.

The patch from Viresh is purely cosmetic AFAICS and it really can wait.

Thanks,
Rafael
