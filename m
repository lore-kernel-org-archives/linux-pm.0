From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 13/16] cpufreq: Add cpufreq driver for Tegra124
Date: Thu, 21 Aug 2014 10:39:41 +0530
Message-ID: <CAKohpo=rwM7Gju83heSzhw02J+FP1Jv2zdABZGsXFTF8KH=oEw@mail.gmail.com>
References: <1408568684-11016-1-git-send-email-ttynkkynen@nvidia.com>
	<1408568684-11016-14-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60672 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbaHUFJm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Aug 2014 01:09:42 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp4so7126804obc.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2014 22:09:41 -0700 (PDT)
In-Reply-To: <1408568684-11016-14-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Walmsley <pwalmsley@nvidia.com>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 21 August 2014 02:34, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> Add a new cpufreq driver for Tegra124. Instead of using the PLLX as
> the CPU clocksource, switch immediately to the DFLL. It allows the use
> of higher clock rates, and will automatically scale the CPU voltage as
> well. Besides the CPU clocksource switch, we let the cpufreq-cpu0 driver
> for all the cpufreq operations.
>
> This driver also relies on the DFLL driver to fill the OPP table for the
> CPU0 device, so that the cpufreq-cpu0 driver knows what frequencies to
> use.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> v4:
>  - check for get_cpu_device() return value
>  - add comment why an extra platform driver+device is required
>  - back to 'depends on GENERIC_CPUFREQ_CPU0'

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
