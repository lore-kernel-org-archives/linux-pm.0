From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states infrastructure
Date: Wed, 11 Jun 2014 20:25:49 +0200
Message-ID: <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:39466 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbaFKSZu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 14:25:50 -0400
In-Reply-To: <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <chander.kashyap@linaro>

On Wed, Jun 11, 2014 at 6:18 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On most common ARM systems, the low-power states a CPU can be put into are
> not discoverable in HW and require device tree bindings to describe
> power down suspend operations and idle states parameters.
>
> In order to enable DT based idle states and configure idle drivers, this
> patch implements the bulk infrastructure required to parse the device tree
> idle states bindings and initialize the corresponding CPUidle driver states
> data.
>
> Code that initializes idle states checks the CPU idle driver cpumask so
> that multiple CPU idle drivers can be initialized through it in the
> kernel. The CPU idle driver cpumask defines which idle states should be
> considered valid for the driver, ie idle states that are valid on a set
> of cpus the idle driver manages.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/cpuidle/Kconfig          |   9 ++
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/of_idle_states.c | 282 +++++++++++++++++++++++++++++++++++++++
>  drivers/cpuidle/of_idle_states.h |   8 ++
>  4 files changed, 300 insertions(+)
>  create mode 100644 drivers/cpuidle/of_idle_states.c
>  create mode 100644 drivers/cpuidle/of_idle_states.h
>
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 1b96fb9..760ce20 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -30,6 +30,15 @@ config CPU_IDLE_GOV_MENU
>         bool "Menu governor (for tickless system)"
>         default y
>
> +config OF_IDLE_STATES

One question here.

Do you want this to be generally useful or is it just ARM-specific?

Rafael
