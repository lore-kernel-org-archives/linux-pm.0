From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/15] extcon: cht-wc: Add Intel Cherry Trail Whiskey Cove
 PMIC extcon driver
Date: Mon, 20 Mar 2017 19:08:22 +0100
Message-ID: <c6020cde-5406-0442-adea-f973bded326b@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-4-hdegoede@redhat.com>
 <1489771098.19767.69.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1489771098.19767.69.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 17-03-17 18:18, Andy Shevchenko wrote:
> On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
>> Add a driver for charger detection / control on the Intel Cherrytrail
>> Whiskey Cove PMIC.
>
> +Cc: Felipe for some question(s) below.
>
>>  drivers/extcon/extcon-cht-wc.c | 356
>
> I would use same pattern across drivers, i.e. "chtwc" (same for the rest
> of the drivers in this series).

I already answered this in another part of the thread,
but for the archives sake let me copy and paste my answer:

"One thing I disagree with is the cht_wc > chtwc rename you are
proposing for one Cherry Trail and Whiskey Cove are 2 different
words (4 if you look at spelling but 2 if you look at pronunciation,
so IMHO cht_wc is more readable other then that I see the suggested
rename as a lot of extra churn without any tangible benefits."

>
>> +#define CHT_WC_PWRSRC_IRQ		0x6e03
>> +#define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
>> +#define CHT_WC_PWRSRC_STS		0x6e1e
>> +#define CHT_WC_PWRSRC_VBUS		BIT(0)
>> +#define CHT_WC_PWRSRC_DC		BIT(1)
>> +#define CHT_WC_PWRSRC_BAT		BIT(2)
>> +#define CHT_WC_PWRSRC_ID_GND		BIT(3)
>> +#define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)
>
> Not obvious for which register those bit definitions are.

They are for all 3 CHT_WC_PWRSRC_* registers, this is the
more or less usual irq setup for some i2c devices where
there is a status register, an irq register where the hardware
sets bits to 1 (and we write 1 to clear) when the corresponding
status bits changes and a mask register to select which irq
register bits actually will raise the interrupt line.

> Also, keep them ordered by offset.

Will fix.

>
>> +
>> +#define CHT_WC_PHYCTRL			0x5e07
>> +
>
>> +#define CHT_WC_CHGRCTRL0		0x5e16
>
> Dup!

Good catch, will fix.


>
>> +
>> +#define CHT_WC_CHGRCTRL0		0x5e16
>
>> +static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext)
>> +{
>> +	int ret, usbsrc, status, retries = 5;
>> +
>> +	do {
>> +		ret = regmap_read(ext->regmap, CHT_WC_USBSRC,
>> &usbsrc);
>> +		if (ret) {
>> +			dev_err(ext->dev, "Error reading usbsrc:
>> %d\n", ret);
>> +			return ret;
>> +		}
>> +		status = usbsrc & CHT_WC_USBSRC_STS_MASK;
>> +		if (status == CHT_WC_USBSRC_STS_SUCCESS ||
>> +		    status == CHT_WC_USBSRC_STS_FAIL)
>> +			break;
>> +
>
>> +		msleep(200);
>
> Comment why and why so long?

Fixed for v2 (actually switched to using jiffies +
time_before for a more accurate timeout).

>> +	} while (retries--);
>
>> +static void cht_wc_extcon_det_event(struct cht_wc_extcon_data *ext)
>
> det -> detect ?

Renamed to more accurate cht_wc_extcon_pwrsrc_event

> +static irqreturn_t cht_wc_extcon_isr(int irq, void *data)
>> +{
>> +	struct cht_wc_extcon_data *ext = data;
>> +	int ret, irqs;
>> +
>> +	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_IRQ, &irqs);
>> +	if (ret)
>> +		dev_err(ext->dev, "Error reading irqs: %d\n", ret);
>
> Shouldn't we return IRQ_NONE here?

I was wondering the same myself here, there is no good
answer here, this should simply never fail ... which does
make returning IRQ_NONE a good idea, I was worried that
would lead to a "nobody cared, disabling irq", but as said this
should never happen, so when it does, disabling the irq is
probably for the best. Will fix.

>
>> +
>> +	cht_wc_extcon_det_event(ext);
>> +
>> +	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ, irqs);
>> +	if (ret)
>> +		dev_err(ext->dev, "Error writing irqs: %d\n", ret);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>
>> +/* usb_id sysfs attribute for debug / testing purposes */
>
> Hmm... I would use debugfs for debug, otherwise it looks like it should
> be framework (extcon) wide.

Unfortunately these kinda sysfs files are somewhat normal when
dealing with USB-OTG. For example my board does not have the
id-pin hooked up to the connector, so to test host mode
I need to echo "gnd" to the sysfs attr. But also if I actually
want to use host-mode (or anyone else with the same or a similar
board).

This definitely is not something which belongs in the extcon-core.

> Perhaps Felipe can advise something here.
>
>> +static int cht_wc_extcon_probe(struct platform_device *pdev)
>> +{
>
>> +	struct cht_wc_extcon_data *ext;
>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev-
>>> dev.parent);
>
> Exchange them (assignment first).

Fixed.

>
>> +	int irq, ret;
>> +
>
>
>> +	ret = devm_request_threaded_irq(ext->dev, irq, NULL,
>> cht_wc_extcon_isr,
>> +					IRQF_ONESHOT, pdev->name,
>> ext);
>> +	if (ret) {
>> +		dev_err(ext->dev, "Failed to request interrupt\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Unmask irqs */
>> +	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ_MASK,
>> +			   (int)~(CHT_WC_PWRSRC_VBUS |
>
> Hmm... Do you need explicit casting here?

Yes because the BIT(x) macros are unsigned longs and the ~ sets
the MSB so then the compiler complaints about truncating the
variable without the cast.

>
>> CHT_WC_PWRSRC_ID_GND |
>> +				  CHT_WC_PWRSRC_ID_FLOAT));
>> +	if (ret) {
>> +		dev_err(ext->dev, "Error writing irq-mask: %d\n",
>> ret);
>> +		return ret;
>> +	}
>

Regards,

Hans
