From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
Date: Fri, 23 Nov 2018 16:18:06 +0100
Message-ID: <20181123151806.GC30913@lunn.ch>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181123101556.29888-2-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Jason Cooper <jason@lakedaemon.net>, Nadav Haklai <nadavh@marvell.com>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 23, 2018 at 11:15:50AM +0100, Miquel Raynal wrote:
> Current implementation of the libahci does not take into account the
> new PHY framework. Correct the situation by adding a call to
> phy_set_mode() before phy_power_on() and by adding calls to
> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/ata/libahci_platform.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4b900fc659f7..9f33f72b674b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>  		if (rc)
>  			goto disable_phys;
>  
> +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
> +		if (rc) {
> +			phy_exit(hpriv->phys[i]);
> +			goto disable_phys;
> +		}

Hi Miquel

Russell King wrote a comphy driver for the Armada 3XX family. It only
supports network PHYs. Did you check it does the right thing when
passed PHY_MODE_SATA? This is slightly different to Hans's comment, in
that i expect phy_set_mode() is implemented for the comphy driver, but
it might not understand PHY_MODE_SATA and return an error?

Maybe you should look at rc and keep going if EOPNOTSUPP is returned?

      Andrew
