From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Problem with cpufreq and i5 since post 3.9.0
Date: Sat, 28 Dec 2013 01:50:40 +0100
Message-ID: <1593264.QxQbtiBB9a@vostro.rjw.lan>
References: <20131227185924.GH17115@Blackswan> <20131227195350.GI17115@Blackswan> <20131228000900.GJ17115@Blackswan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64342 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753208Ab3L1AhJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2013 19:37:09 -0500
In-Reply-To: <20131228000900.GJ17115@Blackswan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Woodfall <dave@dawoodfall.net>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

CC: +Viresh and linux-pm

On Saturday, December 28, 2013 12:09:01 AM David Woodfall wrote:
> On (27/12/13 19:53), Dave Woodfall <dave@dawoodfall.net> put forth the proposition:
> >On (27/12/13 20:44), Heinz Diehl <htd@fancy-poultry.org> put forth the proposition:
> >>On 27.12.2013, David Woodfall wrote:
> >>
> >>>But any of the newer kernel versions I've tested only give me
> >>>performance and powersave.
> >>
> >>I don't use any Fedora kernel, so I can't tell which governors are
> >>enabled in those. You should check the value of "CONFIG_CPU_FREQ_GOV"
> >>in the respective .config file for your installed kernel.
> >>
> >>In short: It seems that only "performance" and "powersave" are
> >>compiled in.
> >
> >No, I used the same .config in all versions that I tested. I've also
> >tried setting them as modules rather than built-in. This is the stock
> >slackware .config:
> >
> >CONFIG_CPU_FREQ=y
> >CONFIG_CPU_FREQ_TABLE=m
> >CONFIG_CPU_FREQ_GOV_COMMON=y
> >CONFIG_CPU_FREQ_STAT=m
> >CONFIG_CPU_FREQ_STAT_DETAILS=y
> ># CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> >CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> ># CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> ># CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> >CONFIG_CPU_FREQ_GOV_PERFORMANCE=m
> >CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> >CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >CONFIG_CPU_FREQ_GOV_ONDEMAND=m
> >CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> >
> >And modprobing any governor module does not change the output of 
> >scaling_available_governors.
> >
> >-Dave
> 
> I'm also experiencing this with a Intel G640 dual core machine.
> Exactly the same effect.

Do you have CONFIG_X86_INTEL_PSTATE set?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
