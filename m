From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC PATCH 4/4] dt-bindings: Add support for devices with
 multiple PM domains
Date: Mon, 10 Apr 2017 09:42:42 +0530
Message-ID: <3f96256d-0de5-26a2-e656-7912e06806ea@codeaurora.org>
References: <1490710443-27425-1-git-send-email-jonathanh@nvidia.com>
 <1490710443-27425-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42144 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdDJEMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 00:12:50 -0400
In-Reply-To: <1490710443-27425-5-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org
Cc: stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org



On 03/28/2017 07:44 PM, Jon Hunter wrote:
> Now that the generic PM domain framework supports consumers that can
> control multiple PM domains, update the device-tree binding for generic
> PM domains to state that one or more PM domain is permitted for a
> device.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 723e1ad937da..fb28d37f9e1f 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -20,8 +20,15 @@ Required properties:
>     as specified by device tree binding documentation of particular provider.
>  
>  Optional properties:
> - - power-domains : A phandle and PM domain specifier as defined by bindings of
> -                   the power controller specified by phandle.
> + - power-domains : An array of one or more PM domain specifiers (defined by the
> +		   bindings of the PM domain provider) for each PM domain that
> +		   is required by the device.
> + - power-domain-names: A list of strings of PM domain names. The list must have
> +                       a name for each PM domain specifier in the
> +		       'power-domains' property and these names must be unique
> +		       within the context of this property. The names must be
> +		       indexed so that the first name corresponds to the first
> +		       PM domain specifier and so on.

These bindings are for power-domain providers. We also need to update the bindings
for the consumers (look further down in the same file)

>     Some power domains might be powered from another power domain (or have
>     other hardware specific dependencies). For representing such dependency
>     a standard PM domain consumer binding is used. When provided, all domains
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
