From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] acpi-cpufreq: Fix an acpi perf unregister issue
Date: Thu, 16 Jul 2015 02:33:36 +0200
Message-ID: <10145531.HIolQ1AkeI@vostro.rjw.lan>
References: <559F67E4.7010509@intel.com> <20150713022859.GA10415@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55564 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753571AbbGPAG6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:06:58 -0400
In-Reply-To: <20150713022859.GA10415@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pan Xinhui <xinhuix.pan@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On Monday, July 13, 2015 07:58:59 AM Viresh Kumar wrote:
> On 10-07-15, 14:36, Pan Xinhui wrote:
> > 
> > As policy->cpu may not be same in acpi_cpufreq_cpu_init and
> > acpi_cpufreq_cpu_exit. There is a risk that we use different *cpu* to
> > un/register acpi performance. So acpi_processor_unregister_performance
> > may not be able to do the cleanup work. That causes a memory leak. And
> > if there will be another acpi_processor_register_performance call, it
> > may also fail thanks to the internal check of pr->performace.
> > 
> > So we add a field *acpi_perf_cpu* to fix this issue.
> > 
> > Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> > ---
> > Change from V1:
> > 	comments update
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
