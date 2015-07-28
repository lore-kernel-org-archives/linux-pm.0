From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 7/7] cpufreq: Separate CPU device removal from CPU online
Date: Tue, 28 Jul 2015 16:22:52 +0200
Message-ID: <CAJZ5v0hTW6H8ZStJ7TSqbDGc8JnBdvz33UEMEvQGAD_zLrRHzw@mail.gmail.com>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
	<3874727.Jpay9zgokc@vostro.rjw.lan>
	<1739669.kedIsxdRK2@vostro.rjw.lan>
	<20150727150655.GI18535@linux>
	<CAJZ5v0gT4e2=VRPcF5S2fSBUiNZ3+dAeOrt5rRy_PAT5-+Y4Ow@mail.gmail.com>
	<CAJZ5v0hJYpY7k1+zM41oG=sSM=Zhf4LXZH9FBJFL4O7H2cTJfg@mail.gmail.com>
	<20150728020644.GL18535@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35989 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbG1OWx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 10:22:53 -0400
In-Reply-To: <20150728020644.GL18535@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Viresh,

On Tue, Jul 28, 2015 at 4:06 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-15, 23:56, Rafael J. Wysocki wrote:
>> OK, I've just seen that patch, but it doesn't modify bus_probe_device() AFAICS.
>
> Why is bus_probe_device() required to be modified?

Because that's a different place where sif->add() is called and if it
can fail, we need to fail the probing there too.

In other words, failing things in one place and not doing that in
another analogous place is inconsistent and incorrect.

> I wrote this patch to propagate -EPROBE_DEFER from the ->init()
> callback, which is called from cpufreq_register_driver().
>
> And that worked after my patch..
>
>> Plus we also ignore the return value of cpufreq_add_dev() in the
>> hotplug notifier callback.
>
> My use case needed it for the subsys callback.

That case is a failing cpufreq driver registration, right?

What if a CPU is registered after the cpufreq driver has been
registered and *that* fails?  Shouldn't it fail in the same way in
both cases?

Thanks,
Rafael
