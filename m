From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 14/14] cpufreq: Add support for physical hoplug of CPUs
Date: Sat, 16 May 2015 03:18:09 +0200
Message-ID: <3771347.4CYzBDSQ1Q@vostro.rjw.lan>
References: <cover.1431065963.git.viresh.kumar@linaro.org> <22ea2a0dd3e860d9b0e8703f49d07ca32e2fc490.1431065963.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46763 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934479AbbEPAwz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 20:52:55 -0400
In-Reply-To: <22ea2a0dd3e860d9b0e8703f49d07ca32e2fc490.1431065963.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Friday, May 08, 2015 11:53:57 AM Viresh Kumar wrote:
> It is possible to physically hotplug the CPUs and it happens in this
> sequence.
> 
> Hot removal:
> - CPU is offlined first, ~ 'echo 0 >
>   /sys/devices/system/cpu/cpuX/online'
> - Then its device is removed along with all sysfs files, cpufreq core
>   notified with cpufreq_remove_dev() callback from subsys-interface..
> 
> Hot addition:
> - First the device along with its sysfs files is added, cpufreq core
>   notified with cpufreq_add_dev() callback from subsys-interface..
> - CPU is onlined, ~ 'echo 1 > /sys/devices/system/cpu/cpuX/online'
> 
> This needs to be handled specially as current code isn't taking care of
> this case. Because we will hit the same routines with both hotplug and
> subsys callbacks, we can handle most of the stuff with regular hotplug
> callback paths.  We only need to take care of adding/removing cpufreq
> sysfs links or freeing policy from subsys callbacks.
> 
> And that can be sensed easily as cpu would be offline in those cases.
> This patch adds special code in those paths to take care of policy and
> its links.
> 
> cpufreq_add_remove_dev_symlink() is also broken into another routine
> add_remove_cpu_dev_symlink() to reuse code at several places.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

You seem to be breaking things first and then fixing them up with this patch.

Would it be possible to avoid breaking them in the first place?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
