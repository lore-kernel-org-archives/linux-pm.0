From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Sun, 6 Aug 2017 07:30:05 -0700
Message-ID: <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-11-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

On 08/06/2017 05:35 AM, Hans de Goede wrote:
> On devicetree platforms the fusb302 dt-node will have a vbus regulator
> property with a phandle to the regulator.
> 
> On ACPI platforms, there are no phandles and we need to get the vbus by a
> system wide unique name. Add support for a new "fcs,vbus-regulator-name"
> device-property which ACPI platform code can set to pass the name.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/staging/typec/fusb302/fusb302.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
> index e1e08f57af99..c3bcc5484ade 100644
> --- a/drivers/staging/typec/fusb302/fusb302.c
> +++ b/drivers/staging/typec/fusb302/fusb302.c
> @@ -1722,6 +1722,28 @@ static int fusb302_probe(struct i2c_client *client,
>   			return -EPROBE_DEFER;
>   	}
>   
> +	/*
> +	 * Devicetree platforms should get vbus from their dt-node.
> +	 * On ACPI platforms, we need to get the vbus by a system wide unique
> +	 * name, which is set in a device prop by the platform code.
> +	 */
> +	if (device_property_read_string(dev, "fcs,vbus-regulator-name",
> +					&name) == 0) {

Another property to be documented and approved.

Also, isn't there a better way to get regulator names for dt- and non-dt systems ?
This would apply to every driver supporting both and using regulators, which seems
awkward.

> +		/*
> +		 * Use regulator_get_optional so that we can detect if we need
> +		 * to defer the probe rather then getting the dummy-regulator.
> +		 */

Wouldn't this apply to dt systems as well ?

> +		chip->vbus = devm_regulator_get_optional(dev, name);
> +		if (IS_ERR(chip->vbus)) {
> +			ret = PTR_ERR(chip->vbus);
> +			return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
> +		}
> +	} else {
> +		chip->vbus = devm_regulator_get(dev, "vbus");
> +		if (IS_ERR(chip->vbus))
> +			return PTR_ERR(chip->vbus);
> +	}
> +

You might also want to explain why you moved this code.

>   	ret = tcpm_register_psy(chip->dev, &chip->tcpc_dev,
>   				"fusb302-typec-source");
>   	if (ret < 0)
> @@ -1739,12 +1761,6 @@ static int fusb302_probe(struct i2c_client *client,
>   	INIT_DELAYED_WORK(&chip->bc_lvl_handler, fusb302_bc_lvl_handler_work);
>   	init_tcpc_dev(&chip->tcpc_dev);
>   
> -	chip->vbus = devm_regulator_get(chip->dev, "vbus");
> -	if (IS_ERR(chip->vbus)) {
> -		ret = PTR_ERR(chip->vbus);
> -		goto destroy_workqueue;
> -	}
> -
>   	if (client->irq) {
>   		chip->gpio_int_n_irq = client->irq;
>   	} else {
> 
