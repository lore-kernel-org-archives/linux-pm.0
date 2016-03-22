From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Always update current frequency before
 startig governor
Date: Tue, 22 Mar 2016 20:12:08 +0530
Message-ID: <20160322144208.GM5272@vireshk-i7>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan>
 <1847835.ROHO9MEN8J@vostro.rjw.lan>
 <20160322033032.GT27778@vireshk-i7>
 <7982875.5daSm6IB7M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35174 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbcCVOmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 10:42:12 -0400
Received: by mail-pf0-f175.google.com with SMTP id n5so314223689pfn.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2016 07:42:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7982875.5daSm6IB7M@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 22-03-16, 15:33, Rafael J. Wysocki wrote:
> On Tuesday, March 22, 2016 09:00:32 AM Viresh Kumar wrote:

> > Why we did the same in process context earlier? And why it wouldn't be
> > a problem now, when we do it in interrupt context? Will IRQs be
> > disabled here? If so, then will you hit following ?
> 
> I'm not sure I'm following.

Sorry about that.

> This is process context too.
> 
> Look at the call sites of cpufreq_start_governor() (patch [1/3]):
> - cpufreq_offline() - process context
> - cpufreq_resume() - process context

I somehow thought that this is going to happen in interrupt context. :(

> - cpufreq_set_policy() - process context
> - cpufreq_add_policy_cpu() - process context
> 
> Besides, calling cpufreq_governor() from interrupt context wouldn't reall work,
> because that acquires mutexes etc, like in cpufreq_governor_init().
> 
> > static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
> > 		struct cpufreq_freqs *freqs, unsigned int state)
> > {
> > 	BUG_ON(irqs_disabled());
> > 
> > ...
> > }
> > 
> > And will calling notifiers from interrupt-context just fine ?
> 
> If your question is why the original code doesn't call cpufreq_update_policy()
> directly, I think the reason is because cpufreq_resume() used to be one of the
> syscore ops and *that* would have been run in interrupt context.

Yeah.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
