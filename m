From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] power: qcom_smbb: Add otg regulator for control of vbus
Date: Mon, 26 Oct 2015 11:17:50 +0000
Message-ID: <20151026111555.GA9740@leverpostej>
References: <1445548337-14612-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51456 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394AbbJZLSM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 26 Oct 2015 07:18:12 -0400
Content-Disposition: inline
In-Reply-To: <1445548337-14612-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com, bjorn.andersson@sonymobile.com

On Thu, Oct 22, 2015 at 02:12:17PM -0700, Tim Bird wrote:
> Add a regulator to control the OTG chargepath switch.  The OTG
> switch gets its power from pm8941_5vs1, and that should be expressed
> as an usb_otg_in-supply property in the DT node for the charger driver.
> The regulator name is "otg".  This is used by USB code to control VBUS
> direction.
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
>  .../devicetree/bindings/power_supply/qcom_smbb.txt | 20 ++++++
>  drivers/power/qcom_smbb.c                          | 74 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+)

What tree is this based on? I couldn't spot this in origin/master.

> diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> index 65b88fa..dc0f91d 100644
> --- a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> +++ b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> @@ -105,6 +105,23 @@ PROPERTIES
>                 regulation must be done externally to fully comply with
>                 the JEITA safety guidelines if this flag is set.
>  
> +- usb_otg_in-supply:
> +  Usage: optional
> +  Value type: <phandle>
> +  Description: Reference to the regulator supplying power to the USB_OTG_IN
> +               pin.

s/_/-/ in property names, please.

> +
> +child nodes:
> +- otg:
> +  Usage: optional
> +  Description: This node is used to define a regulator which is used by
> +               other parts of the system to control the direction of VBUS
> +               voltage - specifically: whether to supply voltage to VBUS for
> +               host mode operation of the OTG port. The driver registers a
> +               regulator with this name, which can be looked up by string.
> +               Alternatively, you can add a DT label, which can then be
> +               referenced by phandle.
> +

We shouldn't specify the behaviours of the driver/linux here, just the
hardware.

I'm a little confused by how this is used, but I suspect that'll be
cleared up when I see the rest of the binding that this is based on.

Thanks,
Mark.

>  EXAMPLE
>  charger@1000 {
>         compatible = "qcom,pm8941-charger";
> @@ -128,4 +145,7 @@ charger@1000 {
>  
>         qcom,fast-charge-current-limit = <1000000>;
>         qcom,dc-charge-current-limit = <1000000>;
> +       usb_otg_in-supply = <&pm8941_5vs1>;
> +
> +       otg {};
>  };
> diff --git a/drivers/power/qcom_smbb.c b/drivers/power/qcom_smbb.c
> index 0dabfe8..fa2983a 100644
> --- a/drivers/power/qcom_smbb.c
> +++ b/drivers/power/qcom_smbb.c
> @@ -34,6 +34,9 @@
>  #include <linux/power_supply.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
>  
>  #define SMBB_CHG_VMAX		0x040
>  #define SMBB_CHG_VSAFE		0x041
> @@ -71,6 +74,8 @@
>  #define BTC_CTRL_HOT_EXT_N	BIT(0)
>  
>  #define SMBB_USB_IMAX		0x344
> +#define SMBB_USB_OTG_CTL	0x348
> +#define OTG_CTL_EN		BIT(0)
>  #define SMBB_USB_ENUM_TIMER_STOP 0x34e
>  #define ENUM_TIMER_STOP		BIT(0)
>  #define SMBB_USB_SEC_ACCESS	0x3d0
> @@ -123,6 +128,9 @@ struct smbb_charger {
>  	struct power_supply *dc_psy;
>  	struct power_supply *bat_psy;
>  	struct regmap *regmap;
> +
> +	struct regulator_desc otg_rdesc;
> +	struct regulator_dev *otg_reg;
>  };
>  
>  static int smbb_vbat_weak_fn(unsigned int index)
> @@ -778,12 +786,56 @@ static const struct power_supply_desc dc_psy_desc = {
>  	.property_is_writeable = smbb_charger_writable_property,
>  };
>  
> +static int smbb_chg_otg_enable(struct regulator_dev *rdev)
> +{
> +	struct smbb_charger *chg = rdev_get_drvdata(rdev);
> +	int rc;
> +
> +	rc = regmap_update_bits(chg->regmap, chg->addr + SMBB_USB_OTG_CTL,
> +				OTG_CTL_EN, OTG_CTL_EN);
> +	if (rc)
> +		dev_err(chg->dev, "failed to update OTG_CTL\n");
> +	return rc;
> +}
> +
> +static int smbb_chg_otg_disable(struct regulator_dev *rdev)
> +{
> +	struct smbb_charger *chg = rdev_get_drvdata(rdev);
> +	int rc;
> +
> +	rc = regmap_update_bits(chg->regmap, chg->addr + SMBB_USB_OTG_CTL,
> +				OTG_CTL_EN, 0);
> +	if (rc)
> +		dev_err(chg->dev, "failed to update OTG_CTL\n");
> +	return rc;
> +}
> +
> +static int smbb_chg_otg_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct smbb_charger *chg = rdev_get_drvdata(rdev);
> +	unsigned int value = 0;
> +	int rc;
> +
> +	rc = regmap_read(chg->regmap, chg->addr + SMBB_USB_OTG_CTL, &value);
> +	if (rc)
> +		dev_err(chg->dev, "failed to read OTG_CTL\n");
> +
> +	return !!(value & OTG_CTL_EN);
> +}
> +
> +static struct regulator_ops smbb_chg_otg_ops = {
> +	.enable = smbb_chg_otg_enable,
> +	.disable = smbb_chg_otg_disable,
> +	.is_enabled = smbb_chg_otg_is_enabled,
> +};
> +
>  static int smbb_charger_probe(struct platform_device *pdev)
>  {
>  	struct power_supply_config bat_cfg = {};
>  	struct power_supply_config usb_cfg = {};
>  	struct power_supply_config dc_cfg = {};
>  	struct smbb_charger *chg;
> +	struct regulator_config config = { };
>  	int rc, i;
>  
>  	chg = devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
> @@ -884,6 +936,28 @@ static int smbb_charger_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * otg regulator is used to control VBUS voltage direction
> +	 * when USB switches between host and gadget mode
> +	 */
> +	chg->otg_rdesc.id = -1;
> +	chg->otg_rdesc.name = "otg";
> +	chg->otg_rdesc.ops = &smbb_chg_otg_ops;
> +	chg->otg_rdesc.owner = THIS_MODULE;
> +	chg->otg_rdesc.type = REGULATOR_VOLTAGE;
> +	chg->otg_rdesc.supply_name = "usb_otg_in";
> +	chg->otg_rdesc.fixed_uV = 5000000;
> +	chg->otg_rdesc.n_voltages = 1;
> +	chg->otg_rdesc.of_match = "otg";
> +
> +	config.dev = &pdev->dev;
> +	config.driver_data = chg;
> +
> +	chg->otg_reg = devm_regulator_register(&pdev->dev, &chg->otg_rdesc,
> +					       &config);
> +	if (IS_ERR(chg->otg_reg))
> +		return PTR_ERR(chg->otg_reg);
> +
>  	chg->jeita_ext_temp = of_property_read_bool(pdev->dev.of_node,
>  			"qcom,jeita-extended-temp-range");
>  
> -- 
> 1.8.2.2
> 
