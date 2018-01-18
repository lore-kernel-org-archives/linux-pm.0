From: Aishwarya Pant <aishpant@gmail.com>
Subject: Re: [PATCH 2/3] power: supply: add cros-ec USB PD charger driver.
Date: Thu, 18 Jan 2018 11:26:40 +0530
Message-ID: <20180118055640.GA10380@mordor.localdomain>
References: <20180117175932.20636-1-enric.balletbo@collabora.com>
 <20180117175932.20636-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117175932.20636-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 17, 2018 at 06:59:31PM +0100, Enric Balletbo i Serra wrote:
> From: Sameer Nanda <snanda@chromium.org>
> 
> This driver gets various bits of information about what is connected to
> USB PD ports from the EC and converts that into power_supply properties.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/power/supply/Kconfig              |  11 +
>  drivers/power/supply/Makefile             |   1 +
>  drivers/power/supply/cros_usbpd-charger.c | 953 ++++++++++++++++++++++++++++++
>  include/linux/mfd/cros_ec.h               |   3 +
>  4 files changed, 968 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c

<snip>

> +static DEVICE_ATTR(ext_current_lim, 0664, get_ec_ext_current_lim,
> +		   set_ec_ext_current_lim);
> +static DEVICE_ATTR(ext_voltage_lim, 0664, get_ec_ext_voltage_lim,
> +		   set_ec_ext_voltage_lim);
> +

Hi

I see that you have added new files to the sysfs ABI. It would probably be a
good idea to have these new interfaces documented in Documentation/ABI.

Aishwarya

> +static struct attribute *__ext_power_cmds_attrs[] = {
> +	&dev_attr_ext_current_lim.attr,
> +	&dev_attr_ext_voltage_lim.attr,
> +	NULL,
> +};

<snip>
