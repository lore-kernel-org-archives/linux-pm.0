From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: intel_pstate: Generic governors
 support
Date: Tue, 01 Nov 2016 17:14:23 -0700
Message-ID: <1478045663.3655.4.camel@linux.intel.com>
References: y6MlbaQWmXOXdy6MnbhKiO <001301d23484$7a57fd80$6f07f880$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbcKBAOZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Nov 2016 20:14:25 -0400
In-Reply-To: <001301d23484$7a57fd80$6f07f880$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On Tue, 2016-11-01 at 14:11 -0700, Doug Smythies wrote:
> On 2016.10.22 17:17 Rafael J. Wysocki wrote:
> 
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There may be reasons to use generic cpufreq governors (eg.
> > schedutil)
> > on Intel platforms instead of the intel_pstate driver's internal
> > governor.  However, that currently can only be done by disabling
> > intel_pstate altogether and using the acpi-cpufreq driver instead
> > of it, which is subject to limitations.
> > 
> > First of all, acpi-cpufreq only works on systems where the _PSS
> > object is present in the ACPI tables for all logical CPUs.  Second,
> > on those systems acpi-cpufreq will only use frequencies listed by
> > _PSS which may be suboptimal.  In particular, by convention, the
> > whole turbo range is represented in _PSS as a single P-state and
> > the frequency assigned to it is greater by 1 MHz than the greatest
> > non-turbo frequency listed by _PSS.  That may confuse governors to
> > use turbo frequencies less frequently which may lead to suboptimal
> > performance.
> > 
> > For this reason, make it possible to use the intel_pstate driver
> > with generic cpufreq governors as a "normal" cpufreq driver.  That
> > mode is enforced by adding intel_pstate=passive to the kernel
> > command line and cannot be disabled at run time.  In that mode,
> > intel_pstate provides a cpufreq driver interface including
> > the ->target() and ->fast_switch() callbacks and is listed in
> > scaling_driver as "intel_cpufreq".
> 
> It is not clear to me why users that currently use
> intel_pstate=disable on the kernel command line would benefit from
> this change.
Two reasons I think:
- We have a big turbo zone, where current acpi-cpufreq can't select any
target frequency even if controllable.

- We can still target ACPI-CPPC compatible devices in legacy mode and
later in non-legacy mode.

Thanks,
Srinivas
