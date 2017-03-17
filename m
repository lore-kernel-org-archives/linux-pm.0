From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 13/15] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 17 Mar 2017 19:41:01 +0200
Message-ID: <1489772461.19767.81.camel@linux.intel.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
         <20170317095527.10487-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-14-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
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

> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -212,6 +212,9 @@ struct i2c_driver {
>  	int (*detect)(struct i2c_client *, struct i2c_board_info *);
>  	const unsigned short *address_list;
>  	struct list_head clients;
> +
> +	/* IRQ index for retreiving irq from ACPI resources */

We have kernel doc.

> +	int irq_index;

Not sure about name (would like it to be shorter, but Friday evening
doesn't allow to be creative).

>  };
>  #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
