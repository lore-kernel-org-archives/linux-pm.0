From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: cros_ec: Add USBPD charger commands and struct
 definitions.
Date: Tue, 23 Jan 2018 11:49:14 +0000
Message-ID: <20180123114914.5wdpr4fszzqxhsop@dell>
References: <20180117175932.20636-1-enric.balletbo@collabora.com>
 <20180117175932.20636-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180117175932.20636-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jan 2018, Enric Balletbo i Serra wrote:

> From: Sameer Nanda <snanda@chromium.org>
> 
> The USB PD charger driver gets information from the ChromeOS EC, this
> patch adds the USBPD charger definitions needed by this driver.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 135 +++++++++++++++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 4 deletions(-)

Looks okay.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
