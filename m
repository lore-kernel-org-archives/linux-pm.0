From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: cros_ec: Add USBPD charger commands and
 struct definitions.
Date: Wed, 4 Jul 2018 07:08:15 +0100
Message-ID: <20180704060815.GT20176@dell>
References: <20180502154418.2153-1-enric.balletbo@collabora.com>
 <20180502154418.2153-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180502154418.2153-2-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

On Wed, 02 May 2018, Enric Balletbo i Serra wrote:

> From: Sameer Nanda <snanda@chromium.org>
> 
> The USBPD charger driver gets information from the ChromeOS EC, this
> patch adds the USBPD charger definitions needed by this driver.
> 
> Signed-off-by: Sameer Nanda <snanda@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4: None
> Changes in v3:
> - [1/3] Use the BIT macro.
> 
> Changes in v2: None
> 
>  include/linux/mfd/cros_ec_commands.h | 132 ++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
