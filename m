From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Mon, 27 Jul 2015 07:59:52 +0530
Message-ID: <20150727022952.GF19944@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <20150725130002.GC1691@linux>
 <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
 <2161701.diIE0m8ocR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34048 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbbG0C34 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jul 2015 22:29:56 -0400
Received: by pacan13 with SMTP id an13so43926601pac.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 19:29:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2161701.diIE0m8ocR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 26-07-15, 02:28, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 87549141d516 (cpufreq: Stop migrating sysfs files on
> hotplug) there is a problem with CPUs that share cpufreq policy
> objects with other CPUs and are initially offline.
> 
> Say CPU1 shares a policy with CPU0 which is online and is registered
> first.  As part of the registration process, cpufreq_add_dev() is
> called for it.  It creates the policy object and a symbolic link
> to it from the CPU1's sysfs directory.  If CPU1 is registered
> subsequently and it is offline at that time, cpufreq_add_dev() will
> attempt to create a symbolic link to the policy object for it, but
> that link is present already, so a warning about that will be
> triggered.
> 
> To avoid that warning, make cpufreq use an additional CPU mask
> containing related CPUs that are actually present for each policy
> object.  That mask is initialized when the policy object is populated
> after its creation (for the first online CPU using it) and it includes
> CPUs from the "policy CPUs" mask returned by the cpufreq driver's
> ->init() callback that are physically present at that time.  Symbolic
> links to the policy are created only for the CPUs in that mask.
> 
> If cpufreq_add_dev() is invoked for an offline CPU, it checks the
> new mask and only creates the symlink if the CPU was not in it (the
> CPU is added to the mask at the same time).
> 
> In turn, cpufreq_remove_dev() drops the given CPU from the new mask,
> removes its symlink to the policy object and returns, unless it is
> the CPU owning the policy object.  In that case, the policy object
> is moved to a new CPU's sysfs directory or deleted if the CPU being
> removed was the last user of the policy.
> 
> While at it, notice that cpufreq_remove_dev() can't fail, because
> its return value is ignored, so make it ignore return values from
> __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
> and prevent these functions from aborting on errors returned by
> __cpufreq_governor().  Also drop the now unused sif argument from
> them.
> 
> Fixes: 87549141d516 (cpufreq: Stop migrating sysfs files on hotplug)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Russell King <linux@arm.linux.org.uk>
> ---
> 
> This goes back to the https://patchwork.kernel.org/patch/6856011/
> idea, but has a couple of bugs fixed and goes a it further with
> cleaning things up.
> 
> ---
>  drivers/cpufreq/cpufreq.c |  108 +++++++++++++++++++++++-----------------------
>  include/linux/cpufreq.h   |    1 
>  2 files changed, 56 insertions(+), 53 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
