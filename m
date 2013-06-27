From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 5/7] cpufreq: Calculate number of busy CPUs
Date: Thu, 27 Jun 2013 12:58:19 +0200
Message-ID: <20130627125819.5c90da30@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-6-git-send-email-l.majewski@samsung.com>
 <CAKohpo=EwapTp8epok30=_ZYLPeCR8_LhpBF5H724dE=+SwMLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31692 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab3F0K63 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 06:58:29 -0400
In-reply-to: <CAKohpo=EwapTp8epok30=_ZYLPeCR8_LhpBF5H724dE=+SwMLg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>

On Thu, 27 Jun 2013 15:06:43 +0530, Viresh Kumar wrote:
> On 19 June 2013 22:42, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > In the core governor code, per cpu load value is calculated. This
> > patch uses it to mark processor as a "busy" one, when load value is
> > higher than 90%.
> 
> How can we take this assumption. What about a cpu which is only 70-80%
> busy [*]? 

Do you have any idea of how to precisely set the load threshold?

As a side note:

I've thought about this patch for some time and for me it looks like we
are mixing policy (number of busy CPUs) with abilities, which shall be
provided by the driver (boost). 
Additionally, we can only roughly "estimate" [*] when boost shall run
and when it shall be turned off.

I think that, we shall leave this management [*] to the thermal
framework. This framework is designed exactly to protect from over
heating (it uses the same freq_table for passive CPU cooling) with
several trip points -> e.g. 40 deg (disable boost), 75 deg (impose max
freq as 1.0 GHz to cool down, 90 deg (shutdown immediately).
Please refer to PATH v4 7/7.

Unfortunately, since we dropped Kconfig flag for BOOST we cannot
impose "select THERMAL_FRAMEWORK", when flag for BOOST is enabled at
Kconfig.

Ideally kernel shall not even build when CONFIG_CPUFREQ_BOOST Kconfig
flag is set and thermal for target architecture is not correctly
configured (including proper trip points).




> So, we would be running at around 70% of policy->max.. Now at
> this point you want to enable boost frequency and so that will happen
> for all cores... Wouldn't that burn your chip?

As I've written above, we can only estimate here. Even with the same
manufacturer at one SoC revision BOOST will work with 95% of policy max
but the other revision will work stable only with 70%.

> 
> > New cpufreq sysfs attribute is created (busy_cpus). It is read only
> > and provides information about number of actually busy CPU.
> 
> Not required.

This attribute seems helpful for debug.

> 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c
> > b/drivers/cpufreq/cpufreq_governor.c index 077cea7..3402533 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -148,6 +148,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data,
> > int cpu) continue;
> >
> >                 load = 100 * (wall_time - idle_time) / wall_time;
> > +               cpufreq_set_busy_cpu(j, load > 90 ? 1 : 0);
> 
> do this only when boost is enabled.

Please read above side note.

> 
> >                 if (dbs_data->cdata->governor == GOV_ONDEMAND) {
> >                         int freq_avg =
> > __cpufreq_driver_getavg(policy, j);


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
