From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] AHCI: speed up resume
Date: Fri, 4 Jul 2008 01:23:49 +0200
Message-ID: <200807040123.50337.rjw__37137.5941708267$1215127464$gmane$org@sisk.pl>
References: <1215074882.3214.15.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1215074882.3214.15.camel@rzhang-dt.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: tj@kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 of July 2008, Zhang Rui wrote:
> During S3 resume, AHCI driver sleeps 1 second to wait for the HBA reset
> to finish. This is luxurious, :)
> 
> According to the AHCI 1.2 spec, We should poll the HOST_CTL register,
> and return error if the host reset is not finished within 1 second.
> 
> Test results show that the HBA reset can be done quickly(in usecs).
> And this patch may save nearly 1 second during resume.

That's a lot.

How heavily has it been tested?

Rafael


> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> --
>  drivers/ata/ahci.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/ata/ahci.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/ahci.c	2007-05-03 11:06:33.000000000 +0800
> +++ linux-2.6/drivers/ata/ahci.c	2008-07-02 16:25:54.000000000 +0800
> @@ -1073,18 +1073,29 @@
>  
>  	/* global controller reset */
>  	if (!ahci_skip_host_reset) {
> +		int delay = msecs_to_jiffies(1000);
> +		int timeout;
> +
>  		tmp = readl(mmio + HOST_CTL);
>  		if ((tmp & HOST_RESET) == 0) {
>  			writel(tmp | HOST_RESET, mmio + HOST_CTL);
>  			readl(mmio + HOST_CTL); /* flush */
>  		}
>  
> -		/* reset must complete within 1 second, or
> +		/*
> + 		 * to perform host reset, OS should set HOST_RESET
> +		 * and poll until this bit is read to be "0"
> + 		 * reset must complete within 1 second, or
>  		 * the hardware should be considered fried.
>  		 */
> -		ssleep(1);
> +		timeout = jiffies + delay;
> +		while (jiffies < timeout) {
> +			tmp = readl(mmio + HOST_CTL);
> +			if (!(tmp & HOST_RESET))
> +				break;
> +			cpu_relax();
> +		}
>  
> -		tmp = readl(mmio + HOST_CTL);
>  		if (tmp & HOST_RESET) {
>  			dev_printk(KERN_ERR, host->dev,
>  				   "controller reset failed (0x%x)\n", tmp);
> 
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
