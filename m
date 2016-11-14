From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] idle/i7300: Add CONFIG_PCI dependency
Date: Mon, 14 Nov 2016 01:36:15 +0100
Message-ID: <9076226.zObyvXuPt3@vostro.rjw.lan>
References: <20161030114228.24114-1-bp@alien8.de> <1e525299-ffb2-4031-a215-c9407c22a312@infradead.org> <20161030163247.l5nj4b52un3nef6z@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161030163247.l5nj4b52un3nef6z@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Andy Henroid <andrew.d.henroid@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, October 30, 2016 05:32:47 PM Borislav Petkov wrote:
> On Sun, Oct 30, 2016 at 07:54:44AM -0700, Randy Dunlap wrote:
> > 	depends on PCI
> > (no CONFIG_ prefix)
> 
> Whoops!
> 
> Thanks. FWIW, it didn't fire even with "depends on CONFIG_PCI" anymore.
> Didn't investigate why though...
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 30 Oct 2016 14:39:28 +0100
> Subject: [PATCH] idle/i7300: Add CONFIG_PCI dependency
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
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
> index 4732dfc15447..a066fca3688f 100644
> --- a/drivers/idle/Kconfig
> +++ b/drivers/idle/Kconfig
> @@ -18,6 +18,7 @@ config I7300_IDLE_IOAT_CHANNEL
>  config I7300_IDLE
>  	tristate "Intel chipset idle memory power saving driver"
>  	select I7300_IDLE_IOAT_CHANNEL
> +	depends on PCI
>  	help
>  	  Enable memory power savings when idle with certain Intel server
>  	  chipsets. The chipset must have I/O AT support, such as the
> 

Applied.

Thanks,
Rafael
