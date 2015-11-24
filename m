From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate
 definitions
Date: Tue, 24 Nov 2015 11:50:38 +0200
Message-ID: <1448358638.15393.16.camel@linux.intel.com>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hock Leong Kweh <hock.leong.kweh@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-11-11 at 19:59 +0200, Andy Shevchenko wrote:
> The read and write opcodes are global for all units on SoC and even
> across
> Intel SoCs. Remove duplication of corresponding constants. At the
> same time
> convert all current users.
>=20
> No functional change.
>=20
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Hock Leong Kweh <hock.leong.kweh@intel.com>

Any concerns, anyone?

Btw, this patch has been tested on Intel BayTrail and Braswell.

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Since v1:
> - satisfy kbuild robot
>=20
> =C2=A0arch/x86/include/asm/iosf_mbi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 49 +++++----------=
---
> ----
> =C2=A0arch/x86/platform/atom/punit_atom_debug.c=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A07 +---
> =C2=A0arch/x86/platform/intel-quark/imr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 28 +++++--------
> =C2=A0drivers/i2c/busses/i2c-designware-baytrail.c | 17 +++-----
> =C2=A0drivers/powercap/intel_rapl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 ++---
> =C2=A0drivers/thermal/intel_quark_dts_thermal.c=C2=A0=C2=A0=C2=A0=C2=A0=
| 61 ++++++++++++++--
> ------------
> =C2=A0drivers/thermal/intel_soc_dts_iosf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 43 ++++++++++------
> ----
> =C2=A07 files changed, 85 insertions(+), 130 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/iosf_mbi.h
> b/arch/x86/include/asm/iosf_mbi.h
> index b72ad0f..cdc5f63 100644
> --- a/arch/x86/include/asm/iosf_mbi.h
> +++ b/arch/x86/include/asm/iosf_mbi.h
> @@ -1,5 +1,5 @@
> =C2=A0/*
> - * iosf_mbi.h: Intel OnChip System Fabric MailBox access support
> + * Intel OnChip System Fabric MailBox access support
> =C2=A0 */
> =C2=A0
> =C2=A0#ifndef IOSF_MBI_SYMS_H
> @@ -16,6 +16,16 @@
> =C2=A0#define MBI_MASK_LO		0x000000FF
> =C2=A0#define MBI_ENABLE		0xF0
> =C2=A0
> +/* IOSF SB read/write opcodes */
> +#define MBI_MMIO_READ		0x00
> +#define MBI_MMIO_WRITE		0x01
> +#define MBI_CR_READ		0x06
> +#define MBI_CR_WRITE		0x07
> +#define MBI_REG_READ		0x10
> +#define MBI_REG_WRITE		0x11
> +#define MBI_ESRAM_READ		0x12
> +#define MBI_ESRAM_WRITE		0x13
> +
> =C2=A0/* Baytrail available units */
> =C2=A0#define BT_MBI_UNIT_AUNIT	0x00
> =C2=A0#define BT_MBI_UNIT_SMC		0x01
> @@ -28,50 +38,13 @@
> =C2=A0#define BT_MBI_UNIT_SATA	0xA3
> =C2=A0#define BT_MBI_UNIT_PCIE	0xA6
> =C2=A0
> -/* Baytrail read/write opcodes */
> -#define BT_MBI_AUNIT_READ	0x10
> -#define BT_MBI_AUNIT_WRITE	0x11
> -#define BT_MBI_SMC_READ		0x10
> -#define BT_MBI_SMC_WRITE	0x11
> -#define BT_MBI_CPU_READ		0x10
> -#define BT_MBI_CPU_WRITE	0x11
> -#define BT_MBI_BUNIT_READ	0x10
> -#define BT_MBI_BUNIT_WRITE	0x11
> -#define BT_MBI_PMC_READ		0x06
> -#define BT_MBI_PMC_WRITE	0x07
> -#define BT_MBI_GFX_READ		0x00
> -#define BT_MBI_GFX_WRITE	0x01
> -#define BT_MBI_SMIO_READ	0x06
> -#define BT_MBI_SMIO_WRITE	0x07
> -#define BT_MBI_USB_READ		0x06
> -#define BT_MBI_USB_WRITE	0x07
> -#define BT_MBI_SATA_READ	0x00
> -#define BT_MBI_SATA_WRITE	0x01
> -#define BT_MBI_PCIE_READ	0x00
> -#define BT_MBI_PCIE_WRITE	0x01
> -
> =C2=A0/* Quark available units */
> =C2=A0#define QRK_MBI_UNIT_HBA	0x00
> =C2=A0#define QRK_MBI_UNIT_HB		0x03
> =C2=A0#define QRK_MBI_UNIT_RMU	0x04
> =C2=A0#define QRK_MBI_UNIT_MM		0x05
> -#define QRK_MBI_UNIT_MMESRAM	0x05
> =C2=A0#define QRK_MBI_UNIT_SOC	0x31
> =C2=A0
> -/* Quark read/write opcodes */
> -#define QRK_MBI_HBA_READ	0x10
> -#define QRK_MBI_HBA_WRITE	0x11
> -#define QRK_MBI_HB_READ		0x10
> -#define QRK_MBI_HB_WRITE	0x11
> -#define QRK_MBI_RMU_READ	0x10
> -#define QRK_MBI_RMU_WRITE	0x11
> -#define QRK_MBI_MM_READ		0x10
> -#define QRK_MBI_MM_WRITE	0x11
> -#define QRK_MBI_MMESRAM_READ	0x12
> -#define QRK_MBI_MMESRAM_WRITE	0x13
> -#define QRK_MBI_SOC_READ	0x06
> -#define QRK_MBI_SOC_WRITE	0x07
> -
> =C2=A0#if IS_ENABLED(CONFIG_IOSF_MBI)
> =C2=A0
> =C2=A0bool iosf_mbi_available(void);
> diff --git a/arch/x86/platform/atom/punit_atom_debug.c
> b/arch/x86/platform/atom/punit_atom_debug.c
> index 5ca8ead..81c769e 100644
> --- a/arch/x86/platform/atom/punit_atom_debug.c
> +++ b/arch/x86/platform/atom/punit_atom_debug.c
> @@ -25,8 +25,6 @@
> =C2=A0#include <asm/cpu_device_id.h>
> =C2=A0#include <asm/iosf_mbi.h>
> =C2=A0
> -/* Side band Interface port */
> -#define PUNIT_PORT		0x04
> =C2=A0/* Power gate status reg */
> =C2=A0#define PWRGT_STATUS		0x61
> =C2=A0/* Subsystem config/status Video processor */
> @@ -85,9 +83,8 @@ static int punit_dev_state_show(struct seq_file
> *seq_file, void *unused)
> =C2=A0
> =C2=A0	seq_puts(seq_file, "\n\nPUNIT NORTH COMPLEX DEVICES :\n");
> =C2=A0	while (punit_devp->name) {
> -		status =3D iosf_mbi_read(PUNIT_PORT, BT_MBI_PMC_READ,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0punit_devp->reg,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&punit_pwr_status);
> +		status =3D iosf_mbi_read(BT_MBI_UNIT_PMC,
> MBI_REG_READ,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0punit_devp->reg,
> &punit_pwr_status);
> =C2=A0		if (status) {
> =C2=A0			seq_printf(seq_file, "%9s : Read Failed\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0punit_devp->name);
> diff --git a/arch/x86/platform/intel-quark/imr.c
> b/arch/x86/platform/intel-quark/imr.c
> index 0ee619f..c1bdafa 100644
> --- a/arch/x86/platform/intel-quark/imr.c
> +++ b/arch/x86/platform/intel-quark/imr.c
> @@ -111,23 +111,19 @@ static int imr_read(struct imr_device *idev,
> u32 imr_id, struct imr_regs *imr)
> =C2=A0	u32 reg =3D imr_id * IMR_NUM_REGS + idev->reg_base;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, QRK_MBI_MM_READ,
> -				reg++, &imr->addr_lo);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, MBI_REG_READ, reg++,
> &imr->addr_lo);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, QRK_MBI_MM_READ,
> -				reg++, &imr->addr_hi);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, MBI_REG_READ, reg++,
> &imr->addr_hi);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, QRK_MBI_MM_READ,
> -				reg++, &imr->rmask);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_MM, MBI_REG_READ, reg++,
> &imr->rmask);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	return iosf_mbi_read(QRK_MBI_UNIT_MM, QRK_MBI_MM_READ,
> -				reg++, &imr->wmask);
> +	return iosf_mbi_read(QRK_MBI_UNIT_MM, MBI_REG_READ, reg++,
> &imr->wmask);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -151,31 +147,27 @@ static int imr_write(struct imr_device *idev,
> u32 imr_id,
> =C2=A0
> =C2=A0	local_irq_save(flags);
> =C2=A0
> -	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, QRK_MBI_MM_WRITE,
> reg++,
> -				imr->addr_lo);
> +	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, MBI_REG_WRITE, reg++,
> imr->addr_lo);
> =C2=A0	if (ret)
> =C2=A0		goto failed;
> =C2=A0
> -	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, QRK_MBI_MM_WRITE,
> -				reg++, imr->addr_hi);
> +	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, MBI_REG_WRITE, reg++,
> imr->addr_hi);
> =C2=A0	if (ret)
> =C2=A0		goto failed;
> =C2=A0
> -	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, QRK_MBI_MM_WRITE,
> -				reg++, imr->rmask);
> +	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, MBI_REG_WRITE, reg++,
> imr->rmask);
> =C2=A0	if (ret)
> =C2=A0		goto failed;
> =C2=A0
> -	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, QRK_MBI_MM_WRITE,
> -				reg++, imr->wmask);
> +	ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, MBI_REG_WRITE, reg++,
> imr->wmask);
> =C2=A0	if (ret)
> =C2=A0		goto failed;
> =C2=A0
> =C2=A0	/* Lock bit must be set separately to addr_lo address bits.
> */
> =C2=A0	if (lock) {
> =C2=A0		imr->addr_lo |=3D IMR_LOCK;
> -		ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM,
> QRK_MBI_MM_WRITE,
> -					reg - IMR_NUM_REGS, imr-
> >addr_lo);
> +		ret =3D iosf_mbi_write(QRK_MBI_UNIT_MM, MBI_REG_WRITE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg - IMR_NUM_REGS, imr-
> >addr_lo);
> =C2=A0		if (ret)
> =C2=A0			goto failed;
> =C2=A0	}
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c
> b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 7d7ae97..e38c2bb 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -34,8 +34,7 @@ static int get_sem(struct device *dev, u32 *sem)
> =C2=A0	u32 data;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> PUNIT_SEMAPHORE,
> -				&data);
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &data);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev, "iosf failed to read punit
> semaphore\n");
> =C2=A0		return ret;
> @@ -50,21 +49,19 @@ static void reset_semaphore(struct device *dev)
> =C2=A0{
> =C2=A0	u32 data;
> =C2=A0
> -	if (iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> -				PUNIT_SEMAPHORE, &data)) {
> +	if (iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &data)) {
> =C2=A0		dev_err(dev, "iosf failed to reset punit semaphore
> during read\n");
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> =C2=A0	data &=3D ~PUNIT_SEMAPHORE_BIT;
> -	if (iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> -				PUNIT_SEMAPHORE, data))
> +	if (iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> PUNIT_SEMAPHORE, data))
> =C2=A0		dev_err(dev, "iosf failed to reset punit semaphore
> during write\n");
> =C2=A0}
> =C2=A0
> =C2=A0static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
> =C2=A0{
> -	u32 sem;
> +	u32 sem =3D PUNIT_SEMAPHORE_ACQUIRE;
> =C2=A0	int ret;
> =C2=A0	unsigned long start, end;
> =C2=A0
> @@ -77,8 +74,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> *dev)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	/* host driver writes to side band semaphore register */
> -	ret =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> -				PUNIT_SEMAPHORE,
> PUNIT_SEMAPHORE_ACQUIRE);
> +	ret =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> PUNIT_SEMAPHORE, sem);
> =C2=A0	if (ret) {
> =C2=A0		dev_err(dev->dev, "iosf punit semaphore request
> failed\n");
> =C2=A0		return ret;
> @@ -102,8 +98,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev
> *dev)
> =C2=A0	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
> =C2=A0	reset_semaphore(dev->dev);
> =C2=A0
> -	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> -				PUNIT_SEMAPHORE, &sem);
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> PUNIT_SEMAPHORE, &sem);
> =C2=A0	if (ret)
> =C2=A0		dev_err(dev->dev, "iosf failed to read punit
> semaphore\n");
> =C2=A0	else
> diff --git a/drivers/powercap/intel_rapl.c
> b/drivers/powercap/intel_rapl.c
> index cc97f08..fa07809 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -988,16 +988,16 @@ static void set_floor_freq_atom(struct
> rapl_domain *rd, bool enable)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!power_ctrl_orig_val)
> -		iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_PMC_READ,
> -			rapl_defaults->floor_freq_reg_addr,
> -				&power_ctrl_orig_val);
> +		iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_CR_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rapl_defaults->floor_freq_reg=
_addr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&power_ctrl_orig_val);
> =C2=A0	mdata =3D power_ctrl_orig_val;
> =C2=A0	if (enable) {
> =C2=A0		mdata &=3D ~(0x7f << 8);
> =C2=A0		mdata |=3D 1 << 8;
> =C2=A0	}
> -	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_PMC_WRITE,
> -		rapl_defaults->floor_freq_reg_addr, mdata);
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rapl_defaults->floor_fre=
q_reg_addr, mdata);
> =C2=A0}
> =C2=A0
> =C2=A0static u64 rapl_compute_time_window_core(struct rapl_package *r=
p,
> u64 value,
> diff --git a/drivers/thermal/intel_quark_dts_thermal.c
> b/drivers/thermal/intel_quark_dts_thermal.c
> index 5ed90e6..5d33b35 100644
> --- a/drivers/thermal/intel_quark_dts_thermal.c
> +++ b/drivers/thermal/intel_quark_dts_thermal.c
> @@ -125,8 +125,8 @@ static int soc_dts_enable(struct
> thermal_zone_device *tzd)
> =C2=A0	struct soc_sensor_entry *aux_entry =3D tzd->devdata;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> &out);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENABLE, &out);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -137,8 +137,8 @@ static int soc_dts_enable(struct
> thermal_zone_device *tzd)
> =C2=A0
> =C2=A0	if (!aux_entry->locked) {
> =C2=A0		out |=3D QRK_DTS_ENABLE_BIT;
> -		ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_WRITE,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> out);
> +		ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU,
> MBI_REG_WRITE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENABLE,
> out);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> @@ -158,8 +158,8 @@ static int soc_dts_disable(struct
> thermal_zone_device *tzd)
> =C2=A0	struct soc_sensor_entry *aux_entry =3D tzd->devdata;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> &out);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENABLE, &out);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -170,8 +170,8 @@ static int soc_dts_disable(struct
> thermal_zone_device *tzd)
> =C2=A0
> =C2=A0	if (!aux_entry->locked) {
> =C2=A0		out &=3D ~QRK_DTS_ENABLE_BIT;
> -		ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_WRITE,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> out);
> +		ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU,
> MBI_REG_WRITE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENABLE,
> out);
> =C2=A0
> =C2=A0		if (ret)
> =C2=A0			return ret;
> @@ -192,8 +192,8 @@ static int _get_trip_temp(int trip, int *temp)
> =C2=A0	u32 out;
> =C2=A0
> =C2=A0	mutex_lock(&dts_update_mutex);
> -	status =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -				QRK_DTS_REG_OFFSET_PTPS, &out);
> +	status =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_PTPS=
, &out);
> =C2=A0	mutex_unlock(&dts_update_mutex);
> =C2=A0
> =C2=A0	if (status)
> @@ -236,8 +236,8 @@ static int update_trip_temp(struct
> soc_sensor_entry *aux_entry,
> =C2=A0		goto failed;
> =C2=A0	}
> =C2=A0
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -				QRK_DTS_REG_OFFSET_PTPS,
> &store_ptps);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_PTPS, &store_ptps);
> =C2=A0	if (ret)
> =C2=A0		goto failed;
> =C2=A0
> @@ -262,8 +262,8 @@ static int update_trip_temp(struct
> soc_sensor_entry *aux_entry,
> =C2=A0	out |=3D (temp_out & QRK_DTS_MASK_TP_THRES) <<
> =C2=A0		(trip * QRK_DTS_SHIFT_TP);
> =C2=A0
> -	ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_WRITE,
> -				QRK_DTS_REG_OFFSET_PTPS, out);
> +	ret =3D iosf_mbi_write(QRK_MBI_UNIT_RMU, MBI_REG_WRITE,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_PTPS, out);
> =C2=A0
> =C2=A0failed:
> =C2=A0	mutex_unlock(&dts_update_mutex);
> @@ -294,8 +294,8 @@ static int sys_get_curr_temp(struct
> thermal_zone_device *tzd,
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	mutex_lock(&dts_update_mutex);
> -	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_TEMP,
> &out);
> +	ret =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_TEMP, &out);
> =C2=A0	mutex_unlock(&dts_update_mutex);
> =C2=A0
> =C2=A0	if (ret)
> @@ -350,13 +350,13 @@ static void free_soc_dts(struct
> soc_sensor_entry *aux_entry)
> =C2=A0	if (aux_entry) {
> =C2=A0		if (!aux_entry->locked) {
> =C2=A0			mutex_lock(&dts_update_mutex);
> -			iosf_mbi_write(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_WRITE,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> -					aux_entry-
> >store_dts_enable);
> +			iosf_mbi_write(QRK_MBI_UNIT_RMU,
> MBI_REG_WRITE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENA=
BLE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aux_entry->store_dts_e=
nable);
> =C2=A0
> -			iosf_mbi_write(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_WRITE,
> -					QRK_DTS_REG_OFFSET_PTPS,
> -					aux_entry->store_ptps);
> +			iosf_mbi_write(QRK_MBI_UNIT_RMU,
> MBI_REG_WRITE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_PTP=
S,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0aux_entry->store_ptps)=
;
> =C2=A0			mutex_unlock(&dts_update_mutex);
> =C2=A0		}
> =C2=A0		thermal_zone_device_unregister(aux_entry->tzone);
> @@ -378,9 +378,8 @@ static struct soc_sensor_entry
> *alloc_soc_dts(void)
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Check if DTS register is locked */
> -	err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_LOCK,
> -					&out);
> +	err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_LOCK, &out);
> =C2=A0	if (err)
> =C2=A0		goto err_ret;
> =C2=A0
> @@ -395,16 +394,16 @@ static struct soc_sensor_entry
> *alloc_soc_dts(void)
> =C2=A0	/* Store DTS default state if DTS registers are not locked
> */
> =C2=A0	if (!aux_entry->locked) {
> =C2=A0		/* Store DTS default enable for restore on exit */
> -		err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_ENABLE,
> -					&aux_entry-
> >store_dts_enable);
> +		err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +				=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_ENABLE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0&aux_entry->store_dts_enable);
> =C2=A0		if (err)
> =C2=A0			goto err_ret;
> =C2=A0
> =C2=A0		/* Store DTS default PTPS register for restore on
> exit */
> -		err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU,
> QRK_MBI_RMU_READ,
> -					QRK_DTS_REG_OFFSET_PTPS,
> -					&aux_entry->store_ptps);
> +		err =3D iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
> +				=C2=A0=C2=A0=C2=A0=C2=A0QRK_DTS_REG_OFFSET_PTPS,
> +				=C2=A0=C2=A0=C2=A0=C2=A0&aux_entry->store_ptps);
> =C2=A0		if (err)
> =C2=A0			goto err_ret;
> =C2=A0	}
> diff --git a/drivers/thermal/intel_soc_dts_iosf.c
> b/drivers/thermal/intel_soc_dts_iosf.c
> index 5841d1d..f72e1db 100644
> --- a/drivers/thermal/intel_soc_dts_iosf.c
> +++ b/drivers/thermal/intel_soc_dts_iosf.c
> @@ -90,7 +90,7 @@ static int sys_get_trip_temp(struct
> thermal_zone_device *tzd, int trip,
> =C2=A0	dts =3D tzd->devdata;
> =C2=A0	sensors =3D dts->sensors;
> =C2=A0	mutex_lock(&sensors->dts_update_lock);
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTP=
S, &out);
> =C2=A0	mutex_unlock(&sensors->dts_update_lock);
> =C2=A0	if (status)
> @@ -124,27 +124,27 @@ static int update_trip_temp(struct
> intel_soc_dts_sensor_entry *dts,
> =C2=A0
> =C2=A0	temp_out =3D (sensors->tj_max - temp) / 1000;
> =C2=A0
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTP=
S, &store_ptps);
> =C2=A0	if (status)
> =C2=A0		return status;
> =C2=A0
> =C2=A0	out =3D (store_ptps & ~(0xFF << (thres_index * 8)));
> =C2=A0	out |=3D (temp_out & 0xFF) << (thres_index * 8);
> -	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0				SOC_DTS_OFFSET_PTPS, out);
> =C2=A0	if (status)
> =C2=A0		return status;
> =C2=A0
> =C2=A0	pr_debug("update_trip_temp PTPS =3D %x\n", out);
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTM=
C, &out);
> =C2=A0	if (status)
> =C2=A0		goto err_restore_ptps;
> =C2=A0
> =C2=A0	store_ptmc =3D out;
> =C2=A0
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_TE_AUX0 + =
thres_index,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&te_out);
> =C2=A0	if (status)
> @@ -167,12 +167,12 @@ static int update_trip_temp(struct
> intel_soc_dts_sensor_entry *dts,
> =C2=A0			out &=3D ~SOC_DTS_AUX0_ENABLE_BIT;
> =C2=A0		te_out &=3D ~int_enable_bit;
> =C2=A0	}
> -	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0				SOC_DTS_OFFSET_PTMC, out);
> =C2=A0	if (status)
> =C2=A0		goto err_restore_te_out;
> =C2=A0
> -	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0				SOC_DTS_TE_AUX0 + thres_index,
> =C2=A0				te_out);
> =C2=A0	if (status)
> @@ -182,13 +182,13 @@ static int update_trip_temp(struct
> intel_soc_dts_sensor_entry *dts,
> =C2=A0
> =C2=A0	return 0;
> =C2=A0err_restore_te_out:
> -	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTMC=
, store_te_out);
> =C2=A0err_restore_ptmc:
> -	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTMC=
, store_ptmc);
> =C2=A0err_restore_ptps:
> -	iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTPS=
, store_ptps);
> =C2=A0	/* Nothing we can do if restore fails */
> =C2=A0
> @@ -235,7 +235,7 @@ static int sys_get_curr_temp(struct
> thermal_zone_device *tzd,
> =C2=A0
> =C2=A0	dts =3D tzd->devdata;
> =C2=A0	sensors =3D dts->sensors;
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_TEM=
P, &out);
> =C2=A0	if (status)
> =C2=A0		return status;
> @@ -259,14 +259,14 @@ static int soc_dts_enable(int id)
> =C2=A0	u32 out;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_ENABLE, &out);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	if (!(out & BIT(id))) {
> =C2=A0		out |=3D BIT(id);
> -		ret =3D iosf_mbi_write(BT_MBI_UNIT_PMC,
> BT_MBI_BUNIT_WRITE,
> +		ret =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_ENABLE, out);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> @@ -278,7 +278,7 @@ static int soc_dts_enable(int id)
> =C2=A0static void remove_dts_thermal_zone(struct
> intel_soc_dts_sensor_entry *dts)
> =C2=A0{
> =C2=A0	if (dts) {
> -		iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +		iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_ENA=
BLE, dts-
> >store_status);
> =C2=A0		thermal_zone_device_unregister(dts->tzone);
> =C2=A0	}
> @@ -296,9 +296,8 @@ static int add_dts_thermal_zone(int id, struct
> intel_soc_dts_sensor_entry *dts,
> =C2=A0	int i;
> =C2=A0
> =C2=A0	/* Store status to restor on exit */
> -	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> -			=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_ENABLE,
> -			=C2=A0=C2=A0=C2=A0=C2=A0&dts->store_status);
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> +			=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_ENABLE, &dts-
> >store_status);
> =C2=A0	if (ret)
> =C2=A0		goto err_ret;
> =C2=A0
> @@ -311,7 +310,7 @@ static int add_dts_thermal_zone(int id, struct
> intel_soc_dts_sensor_entry *dts,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Check if the writable trip we provide is not used by BIOS
> */
> -	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	ret =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTPS, &store_ptps);
> =C2=A0	if (ret)
> =C2=A0		trip_mask =3D 0;
> @@ -374,19 +373,19 @@ void
> intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors
> *sensors)
> =C2=A0
> =C2=A0	spin_lock_irqsave(&sensors->intr_notify_lock, flags);
> =C2=A0
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTM=
C, &ptmc_out);
> =C2=A0	ptmc_out |=3D SOC_DTS_PTMC_APIC_DEASSERT_BIT;
> -	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_WRITE,
> +	status =3D iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> =C2=A0				SOC_DTS_OFFSET_PTMC, ptmc_out);
> =C2=A0
> -	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> +	status =3D iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SOC_DTS_OFFSET_PTT=
SS, &sticky_out);
> =C2=A0	pr_debug("status %d PTTSS %x\n", status, sticky_out);
> =C2=A0	if (sticky_out & SOC_DTS_TRIP_MASK) {
> =C2=A0		int i;
> =C2=A0		/* reset sticky bit */
> -		status =3D iosf_mbi_write(BT_MBI_UNIT_PMC,
> BT_MBI_BUNIT_WRITE,
> +		status =3D iosf_mbi_write(BT_MBI_UNIT_PMC,
> MBI_REG_WRITE,
> =C2=A0					SOC_DTS_OFFSET_PTTSS,
> sticky_out);
> =C2=A0		spin_unlock_irqrestore(&sensors->intr_notify_lock,
> flags);
> =C2=A0

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
