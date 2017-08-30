From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 04/11] staging: typec: fusb302: Get max snk mv/ma/mw
 from device-properties
Date: Wed, 30 Aug 2017 06:50:04 -0700
Message-ID: <a4aeec52-9d95-5f66-fa02-27f493a9c222@roeck-us.net>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170830094814.17758-5-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Yueyao (Nathan) Zhu" <yueyao@google.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 08/30/2017 02:48 AM, Hans de Goede wrote:
> This is board specific info so it should come from board config, such
> as devicetree.
> 
> I've chosen to prefix these with "fcs," treating them as fusb302 driver
> specific for now. We may want to revisit this and replace these with
> properties which are part of a (to be written) generic type-c controller
> devicetree binding.
> 
> Since this commit adds new dt-properties it also adds devicetree-bindings
> documentation (which so far was absent for the fusb302 driver).
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -Use micro... instead of mili...
> -Add devicetree bindings documentation
> 
> Changes in v3:
> -Use sink rather then snk in property names
> -Add Rob's Acked-by
> ---
>   .../devicetree/bindings/usb/fcs,fusb302.txt        | 29 ++++++++++++++++++++++
>   drivers/staging/typec/fusb302/TODO                 |  4 +++
>   drivers/staging/typec/fusb302/fusb302.c            | 18 +++++++++++++-
>   3 files changed, 50 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/fcs,fusb302.txt b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> new file mode 100644
> index 000000000000..472facfa5a71
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/fcs,fusb302.txt
> @@ -0,0 +1,29 @@
> +Fairchild FUSB302 Type-C Port controllers
> +
> +Required properties :
> +- compatible             : "fcs,fusb302"
> +- reg                    : I2C slave address
> +- interrupts             : Interrupt specifier
> +
> +Optional properties :
> +- fcs,max-sink-microvolt : Maximum voltage to negotiate when configured as sink
> +- fcs,max-sink-microamp  : Maximum current to negotiate when configured as sink
> +- fcs,max-sink-microwatt : Maximum power to negotiate when configured as sink
> +			   If this is less then max-sink-microvolt *
> +			   max-sink-microamp then the configured current will
> +			   be clamped.
> +- fcs,operating-sink-microwatt :
> +			   Minimum amount of power accepted from a sink
> +			   when negotiating
> +
> +Example:
> +
> +fusb302: typec-portc@54 {
> +	compatible = "fcs,fusb302";
> +	reg = <0x54>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	fcs,max-sink-microvolt = <12000000>;
> +	fcs,max-sink-microamp = <3000000>;
> +	fcs,max-sink-microwatt = <36000000>;
> +};
> diff --git a/drivers/staging/typec/fusb302/TODO b/drivers/staging/typec/fusb302/TODO
> index 4933a1d92c32..19b466eb585d 100644
> --- a/drivers/staging/typec/fusb302/TODO
> +++ b/drivers/staging/typec/fusb302/TODO
> @@ -4,3 +4,7 @@ fusb302:
>   - Find a non-hacky way to coordinate between PM and I2C access
>   - Documentation? The FUSB302 datasheet provides information on the chip to help
>     understand the code. But it may still be helpful to have a documentation.
> +- We may want to replace the  "fcs,max-snk-microvolt", "fcs,max-snk-microamp",
> +  "fcs,max-snk-microwatt" and "fcs,operating-snk-microwatt" device(tree)
> +  properties with properties which are part of a generic type-c controller
> +  devicetree binding.
> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
> index 6baed06a3c0d..1c1751c994db 100644
> --- a/drivers/staging/typec/fusb302/fusb302.c
> +++ b/drivers/staging/typec/fusb302/fusb302.c
> @@ -90,6 +90,7 @@ struct fusb302_chip {
>   	struct i2c_client *i2c_client;
>   	struct tcpm_port *tcpm_port;
>   	struct tcpc_dev tcpc_dev;
> +	struct tcpc_config tcpc_config;
>   
>   	struct regulator *vbus;
>   
> @@ -1198,7 +1199,6 @@ static const struct tcpc_config fusb302_tcpc_config = {
>   
>   static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
>   {
> -	fusb302_tcpc_dev->config = &fusb302_tcpc_config;
>   	fusb302_tcpc_dev->init = tcpm_init;
>   	fusb302_tcpc_dev->get_vbus = tcpm_get_vbus;
>   	fusb302_tcpc_dev->set_cc = tcpm_set_cc;
> @@ -1684,7 +1684,9 @@ static int fusb302_probe(struct i2c_client *client,
>   {
>   	struct fusb302_chip *chip;
>   	struct i2c_adapter *adapter;
> +	struct device *dev = &client->dev;
>   	int ret = 0;
> +	u32 v;
>   
>   	adapter = to_i2c_adapter(client->dev.parent);
>   	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
> @@ -1699,8 +1701,22 @@ static int fusb302_probe(struct i2c_client *client,
>   	chip->i2c_client = client;
>   	i2c_set_clientdata(client, chip);
>   	chip->dev = &client->dev;
> +	chip->tcpc_config = fusb302_tcpc_config;
> +	chip->tcpc_dev.config = &chip->tcpc_config;
>   	mutex_init(&chip->lock);
>   
> +	if (!device_property_read_u32(dev, "fcs,max-sink-microvolt", &v))
> +		chip->tcpc_config.max_snk_mv = v / 1000;
> +
> +	if (!device_property_read_u32(dev, "fcs,max-sink-microamp", &v))
> +		chip->tcpc_config.max_snk_ma = v / 1000;
> +
> +	if (!device_property_read_u32(dev, "fcs,max-sink-microwatt", &v))
> +		chip->tcpc_config.max_snk_mw = v / 1000;
> +
> +	if (!device_property_read_u32(dev, "fcs,operating-sink-microwatt", &v))
> +		chip->tcpc_config.operating_snk_mw = v / 1000;
> +
>   	ret = fusb302_debugfs_init(chip);
>   	if (ret < 0)
>   		return ret;
> 
