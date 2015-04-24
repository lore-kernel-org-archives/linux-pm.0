From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
Date: Fri, 24 Apr 2015 12:03:38 +0200
Message-ID: <CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36557 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbDXKDj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 06:03:39 -0400
Received: by qku63 with SMTP id 63so26510041qku.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 03:03:38 -0700 (PDT)
In-Reply-To: <1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 23 April 2015 at 10:45, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add runtime PM support to handle (core and iface) clocks for devices
> without a controllable power domain. Once the drivers for these devices
> are converted to use runtime PM apis, all clock handling (for core and
> iface) from these drivers can then be removed.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/clk/qcom/gdsc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 480ebf6..92b0f6d 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -15,6 +15,7 @@
>  #include <linux/err.h>
>  #include <linux/jiffies.h>
>  #include <linux/pm_clock.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include "gdsc.h"
>
> @@ -226,3 +227,22 @@ void gdsc_unregister(struct device *dev)
>  {
>         of_genpd_del_provider(dev->of_node);
>  }
> +
> +static struct dev_pm_domain default_qcom_pm_domain = {
> +       .ops = {
> +               USE_PM_CLK_RUNTIME_OPS
> +               USE_PLATFORM_PM_SLEEP_OPS
> +       },
> +};
> +
> +static struct pm_clk_notifier_block qcom_pm_notifier = {
> +       .pm_domain      = &default_qcom_pm_domain,
> +       .con_ids        = { "core", "iface" },
> +};
> +
> +static int __init qcom_pm_runtime_init(void)
> +{
> +       pm_clk_add_notifier(&platform_bus_type, &qcom_pm_notifier);
> +       return 0;
> +}
> +core_initcall(qcom_pm_runtime_init);

First, I don't follow how this code is related to GDSC.

Second, I want to see less users of pm_clk_add_notifier() since it's
not the proper/long-term way of how to assign PM domain pointers to a
device. Instead that shall be done at device registration point. In
your case while parsing the DT nodes and adding devices onto to their
buses.

Yes, I understand that it will requires quite some work to adopt to
this behaviour - but that how it shall be done.

Finally, an important note, you don't need to use PM domains for these
devices at all and thus you don't need to fix what I propose. Instead
you only have to implement the runtime PM callbacks for each driver
and manage the clocks from there. That is probably also a easier
solution.

Kind regards
Uffe
