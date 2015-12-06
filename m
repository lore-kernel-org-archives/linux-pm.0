From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V4 11/16] Documentation: DT: bindings: Update NVIDIA PMC
 for Tegra210
Date: Sat, 5 Dec 2015 18:31:07 -0600
Message-ID: <20151206003106.GA12441@rob-hp-laptop>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-12-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40939 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbbLFAbM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 5 Dec 2015 19:31:12 -0500
Content-Disposition: inline
In-Reply-To: <1449241037-22193-12-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Dec 04, 2015 at 02:57:12PM +0000, Jon Hunter wrote:
> ---
>  Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 02c27004d4a8..838e1a69ec0a 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -9,8 +9,9 @@ Required properties:
>  - compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
>    must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
>    "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
> -  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
> -  above, where <chip> is tegra132.
> +  For Tegra210, must contain "nvidia,tegra210-pmc". Otherwise, must contain
> +  "nvidia,<chip>-pmc", plus at least one of the above, where <chip> is
> +  tegra132.

Can you reorg this some so the compatible strings are a list rather than 
a paragraph of text. I find the last sentence a bit confusing as well. 
Seems like <chip> should be a list rather than just tegra132.


>  - reg : Offset and length of the register set for the device
>  - clocks : Must contain an entry for each entry in clock-names.
>    See ../clocks/clock-bindings.txt for details.
> -- 
> 2.1.4
> 
