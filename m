From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set
 correctly
Date: Wed, 01 Apr 2015 14:48:14 -0700
Message-ID: <20150401214814.14369.56281@quantum>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
 <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
 <551951F4.9070804@arm.com> <20150331014854.25195.34023@quantum>
 <551A67CD.50602@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:32871 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbbDAVs1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 17:48:27 -0400
Received: by pdrw1 with SMTP id w1so59512383pdr.0
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 14:48:27 -0700 (PDT)
In-Reply-To: <551A67CD.50602@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Quoting Sudeep Holla (2015-03-31 02:24:29)
> 
> 
> On 31/03/15 02:48, Michael Turquette wrote:
> > Quoting Sudeep Holla (2015-03-30 06:39:00)
> >> On 30/03/15 14:27, Viresh Kumar wrote:
> >>> On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >>>> The actual frequency is set through "clk_change_rate" which is void
> >>>> function. If the underlying hardware fails and returns error, the error
> >>>> is lost in the clk layer. In order to track such failures, we need to
> >>>> read back the frequency(just the cached value as clk_recalc called after
> >>>> clk->ops->set_rate gets the frequency)
> 
> [...]
> >>>
> >>> This doesn't look to me the right place for fixing this.
> >>>
> >>
> >> Yes I agree, after going through clk.c, I thought pre-/post- notifiers
> >> are designed for such purpose. I tried using them but found it
> >> unnecessary when it can be as simple as in this patch. However it's good
> >> to hear from Mike as I seem to have assumed a lot here.
> >
> > Viresh & Sudeep,
> >
> > clk_set_rate returns an error (and always has), so it seems to me that
> > this patch is unnecessary. bL_cpufreq_set_rate checks for an error from
> > clk_set_rate and handles it.
> >
> 
> No that's not correct, may be I was not clear earlier. Let me explain
> with the stack trace.
> 
> bL_cpufreq_set_target(returns 0 even when clock driver returned error)
>          |
>          V
> clk_set_rate(returns whatever it get from clk_core_set_rate_nolock)
>          |
>          V
> clk_core_set_rate_nolock(always return 0 after calling clk_change_rate)

Ah, now I understand our misunderstanding.

clk_core_set_rate_nolock can fail BEFORE calling clk_change_rate, which
is where we do a lot of the work to see if the rate change is even
possible. That is what I was referring to in my previous mail.

What you have is a failing .set_rate callback and you need to know if it
failed. You are correct that we are not handling the return value from
.set_rate. That needs to change.

>          |
>          V
> clk_change_rate(void function, so no return)
>          |
>          V
> clk->ops->set_rate(i.e. <clock_driver_set_rate>)
> 
> Now for drivers/clk/clk.c IIUC, the return value from clk->ops->set_rate
> is not checked. Now if <clock_driver_set_rate> returns error when h/w
> fails to set the rate, I would like to know how the error returned by
> <clock_driver_set_rate> is returned and received by clk_set_rate.
> Correct me if I am missing anything in the above sequence.
> 
> In the current state of code, one can use notifier(basically
> POST_RATE_CHANGE is called only if the clock rate changes), but since
> the clk_recalc reads back the clock rate, I found this patch is simpler
> compared to the notifiers.

Simpler, but not better. What you want is to know if the rate change
failed. We need to through an exception when .set_rate fails and
propagate the error up the call chain to the cpufreq driver.

I'm thinking of ways to do this ... would require some surgery to the
clock framework but it might give us a more elegant way to recover from
a failure and roll back to a known good state.

Regards,
Mike

> 
> Regards,
> Sudeep
