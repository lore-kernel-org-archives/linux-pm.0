From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Tue, 1 Aug 2017 20:48:50 +0300
Message-ID: <1501609730.17254.5.camel@nxp.com>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
         <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
         <1500983686.30745.28.camel@nxp.com> <20170726060634.GY352@vireshk-i7>
         <1501174453.7957.30.camel@nxp.com> <20170728052843.GT352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:22104
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751866AbdHARs4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Aug 2017 13:48:56 -0400
In-Reply-To: <20170728052843.GT352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On Fri, 2017-07-28 at 10:58 +0530, Viresh Kumar wrote:
> On 27-07-17, 19:54, Leonard Crestez wrote:
> > On Wed, 2017-07-26 at 11:36 +0530, Viresh Kumar wrote:
> > > Without this patch the sampling rate of ondemand governor will be 109
> > > ms. And after this patch it would be capped at 10 ms. Why would that
> > > screw up anyone's setup ? I don't have an answer to that right now.
> > On a closer look it seems that most of the time is actually spent at
> > low cpufreq though (90%+).
> > 
> > Your change makes it so that even something like "sleep 1; cat
> > scaling_cur_freq" raises the frequency to the maximum.
> Why?
> 
> > 
> > This happens
> > enough that even if you do it in a loop you will never see the minimum
> > frequency. It seems there is enough internal bookkeeping on such a
> > wakeup that it takes more than 10ms and enough for a reevaluation of
> > cpufreq until cat returns the value?!

> At this point I really feel that this is a hardware specific problem
> and it was working by chance until now. And I am not sure if we
> shouldn't be stopping this patch from getting merged just because of
> that.

Yes, I agree. Something is fishy here but most likely your patch just
expose the problem.

> At least you can teach your distribution to go increase the sampling
> rate from userspace to make it all work.
> 
> Can you try one more thing? Try using schedutil governor and see how
> it behaves ?

I don't have the time to investigate this properly right now.

> > I found this by enabling the power:cpu_frequency tracepoint event and
> > checking for deltas with a script. Enabling CPU_FREQ_STAT show this:
> > 
> > time_in_state:
> > 
> > 396000 1609
> So we still stay at the lowest frequency most of the time.

Yes

> Maybe can you compare these values with and without this patch to let
> us know?

Without the patch it is always at low freq. Sampling at a lower
frequency means spikes get ignored.
