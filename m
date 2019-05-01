From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
Date: Wed, 1 May 2019 09:48:43 -0700
Message-ID: <20190501164843.GA16333@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555617500-10862-2-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
> thermal_of_cooling_device_register() and thermal_cooling_device_register()
> are typically called from driver probe functions, and
> thermal_cooling_device_unregister() is called from remove functions. This
> makes both a perfect candidate for device managed functions.
> 
> Introduce devm_thermal_of_cooling_device_register(). This function can
> also be used to replace thermal_cooling_device_register() by passing a NULL
> pointer as device node. The new function requires both struct device *
> and struct device_node * as parameters since the struct device_node *
> parameter is not always identical to dev->of_node.
> 
> Don't introduce a device managed remove function since it is not needed
> at this point.
> 

Any feedback / thoughts / comments ?

Thanks,
Guenter
