From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers: cpufreq: exynos: update related_cpus mask to fix
 hotplug dump
Date: Mon, 28 Jan 2013 18:29:35 +0530
Message-ID: <CAKohpokHXWh9ZCUK7jV3WHm2WMszO9e9UAmb1Wy0DdqeCWHNqA@mail.gmail.com>
References: <1359000647-8366-1-git-send-email-inderpal.singh@linaro.org>
	<CAOh2x==_n7d+FUyAA6nWuHHLK0TA7smBYXd2M=72HDQef3NG4w@mail.gmail.com>
	<5258369.So5tj1UHcd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:56292 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3A1M7g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jan 2013 07:59:36 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so2702444oag.27
        for <linux-pm@vger.kernel.org>; Mon, 28 Jan 2013 04:59:36 -0800 (PST)
In-Reply-To: <5258369.So5tj1UHcd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Inderpal Singh <inderpal.singh@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, patches@linaro.org

On 28 January 2013 17:56, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> So here's a deal: I'll drop "cpufreq: Simplify cpufreq_add_dev()" for now and
> you'll generate a new patch that won't cause the WARN_ON() to trigger.  OK?

:(

Or what about set all cpus from policy->cpus into related_cpus in our core code?
So, if platform sets any additional cpus, they would be retained?
