From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Sat, 30 Jan 2016 12:49:03 +0100
Message-ID: <1703921.2AHaiQoggk@vostro.rjw.lan>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com> <20160112102025.GC1084@ubuntu> <56AC04E3.8090900@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61019 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754156AbcA3LsI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2016 06:48:08 -0500
In-Reply-To: <56AC04E3.8090900@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Friday, January 29, 2016 04:33:39 PM Saravana Kannan wrote:
> On 01/12/2016 02:20 AM, Viresh Kumar wrote:
> > On 11-01-16, 17:35, Juri Lelli wrote:
> >> __cpufreq_governor works on policy, so policy->rwsem has to be held.
> >> Add assertion for such condition.
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> >> ---
> >>   drivers/cpufreq/cpufreq.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index f1f9fbc..e7fc5c9 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1950,6 +1950,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
> >>   	/* Don't start any governor operations if we are entering suspend */
> >>   	if (cpufreq_suspended)
> >>   		return 0;
> >> +
> >> +	lockdep_assert_held(&policy->rwsem);
> >> +
> >
> > We had an ABBA problem with the EXIT governor callback and so this
> > rwsem is dropped just before that from set_policy()..
> >
> > commit 955ef4833574 ("cpufreq: Drop rwsem lock around
> > CPUFREQ_GOV_POLICY_EXIT")
> >
> 
> AFAIR, the ABBA issue was between the sysfs lock and the policy lock. 
> The fix for that issue should not be dropping the lock around 
> POLICY_EXIT.

Right.  Dropping the lock is a mistake (which I overlooked, sadly).

Thanks,
Rafael

