From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/5] ARM: vexpress/TC2: cpufreq support
Date: Wed, 23 Oct 2013 00:05:01 +0200
Message-ID: <2836723.FbRfprjZNt@vostro.rjw.lan>
References: <1382349534-31502-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <CAKohpo=7Z7D9VsF5GHXKTUy70muNSr-q4nf8k8_qzWBzitzmvA@mail.gmail.com> <52664A94.3040508@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:53139 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753370Ab3JVVxH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Oct 2013 17:53:07 -0400
In-Reply-To: <52664A94.3040508@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Nicolas Pitre <nico@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On Tuesday, October 22, 2013 10:51:16 AM Sudeep KarkadaNagesha wrote:
> On 22/10/13 09:22, Viresh Kumar wrote:
> > On 21 October 2013 15:28, Sudeep KarkadaNagesha
> > <Sudeep.KarkadaNagesha@arm.com> wrote:
> >> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> >>
> >> Hi,
> >>
> >> The SPC(Serial Power Controller) on Versatile Express V2P-CA15_A7(TC2)
> >> not only controls low-power states, wake-up irqs and per-CPU jump addresses
> >> but also the CPU performance operating points which is essential to provide
> >> CPU DVFS. The M3 microcontroller can provide upto eight performance values,
> >> one set for each cluster (CA15 or CA7). Each of this value contains the
> >> frequency(kHz) and voltage(mV) at that performance level. It expects
> >> these performance level to be passed through the SPC PERF_LVL registers.
> >>
> >> This patch series adds support to populate those OPPs, add them to the
> >> cpu devices and runtime programming of these performance levels through
> >> clock framework. It also adds a small interface cpufreq driver to validate
> >> the OPPs and register the arm_big_little cpufreq driver.
> >>
> >> Changes v1->v2:
> >>         - Introduced ARCH_VEXPRESS_SPC config to make dependency
> >>           selection cleaner
> >>         - Other minor review comments from Nico implemented
> >>
> >> Regards,
> >> Sudeep
> >>
> >> Sudeep KarkadaNagesha (5):
> >>   cpufreq: arm-big-little: use clk_get instead of clk_get_sys
> >>   ARM: vexpress/TC2: add support for CPU DVFS
> >>   ARM: vexpress/TC2: add cpu clock support
> >>   cpufreq: arm_big_little: add vexpress SPC interface driver
> >>   ARM: vexpress/TC2: register vexpress-spc cpufreq device
> > 
> > For All Patches:
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Thanks Nico, Pawel and Viresh for the review and acks.
> 
> Hi Rafael,
> 
> Do you prefer a pull request for this or are you OK to pull from the mails ?

I can pick them up from email I think.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
