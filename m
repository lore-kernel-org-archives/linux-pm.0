From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 01/11] ARM: shmobile: r8a7740: Add missing A3SP pm
 domain devices
Date: Mon, 27 Oct 2014 12:55:59 +0900
Message-ID: <20141027035555.GA31487@verge.net.au>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55881 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbaJ0D4E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Oct 2014 23:56:04 -0400
Content-Disposition: inline
In-Reply-To: <1414063141-8856-2-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 01:18:51PM +0200, Geert Uytterhoeven wrote:
> Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
> support") added the A3SP power domain, but forgot to hook up the IPPMU,
> DMAC0/1/2, and USBDMAC hardware blocks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - No changes,
> v2:
>   - No changes.
> ---
>  arch/arm/mach-shmobile/setup-r8a7740.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, I have queued this up.

> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 8894e1b7ab0e65bb..6992d4013ef013da 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -756,6 +756,11 @@ void __init r8a7740_add_standard_devices(void)
>  		{ "A3SP", &scif7_device },
>  		{ "A3SP", &scif8_device },
>  		{ "A3SP", &i2c1_device },
> +		{ "A3SP", &ipmmu_device },
> +		{ "A3SP", &dma0_device },
> +		{ "A3SP", &dma1_device },
> +		{ "A3SP", &dma2_device },
> +		{ "A3SP", &usb_dma_device },
>  	};
>  
>  	/* I2C work-around */
> -- 
> 1.9.1
> 
