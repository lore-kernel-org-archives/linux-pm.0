From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for
 Kirkwood SoC
Date: Sat, 8 Dec 2012 01:07:08 +0100
Message-ID: <20121208010708.260209f5@skate>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Sat,  8 Dec 2012 08:15:50 +0900, Nobuhiro Iwamatsu wrote:

> +config KIRKWOOD_THERMAL
> +	tristate "Temperature sensor on Marvel Kirkwood"

Marvell

> +	/* Valid check */
> +	if (!(reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK) {
> +		dev_info(&thermal->device, "Reading temperature is not valid\n");

"Temperature read is not valid" maybe? An native english speaker could
say.

> +	thermal_dev
> +		= devm_kzalloc(&pdev->dev, sizeof(*thermal_dev), GFP_KERNEL);

I think the usual coding style is to have the = on the first line.

> +static int kirkwood_thermal_exit(struct platform_device *pdev)
> +{
> +	struct thermal_zone_device *kirkwood_thermal
> +			= platform_get_drvdata(pdev);

Ditto.

> +static const struct of_device_id kirkwood_thermal_id_table[] = {
> +	{ .compatible = "marvel,thermal-kirkwood" },

marvel -> marvell

Also, I think it should be marvell,kirkwood-thermal, since most other
DT compatible strings that we have for Marvell SoCs are
marvell,<soc>-<function>.

Also, the Device Tree binding documentation is missing (even though it
is admittedly going to be a very short documentation).

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
