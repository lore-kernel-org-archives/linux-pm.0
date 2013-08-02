From: Mike Turquette <mturquette@linaro.org>
Subject: Re: BUG_ON(irqs_disabled()) in cpufreq.c
Date: Thu, 01 Aug 2013 23:38:54 -0700
Message-ID: <20130802063854.6450.70950@quantum>
References: <CAEL66Hib_KJ3=5Hi-=OAye=2pbQz_0-PcC6CicjP9n2Ng2KG9g@mail.gmail.com>
 <CAOh2x=nfzMEgbetmaUhjKx2FfCvxPjOxk6A_XC-Q9h0+HOEnGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:47794 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3HBGi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Aug 2013 02:38:59 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so326560pbc.29
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2013 23:38:59 -0700 (PDT)
In-Reply-To: <CAOh2x=nfzMEgbetmaUhjKx2FfCvxPjOxk6A_XC-Q9h0+HOEnGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Michael Giardino <giardino@ece.gatech.edu>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

Quoting Viresh Kumar (2013-08-01 22:02:37)
> More lists cc'd
> 
> On Thu, Aug 1, 2013 at 6:08 PM, Michael Giardino
> <giardino@ece.gatech.edu> wrote:
> > Hi,
> >
> > I hope this is the right spot to ask this.
> >
> > Is there any way to change the cpu frequency using the cpufreq driver
> > from within an hrtimer callback function? I encounter a kernel panic
> > at cpufreq.c line 255 (260 in 3.9.5)

It is not just about the notifiers.

Performing a clock rate change and voltage regulator transition (DVFS)
is not a short operation on many ARM platforms. Relocking a PLL and
waiting for a regulator to step and stabilize can take well over 100
milliseconds and some of those functions might sleep.

Some ARM platform do not manage this directly and talk to a power
management micro controller, so we could probably do that with
interrupts disabled if it's just a matter of writing to some
memory-mapped registers.

I don't know how Intel does it with ACPI but I assume that they don't
block waiting for things to happen based on a recent G+ post I read[1].
I have even less of a clue how the other architectures out there do it.

So the question in general is whether we should assume that we may sleep
or block during a CPU frequency scaling operation.  The short answer
seems to be "yes" since some platforms need this today.

Perhaps CPUfreq could allow for differentiating between platforms that
need to sleep/block and those that do not?

Regards,
Mike

[1] https://plus.google.com/114657443111661859546/posts/dLn9T4ehywL

> >
> > void __cpufreq_notify_transition(struct cpufreq_policy *policy,
> > 253                 struct cpufreq_freqs *freqs, unsigned int state)
> > 254 {
> > 255         BUG_ON(irqs_disabled());
> >
> >
> > I'm assuming this is due to the cpufreq_notify_transition needs
> > interrupts to notify? Is there a way around this? It appears that
> > acpi-cpufreq.c is calling the notifier both before and after the
> > transition (CPUFREQ_PRECHANGE and CPUFREQ_POSTCHANGE).
> >
> > Are there any frequency change functions that can operate without interrupts?
> >
> > The background is this:
> >
> > For the past few days I have been trying to get to the bottom of a
> > problem involving a nonSMP governor I have written. The goal of this
> > governor is to change the frequency on a predefined schedule (in the
> > ms scale). The basic breakdown is this:
> >
> > 1. The external scheduler computes schedules and then passes them to
> > the governor (with much code appropriated from the userspace governor)
> > via an exported function.
> > 2. The governor sets the frequency, then sets a timer to call the next
> > frequency change when it goes off
> >
> > In order to do this, I was using hrtimers. These timer's callback
> > functions run with interrupts disabled.
> >
> > Michael Giardino
> > <giardino@ece.gatech.edu>
> > <michael.giardino@gmail.com>
> > --
> > To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
