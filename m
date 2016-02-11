From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 2/7] cpufreq: Call __cpufreq_governor() with
 policy->rwsem held
Date: Thu, 11 Feb 2016 10:48:20 +0100
Message-ID: <CAJZ5v0hVhVyDvk1Vj5NAh1w1nXEZ6eF0v9x+8CfZ6pyKSu=k9g@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<2d9def751daa27c9aba57ab29a54003dd279e5e7.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:35252 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcBKJsW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 04:48:22 -0500
In-Reply-To: <2d9def751daa27c9aba57ab29a54003dd279e5e7.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This isn't followed properly by all parts of the core code, some follow
> it, whereas others don't.

"The cpufreq core code is not consistent with respect to invoking
__cpufreq_governor() under policy->rwsem."

> Enforcing it will also enable us to remove cpufreq_governor_lock, that
> is used today because we can't guarantee that __cpufreq_governor() isn't
> executed in parallel.

"Changing all code to always hold policy->rwsem around
__cpufreq_governor() invocations will allow us to ..."

> We should also ensure that the lock is held across state changes to the
> governors.
>
> For example, while adding a CPU to the policy on cpu-online path, we
> need to stop the governor, change policy->cpus, start the governor and
> then refresh its limits. The complete sequence must be guaranteed to
> execute without any concurrent races. And that can be achieved using
> policy->rwsem around these use cases.
>
> Also note that cpufreq_driver->stop_cpu() and ->exit() can get called
> while policy->rwsem is held. That shouldn't have any side effects
> though.

The last paragraph is unclear.

Is it supposed to mean that the change will cause
cpufreq_driver->stop_cpu() and ->exit() to be called under
policy->rwsem sometimes?

Thanks,
Rafael
