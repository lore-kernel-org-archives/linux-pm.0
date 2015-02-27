From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/20] cpufreq: Don't loose cpufreq history on CPU hotplug
Date: Fri, 27 Feb 2015 10:56:26 +0530
Message-ID: <CAKohponfFhGCAm8Dn_9V4doLhJzt6362q31Ub2nC9C3+o1Mvug@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:51323 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbbB0F01 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 00:26:27 -0500
Received: by mail-oi0-f49.google.com with SMTP id v63so13795973oia.8
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 21:26:26 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Saravana Kannan <skannan@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srivatsa Bhat <srivatsa@mit.edu>

On 19 February 2015 at 17:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> The aim of this series is to stop managing cpufreq sysfs directories on CPU
> hotplugs.
>
> Currently on removal of a 'cpu != policy->cpu', we remove its sysfs directories
> by removing the soft-link. And on removal of policy->cpu, we migrate the sysfs
> directories to the next cpu. But if policy->cpu was the last CPU, we remove the
> policy completely and allocate it again as soon as the CPUs come back. This has
> shortcomings:
>
> - Code Complexity
> - Slower hotplug
> - sysfs file permissions are reset after all policy->cpus are offlined
> - CPUFreq stats history lost after all policy->cpus are offlined
> - Special management of sysfs stuff during suspend/resume
>
>
> To make things simple we stop playing with sysfs files unless the driver is
> getting removed. Also the policy is kept intact to be used later.
>
> First few patches provide a clean base for others *more important* patches.
>
> Rebased-over: your bleeding edge branch as there were dependencies on my earlier
> patches.
>
> Pushed here:
>
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/core/sysfs
>
> v1->V2:
> - Dropped the idea of using policy-lists for getting policy for any cpu
> - Also dropped fallback list and its per-cpu variable
> - Stopped cleaning cpufreq_cpu_data and doing list_del(policy) on logical
>   hotplug.
> - Added support for physical hotplug of CPUs (Untested).

Gentle reminder for reviews !! :)
