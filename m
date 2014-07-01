From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: ti-bandgap.c:  Cleaning up
 wrong address is checked
Date: Tue, 01 Jul 2014 09:54:24 +0800
Message-ID: <1404179664.8366.8.camel@rzhang1-toshiba>
References: <1401744330-25966-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16657 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaGABy2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Jun 2014 21:54:28 -0400
In-Reply-To: <1401744330-25966-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, 2014-06-02 at 23:25 +0200, Rickard Strandqvist wrote:
> Wrong address is checked after memory allocation.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

applied, thanks.

-rui
> ---
>  drivers/thermal/ti-soc-thermal/ti-bandgap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 3ab12ee..43c0f83 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -1155,7 +1155,7 @@ static struct ti_bandgap *ti_bandgap_build(struct platform_device *pdev)
>  	/* register shadow for context save and restore */
>  	bgp->regval = devm_kzalloc(&pdev->dev, sizeof(*bgp->regval) *
>  				   bgp->conf->sensor_count, GFP_KERNEL);
> -	if (!bgp) {
> +	if (!bgp->regval) {
>  		dev_err(&pdev->dev, "Unable to allocate mem for driver ref\n");
>  		return ERR_PTR(-ENOMEM);
>  	}


