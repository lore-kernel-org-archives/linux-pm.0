From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH] NET / skge: Enable WoL by default if
	supported
Date: Wed, 22 Jul 2009 09:59:53 -0700
Message-ID: <20090722095953.0806bea2__13183.6831140847$1248282351$gmane$org@nehalam>
References: <200907221458.55616.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907221458.55616.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Michael Guntsche <mike@it-loops.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Jul 2009 14:58:55 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If skge hardware is capable of waking up the system from sleep,
> enable magic packet WoL during driver initialisation.
> 
> This makes WoL work without calling 'ethtool -s ethX wol g'
> for each adapter.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Tested-by: Michael Guntsche <mike@it-loops.com>
> ---
>  drivers/net/skge.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/net/skge.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/skge.c
> +++ linux-2.6/drivers/net/skge.c
> @@ -3856,8 +3856,10 @@ static struct net_device *skge_devinit(s
>  	skge->speed = -1;
>  	skge->advertising = skge_supported_modes(hw);
>  
> -	if (device_may_wakeup(&hw->pdev->dev))
> +	if (device_can_wakeup(&hw->pdev->dev)) {
>  		skge->wol = wol_supported(hw) & WAKE_MAGIC;
> +		device_set_wakeup_enable(&hw->pdev->dev, skge->wol);
> +	}
>  
>  	hw->dev[port] = dev;
>  

Acked-by: Stephen Hemminger <shemminger@vyatta.com>
-- 
