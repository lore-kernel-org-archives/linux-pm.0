From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/7] cpufreq: intel_pstate: Remove duplicate CPU ID check
Date: Wed, 11 Jun 2014 02:32:41 +0200
Message-ID: <3882689.ERRzduavD8@vostro.rjw.lan>
References: <53962059.6070306@semaphore.gr> <CAKohpokABMSRr88Tf=+Kn4b4=r7ThE+mjdAZcU+dvo28b47Kcg@mail.gmail.com> <53973CF5.4000201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62147 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752183AbaFKAPR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 20:15:17 -0400
In-Reply-To: <53973CF5.4000201@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, dirk.j.brandewie@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tuesday, June 10, 2014 10:14:29 AM Dirk Brandewie wrote:
> On 06/09/2014 10:21 PM, Viresh Kumar wrote:
> > On 10 June 2014 02:30, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> >> We check the CPU ID during driver init. There is no need
> >> to do it again per logical CPU initialization.
> >>
> >> So, remove the duplicate check.
> >>
> >> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> >> ---
> >>   drivers/cpufreq/intel_pstate.c | 6 ------
> >>   1 file changed, 6 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> >> index aebd457..4e7f492 100644
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -691,14 +691,8 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> >>
> >>   static int intel_pstate_init_cpu(unsigned int cpunum)
> >>   {
> >> -
> >> -       const struct x86_cpu_id *id;
> >>          struct cpudata *cpu;
> >>
> >> -       id = x86_match_cpu(intel_pstate_cpu_ids);
> >> -       if (!id)
> >> -               return -ENODEV;
> >> -
> >>          all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
> >>          if (!all_cpu_data[cpunum])
> >>                  return -ENOMEM;
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

[1/7] applied, please wait with the rest until after 3.16-rc1 is released.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
