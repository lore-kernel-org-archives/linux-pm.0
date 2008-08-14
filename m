From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH 2/3] Adapt the sky2 driver to the reworked
	PCI PM
Date: Thu, 14 Aug 2008 15:23:18 -0700
Message-ID: <20080814152318.625f8609__29698.0352759876$1218752818$gmane$org@extreme>
References: <200808142335.56644.rjw@sisk.pl> <200808142338.18361.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808142338.18361.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Garzik <jeff@garzik.org>, Jeff@smtp1.linux-foundation.org, netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Brandeburg,
	Jesse" <jesse.brandeburg@intel.com>, Stephen Hemminger <stephen.hemminger@vyatta.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Aug 2008 23:38:17 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Adapt the sky2 driver to the reworked PCI PM
> 
> * Use device_set_wakeup_enable() and friends as needed
> * Remove an open-coded reference to the standard PCI PM registers
> * Use pci_prepare_to_sleep() and pci_back_from_sleep() in the
>   ->suspend() and ->resume() callbacks
> * Use the observation that it is sufficient to call pci_enable_wake()
>   once, unless it fails
> 
> Tested on Asus M3A32-MVP (Yukon-2 EC Ultra rev 3).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/net/sky2.c |   34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
> 
> Index: linux-2.6/drivers/net/sky2.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/sky2.c
> +++ linux-2.6/drivers/net/sky2.c
> @@ -3035,7 +3035,8 @@ static int sky2_set_wol(struct net_devic
>  	struct sky2_port *sky2 = netdev_priv(dev);
>  	struct sky2_hw *hw = sky2->hw;
>  
> -	if (wol->wolopts & ~sky2_wol_supported(sky2->hw))
> +	if ((wol->wolopts & ~sky2_wol_supported(sky2->hw))
> +	    || !device_can_wakeup(&hw->pdev->dev))
>  		return -EOPNOTSUPP;
>  

There was a regression in earlier releases caused because some BIOS's
are wrong, and device can wakeup.
