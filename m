From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 13:21:16 +0530
Message-ID: <CAOh2x=n0-a9amv5cfwOotvCnhNksnNZOSVp4jWk400z71UQeWQ@mail.gmail.com>
References: <51F40612.2050403@gmx.de>
	<2111514.pxW5saG1J3@vostro.rjw.lan>
	<18359786.D7glpto546@vostro.rjw.lan>
	<2368277.VjYrsHUseA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:63454 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab3G2HvR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 03:51:17 -0400
In-Reply-To: <2368277.VjYrsHUseA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Mon, Jul 29, 2013 at 4:50 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Having a deeper look at it, though, I see that in fact the whole
> cpufreq_cpu_put() is needed if the CPU is not the last one for the given
> policy and is not needed at all otherwise (as described in the changelog
> of the patch below).
>
> Srivatsa, does this make sense to you?

It makes atleast to me :)

> This is not the only bad thing that happens there, however, because
> kobject_put() should only be called for the policy kobject at this
> point if the CPU is not the last one for that policy.
>
> Namely, if the given CPU is the last one for that policy, the
> policy kobject's refcount should be 1 at this point, as set by
> cpufreq_add_dev_interface(), and only needs to be dropped once for
> the kobject to go away.  This actually happens under the cpu == 1
> check, so it need not be done before by cpufreq_cpu_put().

But I see one more issue with this code. For the last cpu we are just
calling kobject_put() and not cpufreq_cpu_put() and hence call to
module_put() is skipped. I am not sure, but that will probably cause
a problem when we try to rmmod the module? But which module then?
As we can't compile cpufreq.c as module.. So, is this part of code junk?
And so can be removed?
