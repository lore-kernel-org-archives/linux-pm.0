From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH v7 1/6] mfd: max8997: Use regmap to access registers
Date: Wed, 01 Jun 2016 13:37:18 +0200
Message-ID: <574EC8EE.5000509@samsung.com>
References: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
 <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, r.baldyga@hackerion.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

One thing drew my attention while reviewing this again:
max8997_led_brightness_set() can sleep, but the brightness_set
op it is assigned to must not sleep. At the time when this driver was
merged we were delegating brightness setting to workqueues task
in LED class drivers that can sleep during this call.
This must have been overlooked, which is even more likely, taking into
account that the initial patch doesn't have LED maintainer's ack.

The non-sleeping requirement is motivated by the fact that brightness
can be set from softirq context, e.g. when timer trigger is enabled.

Currently LED class drivers don't have to use workqueue on their own,
but are required to use brightness_set_blocking op instead of
brightness_set if they can sleep while setting brightness.

Apart of that, I think that operations in max8997_led_brightness_set()
should be protected with mutex to assure leaving the device in
a consistent state in case of concurrent calls.

I am aware that this is out of this patch scope, but I'd be grateful
if you could apply those changes and test them on hardware if you have
an access to.

Thanks,
Jacek Anaszewski

On 06/01/2016 11:53 AM, Krzysztof Kozlowski wrote:
> From: Robert Baldyga <r.baldyga@samsung.com>

> diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
> index 4edf74f1d6d4..e5f0dc2e9edf 100644
> --- a/drivers/leds/leds-max8997.c
> +++ b/drivers/leds/leds-max8997.c
> @@ -17,6 +17,7 @@
>   #include <linux/mfd/max8997.h>
>   #include <linux/mfd/max8997-private.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>
>   #define MAX8997_LED_FLASH_SHIFT			3
>   #define MAX8997_LED_FLASH_CUR_MASK		0xf8
> @@ -52,7 +53,6 @@ static void max8997_led_set_mode(struct max8997_led *led,
>   			enum max8997_led_mode mode)
>   {
>   	int ret;
> -	struct i2c_client *client = led->iodev->i2c;
>   	u8 mask = 0, val;
>
>   	switch (mode) {
> @@ -88,8 +88,8 @@ static void max8997_led_set_mode(struct max8997_led *led,
>   	}
>
>   	if (mask) {
> -		ret = max8997_update_reg(client, MAX8997_REG_LEN_CNTL, val,
> -					 mask);
> +		ret = regmap_update_bits(led->iodev->regmap,
> +					MAX8997_REG_LEN_CNTL, mask, val);
>   		if (ret)
>   			dev_err(led->iodev->dev,
>   				"failed to update register(%d)\n", ret);
> @@ -101,7 +101,6 @@ static void max8997_led_set_mode(struct max8997_led *led,
>   static void max8997_led_enable(struct max8997_led *led, bool enable)
>   {
>   	int ret;
> -	struct i2c_client *client = led->iodev->i2c;
>   	u8 val = 0, mask = MAX8997_LED_BOOST_ENABLE_MASK;
>
>   	if (led->enabled == enable)
> @@ -109,7 +108,8 @@ static void max8997_led_enable(struct max8997_led *led, bool enable)
>
>   	val = enable ? MAX8997_LED_BOOST_ENABLE_MASK : 0;
>
> -	ret = max8997_update_reg(client, MAX8997_REG_BOOST_CNTL, val, mask);
> +	ret = regmap_update_bits(led->iodev->regmap,
> +				MAX8997_REG_BOOST_CNTL, mask, val);
>   	if (ret)
>   		dev_err(led->iodev->dev,
>   			"failed to update register(%d)\n", ret);
> @@ -121,7 +121,6 @@ static void max8997_led_set_current(struct max8997_led *led,
>   				enum led_brightness value)
>   {
>   	int ret;
> -	struct i2c_client *client = led->iodev->i2c;
>   	u8 val = 0, mask = 0, reg = 0;
>
>   	switch (led->led_mode) {
> @@ -142,7 +141,7 @@ static void max8997_led_set_current(struct max8997_led *led,
>   	}
>
>   	if (mask) {
> -		ret = max8997_update_reg(client, reg, val, mask);
> +		ret = regmap_update_bits(led->iodev->regmap, reg, mask, val);
>   		if (ret)
>   			dev_err(led->iodev->dev,
>   				"failed to update register(%d)\n", ret);
