From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Tue, 21 Jul 2015 16:13:17 +0530
Message-ID: <CAKohpo=SnEZ5VezV2mCrkgoXKu9KT2XBG3qz3vn8vXxZwZdUPA@mail.gmail.com>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
	<a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
	<20150720103623.GQ7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32890 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbbGUKnS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 06:43:18 -0400
Received: by pdbnt7 with SMTP id nt7so47893568pdb.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2015 03:43:18 -0700 (PDT)
In-Reply-To: <20150720103623.GQ7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 20 July 2015 at 16:06, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Why do we try to create the symlink for CPU devices which we haven't
> "detected" yet (iow, we haven't had cpufreq_add_dev() called for)?
> Surely we are guaranteed to have cpufreq_add_dev() called for every
> CPU which exists in sysfs?  So why not _only_ create the sysfs symlinks
> when cpufreq_add_dev() is notified that a CPU subsys interface is
> present?
>
> Sure, if the policy changes, we need to do maintanence on these symlinks,
> but I see only one path down into cpufreq_add_dev_symlink(), which is:
>
>         cpufreq_add_dev() -> cpufreq_add_dev_interface() ->
>                 cpufreq_add_dev_symlink()
>
> In other words, only when we see a new CPU interface appears, not when
> the policy changes.  If the set of related CPUs is policy independent,
> why is this information carried in the cpufreq_policy struct?
>
> If it is policy dependent, then I see no code which handles the effect
> of a policy change where the policy->related_cpus is different.  To me,
> that sounds like a rather huge design hole.
>
> Things get worse.  Reading drivers/base/cpu.c, CPU interface nodes are
> only ever created - they're created for the set of _possible_ CPUs in
> the system, not those which are possible and present, and there is no
> unregister_cpu() API, only a register_cpu() API.  So, cpufreq_remove_dev()
> won't be called for CPUs which were present and are no longer present.
> This appears to be a misunderstanding of CPU hotplug...
>
> So, cpufreq_remove_dev() will only get called when you call
> subsys_interface_unregister(), not when the CPU present mask changes.
> I suspect that the code in cpufreq_remove_dev() dealing with "offline"
> CPUs even works... I'd recommend reading Documentation/cpu-hotplug.txt:
>
> | cpu_present_mask: Bitmap of CPUs currently present in the system. Not all
> | of them may be online. When physical hotplug is processed by the relevant
> | subsystem (e.g ACPI) can change and new bit either be added or removed
> | from the map depending on the event is hot-add/hot-remove. There are
> | currently no locking rules as of now. Typical usage is to init topology
> | during boot, at which time hotplug is disabled.
> |
> | You really dont need to manipulate any of the system cpu maps. They should
> | be read-only for most use. When setting up per-cpu resources almost always
> | use cpu_possible_mask/for_each_possible_cpu() to iterate.
>
> In other words, I think your usage of cpu_present_mask in this code is
> buggy in itself.
>
> Please rethink the design of this code - I think your original change is
> mis-designed.

I wasn't able to get time in last few days for this, sorry about that..

Will try my best tomorrow to come back to this..
