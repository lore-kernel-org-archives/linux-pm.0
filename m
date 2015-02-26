From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 6/6] hwmon: pwm-fan: Code for using PWM FAN as a cooling
 device
Date: Thu, 26 Feb 2015 15:40:33 +0100
Message-ID: <20150226154033.301a699d@amdc2363>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424959177-28739-1-git-send-email-l.majewski@samsung.com>
 <1424959177-28739-7-git-send-email-l.majewski@samsung.com>
 <54EF29D4.7040508@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54EF29D4.7040508@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Guenter,

> On 02/26/2015 05:59 AM, Lukasz Majewski wrote:
> > The PWM FAN device can now be used as a thermal cooling device.
> > Necessary infrastructure has been added in this commit.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Acked-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> > Changes for v2:
> > - Replace pwm_fan_cooling_states with pwm_fan_cooling_levels
> > - Update ctx->pwm_fan_state when correct data from device tree is
> > available
> > - Using therma_cdev_update() when thermal is ready for controlling
> > the fan Changes for v3:
> > - Rename patch heading
> > - pwm_fan_of_get_cooling_data() now returns -EINVAL when no
> > "cooling-levels" property defined
> > - register of cooling device only when proper cooling data is
> > present Changes for v4:
> > - None
> > Changes for v5:
> > - Check for IS_ENABLED(CONFIG_THERMAL) has been added to prevent
> > from executing thermal_* specific functions
> > Changes for v6:
> > - Adding missing ctx == NULL check in pwm_fan_get_max_state()
> > - Call to thermal_cooling_device_unregister(ctx->cdev); at
> > pwm_fan_remove()
> > - struct thermal_cooling_device *cdev; added to struct pwm_fan_ctx
> > ---
> >   drivers/hwmon/pwm-fan.c | 89
> > ++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> > 88 insertions(+), 1 deletion(-)
> [ ... ]
> >
> > @@ -200,6 +286,7 @@ static int pwm_fan_remove(struct
> > platform_device *pdev) {
> >   	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> >
> > +	thermal_cooling_device_unregister(ctx->cdev);
> 
> Unfortunately there is still no prototype for this if CONFIG_THERMAL
> is not configured.

Yes... since Nishanth Menon's changes are now only in
linux-soc-thermal/fixes

> 
> Two options: Yet another revision, or wait a week until the prototypes
> are (hopefully) available and submit a patch without the conditionals.

No problem, I will wait a bit and resend this patch set.

> 
> Guenter
> 

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
