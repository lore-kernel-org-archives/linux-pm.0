From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v5 1/5] thermal: Add support for hardware-tracked trip
 points
Date: Mon, 6 Jun 2016 13:47:00 +0100
Message-ID: <20160606124700.GB2897@e104805>
References: <1465213489-14898-1-git-send-email-wxt@rock-chips.com>
 <1465213489-14898-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465213489-14898-2-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, cf@rock-chips.com, huangtao@rock-chips.com, dmitry.torokhov@gmail.com, peter@piie.net, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Jonathan Corbet <corbet@lwn.net>, Andy Champ <andycham@amazon.com>, Laxman Dewangan <ldewangan@nvidia.com>, Durgadoss R <durgadoss.r@intel.com>, Ni Wade <wni@nvidia.com>, Leo Yan <leo.yan@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 06, 2016 at 07:44:45PM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> This adds support for hardware-tracked trip points to the device tree
> thermal sensor framework.
> 
> The framework supports an arbitrary number of trip points. Whenever
> the current temperature is updated, the trip points immediately
> below and above the current temperature are found. A .set_trips
> callback is then called with the temperatures. If there is no trip
> point above or below the current temperature, the passed trip
> temperature will be -INT_MAX or INT_MAX respectively. In this callback,
> the driver should program the hardware such that it is notified
> when either of these trip points are triggered. When a trip point
> is triggered, the driver should call `thermal_zone_device_update'
> for the respective thermal zone. This will cause the trip points
> to be updated again.
> 
> If .set_trips is not implemented, the framework behaves as before.
> 
> This patch is based on an earlier version from Mikko Perttunen
> <mikko.perttunen@kapsi.fi>
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
> Changes in v5:
> - add the lock for thermal_zone_set_trips function.

Looks good to me!

Reviewed-by: Javi Merino <javi.merino@arm.com>

> - change based on next kernel.
> 
> Changes in v4:
> - Missing the lock added in v3.
> 
> Changes in v3:
> - as Javi comments on https://patchwork.kernel.org/patch/9001281/.
> - add the lock for preventing the called from multi placce
> - add the note for pre_low/high_trip.
> 
> Changes in v2:
> - update the sysfs-api.txt for set_trips.
> 
>  Documentation/thermal/sysfs-api.txt |  7 +++++
>  drivers/thermal/thermal_core.c      | 54 +++++++++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c     |  3 +++
>  include/linux/thermal.h             | 10 +++++++
>  4 files changed, 74 insertions(+)
> 
