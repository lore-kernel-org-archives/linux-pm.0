From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change
 frequency with rate_limit
Date: Thu, 16 Feb 2017 11:57:19 +0530
Message-ID: <20170216062719.GB21911@vireshk-i7>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
 <6429586.HoWBhxDx3r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35420 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdBPG1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2017 01:27:22 -0500
Received: by mail-pg0-f51.google.com with SMTP id t188so3572547pgt.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Feb 2017 22:27:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <6429586.HoWBhxDx3r@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 15-02-17, 23:35, Rafael J. Wysocki wrote:
> On Wednesday, February 15, 2017 10:45:47 PM Viresh Kumar wrote:
> 
> First of all, [RFC] pretty please on things like this.

Sure.

> > Normally, the time it takes to reevaluate the frequency is negligible
> > compared to the time it takes to change the frequency.
> 
> This should be "the time it takes to reevaluate the load is negligible
> relative to the time it takes to change the frequency" I suppose?
> 
> Specifically, the "to reevaluate the frequency" phrase is ambiguous.

Actually we reevaluate both load and frequency, but I am fine with what you have
suggested here.

> > And considering
> > that in the above scenario, as we haven't updated the frequency for over
> > 10ms, we should have changed the frequency as soon as the load changed.
> 
> Why should we?

I will modify above as:

... we should have changed the frequency as soon as the load changed in order to
be more responsive to the load on the CPUs.

Is that the missing part you are pointing at ?

> > Its difficult to create a test case (tried rt-app as well) where this
> > patch will show a lot of improvements as the target of this patch is a
> > real corner case. I.e. Current load is X (resulting in freq change),
> > load after rate_limit_us is also X, but right after that load becomes Y.
> > Undoubtedly this patch would improve the responsiveness in such cases.
> 
> But can that be demonstrated somehow?

I hope you are talking about demonstrating performance enhancement here? I am
not sure if we can actually have a testcase to show that. Can you or others give
some testcases where we can hit similar situation again and again ?

Though I can surely try to get some traces which show that such cases do exist
and we are able to change the frequency before waiting for another 10ms. But
such an outcome is quite obvious here.

> Otherwise it is rather not "undoubtedly", but "theoretically".

Do you want to see the traces to confirm that we actually changed the frequency
earlier due to this change ?

-- 
viresh
