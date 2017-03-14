From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 4/9] PM / cpu_domains: Setup PM domains for CPUs/clusters
Date: Tue, 14 Mar 2017 12:36:09 +0100
Message-ID: <CAPDyKFpB-nZwkcs3ZEsFA+9UYmu1Z+qhAK4FeDSpMRmwjTbVDg@mail.gmail.com>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org> <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33492 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdCNLgL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 07:36:11 -0400
Received: by mail-ua0-f177.google.com with SMTP id u30so169785222uau.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2017 04:36:10 -0700 (PDT)
In-Reply-To: <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like power
> rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> CPUs may be associated with their domain providers. The domains in
> turn may be associated with their providers. This is clean way to model
> the cluster hierarchy like that of ARM's big.little architecture.
>
> Platform drivers may initialize generic PM domains and setup the CPU PM
> domains for the genpd and attach CPUs to the domain. In the following
> patches, the CPUs are hooked up to runtime PM framework which helps
> power down the domain, when all the CPUs in the domain are idle.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/Makefile      |   2 +-
>  drivers/base/power/cpu_domains.c | 192 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpu_domains.h      |  48 ++++++++++
>  3 files changed, 241 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/power/cpu_domains.c
>  create mode 100644 include/linux/cpu_domains.h
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 5998c53..ee383f1 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,7 @@ obj-$(CONFIG_PM)        += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
>  obj-$(CONFIG_PM_OPP)   += opp/
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
> +obj-$(CONFIG_PM_GENERIC_DOMAINS)       += domain.o domain_governor.o cpu_domains.o

One more thing that I wonder about.

Isn't cpu_domains relying on CONFIG_PM_GENERIC_DOMAINS_OF to work?
Perhaps it's just better to build for that case?

[...]

Kind regards
Uffe
