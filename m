From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 12/15] cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
Date: Tue, 19 Aug 2014 09:17:58 +0530
Message-ID: <CAKohponqx8hKKXE7dc03h_tZNeEZabX6SWmHh9-RYGy7RzbRfA@mail.gmail.com>
References: <1408419205-10048-1-git-send-email-tuomas.tynkkynen@iki.fi>
	<1408419205-10048-13-git-send-email-tuomas.tynkkynen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37824 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbaHSDr7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Aug 2014 23:47:59 -0400
Received: by mail-oi0-f45.google.com with SMTP id e131so4250190oig.32
        for <linux-pm@vger.kernel.org>; Mon, 18 Aug 2014 20:47:59 -0700 (PDT)
In-Reply-To: <1408419205-10048-13-git-send-email-tuomas.tynkkynen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Walmsley <pwalmsley@nvidia.com>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>

On 19 August 2014 09:03, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi> wrote:
> From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
>
> The Tegra124 will use a different driver for frequency scaling, so
> rename the old driver (which handles only Tegra20) appropriately.
>
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
> v3: New patch
> ---
>  drivers/cpufreq/Kconfig.arm                            | 6 +++---
>  drivers/cpufreq/Makefile                               | 2 +-
>  drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} | 0
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
