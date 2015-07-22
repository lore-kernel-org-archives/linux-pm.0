From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Wed, 22 Jul 2015 12:34:48 +0530
Message-ID: <20150722070448.GC30970@linux>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
 <20150720103623.GQ7557@n2100.arm.linux.org.uk>
 <CAJZ5v0i4-F1XO1ioSLZpYToGWvzM+xLh1-QS6j5zEdOQ8itRfA@mail.gmail.com>
 <CAJZ5v0gHz5cEmX23uXESTmWbx5S+XsXMvxUp4ikTTpgdVy9N3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36382 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbGVHEx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 03:04:53 -0400
Received: by pdjr16 with SMTP id r16so136373598pdj.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 00:04:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gHz5cEmX23uXESTmWbx5S+XsXMvxUp4ikTTpgdVy9N3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 21-07-15, 03:14, Rafael J. Wysocki wrote:
> That said, cpu_present_mask may only be updated after calling
> arch_unregister_cpu(), so checking it in cpufreq_remove_dev() doesn't
> really help.

No, it is indeed useful. This is a snippet from the latest code we
have:

		cpumask_copy(&mask, policy->related_cpus);
		cpumask_clear_cpu(cpu, &mask);

		/*
		 * Free policy only if all policy->related_cpus are removed
		 * physically.
		 */
		if (cpumask_intersects(&mask, cpu_present_mask)) {
			remove_cpu_dev_symlink(policy, cpu);
			return 0;
		}

		cpufreq_policy_free(policy, true);



So what we are checking in the 'if' block is: "Is any CPU from
related_cpus, apart from the one getting removed now, present in the
system."

If not, then free the policy.

> It looks like using cpufreq_remove_dev() as the subsys ->remove_dev
> callback is a mistake as it cannot really tell the difference between
> that code path and the CPU offline one.

What do you mean by this? Doesn't the sif parameter confirms that its
called from subsys path ?

-- 
viresh
