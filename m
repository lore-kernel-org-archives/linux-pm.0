From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
Date: Wed, 23 Jul 2014 22:20:14 +0530
Message-ID: <CAKohponLh66Ubr6=wY2OZCCrK11KZDj=DmXXqXsGGTHSG45wpA@mail.gmail.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
	<1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
	<CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
	<53CFA33F.6030307@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:33972 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549AbaGWQuP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 12:50:15 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so1988736oag.14
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 09:50:14 -0700 (PDT)
In-Reply-To: <53CFA33F.6030307@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Walmsley <pwalmsley@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 23 July 2014 17:27, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> The platform device is required for the deferred probe that can happen if the
> DFLL driver hasn't initialized yet, and module_init() callbacks don't seem to
> respect -EPROBE_DEFER.

Oh, which call in this file will return EPROBE_DEFER? I couldn't make out
which one will depend on DFLL driver.
