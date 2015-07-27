From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 7/7] cpufreq: Separate CPU device removal from CPU online
Date: Mon, 27 Jul 2015 23:56:09 +0200
Message-ID: <CAJZ5v0hJYpY7k1+zM41oG=sSM=Zhf4LXZH9FBJFL4O7H2cTJfg@mail.gmail.com>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
	<3874727.Jpay9zgokc@vostro.rjw.lan>
	<1739669.kedIsxdRK2@vostro.rjw.lan>
	<20150727150655.GI18535@linux>
	<CAJZ5v0gT4e2=VRPcF5S2fSBUiNZ3+dAeOrt5rRy_PAT5-+Y4Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37171 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbbG0V4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 17:56:11 -0400
In-Reply-To: <CAJZ5v0gT4e2=VRPcF5S2fSBUiNZ3+dAeOrt5rRy_PAT5-+Y4Ow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, Jul 27, 2015 at 10:56 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jul 27, 2015 at 5:06 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 27-07-15, 16:09, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> To separate the CPU online interface from the CPU device removal
>>> one,
>>
>> Why do you call this cpu device removal code?
>
> By mistake.
>
> Of course, that should be addition/registration.
>
>>> split cpufreq_online() out of cpufreq_add_dev() and make
>>> cpufreq_cpu_callback() call the former, while the latter will only
>>> be used as the CPU device removal subsystem interface callback.
>>>
>>> While at it, notice that the return value of sif->add_dev() is
>>> ignored in bus_probe_device(), so (the new) cpufreq_add_dev()
>>> doesn't need to bother with returning anything different from 0
>>> and cpufreq_online() may be a void function.
>>
>> That is going to change in 4.3:
>>
>> https://lkml.org/lkml/2015/6/26/132
>
> There are some problems with access to klml.org today and I'm not sure
> what you mean.
>
> Can you explain your points in addition to sending links to stuff, please?

OK, I've just seen that patch, but it doesn't modify bus_probe_device() AFAICS.

Plus we also ignore the return value of cpufreq_add_dev() in the
hotplug notifier callback.

Thanks,
Rafael
