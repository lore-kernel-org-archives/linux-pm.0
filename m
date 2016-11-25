From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 02/10] power: supply: axp20x_usb_power: set min voltage
 and max current from sysfs
Date: Fri, 25 Nov 2016 10:48:18 +0100
Message-ID: <20161125104818.597c0718@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
 <20161125090921.23138-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161125090921.23138-3-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quentin,

On Fri, 25 Nov 2016 10:09:13 +0100, Quentin Schulz wrote:

> +static int axp20x_usb_power_set_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> +	int ret, val1;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		switch (val->intval) {

This nested switch construct doesn't look very pretty. What about
instead:

	switch(psp) {
	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
		return axp20x_usb_power_set_prop_voltage_min(...);
	case POWER_SUPPLY_PROP_CURRENT_MAX:
		return axp20x_usb_power_set_prop_current_max(...);
	default:
		return -EINVAL;
	}

> +		case 4000000:
> +		case 4100000:
> +		case 4200000:
> +		case 4300000:
> +		case 4400000:
> +		case 4500000:
> +		case 4600000:
> +		case 4700000:
> +			val1 = (val->intval - 4000000) / 100000;
> +			ret = regmap_update_bits(power->regmap,
> +						 AXP20X_VBUS_IPSOUT_MGMT,
> +						 AXP20X_VBUS_VHOLD_MASK,
> +						 val1 << 3);
> +			if (ret)
> +				return ret;
> +
> +			return 0;

Just do:

			return regmap_update_bits(...);

The dance to test ret is useless, since you anyway return ret when
non-zero, or return zero when ret was zero.

While you're at it, maybe make val1 a u32, since I guess it's written
to a 32-bit register (unless u32 is not commonly used in this driver
already, of course).

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
