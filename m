From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Apply default governor for setpolicy drivers
Date: Thu, 19 Dec 2013 14:18:20 +0100
Message-ID: <1705569.2YBVYpbg6Q@vostro.rjw.lan>
References: <20131218203102.9F9692036@prod-mail-relay06.akamai.com> <2651749.Dr3egRT25J@vostro.rjw.lan> <52B26D3E.2070600@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63654 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757047Ab3LSNFA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 08:05:00 -0500
In-Reply-To: <52B26D3E.2070600@akamai.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>Viresh Kumar <viresh.kumar@linaro.org>

On Wednesday, December 18, 2013 10:51:26 PM Jason Baron wrote:
> On 12/18/2013 06:33 PM, Rafael J. Wysocki wrote:
> > On Wednesday, December 18, 2013 04:35:04 PM Jason Baron wrote:
> >> On 12/18/2013 04:38 PM, Rafael J. Wysocki wrote:
> >>> On Wednesday, December 18, 2013 08:31:02 PM Jason Baron wrote:
> >>>> When configuring a default governor (via CONFIG_CPU_FREQ_DEFAULT_*) with the
> >>>> 'intel_pstate' driver, I found that the default is not honored. For example,
> >>>> configure 'CONFIG_CPU_FREQ_GOV_PERFORMANCE', and then do:
> >>> intel_pstate doesn't use any cpufreq governors, so all of this is pointless
> >>> for that particular driver anyway.
> >>>
> >>> Thanks!
> >>>
> >> Ok, but if I look at 'intel_pstate', I see a 'set_policy' call that does different
> >> things if the policy is 'performance' vs. 'powersave'. Same for the 'longrun'
> >> driver. So yes, they don't use the 'governors', but changing the governors
> >> at runtime does appear to change change how they behave.
> > OK, so you want the initial policy to be set in accordance with the
> > CONFIG_CPU_FREQ_DEFAULT_* setting.  That makes sense, although it is not
> > immediately clear from the patch changelog.
> >
> > That said the change in the patch looks kind of overly complicated.
> > What about adding something like this instead?
> 
> Agreed - this is better. Will you just pull the below patch, or should
> I re-post with a better changelog?

I think the Viresh' version is the best one, but it needs a comment about what
it is for and a better changelog would be welcome. :-)

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
