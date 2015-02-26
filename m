From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] dmaengine: shdma: Move DMA stop to (runtime) suspend
 callbacks
Date: Thu, 26 Feb 2015 16:21:06 +0300
Message-ID: <54EF1DC2.30703@cogentembedded.com>
References: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:41055 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbBZNVK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 08:21:10 -0500
Received: by lbiz11 with SMTP id z11so10717534lbi.8
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2015 05:21:09 -0800 (PST)
In-Reply-To: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, dmaengine@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 02/26/2015 01:26 PM, Geert Uytterhoeven wrote:

> During system reboot, the sh-dma-engine device may be runtime-suspended,
> causing a crash:

>      Unhandled fault: imprecise external abort (0x1406) at 0x0002c02c
>      Internal error: : 1406 [#1] SMP ARM
>      ...
>      PC is at sh_dmae_ctl_stop+0x28/0x64
>      LR is at sh_dmae_ctl_stop+0x24/0x64

> If the sh-dma-engine is runtime-suspended, its module clock is turned
> off, and its registers cannot be accessed.

> To fix this, move the call to sh_dmae_ctl_stop(), which touches the
> DMAOR register, to the sh_dmae_suspend() and sh_dmae_runtime_suspend()
> callbacks.  This makes PM operations more symmetric, as both
> sh_dmae_resume() and sh_dmae_runtime_resume() already call sh_dmae_rst()
> to re-initialize the DMAOR register.

> Remove sh_dmae_shutdown(), as it became empty.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is v3 of "dmaengine: shdma: Runtime-resume device in .shutdown()"

> v3:
>    - Move the call to sh_dmae_ctl_stop() to sh_dmae_suspend() and
>      sh_dmae_runtime_suspend() instead of runtime-resuming the device in
>      .shutdown(),

> v2:
>    - Do nothing if we're runtime suspended.
> ---
>   drivers/dma/sh/shdmac.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index b2431aa300331270..9f1d4c7dbab83890 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
[...]
> @@ -929,13 +929,12 @@ static int sh_dmae_remove(struct platform_device *pdev)
>   }
>
>   static struct platform_driver sh_dmae_driver = {
> -	.driver 	= {
> +	.driver		= {

    Hm, don't understand what was changed on this line...

WBR, Sergei

