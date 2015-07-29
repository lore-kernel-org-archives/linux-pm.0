From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Wed, 29 Jul 2015 22:32:43 +0200
Message-ID: <CAJZ5v0gQTYgr1mweGV+CeQHgnkYp+PDwvqv09XRZHbMiQgjzQQ@mail.gmail.com>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
	<4080510.IQ60sVQvbL@vostro.rjw.lan>
	<20150727143935.GB18535@linux>
	<2112385.YuDJ7h1x56@vostro.rjw.lan>
	<20150729091136.GN7557@n2100.arm.linux.org.uk>
	<CAJZ5v0iUn0rSVSqyXscCfGgujpM7r9o9xjQgDOk+JQ=y6seRgQ@mail.gmail.com>
	<20150729142148.GF5100@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38754 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbbG2Ucp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 16:32:45 -0400
In-Reply-To: <20150729142148.GF5100@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Viresh,

On Wed, Jul 29, 2015 at 4:21 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-07-15, 15:57, Rafael J. Wysocki wrote:
>> In practice, this means a cpufreq driver registration done in parallel
>> with CPU hotplug.
>
> Not necessarily. Also consider the case where cpufreq driver is already working
> for a set of CPUs. And a new set of CPUs (that will share the policy) are
> getting physically added to the system.

That's what I mean by "hotplug" (as opposed to online/offline).

Adding a CPU involves (a) updating the present map and (b) registering
the CPU device and both are carried out together with CPU
online/offline locked.  At least that's the expectation and I'm not
aware of any architecture doing that differently.

So locking CPU online/offline around the cpufreq driver registration
would close that race and there's one more reason for doing that
(other than we do it for the cpufreq driver unregistration as I said
before): we need the CPU *online* map to be stable too while we're
registering the cpufreq driver.

> Anyway, even if there is no problem at all, I do agree with Russell that it will
> be better to do operations on behalf of the devices only when we are requested
> for those devices.

Problem is, we can't do that for all of them.  If the CPU is ofline
while being registered (the common case for hot-add) and it doesn't
have a policy already, we can't link it to an existing policy anyway,
so that operation has to be carried out later.  That is, we need to
create links for those CPUs after the policy has been created in any
case.

Moreover, the only case when we need to create links for online CPUs
is the registration of a cpufreq driver, because only then we can see
online CPUs that should be linked to a policy, but aren't.  It takes
less code to treat them in the same way as the offline CPUs at that
point (and create the links for them right after the policy has been
created) than to defer it to until sif->add() is called for each of
them, because we know that sif->add() is practically guaraneed to
succeeed for them (this is the code path in which we call
cpufreq_add_policy_cpu() and the governor "stop" only fails if it
hasn't been started for that policy).

Thanks,
Rafael
