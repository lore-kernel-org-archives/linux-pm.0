From: Michael Turquette <mike.turquette@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is set
 correctly
Date: Mon, 30 Mar 2015 18:48:54 -0700
Message-ID: <20150331014854.25195.34023@quantum>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
 <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
 <551951F4.9070804@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34891 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbCaBtH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 21:49:07 -0400
Received: by patj18 with SMTP id j18so3760715pat.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2015 18:49:06 -0700 (PDT)
In-Reply-To: <551951F4.9070804@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Quoting Sudeep Holla (2015-03-30 06:39:00)
> 
> 
> On 30/03/15 14:27, Viresh Kumar wrote:
> > On 30 March 2015 at 17:57, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >> The actual frequency is set through "clk_change_rate" which is void
> >> function. If the underlying hardware fails and returns error, the error
> >> is lost in the clk layer. In order to track such failures, we need to
> >> read back the frequency(just the cached value as clk_recalc called after
> >> clk->ops->set_rate gets the frequency)
> >>
> >> This patch adds check to see if the frequency is set correctly or if
> >> they were any hardware failures and sends the appropriate errors to the
> >> cpufreq core.
> >>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >>   drivers/cpufreq/arm_big_little.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> >> index e1a6ba66a7f5..3fc676c63f91 100644
> >> --- a/drivers/cpufreq/arm_big_little.c
> >> +++ b/drivers/cpufreq/arm_big_little.c
> >> @@ -186,6 +186,8 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> >>                  mutex_unlock(&cluster_lock[old_cluster]);
> >>          }
> >>
> >> +       if (bL_cpufreq_get_rate(cpu) != new_rate)
> >> +               return -EIO;
> >>          return 0;
> >>   }
> >
> > This doesn't look to me the right place for fixing this.
> >
> 
> Yes I agree, after going through clk.c, I thought pre-/post- notifiers
> are designed for such purpose. I tried using them but found it
> unnecessary when it can be as simple as in this patch. However it's good
> to hear from Mike as I seem to have assumed a lot here.

Viresh & Sudeep,

clk_set_rate returns an error (and always has), so it seems to me that
this patch is unnecessary. bL_cpufreq_set_rate checks for an error from
clk_set_rate and handles it.

clk_change_rate is static and not exposed outside of drivers/clk/clk.c.

This patch gets a NAK from me.

Regards,
Mike

> 
> Regards,
> Sudeep
