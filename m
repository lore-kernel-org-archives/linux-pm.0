From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/5] x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF
Date: Mon, 19 Jun 2017 14:28:21 +0200
Message-ID: <136184443.Dv0asqkIzm@aspire.rjw.lan>
References: <1496889556-17923-1-git-send-email-lenb@kernel.org> <2034981.ATAhzOCgUq@aspire.rjw.lan> <CAJvTdKmK6SPq1L1nWpkAcVgXBT92r=-EZsTNPi1C5eBDaux5xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63570 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751054AbdFSMfg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 08:35:36 -0400
In-Reply-To: <CAJvTdKmK6SPq1L1nWpkAcVgXBT92r=-EZsTNPi1C5eBDaux5xQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Friday, June 16, 2017 09:49:00 PM Len Brown wrote:
> On Fri, Jun 16, 2017 at 8:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, June 07, 2017 07:39:13 PM Len Brown wrote:
> >> From: Len Brown <len.brown@intel.com>

[cut]

> >
> > I wonder if we could change intel_pstate_get() to simply return
> > aperfmperf_khz_on_cpu(cpu_num)?
> >
> > That would allow us to avoid the extra branch here and get rid of the
> > #ifdef x86 from the header.
> 
> The reason I put the hook here is specifically so that the same
> code would always be called on the x86 architecture,
> no not matter what cpufreq driver is loaded.
> 
> Yes, alternatively, all possible driver.get routines could be updated
> to call the same routine.  That is acpi-cpufreq.c, intel_pstate.c,
> others?

Just acpi-cpufreq.c and intel_pstate.c.

Moreover, I wouldn't change the behavior on systems using acpi-cpufreq.c,
because why really?

And some users may complain that now what they see in cpuinfo_cur_freq is
different from what they saw there before.

That leaves us with just intel_pstate.

In addition to that, it would be good to avoid reading APERF and MPERF in the
cases when we already have the values.  I have an idea on how to do that, but
I'll just need to prepare a patch.

> Do I think that saving a branch is meaningful in a system call to retrieve
> the average frequency from the kernel?  No, I don't.
>
> I'm not religious about "if (CONFIG_X86)" appearing in cpufreq.h.
> If somebody really cares, then the purist approach would be
> to add an additional arch-specific-hook header -- though that seemed
> overkill to me...

I'm not a fan of arch stuff in general code, C or headers.

If it is necessary to add an arch header, let's add it, but at this point I'm
not sure about that even.

Thanks,
Rafael
