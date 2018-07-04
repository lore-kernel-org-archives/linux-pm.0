From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] device core: Rename flag AUTOREMOVE to AUTOREMOVE_CONSUMER
Date: Wed, 4 Jul 2018 14:55:25 +0200
Message-ID: <CAPDyKFru0zL4prQ9Vk1RAM-73PW8rTkseAGGwxqpZuTz+Fhczw@mail.gmail.com>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627125056.12851-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Jonathan Hunter <jonathanh@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 June 2018 at 14:50, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> Now that we want to add another flag to autoremove the device link
> on supplier unbind, it's fair to rename the existing flag from
> DL_FLAG_AUTOREMOVE to DL_FLAG_AUTOREMOVE_CONSUMER so that we can
> add similar flag for supplier later.
> And, while we are touching device.h, fix a doc build warning.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/driver-api/device_link.rst |  8 ++++----
>  drivers/base/core.c                      | 15 ++++++++-------
>  drivers/gpu/drm/tegra/dc.c               |  2 +-
>  drivers/gpu/ipu-v3/ipu-pre.c             |  3 ++-
>  drivers/gpu/ipu-v3/ipu-prg.c             |  3 ++-
>  drivers/soc/imx/gpc.c                    |  2 +-
>  include/linux/device.h                   | 12 ++++++------
>  7 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index 70e328e16aad..a005b904a264 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -81,10 +81,10 @@ integration is desired.
>  Two other flags are specifically targeted at use cases where the device
>  link is added from the consumer's ``->probe`` callback:  ``DL_FLAG_RPM_ACTIVE``
>  can be specified to runtime resume the supplier upon addition of the
> -device link.  ``DL_FLAG_AUTOREMOVE`` causes the device link to be automatically
> -purged when the consumer fails to probe or later unbinds.  This obviates
> -the need to explicitly delete the link in the ``->remove`` callback or in
> -the error path of the ``->probe`` callback.
> +device link.  ``DL_FLAG_AUTOREMOVE_CONSUMER`` causes the device link to be
> +automatically purged when the consumer fails to probe or later unbinds.
> +This obviates the need to explicitly delete the link in the ``->remove``
> +callback or in the error path of the ``->probe`` callback.
>
>  Limitations
>  ===========
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index df3e1a44707a..14c1e3151e08 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -178,10 +178,10 @@ void device_pm_move_to_tail(struct device *dev)
>   * of the link.  If DL_FLAG_PM_RUNTIME is not set, DL_FLAG_RPM_ACTIVE will be
>   * ignored.
>   *
> - * If the DL_FLAG_AUTOREMOVE is set, the link will be removed automatically
> - * when the consumer device driver unbinds from it.  The combination of both
> - * DL_FLAG_AUTOREMOVE and DL_FLAG_STATELESS set is invalid and will cause NULL
> - * to be returned.
> + * If the DL_FLAG_AUTOREMOVE_CONSUMER is set, the link will be removed
> + * automatically when the consumer device driver unbinds from it.
> + * The combination of both DL_FLAG_AUTOREMOVE_CONSUMER and DL_FLAG_STATELESS
> + * set is invalid and will cause NULL to be returned.
>   *
>   * A side effect of the link creation is re-ordering of dpm_list and the
>   * devices_kset list by moving the consumer device and all devices depending
> @@ -198,7 +198,8 @@ struct device_link *device_link_add(struct device *consumer,
>         struct device_link *link;
>
>         if (!consumer || !supplier ||
> -           ((flags & DL_FLAG_STATELESS) && (flags & DL_FLAG_AUTOREMOVE)))
> +           ((flags & DL_FLAG_STATELESS) &&
> +            (flags & DL_FLAG_AUTOREMOVE_CONSUMER)))
>                 return NULL;
>
>         device_links_write_lock();
> @@ -479,7 +480,7 @@ static void __device_links_no_driver(struct device *dev)
>                 if (link->flags & DL_FLAG_STATELESS)
>                         continue;
>
> -               if (link->flags & DL_FLAG_AUTOREMOVE)
> +               if (link->flags & DL_FLAG_AUTOREMOVE_CONSUMER)
>                         kref_put(&link->kref, __device_link_del);
>                 else if (link->status != DL_STATE_SUPPLIER_UNBIND)
>                         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
> @@ -515,7 +516,7 @@ void device_links_driver_cleanup(struct device *dev)
>                 if (link->flags & DL_FLAG_STATELESS)
>                         continue;
>
> -               WARN_ON(link->flags & DL_FLAG_AUTOREMOVE);
> +               WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
>                 WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
>                 WRITE_ONCE(link->status, DL_STATE_DORMANT);
>         }
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index c3afe7b2237e..965088afcfad 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -2312,7 +2312,7 @@ static int tegra_dc_couple(struct tegra_dc *dc)
>          * POWER_CONTROL registers during CRTC enabling.
>          */
>         if (dc->soc->coupled_pm && dc->pipe == 1) {
> -               u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE;
> +               u32 flags = DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER;
>                 struct device_link *link;
>                 struct device *partner;
>
> diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
> index 0f70e8847540..2f8db9d62551 100644
> --- a/drivers/gpu/ipu-v3/ipu-pre.c
> +++ b/drivers/gpu/ipu-v3/ipu-pre.c
> @@ -128,7 +128,8 @@ ipu_pre_lookup_by_phandle(struct device *dev, const char *name, int index)
>         list_for_each_entry(pre, &ipu_pre_list, list) {
>                 if (pre_node == pre->dev->of_node) {
>                         mutex_unlock(&ipu_pre_list_mutex);
> -                       device_link_add(dev, pre->dev, DL_FLAG_AUTOREMOVE);
> +                       device_link_add(dev, pre->dev,
> +                                       DL_FLAG_AUTOREMOVE_CONSUMER);
>                         of_node_put(pre_node);
>                         return pre;
>                 }
> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index 83f9dd934a5d..38a3a9764e49 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -100,7 +100,8 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
>         list_for_each_entry(prg, &ipu_prg_list, list) {
>                 if (prg_node == prg->dev->of_node) {
>                         mutex_unlock(&ipu_prg_list_mutex);
> -                       device_link_add(dev, prg->dev, DL_FLAG_AUTOREMOVE);
> +                       device_link_add(dev, prg->dev,
> +                                       DL_FLAG_AUTOREMOVE_CONSUMER);
>                         prg->id = ipu_id;
>                         of_node_put(prg_node);
>                         return prg;
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 32f0748fd067..aa9e65bc965e 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -202,7 +202,7 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
>                         goto genpd_err;
>         }
>
> -       device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE);
> +       device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE_CONSUMER);
>
>         return 0;
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 055a69dbcd18..3929805cdd59 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -90,7 +90,7 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
>   * @num_vf:    Called to find out how many virtual functions a device on this
>   *             bus supports.
>   * @dma_configure:     Called to setup DMA configuration on a device on
> -                       this bus.
> + *                     this bus.
>   * @pm:                Power management operations of this bus, callback the specific
>   *             device driver's pm-ops.
>   * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
> @@ -784,14 +784,14 @@ enum device_link_state {
>   * Device link flags.
>   *
>   * STATELESS: The core won't track the presence of supplier/consumer drivers.
> - * AUTOREMOVE: Remove this link automatically on consumer driver unbind.
> + * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>   * PM_RUNTIME: If set, the runtime PM framework will use this link.
>   * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
>   */
> -#define DL_FLAG_STATELESS      BIT(0)
> -#define DL_FLAG_AUTOREMOVE     BIT(1)
> -#define DL_FLAG_PM_RUNTIME     BIT(2)
> -#define DL_FLAG_RPM_ACTIVE     BIT(3)
> +#define DL_FLAG_STATELESS              BIT(0)
> +#define DL_FLAG_AUTOREMOVE_CONSUMER    BIT(1)
> +#define DL_FLAG_PM_RUNTIME             BIT(2)
> +#define DL_FLAG_RPM_ACTIVE             BIT(3)
>
>  /**
>   * struct device_link - Device link representation.
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
