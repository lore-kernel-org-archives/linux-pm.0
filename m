From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2 06/21] ARM: pxa: magician: Add normal and power I2C
 definition
Date: Wed, 19 Aug 2015 20:41:43 +0200
Message-ID: <87mvxn6ryw.fsf@belgarion.home>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D2593A.5060400@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, sameo@linux.intel.com, linux-pm@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cooloney@gmail.com, sre@kernel.org, haojian.zhuang@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, philipp.zabel@gmail.com, lee.jones@linaro.org, j.anaszewski@samsung.com, daniel@zonque.org
List-Id: linux-pm@vger.kernel.org

Petr Cvek <petr.cvek@tul.cz> writes:

> @@ -873,10 +875,39 @@ static struct platform_device strataflash = {
>   */
>  
>  static struct i2c_pxa_platform_data i2c_info = {
> -	.fast_mode = 1,
> +	.fast_mode = 0,	/* fast mode seems to be have bit errors */
> +	.use_pio = 0, /* no polling */
This deserves a better commit message : why the switch out of fast_mode, what
was not working, etc ...

> +/*
> + * GPIO I2C normal controller (alternative)
> + */
> +
> +static struct i2c_gpio_platform_data rtc_device_data = {
> +	.sda_pin = GPIO118_MAGICIAN_I2C_SDA,
> +	.scl_pin = GPIO117_MAGICIAN_I2C_SCL,
> +	.udelay = 100
> +};
> +
> +static struct platform_device i2c_gpio_bus_alt = {
> +	.name = "i2c-gpio",
> +	.id = 0,
> +	.dev = {
> +		.platform_data = &rtc_device_data,
rtc_device_data, really ?
Can you add __initdata, I think i2c-gpio copies the data and doesn't use it
anymore after ?

Cheers.

-- 
Robert
