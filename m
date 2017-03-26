From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for
 irq to get from of / ACPI
Date: Sun, 26 Mar 2017 15:15:35 +0300
Message-ID: <1490530535.21738.31.camel@linux.intel.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
         <20170325135550.22509-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170325135550.22509-4-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2017-03-25 at 14:55 +0100, Hans de Goede wrote:
> Some of or ACPI declared / enumerated devices may have multiple irq
> resources declared and the driver may want to use a different irq then
> the one with index 0.
> 
> This commit adds a new irq_index field to struct i2c_driver and makes
> the i2c-core pass this to of_irq_get / acpi_dev_gpio_irq_get.
> 
> This is esp. useful for ACPI declared devices where the irq with
> index 0 may be entirely useless and cause i2c_device_probe to fail
> with
> -EPROBE_DEFER.

Just a side note / question: are we assuming that the index of
I2cSerialBus() resource and index of GpioInt() resource should be 1:1
mapped?

One nit below, and

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Actually also use the irq_index for of interrupts
> Changes in v3:
> -Add kernel doc for new i2c_driver irq_index member
> -Remove duplicate assignment of driver in i2c_device_probe
> ---
>  drivers/i2c/i2c-core.c | 10 ++++++----
>  include/linux/i2c.h    |  4 ++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 062b480..a7dfa6c 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -983,6 +983,8 @@ static int i2c_device_probe(struct device *dev)
>  	if (!client)
>  		return 0;
>  
> +	driver = to_i2c_driver(dev->driver);
> +
>  	if (!client->irq) {
>  		int irq = -ENOENT;
>  
> @@ -992,9 +994,11 @@ static int i2c_device_probe(struct device *dev)
>  		} else if (dev->of_node) {
>  			irq = of_irq_get_byname(dev->of_node, "irq");
>  			if (irq == -EINVAL || irq == -ENODATA)
> -				irq = of_irq_get(dev->of_node, 0);
> +				irq = of_irq_get(dev->of_node,
> +						 driver->irq_index);
>  		} else if (ACPI_COMPANION(dev)) {
> -			irq =
> acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
> +			irq =
> acpi_dev_gpio_irq_get(ACPI_COMPANION(dev),
> +						    driver-
> >irq_index);
>  		}
>  		if (irq == -EPROBE_DEFER)
>  			return irq;
> @@ -1005,8 +1009,6 @@ static int i2c_device_probe(struct device *dev)
>  		client->irq = irq;
>  	}
>  
> -	driver = to_i2c_driver(dev->driver);
> -
>  	/*
>  	 * An I2C ID table is not mandatory, if and only if, a
> suitable Device
>  	 * Tree match table entry is supplied for the probing device.
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 369ebfa..79de1d1 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -149,6 +149,7 @@ enum i2c_alert_protocol {
>   * @detect: Callback for device detection
>   * @address_list: The I2C addresses to probe (for detect)
>   * @clients: List of detected clients we created (for i2c-core use
> only)
> + * @irq_index: IRQ index for retreiving irq from OF/ACPI
>   *
>   * The driver.owner field should be set to the module owner of this
> driver.
>   * The driver.name field should be set to the name of this driver.
> @@ -212,6 +213,9 @@ struct i2c_driver {
>  	int (*detect)(struct i2c_client *, struct i2c_board_info *);
>  	const unsigned short *address_list;
>  	struct list_head clients;

> +
> +	/* IRQ index for retreiving irq from OF/ACPI */

Since kernel doc in place the above is redundant.

> +	int irq_index;
>  };
>  #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
