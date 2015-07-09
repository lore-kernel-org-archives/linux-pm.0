From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] acpi-cpufreq: replace per_cpu with driver_data of policy
Date: Thu, 09 Jul 2015 02:20:56 +0200
Message-ID: <12074796.mAD950pclu@vostro.rjw.lan>
References: <559BC96E.8020804@intel.com> <20150707143443.GT14598@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58208 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751082AbbGHXy2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 19:54:28 -0400
In-Reply-To: <20150707143443.GT14598@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pan Xinhui <xinhuix.pan@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Tuesday, July 07, 2015 08:04:43 PM Viresh Kumar wrote:
> On 07-07-15, 20:43, Pan Xinhui wrote:
> > 
> > Drivers can store their internal per-policy information in
> > policy->driver_data, lets use it.
> > 
> > we have benefits after this replacing.
> > 1) memory saving.
> > 2) policy is shared by several cpus, per_cpu seems not correct. using
> > *driver_data* is more reasonable.
> > 3) fix a memory leak in acpi_cpufreq_cpu_exit. as policy->cpu might
> > change during cpu hotplug. So sometimes we cant't free *data*, use
> > *driver_data* to fix it.
> > 4) fix a zero return value of get_cur_freq_on_cpu. Only per_cpu of
> > policy->cpu is set to *data*, if we try to get cpufreq on other cpus, we
> > get zero instead of correct values. Use *driver_data* to fix it.
> > 
> > Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> > ---
> > Changes from V1:
> > 	codes style fix, comments update
> > 	move cpufreq_cpu_put(policy) after we get *driver_data*
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 40 ++++++++++++++++++++++------------------
> >  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

OK

Does it fix any recent regressions or is it just an old bug?

Rafael

