From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] cpufreq: Add Tegra186 cpufreq driver
Date: Thu, 20 Apr 2017 02:46:37 +0200
Message-ID: <4060196.qTg8b6XvfH@aspire.rjw.lan>
References: <1491313417-25085-1-git-send-email-mperttunen@nvidia.com> <20170411063548.GD3670@vireshk-i7> <ce29c6b7-2942-0054-d014-7b262da6fb6d@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51650 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S940590AbdDTAwo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 20:52:44 -0400
In-Reply-To: <ce29c6b7-2942-0054-d014-7b262da6fb6d@kapsi.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

On Tuesday, April 11, 2017 09:37:28 AM Mikko Perttunen wrote:
> On 04/11/2017 09:35 AM, Viresh Kumar wrote:
> > On 04-04-17, 16:43, Mikko Perttunen wrote:
> >> Add a new cpufreq driver for Tegra186 (and likely later).
> >> The CPUs are organized into two clusters, Denver and A57,
> >> with two and four cores respectively. CPU frequency can be
> >> adjusted by writing the desired rate divisor and a voltage
> >> hint to a special per-core register.
> >>
> >> The frequency of each core can be set individually; however,
> >> this is just a hint as all CPUs in a cluster will run at
> >> the maximum rate of non-idle CPUs in the cluster.
> >>
> >> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> >> ---
> >> v2:
> >> - Many cosmetic / restructuring changes
> >> - Only one aperture read from DT now, with a new
> >>   structure containing the offset among other details
> >>   per cluster.
> >> - Don't enable the driver by default.
> >>
> >>  drivers/cpufreq/Kconfig.arm        |   6 +
> >>  drivers/cpufreq/Makefile           |   1 +
> >>  drivers/cpufreq/tegra186-cpufreq.c | 275 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 282 insertions(+)
> >>  create mode 100644 drivers/cpufreq/tegra186-cpufreq.c
> >
> > For all three patches.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I've applied the [1/3], but ACKs from the DT maintainers are needed for the
other two.

Thanks,
Rafael
