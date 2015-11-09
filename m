From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: bq27xxx_battery: Revert "Remove unneeded
 dependency in Kconfig"
Date: Mon, 09 Nov 2015 21:51:12 +0100
Message-ID: <10870776.N30IekZOBt@wuerfel>
References: <3819790.E2ziFviWmU@wuerfel> <5640D02D.6040601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5640D02D.6040601@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Xiong Zhou <jencce.kernel@gmail.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Pali Rohar <pali.rohar@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 November 2015 10:56:13 Andrew F. Davis wrote:
> On 11/09/2015 07:50 AM, Arnd Bergmann wrote:
> Nothing enabled by BATTERY_BQ27XXX depends on I2C, this workaround is not
> correct as it prevents BATTERY_BQ27XXX from being built-in when I2C is a
> module, there is no reason for this limitation.
> 
> The undefined references are caused by BATTERY_BQ27XXX being built-in AND
> its I2C functionality being enabled (BATTERY_BQ27XXX_I2C) while I2C is a
> module. Reorganizing this driver is being discussed anyway, but in the
> meantime a more correct fix would be along the lines of:
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 6de6ec2..d1d32f9 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -167,6 +167,7 @@ config BATTERY_BQ27XXX_I2C
>          bool "BQ27xxx I2C support"
>          depends on BATTERY_BQ27XXX
>          depends on I2C
> +       depends on !(I2C=m && BATTERY_BQ27XXX=y)
>          default y
>          help
>            Say Y here to enable support for batteries with BQ27xxx (I2C) chips.

That works too, there is just very little difference in the end here,
and it's easier to revert an patch that only introduces a regression
than to do a different hack, especially if it's going to be reworked
soon anyway.

Do you want to submit the above as a fixup to your other patch or
should we just do the revert? It would be good to get one of the two
into -rc1.

	Arnd
