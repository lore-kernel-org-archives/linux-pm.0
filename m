From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] nvme/pci: Use host managed power state for suspend
Date: Sat, 11 May 2019 00:52:02 +0000
Message-ID: <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
References: <20190510212937.11661-1-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510212937.11661-1-keith.busch@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: keith.busch@intel.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kai.heng.feng@canonical.com
List-Id: linux-pm@vger.kernel.org

>=20
> Cc: Mario Limonciello <Mario.Limonciello@dell.com>
> Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
> Disclaimer: I've tested only on emulation faking support for the feature.

Thanks for sharing.  I'll arrange some testing with this with storage partn=
ers early=20
next week.

>=20
> General question: different devices potentially have divergent values for=
 power
> consumption and transition latencies. Would it be useful to allow a user =
tunable
> setting to select the desired target power state instead of assuming the =
lowest
> one?

Since this action only happens on the way down to suspend to idle I don't t=
hink
there is a lot of value in configuring this to be user tunable which state =
is used.

If you don't go into the deepest state for NVME, at least on Intel the PCH =
generally
won't be able to go into its deepest state either.

>=20
>  drivers/nvme/host/core.c | 27 ++++++++++++++++++++++++
> drivers/nvme/host/nvme.h |  2 ++  drivers/nvme/host/pci.c  | 53
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
> a6644a2c3ef7..eb3640fd8838 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1132,6 +1132,33 @@ static int nvme_set_features(struct nvme_ctrl *dev=
,
> unsigned fid, unsigned dword
>  	return ret;
>  }
>=20
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps) {
> +	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL,
> 0,
> +NULL); } EXPORT_SYMBOL_GPL(nvme_set_power);
> +
> +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result) {
> +	struct nvme_command c;
> +	union nvme_result res;
> +	int ret;
> +
> +	if (!result)
> +		return -EINVAL;
> +
> +	memset(&c, 0, sizeof(c));
> +	c.features.opcode =3D nvme_admin_get_features;
> +	c.features.fid =3D cpu_to_le32(NVME_FEAT_POWER_MGMT);
> +
> +	ret =3D __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> +	if (ret >=3D 0)
> +		*result =3D le32_to_cpu(res.u32);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_get_power);
> +
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)  {
>  	u32 q_count =3D (*count - 1) | ((*count - 1) << 16); diff --git
> a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index
> 5ee75b5ff83f..eaa571ac06d2 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,6 +459,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q,
> struct nvme_command *cmd,
>  		unsigned timeout, int qid, int at_head,
>  		blk_mq_req_flags_t flags, bool poll);  int
> nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
> +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps); int
> +nvme_get_power(struct nvme_ctrl *ctrl, u32 *result);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);  int nvme_reset_ctrl(=
struct
> nvme_ctrl *ctrl);  int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl); diff=
 --git
> a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> 3e4fb891a95a..0d5d91e5b293 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -18,6 +18,7 @@
>  #include <linux/mutex.h>
>  #include <linux/once.h>
>  #include <linux/pci.h>
> +#include <linux/suspend.h>
>  #include <linux/t10-pi.h>
>  #include <linux/types.h>
>  #include <linux/io-64-nonatomic-lo-hi.h> @@ -116,6 +117,7 @@ struct
> nvme_dev {
>  	u32 cmbsz;
>  	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
> +	u32 last_ps;
>=20
>  	mempool_t *iod_mempool;
>=20
> @@ -2828,11 +2830,59 @@ static void nvme_remove(struct pci_dev *pdev)  }
>=20
>  #ifdef CONFIG_PM_SLEEP
> +static int nvme_deep_state(struct nvme_dev *dev) {
> +	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
> +	int ret;
> +
> +	/*
> +	 * Save the current power state in case a user tool set a power policy
> +	 * for this device. We'll restore that state on resume.
> +	 */
> +	dev->last_ps =3D 0;
> +	ret =3D nvme_get_power(&dev->ctrl, &dev->last_ps);
> +
> +	/*
> +	 * Return the error to halt suspend if the driver either couldn't
> +	 * submit a command or didn't see a response.
> +	 */
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D nvme_set_power(&dev->ctrl, dev->ctrl.npss);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!ret) {
> +		/*
> +		 * A saved state prevents pci pm from generically controlling
> +		 * the device's power. We're using protocol specific settings
> +		 * so we don't want pci interfering.
> +		 */
> +		pci_save_state(pdev);
> +	} else {
> +		/*
> +		 * The drive failed the low power request. Fallback to device
> +		 * shutdown and clear npss to force a controller reset on
> +		 * resume. The value will be rediscovered during reset.
> +		 */
> +		dev->ctrl.npss =3D 0;
> +		nvme_dev_disable(dev, true);
> +	}
> +	return 0;
> +}
> +
>  static int nvme_suspend(struct device *dev)  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
>=20
> +	/*
> +	 * Try to use nvme if the device supports host managed power settings
> +	 * and platform firmware is not involved.
> +	 */
> +	if (!pm_suspend_via_firmware() && ndev->ctrl.npss)
> +		return nvme_deep_state(ndev);
>  	nvme_dev_disable(ndev, true);
>  	return 0;
>  }
> @@ -2842,6 +2892,9 @@ static int nvme_resume(struct device *dev)
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
>  	struct nvme_dev *ndev =3D pci_get_drvdata(pdev);
>=20
> +	if (!pm_resume_via_firmware() && ndev->ctrl.npss)
> +		if (nvme_set_power(&ndev->ctrl, ndev->last_ps) =3D=3D 0)
> +			return 0;
>  	nvme_reset_ctrl(&ndev->ctrl);
>  	return 0;
>  }
> --
> 2.14.4
