From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
Date: Fri, 23 Nov 2018 11:33:15 +0100
Message-ID: <f14c6e8e-73a9-0b62-0dbc-87d390789c0c@redhat.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181123101556.29888-2-miquel.raynal@bootlin.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Miquel,

On 23-11-18 11:15, Miquel Raynal wrote:
> Current implementation of the libahci does not take into account the
> new PHY framework. Correct the situation by adding a call to
> phy_set_mode() before phy_power_on() and by adding calls to
> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/ata/libahci_platform.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..9f33f72b674b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>   		if (rc)
>   			goto disable_phys;
>   
> +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}
> +

I see that phy_set_mode returns 0 for drivers which do not implement it,
so this should be fine.


>   		rc = phy_power_on(hpriv->phys[i]);
>   		if (rc) {
>   			phy_exit(hpriv->phys[i]);
> @@ -738,6 +744,8 @@ int ahci_platform_suspend_host(struct device *dev)
>   	writel(ctl, mmio + HOST_CTL);
>   	readl(mmio + HOST_CTL); /* flush */
>   
> +	ahci_platform_disable_phys(hpriv);
> +
>   	return ata_host_suspend(host, PMSG_SUSPEND);
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);

I'm afraid that this and the matching change in ahci_platform_suspend_host
needs to be guarded by a flag, there are quite a few sata drivers
using the libahci_platform functions as well as quite a few sata drivers
combining this with using phy drivers.

I'm worried that doing this unconditionally on drivers which have
not been tested with this change my break things.

I think it might be cleanest to extend the existing flags passed
to ahci_platform_get_resources with a flag for this and storing them
somewhere in ahci_host_priv so that the suspend/resume functions can
get to them.

Regards,

Hans





> @@ -756,6 +764,7 @@ EXPORT_SYMBOL_GPL(ahci_platform_suspend_host);
>   int ahci_platform_resume_host(struct device *dev)
>   {
>   	struct ata_host *host = dev_get_drvdata(dev);
> +	struct ahci_host_priv *hpriv = host->private_data;
>   	int rc;
>   
>   	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
> @@ -766,6 +775,8 @@ int ahci_platform_resume_host(struct device *dev)
>   		ahci_init_controller(host);
>   	}
>   
> +	ahci_platform_enable_phys(hpriv);
> +
>   	ata_host_resume(host);
>   
>   	return 0;
> 
