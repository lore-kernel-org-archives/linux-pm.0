From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 6/8] staging: drm/imx: Use SRC to reset IPU
Date: Fri, 29 Mar 2013 08:12:17 -0700
Message-ID: <20130329151217.GA554@kroah.com>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <1364488523-20310-7-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:43485 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab3C2PMU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Mar 2013 11:12:20 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so250131dae.9
        for <linux-pm@vger.kernel.org>; Fri, 29 Mar 2013 08:12:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364488523-20310-7-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On Thu, Mar 28, 2013 at 05:35:21PM +0100, Philipp Zabel wrote:
> Request the System Reset Controller to reset the IPU if
> specified via device tree phandle.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> ---
>  .../devicetree/bindings/staging/imx-drm/fsl-imx-drm.txt      |  3 +++
>  drivers/staging/imx-drm/ipu-v3/ipu-common.c                  | 12 +++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

