From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update PATCH 1/1] Cpufreq: Make governor data on nonboot cpus
 across system suspend/resume
Date: Sat, 16 Nov 2013 20:27:07 +0530
Message-ID: <CAKohpomKqJ-Vb68JvmBdTM-QbrszLH1BLQ14s5H1JzVZBTzpYA@mail.gmail.com>
References: <1384495294-10565-1-git-send-email-tianyu.lan@intel.com>
	<2368963.sKiLjXYCVt@vostro.rjw.lan>
	<5286EDBF.9050001@intel.com>
	<9847309.KdKOG5y1Zx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <9847309.KdKOG5y1Zx@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 November 2013 20:11, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Saturday, November 16, 2013 11:59:59 AM Lan Tianyu wrote:

>> Defaultly, all cpus use ondemand governor after bootup. Change one
>> non-boot cpu's governor to conservative,
>
> Well, why would anyone want to do that?  Just out of curiosity ...

People may want to use different group/cluster/socket of CPUs differently,
with different kind of policies. Maybe performance governor for boot cpu
and ondemand for others.

This bug would also be there for big LITTLE where we want to have
separate set of tunables for big and LITTLE clusters for the same type
of governor.

> So this is acpi-cpufreq, right?

Probably yes, I saw something similar somewhere.. But this is driver
independent..

> The patch looks basically OK to me, but ->

We wouldn't need this patch if my other patch (where I am disabling
governors in suspend/resume goes in, in any form)..
