From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v2 03/21] ARM: pxa: magician: Fix comments, debug
 functions and print strings
Date: Wed, 19 Aug 2015 09:57:01 +0200
Message-ID: <1439971021.11928.26.camel@gmail.com>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D258CD.40101@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D258CD.40101@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, robert.jarzmik@free.fr, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Montag, den 17.08.2015, 23:57 +0200 schrieb Petr Cvek:
> Fix comments, debug functions and print strings. Rename backlight
> structures to be more specific.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 121 +++++++++++++++++++++++++++++++--
> ----------
>  1 file changed, 89 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
> -pxa/magician.c
> index 9e8698a..57da133 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -11,6 +11,46 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> + *
> + * NOTICE MDA Compact (T-mobile XDA) facts:
> + *   On "LCD type = 1, system_rev = 2" (0x3a in CPLD)
> + * Samsung LTP280QV - valid LCD init sequence sequence:
> + *   powerup: Vdigital->Vanalog->gate Voff->gate Von->data enable
> + *   powerdown: data disable->gate Von->gate Voff->Vanalog->Vdigital
> + * Measured on PCB:
> + *   GPIO106
> + *     Affects VOFF, VON and other voltages
> + *     Probably main reset pin for DC-DC converter
> + *   GPIO75
> + *     Must be AF0+OUT (WM leaves it to AF2+OUT), not LCD signal
> + *     GPIO106 works only when GPIO75 is high (DC-DC power enable?)
> + *     After LCD powerup, value is irrelevant
> + *   GPIO104
> + *     LCD VOFF (gate off voltage)
> + *   GPIO105
> + *     LCD VON (gate on voltage)
> + * FFUART (/dev/ttyS0) WM: 38400,8,n,1,crtscts (GSM data?)
> + * BTUART (/dev/ttyS1) WM: 115200,8,n,1,crtscts (GSM AT commands)
> + *   Use a HTC line discipline: 0x02 channel(==0x16) data 0x02
> + * EGPIO(CPLD) should be always present (controls "all" supply 
> power)
> + *   For rootfs on MMC/SD: EGPIO module controls card power (in 
> kernel)
> + * cpu-freq often freeze platform (errata?, use userspace gov)
> + * Do not use YUV420, (erratum E24) causes LCD hang (forever)
> + * Many GSM related pins are unknown
> + * gpio-rc-recv probably require lowpass filter (sw is OK)
> + * TODO EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN
> + * FIXME AC charging blocks IrDA
> + * Unimplemented blocking of camera+power+reset, reset and door open 
> reset
> + *   Registers: htc-pasic3.h (but blocks charging too)
> + * Other PXA machines have wait_for_sync for ADS7846 (during LCD 
> refresh)
> + * pda-power has not optimal charging (accu can be bloated)
> + * TODO Current switching works? Is gpio-regulator/bq24022 required?

> + * pdata supports alternative drivers (mutually exclusive modules)
> + *   i2c-pxa vs i2c-gpio (SCCB)
> + *   pwm_bl vs gpio_backlight
> + *   pxa27x_udc vs phy-gpio-vbus-usb
> + *   physmap-flash vs pxa2xx-flash

This infodump is useful to have, but I don't think it belongs in the
code.
Also, please don't include the mutually exclusive alternatives in
mainline. Let's just pick one option.

>  #include <linux/kernel.h>
> @@ -57,31 +97,31 @@ static unsigned long magician_pin_config[] 
> __initdata = {
>  	GPIO80_nCS_4,
>  	GPIO33_nCS_5,
>  
> -	/* I2C */
> +	/* I2C UDA1380 + OV9640 */
>  	GPIO117_I2C_SCL,
>  	GPIO118_I2C_SDA,
>  
> -	/* PWM 0 */
> +	/* PWM 0 - LCD backlight */
>  	GPIO16_PWM0_OUT,
>  
> -	/* I2S */
> +	/* I2S UDA1380 capture */
>  	GPIO28_I2S_BITCLK_OUT,
>  	GPIO29_I2S_SDATA_IN,
>  	GPIO31_I2S_SYNC,
>  	GPIO113_I2S_SYSCLK,
>  
> -	/* SSP 1 */
> +	/* SSP 1 UDA1380 playback */
>  	GPIO23_SSP1_SCLK,
>  	GPIO24_SSP1_SFRM,
>  	GPIO25_SSP1_TXD,
>  
> -	/* SSP 2 */
> +	/* SSP 2 TSC2046 touchscreen */
>  	GPIO19_SSP2_SCLK,
>  	GPIO14_SSP2_SFRM,
>  	GPIO89_SSP2_TXD,
>  	GPIO88_SSP2_RXD,
>  
> -	/* MMC */
> +	/* MMC/SD/SDHC slot */
>  	GPIO32_MMC_CLK,
>  	GPIO92_MMC_DAT_0,
>  	GPIO109_MMC_DAT_1,

These comments are nice to have.

> @@ -92,7 +132,7 @@ static unsigned long magician_pin_config[] 
> __initdata = {
>  	/* LCD */
>  	GPIOxx_LCD_TFT_16BPP,
>  
> -	/* QCI */
> +	/* QCI camera interface */
>  	GPIO12_CIF_DD_7,
>  	GPIO17_CIF_DD_6,
>  	GPIO50_CIF_DD_3,
> @@ -120,11 +160,12 @@ static unsigned long magician_pin_config[] 
> __initdata = {
>  };
>  
>  /*
> - * IRDA
> + * IrDA
>   */
>  
>  static struct pxaficp_platform_data magician_ficp_info = {
>  	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
> +	/* TODO test with FIR dongle */
>  	.transceiver_cap	= IR_SIRMODE | IR_OFF,
>  };
> @@ -174,8 +215,8 @@ static struct platform_device gpio_keys = {
>   
>  /*
>   * EGPIO (Xilinx CPLD)
> - *
> - * 7 32-bit aligned 8-bit registers: 3x output, 1x irq, 3x input
> + * 32-bit aligned
> + * 7x 8-bit registers: 3x output, 1x irq, 3x input
>   */

Why reorder?

>  static struct resource egpio_resources[] = {
> @@ -197,7 +238,11 @@ static struct htc_egpio_chip egpio_chips[] = {
>  		.gpio_base = MAGICIAN_EGPIO(0, 0),
>  		.num_gpios = 24,
>  		.direction = HTC_EGPIO_OUTPUT,
> -		.initial_values = 0x40, /* EGPIO_MAGICIAN_GSM_RESET 
> */
> +
> +		/*
> +		 * Depends on modules configuration
> +		 */
> +		.initial_values = 0x40,
>  	},
>  	[1] = {
>  		.reg_start = 4,
> @@ -228,7 +273,7 @@ static struct platform_device egpio = {
>  };
>  
>  /*
> - * LCD - Toppoly TD028STEB1 or Samsung LTP280QV
> + * PXAFB LCD - Toppoly TD028STEB1 or Samsung LTP280QV
>   */
>  
>  static struct pxafb_mode_info toppoly_modes[] = {
> @@ -265,10 +310,9 @@ static struct pxafb_mode_info samsung_modes[] = 
> {
>  
>  static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
>  {
> -	pr_debug("Toppoly LCD power\n");
> +	pr_debug("Toppoly LCD power: %s\n", on ? "on" : "off");Ok.

Ok.

> 	if (on) {
> -		pr_debug("on\n");
>  		gpio_set_value(EGPIO_MAGICIAN_TOPPOLY_POWER, 1);
>  		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
>  		udelay(2000);
> @@ -280,8 +324,7 @@ static void toppoly_lcd_power(int on, struct 
> fb_var_screeninfo *si)
>  		udelay(2000);
>  		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
>  	} else {
> -		pr_debug("off\n");
> -		msleep(15);
> +		mdelay(15);

This is an unrelated change and should be in a separate patch.
Also maybe better use usleep_range?

>  		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
>  		udelay(500);
>  		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
> @@ -293,10 +336,9 @@ static void toppoly_lcd_power(int on, struct 
> fb_var_screeninfo *si)
>  
>  static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
>  {
> -	pr_debug("Samsung LCD power\n");
> +	pr_debug("Samsung LCD power: %s\n", on ? "on" : "off");
>  
>  	if (on) {
> -		pr_debug("on\n");
>  		if (system_rev < 3)
>  			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER
> , 1);
>  		else
> @@ -309,7 +351,6 @@ static void samsung_lcd_power(int on, struct 
> fb_var_screeninfo *si)
>  		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
>  		mdelay(10);
>  	} else {
> -		pr_debug("off\n");
>  		mdelay(10);
>  		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
>  		mdelay(30);
> @@ -346,8 +387,8 @@ static struct pxafb_mach_info samsung_info = {
>   */
>  
[...]
> +/*
> + * pda_power Li-ion charger
> + */
> +
>  static struct pda_power_pdata power_supply_info = {
>  	.init		= power_supply_init,
>  	.is_ac_online	= magician_is_ac_online,
> @@ -575,7 +631,7 @@ static struct platform_device power_supply = {
>  };
>  
>  /*
> - * Battery charger
> + * Charging current switch
>   */

The bq24022 is a battery charger. The switch is one of its input pins
to allow to limit USB charging current to 100 mA in case the host
doesn't support more.
 
regards
Philipp
