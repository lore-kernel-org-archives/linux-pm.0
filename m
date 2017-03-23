From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 15/15] i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove
 SMBUS controller driver
Date: Thu, 23 Mar 2017 14:58:24 +0100
Message-ID: <bab2ab40-df1f-97a0-17f3-e0c54b2da734@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-16-hdegoede@redhat.com>
 <1489774932.19767.86.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1489774932.19767.86.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 17-03-17 19:22, Andy Shevchenko wrote:
> On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
>> The Intel Cherry Trail Whiskey Cove PMIC has a builtin SMBUS
>> controller
>> for talking to an external PMIC. Add a driver for this.
>
> Looking to all this mess we have with PMICs, perhaps some file under
> Documentation to explain all those dependencies with nice ASCII flow
> charts would be created.

With Sebastian's suggestion to turn the fuel-gauge driver
into a full-blown power_supply driver things luckily aren't
quite that messy anymore.

<snip>

>> +#define CHT_WC_I2C_CTRL			0x5e24
>> +#define CHT_WC_I2C_CTRL_WR		BIT(0)
>> +#define CHT_WC_I2C_CTRL_RD		BIT(1)
>> +#define CHT_WC_I2C_CLIENT_ADDR		0x5e25
>> +#define CHT_WC_I2C_REG_OFFSET		0x5e26
>> +#define CHT_WC_I2C_WRDATA		0x5e27
>> +#define CHT_WC_I2C_RDDATA		0x5e28
>> +
>> +#define CHT_WC_EXTCHGRIRQ		0x6e0a
>> +#define CHT_WC_EXTCHGRIRQ_CLIENT_IRQ	BIT(0)
>> +#define CHT_WC_EXTCHGRIRQ_WRITE_IRQ	BIT(1)
>> +#define CHT_WC_EXTCHGRIRQ_READ_IRQ	BIT(2)
>> +#define CHT_WC_EXTCHGRIRQ_NACK_IRQ	BIT(3)
>>
>
>> +#define CHT_WC_EXTCHGRIRQ_ADAP_IRQS	((u8)(BIT(1) | BIT(2) |
>> BIT(3)))
>
> _IRQ_MASK ?
>
> GENMASK() ?

Both good idea, both fixed for v2. Note I'm not posting
v2 until the bq24190_charger patches are in place
(so that the device-properties to use are known).

>> +#define CHT_WC_EXTCHGRIRQ_MSK		0x6e17
>
>> +struct cht_wc_i2c_adap {
>> +	struct i2c_adapter adapter;
>> +	wait_queue_head_t wait;
>> +	struct irq_chip irqchip;
>> +	struct mutex irqchip_lock;
>> +	struct regmap *regmap;
>> +	struct irq_domain *irq_domain;
>> +	struct i2c_client *client;
>> +	int client_irq;
>> +	u8 irq_mask;
>> +	u8 old_irq_mask;
>> +	bool nack;
>> +	bool done;
>> +};
>> +
>> +static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
>> +{
>> +	struct cht_wc_i2c_adap *adap = data;
>> +	int ret, reg;
>> +
>> +	/* Read irqs */
>
> IRQs
>
>> +	ret = regmap_read(adap->regmap, CHT_WC_EXTCHGRIRQ, &reg);
>> +	if (ret) {
>> +		dev_err(&adap->adapter.dev, "Error reading extchgrirq
>> reg\n");
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	reg &= ~adap->irq_mask;
>> +
>> +	/*
>> +	 * Immediately ack irqs, so that if new irqs arrives while
>> we're
>> +	 * handling the previous ones our irq will re-trigger when
>> we're done.
>> +	 */
>> +	ret = regmap_write(adap->regmap, CHT_WC_EXTCHGRIRQ, reg);
>> +	if (ret)
>> +		dev_err(&adap->adapter.dev, "Error writing extchgrirq
>> reg\n");
>> +
>> +	/*
>> +	 * Do NOT use handle_nested_irq here, the client irq handler
>> will
>> +	 * likely want to do i2c transfers and the i2c controller
>> uses this
>> +	 * interrupt handler as well, so running the client irq
>> handler from
>> +	 * this thread will cause things to lock up.
>> +	 */
>> +	if (reg & CHT_WC_EXTCHGRIRQ_CLIENT_IRQ) {
>> +		/*
>> +		 * generic_handle_irq expects local irqs to be
>> disabled
>> +		 * as normally it is called from interrupt context.
>> +		 */
>> +		local_irq_disable();
>> +		generic_handle_irq(adap->client_irq);
>> +		local_irq_enable();
>> +	}
>> +
>> +	if (reg & CHT_WC_EXTCHGRIRQ_ADAP_IRQS) {
>
>> +		if (reg & CHT_WC_EXTCHGRIRQ_NACK_IRQ)
>> +			adap->nack = true;
>
> adap->nack = !!(reg & ...);

Good idea, fixed for v2.

>
>> +		adap->done = true;
>> +		wake_up(&adap->wait);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>
>> +static u32 cht_wc_i2c_adap_master_func(struct i2c_adapter *adap)
>> +{
>> +	/* This i2c adapter only supports smbus byte transfers */
>
> smbus -> SMBUS
>
>> +	return I2C_FUNC_SMBUS_BYTE_DATA;
>> +}
>> +
>> +static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16
>> addr,
>> +				      unsigned short flags, char
>> read_write,
>> +				      u8 command, int size,
>> +				      union i2c_smbus_data *data)
>> +{
>> +	struct cht_wc_i2c_adap *adap = i2c_get_adapdata(_adap);
>> +	int ret, reg;
>> +
>
>> +
>> +	/* 3 second timeout, during cable plug the PMIC responds
>> quite slow */
>> +	ret = wait_event_timeout(adap->wait, adap->done, HZ * 3);
>
> 3 * HZ

Fixed for v2 (as well as all the capitalization remarks)

>
>> +	if (ret == 0)
>> +		return -ETIMEDOUT;
>> +	if (adap->nack)
>> +		return -EIO;
>> +
>> +	if (read_write == I2C_SMBUS_READ) {
>> +		ret = regmap_read(adap->regmap, CHT_WC_I2C_RDDATA,
>> &reg);
>> +		if (ret)
>> +			return ret;
>> +
>> +		data->byte = reg;
>> +	}
>> +
>> +	return 0;
>> +}
>
>> +/**** irqchip for the client connected to the extchgr i2c adapter
>> ****/
>
> Useless ?

It is meant as a visual separator between the i2c-adapter and
irqchip code.

>
>> +static void cht_wc_i2c_irq_lock(struct irq_data *data)
>> +{
>> +	struct cht_wc_i2c_adap *adap =
>> irq_data_get_irq_chip_data(data);
>> +
>> +	mutex_lock(&adap->irqchip_lock);
>> +}
>> +
>> +static void cht_wc_i2c_irq_sync_unlock(struct irq_data *data)
>> +{
>> +	struct cht_wc_i2c_adap *adap =
>> irq_data_get_irq_chip_data(data);
>> +	int ret;
>> +
>> +	if (adap->irq_mask != adap->old_irq_mask) {
>> +		ret = regmap_write(adap->regmap,
>> CHT_WC_EXTCHGRIRQ_MSK,
>> +				   adap->irq_mask);
>> +		if (ret == 0)
>> +			adap->old_irq_mask = adap->irq_mask;
>> +		else
>> +			dev_err(&adap->adapter.dev, "Error writing
>> extchgrirq_msk\n");
>
> extchgrirq_msk -> EXTCHGRIRQ_MSK ?

Fixed for v2.

>> +	}
>> +
>> +	mutex_unlock(&adap->irqchip_lock);
>> +}
>
>
>> +static const struct bq24190_platform_data bq24190_pdata = {
>> +	.no_register_reset = true,
>> +	.extcon_name = "cht_wcove_pwrsrc",
>> +	.get_ext_bat_property = cht_wc_fg_get_property,
>> +};
>> +
>> +static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>> +{
>> +	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev-
>>> dev.parent);
>> +	struct cht_wc_i2c_adap *adap;
>
>> +	struct i2c_board_info board_info = {
>> +		.type = "bq24190",
>> +		.addr = 0x6b,
>> +		.platform_data = (void *)&bq24190_pdata,
>> +	};
>> +	int ret, irq;
>> +
>
>> +	/* Clear and activate i2c-adapter interrupts, disable client
>> irq */
>
> irq -> IRQ
>
>> +
>> +	/* Alloc and register client irq */
>
> Ditto.
>
>> +	adap->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
>> 1,
>> +						 &irq_domain_simple_o
>> ps, NULL);
>
> Can you use irq_domain_add_simple()?

We don't have (nor want) a static virq for the irq,
so we would pass 0 for irq_domain_add_simple()'s
first_irq argument which makes it equivalent to
irq_domain_add_linear but with one more function
argument and making it less clear what is going on.

> And why do we need separate domain for one IRQ line?

Every irq-chip needs its own domain to map its hwirq
numbers to virq numbers (which are globally unique).

>
>> +	if (!adap->irq_domain)
>> +		return -ENOMEM;
>> +
>> +	adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
>> +	if (!adap->client_irq) {
>> +		ret = -ENOMEM;
>> +		goto remove_irq_domain;
>> +	}
>> +
>> +	irq_set_chip_data(adap->client_irq, adap);
>> +	irq_set_chip_and_handler(adap->client_irq, &adap->irqchip,
>> +				 handle_simple_irq);
>> +
>
>> +	board_info.irq = adap->client_irq;
>> +	adap->client = i2c_new_device(&adap->adapter, &board_info);
>> +	if (!adap->client) {
>> +		ret = -ENOMEM;
>> +		goto del_adapter;
>> +	}
>
> I would split this to some other module with board info.

We need both the adapter and the irq line to instantiate
the i2c-client for the external charger both of which are
readily available here.

> By the way, doesn't ACPI have the charger IC node?

There are several (disabled, _STA returns 0) ACPI nodes
for charger ICs in all the Cherrytrail DSTDs I've (all
DSTDs seem to be copy and paste from the same templates),
but none of them points to the i2c bus controlled by
the Whiskey Cove PMIC. Those nodes seem to all be
for when the charger IC is directly connected to one
of the designware-i2c busses. TL;DR: No there is no
ACPI node for the external charger IC in this case.

Regards,

Hans
