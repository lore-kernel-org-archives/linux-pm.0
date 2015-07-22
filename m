From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Wed, 22 Jul 2015 12:27:51 +0530
Message-ID: <20150722065751.GB30970@linux>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
 <20150720103623.GQ7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34212 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932482AbbGVG54 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 02:57:56 -0400
Received: by pdbbh15 with SMTP id bh15so88214412pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2015 23:57:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150720103623.GQ7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

Back now, sorry for the delay ..

On 20-07-15, 11:36, Russell King - ARM Linux wrote:
> Why do we try to create the symlink for CPU devices which we haven't
> "detected" yet (iow, we haven't had cpufreq_add_dev() called for)?
> Surely we are guaranteed to have cpufreq_add_dev() called for every
> CPU which exists in sysfs?  So why not _only_ create the sysfs symlinks
> when cpufreq_add_dev() is notified that a CPU subsys interface is
> present?

There are lot of combinations in which things can happen and so it was
done to simplify things a bit, but I agree to what you are saying.
Makes sense, let me put some brain again on that path.

> Sure, if the policy changes, we need to do maintanence on these symlinks,

What do you mean by policy changes? The complete policy structure get
reallocated? or any of its properties changes?

The policy structure is only freed today, if either the driver gets
unregistered or its CPUs are physically hotplugged out. No maintenance
then.

> but I see only one path down into cpufreq_add_dev_symlink(), which is:
> 
> 	cpufreq_add_dev() -> cpufreq_add_dev_interface() ->
> 		cpufreq_add_dev_symlink()
> 
> In other words, only when we see a new CPU interface appears, not when
> the policy changes.

Right.

> If the set of related CPUs is policy independent,
> why is this information carried in the cpufreq_policy struct?

Management of policy is done based on what's there in related_cpus and
so its present here. IOW, these are the CPUs which own this policy.

> If it is policy dependent, then I see no code which handles the effect
> of a policy change where the policy->related_cpus is different.

Sorry, but I don't exactly understand the point here. What's policy
change? When a policy is destroyed we take care of all CPUs which are
there in ->cpus or related_cpus mask.. What else are we missing ?

> To me,
> that sounds like a rather huge design hole.

Maybe, just that I haven't understood it well yet.

> Things get worse.  Reading drivers/base/cpu.c, CPU interface nodes are
> only ever created - they're created for the set of _possible_ CPUs in
> the system, not those which are possible and present, and there is no
> unregister_cpu() API, only a register_cpu() API.  So, cpufreq_remove_dev()
> won't be called for CPUs which were present and are no longer present.
> This appears to be a misunderstanding of CPU hotplug...

You really got me worrying on this one and good that I read Rafael's
reply on this about it being called from arch code.

To be honest, I had no idea how the physical hotplug thing really
works and shouted couple of times on the list for help while working
on this set. Finally I took help of Srivatsa Bhat, who did lot of work
in the hotplug code and my patch was based on his suggestions. I
didn't looked at cpu.c in details to follow all code paths.

> So, cpufreq_remove_dev() will only get called when you call
> subsys_interface_unregister(), not when the CPU present mask changes.

I hope this statement doesn't hold true anymore.

> I suspect that the code in cpufreq_remove_dev() dealing with "offline"
> CPUs even works... I'd recommend reading Documentation/cpu-hotplug.txt:

I never tested it, our lovely ARM world doesn't have a case where we
can do physical hotplug :) .. Or do we have a virtual test to get that
done in some way? That would be helpful for future testing, in case
you are aware of any way out.

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

I do not accept it yet, I thought it was just fine.

> Please rethink the design of this code - I think your original change is
> mis-designed.

Yeah, based on the suggestion at the top, things need to change a bit
for sure. Thanks for looking into the details of the crappy design :)

-- 
viresh
