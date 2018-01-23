From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] power: supply: add cros-ec USB PD charger driver.
Date: Tue, 23 Jan 2018 09:54:59 +0000
Message-ID: <20180123095459.wb4e2jb4ccncbcsf@dell>
References: <20180117175932.20636-1-enric.balletbo@collabora.com>
 <20180117175932.20636-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117175932.20636-3-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jan 2018, Enric Balletbo i Serra wrote:

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

Acked-by: Lee Jones <lee.jones@linaro.org>

>  4 files changed, 968 insertions(+)
>  create mode 100644 drivers/power/supply/cros_usbpd-charger.c

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
