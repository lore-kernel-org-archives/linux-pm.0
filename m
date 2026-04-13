Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85923CB2C7
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085927; cv=none; b=jwUTRHtibr5I+NTHgIBHrs7MAvDNJcYbAIq+lEHfHi4Mit3hfC1qcQsWj35QDchdgesQf9jnPAErpDlOWB6BZk7JZIIBKNtjHLBSfAB++fNOyK0c2Y57aai4tkn7lBQGAtJy0Uu3k9oBWDXlk7c8LVhT9ZF7C4MPvhYBoA4U2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085927; c=relaxed/simple;
	bh=GbD4N/pJfNnK4WMQzA2znyqZqO9eK5cODbqqsEPyntA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqLmeBvCRz/l5iSbbS9TndKvQ69YCHU3vKLgoSM2Z2cHcywnLiWr3qDnx1zssVyycdj0IudUrjNsUUFYi7u/eXtceJRt413bB+YPQUnrDuCpc9/qX0j+hVtU80QvnWqR5vVZR8BLM93+7rled605KCNslqRf9EiGWexyBLXaZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCH53-0005o5-Ok; Mon, 13 Apr 2026 15:11:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCH52-005AxI-1C;
	Mon, 13 Apr 2026 15:11:56 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wCH52-00000007Uuh-17EV;
	Mon, 13 Apr 2026 15:11:56 +0200
Date: Mon, 13 Apr 2026 15:11:56 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc: ulfh@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	imx@lists.linux.dev, linux-pm@vger.kernel.org, xuegang.liu@nxp.com, 
	jindong.yue@nxp.com, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] pmdomain: imx: Make IMX8M/IMX9 BLK_CTRL tristate
Message-ID: <ql2c6m54fjjwifycaan3hcr3p3bp4phva2vdux2qcramt7wrvy@4dsvpyct5tqx>
References: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413053049.3041177-1-zhipeng.wang_1@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On 26-04-13, Zhipeng Wang wrote:
> Convert IMX8M_BLK_CTRL and IMX9_BLK_CTRL from bool to tristate
> to allow building as loadable modules.

Out of curiosity, why do you want to have a PM driver to be buildable as
module?

Regards,
  Marco

> Add prompt strings to make these options visible and configurable
> in menuconfig, keeping them enabled by default on appropriate platforms.
> 
> Also remove the IMX_GPCV2_PM_DOMAINS dependency from IMX9_BLK_CTRL.
> This dependency was incorrect from the beginning - i.MX93 uses a
> different power domain architecture compared to i.MX8M series:
> 
> - i.MX8M uses GPCv2 (General Power Controller v2) for power domain
>   management, hence IMX8M_BLK_CTRL correctly depends on it.
> 
> - i.MX93 uses BLK_CTRL directly without GPCv2. The hardware doesn't
>   have GPCv2 at all.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/pmdomain/imx/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/imx/Kconfig b/drivers/pmdomain/imx/Kconfig
> index 00203615c65e..9168d183b0c5 100644
> --- a/drivers/pmdomain/imx/Kconfig
> +++ b/drivers/pmdomain/imx/Kconfig
> @@ -10,15 +10,18 @@ config IMX_GPCV2_PM_DOMAINS
>  	default y if SOC_IMX7D
>  
>  config IMX8M_BLK_CTRL
> -	bool
> -	default SOC_IMX8M && IMX_GPCV2_PM_DOMAINS
> +	tristate "i.MX8M BLK CTRL driver"
> +	depends on SOC_IMX8M
> +	depends on IMX_GPCV2_PM_DOMAINS
>  	depends on PM_GENERIC_DOMAINS
>  	depends on COMMON_CLK
> +	default y
>  
>  config IMX9_BLK_CTRL
> -	bool
> -	default SOC_IMX9 && IMX_GPCV2_PM_DOMAINS
> +	tristate "i.MX93 BLK CTRL driver"
> +	depends on SOC_IMX9
>  	depends on PM_GENERIC_DOMAINS
> +	default y
>  
>  config IMX_SCU_PD
>  	bool "IMX SCU Power Domain driver"
> -- 
> 2.34.1
> 
> 
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
