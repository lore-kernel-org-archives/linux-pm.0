From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/18] cpufreq: don't loose cpufreq history on CPU hotplug
Date: Tue, 27 Jan 2015 16:06:01 +0100
Message-ID: <18969256.kkPtbfLplS@vostro.rjw.lan>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55156 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932262AbbA0OnR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 09:43:17 -0500
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org

On Tuesday, January 27, 2015 02:06:06 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> The aim of this series is to stop managing cpufreq sysfs directories on CPU
> hotplugs.

OK, and this is the last one I'm going to consider for 3.20 (in case you have
more of them queued up somewhere).

> This issue has been raised multiple times earlier, the latest being tried by
> Saravana. While working on the $Subject thread, I did lots of cleanups, most of
> which are already pushed by you.
> 
> The two remaining ones are added to this series..
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
> getting removed.

And uses will see CPUs that are not present any more?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
