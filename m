From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Tue, 16 Feb 2016 06:43:35 +0530
Message-ID: <20160216011335.GI6334@vireshk-i7>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34148 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbcBPBNp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 20:13:45 -0500
Received: by mail-pa0-f46.google.com with SMTP id fy10so54144907pac.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 17:13:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On 15-02-16, 19:41, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2016 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > [    1.340000] [<c0958e78>] (__cpufreq_driver_target) from [<c095ca58>] (dbs_check_cpu+0x1ac/0x1e8)
> > [    1.340000] [<c095ca58>] (dbs_check_cpu) from [<c095cd04>] (cpufreq_governor_dbs+0x1fc/0x608)
> > [    1.340000] [<c095cd04>] (cpufreq_governor_dbs) from [<c0959c5c>] (__cpufreq_governor+0x1a8/0x204)
> > [    1.340000] [<c0959c5c>] (__cpufreq_governor) from [<c095a2dc>] (cpufreq_init_policy+0x60/0x8c)
> > [    1.340000] [<c095a2dc>] (cpufreq_init_policy) from [<c095a5f0>] (cpufreq_online+0x2e8/0x708)
> > [    1.340000] [<c095a5f0>] (cpufreq_online) from [<c075674c>] (subsys_interface_register+0x80/0xc4)
> > [    1.340000] [<c075674c>] (subsys_interface_register) from [<c0959764>] (cpufreq_register_driver+0x144/0x1a0)
> 
> This is the registration of the cpufreq driver (cpufreq-dt in this case).
> 
> It does cpufreq_online()->cpufreq_init_policy()->__cpufreq_governor()->cpufreq_governor_dbs()->dbs_check_cpu().
> 
> The only way that can happen is when cpufreq_set_policy() finds that
> the "old" and the "new" policies use the same governor, so it goes and
> calls __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS), but I'm not sure
> how this is possible during the initialization ATM.
> 
> Viresh, any ideas?

You misread probably.

During init, policy->gov is NULL and new_policy->gov is set to the
default one, probably ondemand/conservative. And in that case, we do:
- INIT
- START
- LIMITS

So above sequence is guaranteed to happen rather.

-- 
viresh
