From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/15] extcon: cht-wc: Add Intel Cherry Trail Whiskey
 Cove PMIC extcon driver
Date: Fri, 17 Mar 2017 19:18:18 +0200
Message-ID: <1489771098.19767.69.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <20170317095527.10487-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-4-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
> Add a driver for charger detection / control on the Intel Cherrytrail
> Whiskey Cove PMIC.

+Cc: Felipe for some question(s) below.

>  drivers/extcon/extcon-cht-wc.c | 356 

I would use same pattern across drivers, i.e. "chtwc" (same for the rest
of the drivers in this series).

> +#define CHT_WC_PWRSRC_IRQ		0x6e03
> +#define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
> +#define CHT_WC_PWRSRC_STS		0x6e1e
> +#define CHT_WC_PWRSRC_VBUS		BIT(0)
> +#define CHT_WC_PWRSRC_DC		BIT(1)
> +#define CHT_WC_PWRSRC_BAT		BIT(2)
> +#define CHT_WC_PWRSRC_ID_GND		BIT(3)
> +#define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)

Not obvious for which register those bit definitions are.
Also, keep them ordered by offset.

> +
> +#define CHT_WC_PHYCTRL			0x5e07
> +

> +#define CHT_WC_CHGRCTRL0		0x5e16

Dup!

> +
> +#define CHT_WC_CHGRCTRL0		0x5e16

> +static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext)
> +{
> +	int ret, usbsrc, status, retries = 5;
> +
> +	do {
> +		ret = regmap_read(ext->regmap, CHT_WC_USBSRC,
> &usbsrc);
> +		if (ret) {
> +			dev_err(ext->dev, "Error reading usbsrc:
> %d\n", ret);
> +			return ret;
> +		}
> +		status = usbsrc & CHT_WC_USBSRC_STS_MASK;
> +		if (status == CHT_WC_USBSRC_STS_SUCCESS ||
> +		    status == CHT_WC_USBSRC_STS_FAIL)
> +			break;
> +

> +		msleep(200);

Comment why and why so long?

> +	} while (retries--);

> +static void cht_wc_extcon_det_event(struct cht_wc_extcon_data *ext)

det -> detect ?


> 
+static irqreturn_t cht_wc_extcon_isr(int irq, void *data)
> +{
> +	struct cht_wc_extcon_data *ext = data;
> +	int ret, irqs;
> +
> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_IRQ, &irqs);
> +	if (ret)
> +		dev_err(ext->dev, "Error reading irqs: %d\n", ret);

Shouldn't we return IRQ_NONE here?
Perhaps comment is needed.

> +
> +	cht_wc_extcon_det_event(ext);
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ, irqs);
> +	if (ret)
> +		dev_err(ext->dev, "Error writing irqs: %d\n", ret);
> +
> +	return IRQ_HANDLED;
> +}
> +

> +/* usb_id sysfs attribute for debug / testing purposes */

Hmm... I would use debugfs for debug, otherwise it looks like it should
be framework (extcon) wide.

Perhaps Felipe can advise something here.

> +static int cht_wc_extcon_probe(struct platform_device *pdev)
> +{

> +	struct cht_wc_extcon_data *ext;
> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev-
> >dev.parent);

Exchange them (assignment first).

> +	int irq, ret;
> +


> +	ret = devm_request_threaded_irq(ext->dev, irq, NULL,
> cht_wc_extcon_isr,
> +					IRQF_ONESHOT, pdev->name,
> ext);
> +	if (ret) {
> +		dev_err(ext->dev, "Failed to request interrupt\n");
> +		return ret;
> +	}
> +
> +	/* Unmask irqs */
> +	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ_MASK,
> +			   (int)~(CHT_WC_PWRSRC_VBUS | 

Hmm... Do you need explicit casting here?

> CHT_WC_PWRSRC_ID_GND |
> +				  CHT_WC_PWRSRC_ID_FLOAT));
> +	if (ret) {
> +		dev_err(ext->dev, "Error writing irq-mask: %d\n",
> ret);
> +		return ret;
> +	}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
