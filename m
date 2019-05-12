From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Sun, 12 May 2019 06:06:35 +0000
Message-ID: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190510212937.11661-1-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, Mario Limonciello <Mario.Limonciello@dell.com>, lkml <linux-kernel@vger.kernel.org>, Kai Heng Feng <kai.heng.feng@canonical.com>, Rafael Wysocki <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Keith,=0A=
=0A=
Thanks for the patch, few comments below mostly nitpicks.=0A=
=0A=
On 5/10/19 2:35 PM, Keith Busch wrote:=0A=
> The nvme pci driver prepares its devices for power loss during suspend=0A=
> by shutting down the controllers, and the power setting is deferred to=0A=
> pci driver's power management before the platform removes power. The=0A=
> suspend-to-idle mode, however, does not remove power.=0A=
> =0A=
> NVMe devices that implement host managed power settings can achieve=0A=
> lower power and better transition latencies than using generic PCI=0A=
> power settings. Try to use this feature if the platform is not involved=
=0A=
> with the suspend. If successful, restore the previous power state on=0A=
> resume.=0A=
> =0A=
> Cc: Mario Limonciello <Mario.Limonciello@dell.com>=0A=
> Cc: Kai Heng Feng <kai.heng.feng@canonical.com>=0A=
> Signed-off-by: Keith Busch <keith.busch@intel.com>=0A=
> ---=0A=
> Disclaimer: I've tested only on emulation faking support for the feature.=
=0A=
> =0A=
> General question: different devices potentially have divergent values=0A=
> for power consumption and transition latencies. Would it be useful to=0A=
> allow a user tunable setting to select the desired target power state=0A=
> instead of assuming the lowest one?=0A=
> =0A=
>   drivers/nvme/host/core.c | 27 ++++++++++++++++++++++++=0A=
>   drivers/nvme/host/nvme.h |  2 ++=0A=
>   drivers/nvme/host/pci.c  | 53 +++++++++++++++++++++++++++++++++++++++++=
+++++++=0A=
>   3 files changed, 82 insertions(+)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index a6644a2c3ef7..eb3640fd8838 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1132,6 +1132,33 @@ static int nvme_set_features(struct nvme_ctrl *dev=
, unsigned fid, unsigned dword=0A=
>   	return ret;=0A=
>   }=0A=
>   =0A=
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)=0A=
dev->ctrl.npss is u8 can we use same data type here ?=0A=
If this is due to last_ps we use as a result and then call set_power may =
=0A=
be we can change the type of last_ps ?=0A=
OR=0A=
can we please use unsigned int to avoid possible warnings ?=0A=
> +{=0A=
> +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL)=
;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_set_power);=0A=
> +=0A=
> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)=0A=
> +{=0A=
> +	struct nvme_command c;=0A=
May be use struct nvme_command c {} so we can get rid of the memset() call.=
=0A=
> +	union nvme_result res;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!result)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	memset(&c, 0, sizeof(c));=0A=
> +	c.features.opcode =3D nvme_admin_get_features;=0A=
> +	c.features.fid =3D cpu_to_le32(NVME_FEAT_POWER_MGMT);=0A=
> +=0A=
> +	ret =3D __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,=0A=
> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);=0A=
> +	if (ret >=3D 0)=0A=
> +		*result =3D le32_to_cpu(res.u32);=0A=
May be add a check for result here in above if before deref pointer :-=0A=
	if (ret >=3D 0 && result)=0A=
=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(nvme_get_power);=0A=
> +=0A=
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)=0A=
>   {=0A=
>   	u32 q_count =3D (*count - 1) | ((*count - 1) << 16);=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 5ee75b5ff83f..eaa571ac06d2 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -459,6 +459,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, s=
truct nvme_command *cmd,=0A=
>   		unsigned timeout, int qid, int at_head,=0A=
>   		blk_mq_req_flags_t flags, bool poll);=0A=
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);=0A=
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps);=0A=
> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result);=0A=
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);=0A=
>   int nvme_reset_ctrl(struct nvme_ctrl *ctrl);=0A=
>   int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);=0A=
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c=0A=
> index 3e4fb891a95a..0d5d91e5b293 100644=0A=
> --- a/drivers/nvme/host/pci.c=0A=
> +++ b/drivers/nvme/host/pci.c=0A=
> @@ -18,6 +18,7 @@=0A=
>   #include <linux/mutex.h>=0A=
>   #include <linux/once.h>=0A=
>   #include <linux/pci.h>=0A=
> +#include <linux/suspend.h>=0A=
>   #include <linux/t10-pi.h>=0A=
>   #include <linux/types.h>=0A=
>   #include <linux/io-64-nonatomic-lo-hi.h>=0A=
> @@ -116,6 +117,7 @@ struct nvme_dev {=0A=
>   	u32 cmbsz;=0A=
>   	u32 cmbloc;=0A=
>   	struct nvme_ctrl ctrl;=0A=
> +	u32 last_ps;=0A=
>   =0A=
>   	mempool_t *iod_mempool;=0A=
>   =0A=
> @@ -2828,11 +2830,59 @@ static void nvme_remove(struct pci_dev *pdev)=0A=
>   }=0A=
>   =0A=
>   #ifdef CONFIG_PM_SLEEP=0A=
> +static int nvme_deep_state(struct nvme_dev *dev)=0A=
> +{=0A=
> +	struct pci_dev *pdev =3D to_pci_dev(dev->dev);=0A=
> +	int ret;=0A=
> +=0A=
> +	/*=0A=
> +	 * Save the current power state in case a user tool set a power policy=
=0A=
> +	 * for this device. We'll restore that state on resume.=0A=
> +	 */=0A=
> +	dev->last_ps =3D 0;=0A=
Should we only overwrite dev->last_ps value after nvme_get_power() is =0A=
successful and use temp variable to fetch the current power value in the =
=0A=
following call ?=0A=
> +	ret =3D nvme_get_power(&dev->ctrl, &dev->last_ps);=0A=
> +=0A=
> +	/*=0A=
> +	 * Return the error to halt suspend if the driver either couldn't=0A=
> +	 * submit a command or didn't see a response.=0A=
> +	 */=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
> +=0A=
> +	ret =3D nvme_set_power(&dev->ctrl, dev->ctrl.npss);=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
=0A=
> +=0A=
> +	if (!ret) {=0A=
> +		/*=0A=
> +		 * A saved state prevents pci pm from generically controlling=0A=
> +		 * the device's power. We're using protocol specific settings=0A=
> +		 * so we don't want pci interfering.=0A=
> +		 */=0A=
> +		pci_save_state(pdev);=0A=
> +	} else {=0A=
> +		/*=0A=
> +		 * The drive failed the low power request. Fallback to device=0A=
> +		 * shutdown and clear npss to force a controller reset on=0A=
> +		 * resume. The value will be rediscovered during reset.=0A=
> +		 */=0A=
> +		dev->ctrl.npss =3D 0;=0A=
> +		nvme_dev_disable(dev, true);=0A=
> +	}=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>   static int nvme_suspend(struct device *dev)=0A=
>   {=0A=
>   	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>   	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
>   =0A=
> +	/*=0A=
> +	 * Try to use nvme if the device supports host managed power settings=
=0A=
> +	 * and platform firmware is not involved.=0A=
> +	 */=0A=
> +	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)=0A=
> +		return nvme_deep_state(ndev);=0A=
>   	nvme_dev_disable(ndev, true);=0A=
>   	return 0;=0A=
>   }=0A=
> @@ -2842,6 +2892,9 @@ static int nvme_resume(struct device *dev)=0A=
>   	struct pci_dev *pdev =3D to_pci_dev(dev);=0A=
>   	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);=0A=
>   =0A=
> +	if (!pm_resume_via_firmware() && ndev->ctrl.npss)=0A=
> +		if (nvme_set_power(&ndev->ctrl, ndev->last_ps) =3D=3D 0)=0A=
> +			return 0;=0A=
>   	nvme_reset_ctrl(&ndev->ctrl);=0A=
>   	return 0;=0A=
>   }=0A=
> =0A=
=0A=
