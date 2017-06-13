From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
Date: Tue, 13 Jun 2017 09:39:59 -0700
Message-ID: <20170613163959.GU12920@tuxbook>
References: <20170613130430.4272-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33328 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbdFMQkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 12:40:01 -0400
Received: by mail-pf0-f169.google.com with SMTP id 83so70464877pfr.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 09:40:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170613130430.4272-1-robdclark@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux PM list <linux-pm@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

+cc Geert, Simon, linux-pm

On Tue 13 Jun 06:04 PDT 2017, Rob Clark wrote:

> In fact, it is needed for PCI to work on msm8996 (and probably other
> things).  No idea why it was depending on renesas but that doesn't make
> any sense.  So drop the dependency.
> 

This is in line with Geert's previous comments on how to utilize
simple-pm-bus to describe this hardware.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
>  drivers/bus/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 0a52da4..b83c535 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -121,7 +121,6 @@ config QCOM_EBI2
>  config SIMPLE_PM_BUS
>  	bool "Simple Power-Managed Bus Driver"
>  	depends on OF && PM
> -	depends on ARCH_RENESAS || COMPILE_TEST
>  	help
>  	  Driver for transparent busses that don't need a real driver, but
>  	  where the bus controller is part of a PM domain, or under the control
> -- 
> 2.9.4
> 
