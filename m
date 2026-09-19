Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D530349CD8;
	Sat, 19 Sep 2026 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789841765; cv=none; b=Sw3xs4rZaonOJaGhrlGo501dS8ztv1rnsPSGh76e9GLqwTKshsexaoWNlSG45RikRKRORVzPND1sTg9R/OhCn/rnqaBR3lHrzzBSJ9oPKRDzxr5VetRtvSnhP0KO9xkufteoH57YltLnLUDxj2PVE4lHy1vzJ1bR+6VLbRSuWeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789841765; c=relaxed/simple;
	bh=wH8Tb4KqRc4VOh6/dbLrwuxzssZnUUFHkjcWJvCsIAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm8c+p+fiSXDWN8m5gRLK6nG+JvtwRDNUQUS/vCwaDn2q/vFaZPJLlcha8LYsmMg86ZX+dww6qkn85m7+NSi6FjHO5yZIg6h6r7UMehhCUYTQLznJkD/RCuE85osBpBm3rGmfKMbPVhRLPFbX8oaES7MbLUYebsLe+fE+YYQeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uZ10c8pz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uZ10c8pz"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C502C36;
	Sat, 19 Sep 2026 20:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789841655;
	bh=wH8Tb4KqRc4VOh6/dbLrwuxzssZnUUFHkjcWJvCsIAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZ10c8pz/N2zzU7AqCtcuG4Y5uHw/9SgQOpCgF8n0ljm9CDLNkZ1AhCdncdud52hj
	 nOjGc5OsfdA4Ia5olYwgqz6CgKHItk5HnBnjXZiYQnWY4i6kX42wWMGO1J5hGiEFX1
	 4NEr+BuZns3VgYrdr4GsV0GBd2zzU4bDGcMbbuFI=
Date: Sat, 19 Sep 2026 21:15:57 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 10/11] media: rcar-fcp: Handle resets
Message-ID: <20260919181557.GK1124359@killaraus.ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
 <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-10-dbe9236bfd22@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-10-dbe9236bfd22@ideasonboard.com>

Hi Paul,

Thank you for the patch.

On Sat, Sep 19, 2026 at 02:07:07AM +0900, Paul Elder wrote:
> On some versions of the FCP, such as the one on the X5H, reset control
> is required to operate the FCP. Add support for handling resets
> optionally, to continue supporting versions that do not require it.
> 
> Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Changes in v2:
> - handle errors
> ---
>  drivers/media/platform/renesas/rcar-fcp.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
> index dfb0ca93e854dd0bb8aedfb757fd786ef6e45542..76d4c250b30815d9eac58f9b54ad923748df79f6 100644
> --- a/drivers/media/platform/renesas/rcar-fcp.c
> +++ b/drivers/media/platform/renesas/rcar-fcp.c
> @@ -16,6 +16,7 @@
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  
>  #include <media/rcar-fcp.h>
> @@ -29,6 +30,7 @@ struct rcar_fcp_device {
>  	struct list_head list;
>  	struct device *dev;
>  	void __iomem *base;
> +	struct reset_control *rstc;
>  };
>  
>  static LIST_HEAD(fcp_devices);
> @@ -162,20 +164,25 @@ static int rcar_fcp_probe(struct platform_device *pdev)
>  
>  	fcp->dev = &pdev->dev;
>  
> +	platform_set_drvdata(pdev, fcp);
> +
>  	fcp->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(fcp->base))
>  		return PTR_ERR(fcp->base);
>  
>  	dma_set_max_seg_size(fcp->dev, UINT_MAX);
>  
> +	fcp->rstc = devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(fcp->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(fcp->rstc),
> +				     "failed to get reset control\n");
> +
>  	pm_runtime_enable(&pdev->dev);
>  
>  	mutex_lock(&fcp_lock);
>  	list_add_tail(&fcp->list, &fcp_devices);
>  	mutex_unlock(&fcp_lock);
>  
> -	platform_set_drvdata(pdev, fcp);
> -
>  	return 0;
>  }
>  
> @@ -190,6 +197,24 @@ static void rcar_fcp_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
>  
> +static int fcp_pm_runtime_suspend(struct device *dev)
> +{
> +	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
> +
> +	return reset_control_assert(fcp->rstc);
> +}
> +
> +static int fcp_pm_runtime_resume(struct device *dev)
> +{
> +	struct rcar_fcp_device *fcp = dev_get_drvdata(dev);
> +
> +	return reset_control_deassert(fcp->rstc);
> +}
> +
> +static const struct dev_pm_ops fcp_pm_ops = {
> +	RUNTIME_PM_OPS(fcp_pm_runtime_suspend, fcp_pm_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id rcar_fcp_of_match[] = {
>  	{ .compatible = "renesas,fcpf" },
>  	{ .compatible = "renesas,fcpv" },
> @@ -202,6 +227,7 @@ static struct platform_driver rcar_fcp_platform_driver = {
>  	.remove		= rcar_fcp_remove,
>  	.driver		= {
>  		.name	= "rcar-fcp",
> +		.pm = pm_ptr(&fcp_pm_ops),
>  		.of_match_table = rcar_fcp_of_match,
>  		.suppress_bind_attrs = true,
>  	},

-- 
Regards,

Laurent Pinchart
