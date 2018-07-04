From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
Date: Wed, 4 Jul 2018 07:08:28 +0100
Message-ID: <20180704060828.GU20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502154418.2153-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

On Wed, 02 May 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has USBPD host command support and
> instatiate the cros_usbpd-charger driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
> 
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
