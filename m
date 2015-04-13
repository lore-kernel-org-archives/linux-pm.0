From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set
 correctly
Date: Sun, 12 Apr 2015 22:08:25 -0700
Message-ID: <20150413050825.19585.17809@quantum>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
 <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
 <551951F4.9070804@arm.com> <20150331014854.25195.34023@quantum>
 <551A67CD.50602@arm.com> <20150401214814.14369.56281@quantum>
 <551D03E9.508@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33849 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbbDMFIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 01:08:34 -0400
Received: by iedfl3 with SMTP id fl3so64514760ied.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2015 22:08:33 -0700 (PDT)
In-Reply-To: <551D03E9.508@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Quoting Sudeep Holla (2015-04-02 01:55:05)
> 
> 
> On 01/04/15 22:48, Michael Turquette wrote:
> > Quoting Sudeep Holla (2015-03-31 02:24:29)
> 
> [...]
> 
> >>
> >> No that's not correct, may be I was not clear earlier. Let me explain
> >> with the stack trace.
> >>
> >> bL_cpufreq_set_target(returns 0 even when clock driver returned error)
> >>           |
> >>           V
> >> clk_set_rate(returns whatever it get from clk_core_set_rate_nolock)
> >>           |
> >>           V
> >> clk_core_set_rate_nolock(always return 0 after calling clk_change_rate)
> >
> > Ah, now I understand our misunderstanding.
> >
> > clk_core_set_rate_nolock can fail BEFORE calling clk_change_rate, which
> > is where we do a lot of the work to see if the rate change is even
> > possible. That is what I was referring to in my previous mail.
> >
> 
> Ah, I guessed so as I was not clear in my earlier email. A simple flow
> diagram did the job better for me :)
> 
> > What you have is a failing .set_rate callback and you need to know if it
> > failed. You are correct that we are not handling the return value from
> > .set_rate. That needs to change.
> >
> 
> Cool, since I had not followed the design of the clock APIs, I assumed
> it needs to be handled in one of the way: notifiers or get_rate. Thanks
> for the clarification.
> 
> >>           |
> >>           V
> >> clk_change_rate(void function, so no return)
> >>           |
> >>           V
> >> clk->ops->set_rate(i.e. <clock_driver_set_rate>)
> >>
> >> Now for drivers/clk/clk.c IIUC, the return value from clk->ops->set_rate
> >> is not checked. Now if <clock_driver_set_rate> returns error when h/w
> >> fails to set the rate, I would like to know how the error returned by
> >> <clock_driver_set_rate> is returned and received by clk_set_rate.
> >> Correct me if I am missing anything in the above sequence.
> >>
> >> In the current state of code, one can use notifier(basically
> >> POST_RATE_CHANGE is called only if the clock rate changes), but since
> >> the clk_recalc reads back the clock rate, I found this patch is simpler
> >> compared to the notifiers.
> >
> > Simpler, but not better. What you want is to know if the rate change
> > failed. We need to through an exception when .set_rate fails and
> > propagate the error up the call chain to the cpufreq driver.
> >
> 
> Agreed, but I was under the assumption that since the POST_RATE_CHANGE
> notifier are not called, it's implicit. So you are saying that's not the
> case ?

The lack of POST_RATE_CHANGE notifier doesn't imply anything. If we
calculate that a rate cannot be achieved via clk_propagate_rate_change
then we fire off ABORT_RATE_CHANGE notifiers. Once we fix up the
deficiency around not returning the error code for .set_rate callbacks
then we will probably fire these notifiers off in the event that a rate
change fails.

> 
> > I'm thinking of ways to do this ... would require some surgery to the
> > clock framework but it might give us a more elegant way to recover from
> > a failure and roll back to a known good state.
> >
> 
> Agreed. I avoid doing that for 2 reasons: firstly as you said it needs
> changes at multiple places and secondly I assumed alternate ways to
> handle it as the designed way.

So your patch for cpufreq is hopefully a temporary bandage until we fix
the clk framework. Please feel free to add my Reviewed-by.

Regards,
Mike

> 
> Regards,
> Sudeep
