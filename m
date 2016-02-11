From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 1/7] cpufreq: Merge cpufreq_offline_prepare/finish routines
Date: Thu, 11 Feb 2016 01:59:24 +0100
Message-ID: <CAJZ5v0hbZMmgN2q-eR6dXK=rgLSDK_WEbD-mFB12Agb1RMm8-w@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<e773903ed5010cb3a9e445e2cf3a96db3942ff28.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33093 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbcBKA70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 19:59:26 -0500
In-Reply-To: <e773903ed5010cb3a9e445e2cf3a96db3942ff28.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The offline routine was separated into two halves earlier by
> 'commit 1aee40ac9c86 ("cpufreq: Invoke __cpufreq_remove_dev_finish()
> after releasing cpu_hotplug.lock");.
>
> And the reasons cited were, race issues between accessing policy's sysfs
> files and policy kobject's cleanup.
>
> That race isn't valid anymore, as we don't remove the policy & its
> kobject completely on hotplugs, but do that from ->remove() callback of
> subsys framework.

Governor sysfs attributes are still removed in
__cpufreq_governor(_EXIT), though, so had store() been used for them,
the deadlock described in the changelog of commit 1aee40ac9c86 would
have been possible.

Fortunately, we don't use store() (which still does get_online_cpus())
for those attributes now.  We use governor_store() for them and that
doesn't call get_online_cpus().  So in fact this patch is only correct
after the recent rework of the governor attributes handling.

Please modify the changelog to explain that more thoroughly.

Thanks,
Rafael
