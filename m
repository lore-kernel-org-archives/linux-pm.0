From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] idle/i7300: Add CONFIG_PCI dependency
Date: Sun, 30 Oct 2016 07:54:44 -0700
Message-ID: <1e525299-ffb2-4031-a215-c9407c22a312@infradead.org>
References: <20161030114228.24114-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbcJ3Oyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Oct 2016 10:54:46 -0400
In-Reply-To: <20161030114228.24114-1-bp@alien8.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Andy Henroid <andrew.d.henroid@intel.com>, linux-pm@vger.kernel.org

On 10/30/16 04:42, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... in order to fix this randconfig build warning:
> 
>   drivers/idle/i7300_idle.c: In function ‘i7300_idle_stop’:
>   ./include/asm-generic/bug.h:117:24: warning: ‘got_ctl’ is used uninitialized in this function [-Wuninitialized]
>     int __ret_warn_once = !!(condition);   \
>                           ^
>   drivers/idle/i7300_idle.c:415:5: note: ‘got_ctl’ was declared here
>     u8 got_ctl;
>        ^
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andy Henroid <andrew.d.henroid@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/idle/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
> index 4732dfc15447..c11ee3e657a6 100644
> --- a/drivers/idle/Kconfig
> +++ b/drivers/idle/Kconfig
> @@ -18,6 +18,7 @@ config I7300_IDLE_IOAT_CHANNEL
>  config I7300_IDLE
>  	tristate "Intel chipset idle memory power saving driver"
>  	select I7300_IDLE_IOAT_CHANNEL
> +	depends on CONFIG_PCI

	depends on PCI
(no CONFIG_ prefix)

>  	help
>  	  Enable memory power savings when idle with certain Intel server
>  	  chipsets. The chipset must have I/O AT support, such as the
> 


-- 
~Randy
