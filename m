From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 3/3] mfd: cros_ec_dev: Register cros_usbpd-charger
 driver as a subdevice.
Date: Tue, 1 May 2018 09:32:29 +0100
Message-ID: <20180501083229.GL5147@dell>
References: <20180430131403.14296-1-enric.balletbo@collabora.com>
 <20180430131403.14296-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180430131403.14296-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com
List-Id: linux-pm@vger.kernel.org

On Mon, 30 Apr 2018, Enric Balletbo i Serra wrote:

> Check whether this EC instance has USBPD host command support and
> instatiate the cros_usbpd-charger driver as a subdevice in such case.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - [3/3] Use ARRAY_SIZE instead of hardcoded 1.
> 
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Patch looks good to me.

Does it depend on any of the other patches in the series?

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
