From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH v2 02/21] ARM: pxa: magician: Fix indentation and
 whitespaces
Date: Wed, 19 Aug 2015 09:42:58 +0200
Message-ID: <1439970178.11928.15.camel@gmail.com>
References: <cover.1439843482.git.petr.cvek@tul.cz>
	 <55D258A6.2040105@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55D258A6.2040105@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>, robert.jarzmik@free.fr, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Montag, den 17.08.2015, 23:56 +0200 schrieb Petr Cvek:
> Fix magician.c: indentation and whitespaces.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> ---
>  arch/arm/mach-pxa/magician.c | 356 +++++++++++++++++++++------------
> ----------
>  1 file changed, 178 insertions(+), 178 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach
> -pxa/magician.c
> index a9761c2..9e8698a 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -52,8 +52,8 @@ static unsigned long magician_pin_config[] 
> __initdata = {
>  	GPIO20_nSDCS_2,
>  	GPIO21_nSDCS_3,
>  	GPIO15_nCS_1,
> -	GPIO78_nCS_2,   /* PASIC3 */
> -	GPIO79_nCS_3,   /* EGPIO CPLD */
> +	GPIO78_nCS_2,	/* PASIC3 */
> +	GPIO79_nCS_3,	/* EGPIO CPLD */
>  	GPIO80_nCS_4,
>  	GPIO33_nCS_5,
>  
> @@ -107,7 +107,7 @@ static unsigned long magician_pin_config[] 


Yay.

> __initdata = {
>  	GPIO85_CIF_LV,
>  
>  	/* Magician specific input GPIOs */
> -	GPIO9_GPIO,	/* unknown */
> +	GPIO9_GPIO,		/* unknown */
>  	GPIO10_GPIO,	/* GSM_IRQ */
>  	GPIO13_GPIO,	/* CPLD_IRQ */
>  	GPIO107_GPIO,	/* DS1WM_IRQ */

Nay. Are you using 8-space tabs?

> @@ -133,46 +133,45 @@ static struct pxaficp_platform_data 
> magician_ficp_info = {
>   */
>  
>  #define INIT_KEY(_code, _gpio, _desc)	\
> -	{				\
> -		.code   = KEY_##_code,	\
> -		.gpio   = _gpio,	\
> -		.desc   = _desc,	\
> -		.type   = EV_KEY,	\
> -		.wakeup = 1,		\
> +	{						\
> +		.code	= KEY_##_code,	\
> +		.gpio	= _gpio,	\
> +		.desc	= _desc,	\
> +		.type	= EV_KEY,	\
> +		.wakeup	= 1,		\
>  	}

Ok.

>  static struct gpio_keys_button magician_button_table[] = {
> -	INIT_KEY(POWER,      GPIO0_MAGICIAN_KEY_POWER,      "Power 
> button"),
> -	INIT_KEY(ESC,        GPIO37_MAGICIAN_KEY_HANGUP,    "Hangup 
> button"),
> -	INIT_KEY(F10,        GPIO38_MAGICIAN_KEY_CONTACTS, 
>  "Contacts button"),
> -	INIT_KEY(CALENDAR,   GPIO90_MAGICIAN_KEY_CALENDAR, 
>  "Calendar button"),
> -	INIT_KEY(CAMERA,     GPIO91_MAGICIAN_KEY_CAMERA,    "Camera 
> button"),
> -	INIT_KEY(UP,         GPIO93_MAGICIAN_KEY_UP,        "Up 
> button"),
> -	INIT_KEY(DOWN,       GPIO94_MAGICIAN_KEY_DOWN,      "Down 
> button"),
> -	INIT_KEY(LEFT,       GPIO95_MAGICIAN_KEY_LEFT,      "Left 
> button"),
> -	INIT_KEY(RIGHT,      GPIO96_MAGICIAN_KEY_RIGHT,     "Right 
> button"),
> -	INIT_KEY(KPENTER,    GPIO97_MAGICIAN_KEY_ENTER,     "Action 
> button"),
> -	INIT_KEY(RECORD,     GPIO98_MAGICIAN_KEY_RECORD,    "Record 
> button"),
> -	INIT_KEY(VOLUMEUP,   GPIO100_MAGICIAN_KEY_VOL_UP,   "Volume 
> up"),
> -	INIT_KEY(VOLUMEDOWN, GPIO101_MAGICIAN_KEY_VOL_DOWN, "Volume 
> down"),
> -	INIT_KEY(PHONE,      GPIO102_MAGICIAN_KEY_PHONE,    "Phone 
> button"),
> -	INIT_KEY(PLAY,       GPIO99_MAGICIAN_HEADPHONE_IN,  "Headset 
> button"),
> +	INIT_KEY(POWER,		GPIO0_MAGICIAN_KEY_POWER,	> "Power 
> button"),
> +	INIT_KEY(ESC,		GPIO37_MAGICIAN_KEY_HANGUP,	"Han
> gup button"),
> +	INIT_KEY(F10,		GPIO38_MAGICIAN_KEY_CONTACTS,	"Con
> tacts button"),
> +	INIT_KEY(CALENDAR,	GPIO90_MAGICIAN_KEY_CALENDAR,	"Cal
> endar button"),
> +	INIT_KEY(CAMERA,	GPIO91_MAGICIAN_KEY_CAMERA,	"Cam
> era button"),
> +	INIT_KEY(UP,		GPIO93_MAGICIAN_KEY_UP,		> "Up 
> button"),
> +	INIT_KEY(DOWN,		GPIO94_MAGICIAN_KEY_DOWN,	"Dow
> n button"),
> +	INIT_KEY(LEFT,		GPIO95_MAGICIAN_KEY_LEFT,	"Lef
> t button"),
> +	INIT_KEY(RIGHT,		GPIO96_MAGICIAN_KEY_RIGHT,	> "Right 
> button"),
> +	INIT_KEY(KPENTER,	GPIO97_MAGICIAN_KEY_ENTER,	"Act
> ion button"),
> +	INIT_KEY(RECORD,	GPIO98_MAGICIAN_KEY_RECORD,	"Rec
> ord button"),
> +	INIT_KEY(VOLUMEUP,	GPIO100_MAGICIAN_KEY_VOL_UP,	"Vol
> ume up"),
> +	INIT_KEY(VOLUMEDOWN,	GPIO101_MAGICIAN_KEY_VOL_DOWN,	"Vol
> ume down"),
> +	INIT_KEY(PHONE,		GPIO102_MAGICIAN_KEY_PHONE,	> "Phone 
> button"),
> +	INIT_KEY(PLAY,		GPIO99_MAGICIAN_HEADPHONE_IN,	"Hea
> dset button"),
>  };

I don't like this. The tabs cause long lines and it's not like we
expect additional keys to appear that would warrant the reformatting.

>   static struct gpio_keys_platform_data gpio_keys_data = {
> -	.buttons  = magician_button_table,
> +	.buttons = magician_button_table,
>  	.nbuttons = ARRAY_SIZE(magician_button_table),
>  };
>  
>  static struct platform_device gpio_keys = {
>  	.name = "gpio-keys",
> -	.dev  = {
> +	.dev = {
>  		.platform_data = &gpio_keys_data,
>  	},
> -	.id   = -1,
> +	.id = -1,
>  };

Hm, so are we aligning at =, or are we not?


>  /*
>   * EGPIO (Xilinx CPLD)
>   *
> @@ -181,14 +180,14 @@ static struct platform_device gpio_keys = {
>  
>  static struct resource egpio_resources[] = {
>  	[0] = {
> -		.start = PXA_CS3_PHYS,
> -		.end   = PXA_CS3_PHYS + 0x20 - 1,
> -		.flags = IORESOURCE_MEM,
> +		.start	= PXA_CS3_PHYS,
> +		.end	= PXA_CS3_PHYS + 0x20 - 1,
> +		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
> -		.end   = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
> -		.flags = IORESOURCE_IRQ,
> +		.start	= PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
> +		.end	= PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
> +		.flags	= IORESOURCE_IRQ,
>  	},
>  };

I'm not a fan of reformatting unless there's a reason (like the mixture
of space and tab warnings). But as long as this doesn't introduce new
issues like long lines, and as long as it's done consequently, I'm fine
with this.

> @@ -209,20 +208,20 @@ static struct htc_egpio_chip egpio_chips[] = {
>  };
>  
>  static struct htc_egpio_platform_data egpio_info = {
> -	.reg_width    = 8,
> -	.bus_width    = 32,
> -	.irq_base     = IRQ_BOARD_START,
> -	.num_irqs     = 4,
> -	.ack_register = 3,
> -	.chip         = egpio_chips,
> -	.num_chips    = ARRAY_SIZE(egpio_chips),
> +	.reg_width	= 8,
> +	.bus_width	= 32,
> +	.irq_base	= IRQ_BOARD_START,
> +	.num_irqs	= 4,
> +	.ack_register	= 3,
> +	.chip		= egpio_chips,
> +	.num_chips	= ARRAY_SIZE(egpio_chips),
>  };
>  
>  static struct platform_device egpio = {
> -	.name          = "htc-egpio",
> -	.id            = -1,
> -	.resource      = egpio_resources,
> -	.num_resources = ARRAY_SIZE(egpio_resources),
> +	.name		= "htc-egpio",
> +	.id		= -1,
> +	.resource	= egpio_resources,
> +	.num_resources	= ARRAY_SIZE(egpio_resources),
>  	.dev = {
>  		.platform_data = &egpio_info,
>  	},
> @@ -234,33 +233,33 @@ static struct platform_device egpio = {
>  
>  static struct pxafb_mode_info toppoly_modes[] = {
>  	{
> -		.pixclock     = 96153,
> -		.bpp          = 16,
> -		.xres         = 240,
> -		.yres         = 320,
> -		.hsync_len    = 11,
> -		.vsync_len    = 3,
> -		.left_margin  = 19,
> -		.upper_margin = 2,
> -		.right_margin = 10,
> -		.lower_margin = 2,
> -		.sync         = 0,
> +		.pixclock	= 96153,
> +		.bpp		= 16,
> +		.xres		= 240,
> +		.yres		= 320,
> +		.hsync_len	= 11,
> +		.vsync_len	= 3,
> +		.left_margin	= 19,
> +		.upper_margin	= 2,
> +		.right_margin	= 10,
> +		.lower_margin	= 2,
> +		.sync		= 0,
>  	},
>  };
>  
>  static struct pxafb_mode_info samsung_modes[] = {
>  	{
> -		.pixclock     = 96153,
> -		.bpp          = 16,
> -		.xres         = 240,
> -		.yres         = 320,
> -		.hsync_len    = 8,
> -		.vsync_len    = 4,
> -		.left_margin  = 9,
> -		.upper_margin = 4,
> -		.right_margin = 9,
> -		.lower_margin = 4,
> -		.sync         = FB_SYNC_HOR_HIGH_ACT | 
> FB_SYNC_VERT_HIGH_ACT,
> +		.pixclock	= 96153,
> +		.bpp		= 16,
> +		.xres		= 240,
> +		.yres		= 320,
> +		.hsync_len	= 8,
> +		.vsync_len	= 4,
> +		.left_margin	= 9,
> +		.upper_margin	= 4,
> +		.right_margin	= 9,
> +		.lower_margin	= 4,
> +		.sync	= FB_SYNC_HOR_HIGH_ACT | 
> FB_SYNC_VERT_HIGH_ACT,
>  	},
>  };
>  
> @@ -326,19 +325,19 @@ static void samsung_lcd_power(int on, struct 
> fb_var_screeninfo *si)
>  }
>  
>  static struct pxafb_mach_info toppoly_info = {
> -	.modes           = toppoly_modes,
> -	.num_modes       = 1,
> -	.fixed_modes     = 1,
> +	.modes		= toppoly_modes,
> +	.num_modes	= 1,
> +	.fixed_modes	= 1,
>  	.lcd_conn	= LCD_COLOR_TFT_16BPP,
>  	.pxafb_lcd_power = toppoly_lcd_power,
>  };
>  
>  static struct pxafb_mach_info samsung_info = {
> -	.modes           = samsung_modes,
> -	.num_modes       = 1,
> -	.fixed_modes     = 1,
> -	.lcd_conn	 = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL 
> |\
> -			   LCD_ALTERNATE_MAPPING,
> +	.modes		= samsung_modes,
> +	.num_modes	= 1,
> +	.fixed_modes	= 1,
> +	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |
> +		LCD_ALTERNATE_MAPPING,
>  	.pxafb_lcd_power = samsung_lcd_power,
>  };
>  
> @@ -374,22 +373,22 @@ static void magician_backlight_exit(struct 
> device *dev)
>  }
>  
>  static struct platform_pwm_backlight_data backlight_data = {
> -	.pwm_id         = 0,
> -	.max_brightness = 272,
> -	.dft_brightness = 100,
> -	.pwm_period_ns  = 30923,
> -	.enable_gpio    = -1,
> -	.init           = magician_backlight_init,
> -	.notify         = magician_backlight_notify,
> -	.exit           = magician_backlight_exit,
> +	.pwm_id		= 0,
> +	.max_brightness	= 272,
> +	.dft_brightness	= 100,
> +	.pwm_period_ns	= 30923,
> +	.enable_gpio	= -1,
> +	.init		= magician_backlight_init,
> +	.notify		= magician_backlight_notify,
> +	.exit		= magician_backlight_exit,
>  };
>  
>  static struct platform_device backlight = {
> -	.name = "pwm-backlight",
> -	.id   = -1,
> -	.dev  = {
> -		.parent        = &pxa27x_device_pwm0.dev,
> -		.platform_data = &backlight_data,
> +	.name	= "pwm-backlight",
> +	.id	= -1,
> +	.dev	= {
> +		.parent		= &pxa27x_device_pwm0.dev,
> +		.platform_data	= &backlight_data,
>  	},
>  };

So we are aligning, then. Please pick a style and stick with it.
I'll skip the rest for now.

regards
Philipp
