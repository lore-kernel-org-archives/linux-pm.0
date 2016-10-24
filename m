From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 3/8] PM / Domains: Allow domain power states to be read
 from DT
Date: Mon, 24 Oct 2016 14:39:06 +0100
Message-ID: <6ed96121-5040-474d-2d71-7927e8567c50@arm.com>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org>
 <1476467276-75094-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938957AbcJXNjP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 09:39:15 -0400
In-Reply-To: <1476467276-75094-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Marc Titinger <mtitinger+renesas@baylibre.com>



On 14/10/16 18:47, Lina Iyer wrote:
> This patch allows domains to define idle states in the DT. SoC's can
> define domain idle states in DT using the "domain-idle-states" property
> of the domain provider. Add API to read the idle states from DT that can
> be set in the genpd object.
>
> This patch is based on the original patch by Marc Titinger.
>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++
>  2 files changed, 102 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 37ab7f1..9af75ba 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1916,6 +1916,100 @@ out:
>  	return ret ? -EPROBE_DEFER : 0;
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> +
> +static const struct of_device_id idle_state_match[] = {
> +	{ .compatible = "arm,idle-state", },
> +	{ }
> +};
> +

I still think it's better to have another compatible to serve this
purpose. We don't want to end up creating genpd domains just because
they are "arm,idle-state" compatible IMO ?

I agree you can prevent it checking for OSC mode support in the
firmware. But I want to understand if you have any strong reasons for
avoiding that approach.

-- 
Regards,
Sudeep
