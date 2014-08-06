From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem to
 be held for duration of changing governors [v2]
Date: Wed, 6 Aug 2014 13:40:30 +0530
Message-ID: <CAKohpoky1-hj7cwnKc58svh8Z1Yas1=q4uJEK8mWcb56uqAcng@mail.gmail.com>
References: <1406634362-811-1-git-send-email-prarit@redhat.com>
	<2066166.pXm4lKLOID@vostro.rjw.lan>
	<53DA8389.80804@redhat.com>
	<1917362.abr2Y4p7vh@vostro.rjw.lan>
	<53DA8A41.2030601@redhat.com>
	<53DAA60B.6040802@codeaurora.org>
	<53DAA749.5080506@redhat.com>
	<53DAA95B.2040505@codeaurora.org>
	<53DAB038.3050007@redhat.com>
	<53DABFA6.6090503@codeaurora.org>
	<53DACA26.1000908@redhat.com>
	<53DAE592.2030909@codeaurora.org>
	<53DB6B81.6050400@redhat.com>
	<53DBCBE8.6010809@codeaurora.org>
	<53DBE764.8050109@redhat.com>
	<53DBEC27.7050803@codeaurora.org>
	<CAKohpombG3Gj4mbm02vPNnAxzaRvQP7rb=iQ14dCFH4_+71H3w@mail.gmail.com>
	<53E0B657.4070007@redhat.com>
	<CAKohponxBdYEgY2oYuzmdaqfSRS8Uq8bZOzcb1QDmKO-z5ZBFQ@mail.gmail.com>
	<53E1556B.5070304@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48114 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbaHFIKc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Aug 2014 04:10:32 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so1554603obc.34
        for <linux-pm@vger.kernel.org>; Wed, 06 Aug 2014 01:10:30 -0700 (PDT)
In-Reply-To: <53E1556B.5070304@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 6 August 2014 03:36, Saravana Kannan <skannan@codeaurora.org> wrote:
> Stephen and I looked into this. This is not a sysfs framework difference.
> The reason we don't have this issue when we use global tunables is because
> we add the attribute group to the cpufreq_global_kobject and that kobject
> doesn't have a kobj_type ops similar to the per policy kobject. So,
> read/write to those attributes do NOT go through the generic show/store ops
> that wrap every other cpufreq framework attribute read/writes.
>
> So, none of those read/write do any kind of locking. They don't race with
> POLICY_EXIT (because we remove the sysfs group first thing in POLICY_EXIT)
> but might still race with START/STOPs (not sure, haven't looked closely
> yet).
>
> For example, writing to sampling_rate of ondemand governor might cause a
> race in update_sampling_rate(). It could race and happen between a STOP and
> POLICY_EXIT (triggered by hotplug, gov change, etc).

This sounds good but I couldn't prove it. Doing this on my dual core exynos
doesn't give me that crash report and it should?

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 1e0ec57..027b6f7 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -139,7 +139,7 @@ static int exynos_cpufreq_cpu_init(struct
cpufreq_policy *policy)
 }

 static struct cpufreq_driver exynos_driver = {
-       .flags          = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+       .flags          = CPUFREQ_STICKY |
CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
        .verify         = cpufreq_generic_frequency_table_verify,
        .target_index   = exynos_target,
        .get            = cpufreq_generic_get,
