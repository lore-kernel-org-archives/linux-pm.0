From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
Date: Wed, 4 Jul 2018 14:55:33 +0200
Message-ID: <CAPDyKFoXOJA85fr-80inQoORAFW5mDy1QktkVLey6Vs4QERH8A@mail.gmail.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <20180627125056.12851-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627125056.12851-2-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 June 2018 at 14:50, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> Add a flag to autoremove the device links on supplier driver
> unbind. This obviates the need to explicitly delete the link
> in the remove path.
> We remove these links only when the supplier's link to its
> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/driver-api/device_link.rst |  4 ++++
>  drivers/base/core.c                      | 10 ++++++++++
>  include/linux/device.h                   |  2 ++
>  3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index a005b904a264..d6763272e747 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -86,6 +86,10 @@ automatically purged when the consumer fails to probe or later unbinds.
>  This obviates the need to explicitly delete the link in the ``->remove``
>  callback or in the error path of the ``->probe`` callback.
>
> +Similarly, when the device link is added from supplier's ``->probe`` callback,
> +``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
> +purged when the supplier fails to probe or later unbinds.
> +
>  Limitations
>  ===========
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14c1e3151e08..e721218bf352 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -518,6 +518,16 @@ void device_links_driver_cleanup(struct device *dev)
>
>                 WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
>                 WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
> +
> +               /*
> +                * autoremove the links between this @dev and its consumer
> +                * devices that are not active, i.e. where the link state
> +                * has moved to DL_STATE_SUPPLIER_UNBIND.
> +                */
> +               if (link->status == DL_STATE_SUPPLIER_UNBIND &&
> +                   link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
> +                       kref_put(&link->kref, __device_link_del);
> +
>                 WRITE_ONCE(link->status, DL_STATE_DORMANT);
>         }
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3929805cdd59..e80920452b49 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -787,11 +787,13 @@ enum device_link_state {
>   * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>   * PM_RUNTIME: If set, the runtime PM framework will use this link.
>   * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
> + * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
>   */
>  #define DL_FLAG_STATELESS              BIT(0)
>  #define DL_FLAG_AUTOREMOVE_CONSUMER    BIT(1)
>  #define DL_FLAG_PM_RUNTIME             BIT(2)
>  #define DL_FLAG_RPM_ACTIVE             BIT(3)
> +#define DL_FLAG_AUTOREMOVE_SUPPLIER    BIT(4)
>
>  /**
>   * struct device_link - Device link representation.
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
