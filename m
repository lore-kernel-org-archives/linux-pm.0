From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V7 06/12] thermal: tegra: add a debugfs to show registers
Date: Mon, 14 Mar 2016 12:08:40 -0700
Message-ID: <20160314190839.GB1872@localhost.localdomain>
References: <1457665835-29880-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1457665835-29880-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:10:35AM +0800, Wei Ni wrote:
> Add a debugfs interface to show register contents for debug.
>=20
> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 143 +++++++++++++++++++++++++++++++++=
+++++-
>  drivers/thermal/tegra/soctherm.h |   2 +
>  2 files changed, 142 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index 52a33760e8e8..02ac6d2e5a20 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -15,6 +15,7 @@
>   *
>   */
> =20
> +#include <linux/debugfs.h>
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -33,14 +34,18 @@
> =20
>  #define SENSOR_CONFIG0				0
>  #define SENSOR_CONFIG0_STOP			BIT(0)
> -#define SENSOR_CONFIG0_TALL_SHIFT		8
> -#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
> -#define SENSOR_CONFIG0_OVER			BIT(3)
>  #define SENSOR_CONFIG0_CPTR_OVER		BIT(2)
> +#define SENSOR_CONFIG0_OVER			BIT(3)
> +#define SENSOR_CONFIG0_TCALC_OVER		BIT(4)
> +#define SENSOR_CONFIG0_TALL_MASK		(0xfffff << 8)
> +#define SENSOR_CONFIG0_TALL_SHIFT		8
> =20
>  #define SENSOR_CONFIG1				4
> +#define SENSOR_CONFIG1_TSAMPLE_MASK		0x3ff
>  #define SENSOR_CONFIG1_TSAMPLE_SHIFT		0
> +#define SENSOR_CONFIG1_TIDDQ_EN_MASK		(0x3f << 15)
>  #define SENSOR_CONFIG1_TIDDQ_EN_SHIFT		15
> +#define SENSOR_CONFIG1_TEN_COUNT_MASK		(0x3f << 24)
>  #define SENSOR_CONFIG1_TEN_COUNT_SHIFT		24
>  #define SENSOR_CONFIG1_TEMP_ENABLE		BIT(31)
> =20
> @@ -49,6 +54,14 @@
>   * because, it will be used by tegra_soctherm_fuse.c
>   */
> =20
> +#define SENSOR_STATUS0				0xc
> +#define SENSOR_STATUS0_VALID_MASK		BIT(31)
> +#define SENSOR_STATUS0_CAPTURE_MASK		0xffff
> +
> +#define SENSOR_STATUS1				0x10
> +#define SENSOR_STATUS1_TEMP_VALID_MASK		BIT(31)
> +#define SENSOR_STATUS1_TEMP_MASK		0xffff
> +
>  #define READBACK_VALUE_MASK			0xff00
>  #define READBACK_VALUE_SHIFT			8
>  #define READBACK_ADD_HALF			BIT(7)
> @@ -73,6 +86,8 @@ struct tegra_soctherm {
> =20
>  	u32 *calib;
>  	struct tegra_soctherm_soc *soc;
> +
> +	struct dentry *debugfs_dir;
>  };
> =20
>  static int enable_tsensor(struct tegra_soctherm *tegra,
> @@ -140,6 +155,124 @@ static const struct thermal_zone_of_device_ops tegr=
a_of_thermal_ops =3D {
>  	.get_temp =3D tegra_thermctl_get_temp,
>  };
> =20
> +#ifdef CONFIG_DEBUG_FS
> +static int regs_show(struct seq_file *s, void *data)
> +{
> +	struct platform_device *pdev =3D s->private;
> +	struct tegra_soctherm *ts =3D platform_get_drvdata(pdev);
> +	const struct tegra_tsensor *tsensors =3D ts->soc->tsensors;
> +	u32 r, state;
> +	int i;
> +
> +	seq_puts(s, "-----TSENSE (convert HW)-----\n");
> +
> +	for (i =3D 0; i < ts->soc->num_tsensors; i++) {
> +		r =3D readl(ts->regs + tsensors[i].base + SENSOR_CONFIG1);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG1_TEMP_ENABLE);
> +		if (!state)
> +			continue;
> +
> +		seq_printf(s, "%s: ", tsensors[i].name);
> +
> +		seq_printf(s, "En(%d) ", state);


Shouldnt the above if (!state) be place right here?


> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG1_TIDDQ_EN_MASK);
> +		seq_printf(s, "tiddq(%d) ", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG1_TEN_COUNT_MASK);
> +		seq_printf(s, "ten_count(%d) ", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG1_TSAMPLE_MASK);
> +		seq_printf(s, "tsample(%d) ", state + 1);
> +
> +		r =3D readl(ts->regs + tsensors[i].base + SENSOR_STATUS1);
> +		state =3D REG_GET_MASK(r, SENSOR_STATUS1_TEMP_VALID_MASK);
> +		seq_printf(s, "Temp(%d/", state);
> +		state =3D REG_GET_MASK(r, SENSOR_STATUS1_TEMP_MASK);
> +		seq_printf(s, "%d) ", translate_temp(state));
> +
> +		r =3D readl(ts->regs + tsensors[i].base + SENSOR_STATUS0);
> +		state =3D REG_GET_MASK(r, SENSOR_STATUS0_VALID_MASK);
> +		seq_printf(s, "Capture(%d/", state);
> +		state =3D REG_GET_MASK(r, SENSOR_STATUS0_CAPTURE_MASK);
> +		seq_printf(s, "%d) ", state);
> +
> +		r =3D readl(ts->regs + tsensors[i].base + SENSOR_CONFIG0);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG0_STOP);
> +		seq_printf(s, "Stop(%d) ", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG0_TALL_MASK);
> +		seq_printf(s, "Tall(%d) ", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG0_TCALC_OVER);
> +		seq_printf(s, "Over(%d/", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG0_OVER);
> +		seq_printf(s, "%d/", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG0_CPTR_OVER);
> +		seq_printf(s, "%d) ", state);
> +
> +		r =3D readl(ts->regs + tsensors[i].base + SENSOR_CONFIG2);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG2_THERMA_MASK);
> +		seq_printf(s, "Therm_A/B(%d/", state);
> +		state =3D REG_GET_MASK(r, SENSOR_CONFIG2_THERMB_MASK);
> +		seq_printf(s, "%d)\n", (s16)state);
> +	}
> +
> +	r =3D readl(ts->regs + SENSOR_PDIV);
> +	seq_printf(s, "PDIV: 0x%x\n", r);

This is a matter of taste, but:

Why here %x but all the above %d?

Reg dumps are typically %x.
> +
> +	r =3D readl(ts->regs + SENSOR_HOTSPOT_OFF);
> +	seq_printf(s, "HOTSPOT: 0x%x\n", r);
> +
> +	seq_puts(s, "\n");
> +	seq_puts(s, "-----SOC_THERM-----\n");
> +
> +	r =3D readl(ts->regs + SENSOR_TEMP1);
> +	state =3D REG_GET_MASK(r, SENSOR_TEMP1_CPU_TEMP_MASK);
> +	seq_printf(s, "Temperatures: CPU(%d) ", translate_temp(state));

Maybe a line break before CPU, for consistency?

> +	state =3D REG_GET_MASK(r, SENSOR_TEMP1_GPU_TEMP_MASK);
> +	seq_printf(s, " GPU(%d) ", translate_temp(state));
> +	r =3D readl(ts->regs + SENSOR_TEMP2);
> +	state =3D REG_GET_MASK(r, SENSOR_TEMP2_PLLX_TEMP_MASK);
> +	seq_printf(s, " PLLX(%d) ", translate_temp(state));
> +	state =3D REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
> +	seq_printf(s, " MEM(%d)\n", translate_temp(state));
> +

I got confused, I thought you would the above mapped as tsensors[i]. I
will check the code again.


> +	return 0;
> +}
> +
> +static int regs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, regs_show, inode->i_private);
> +}
> +
> +static const struct file_operations regs_fops =3D {
> +	.open		=3D regs_open,
> +	.read		=3D seq_read,
> +	.llseek		=3D seq_lseek,
> +	.release	=3D single_release,
> +};
> +
> +static void soctherm_debug_init(struct platform_device *pdev)
> +{
> +	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> +	struct dentry *root, *file;
> +
> +	root =3D debugfs_create_dir("soctherm", NULL);
> +	if (!root) {
> +		dev_err(&pdev->dev, "failed to create debugfs directory\n");
> +		return;
> +	}
> +
> +	tegra->debugfs_dir =3D root;
> +
> +	file =3D debugfs_create_file("reg_contents", 0644, root,
> +				   pdev, &regs_fops);
> +	if (!file)
> +		dev_err(&pdev->dev, "failed to create debugfs file\n");

Are we leaving the 'soctherm' dir left uncleaned in fail path here?

> +}
> +#else
> +static inline void soctherm_debug_init(struct platform_device *pdev)
> +{
> +	return 0;

I dont think we need this return for a void function.

> +}
> +#endif
> +
>  static const struct of_device_id tegra_soctherm_of_match[] =3D {
>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>  	{
> @@ -279,6 +412,8 @@ static int tegra_soctherm_probe(struct platform_devic=
e *pdev)
>  		}
>  	}
> =20
> +	soctherm_debug_init(pdev);
> +
>  	return 0;
> =20
>  disable_clocks:
> @@ -292,6 +427,8 @@ static int tegra_soctherm_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct tegra_soctherm *tegra =3D platform_get_drvdata(pdev);
> =20
> +	debugfs_remove_recursive(tegra->debugfs_dir);
> +
>  	clk_disable_unprepare(tegra->clock_tsensor);
>  	clk_disable_unprepare(tegra->clock_soctherm);
> =20
> diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soc=
therm.h
> index 69d317269af1..ec4b87616d01 100644
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -16,7 +16,9 @@
>  #define __DRIVERS_THERMAL_TEGRA_SOCTHERM_H
> =20
>  #define SENSOR_CONFIG2                          8
> +#define SENSOR_CONFIG2_THERMA_MASK		(0xffff << 16)
>  #define SENSOR_CONFIG2_THERMA_SHIFT		16
> +#define SENSOR_CONFIG2_THERMB_MASK		0xffff
>  #define SENSOR_CONFIG2_THERMB_SHIFT		0
> =20
>  #define SENSOR_PDIV				0x1c0
> --=20
> 1.9.1
>=20

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5ww1AAoJEMLUO4d9pOJWQLQH/21UQecfD1JenRT8NV5bU4Mr
iQqkbiI+Si+RD4J8SGyHNxekCjkPHloPXZbwFnFRIW8zl8B/T5um37IW3eJAGerM
zXC8K3aPq0bTHwBr7+l5e+26BSMY2pTuf4XH74E96usnQWvReGCsGEGGCO3yBxx6
nMfO84VuNy00i5dGJmymGXiWEipYBP4Td4xBukcZMUC9TCOguIVIoUS9CbznBc8c
6Q/kOiMYgSC2F33xFXhoJGKzV1pWM5l9Lb/gpm/xrcpI0/X7XOUhBPUwFd0zWjVb
t50Tsizmg+4XG9DP8qBBvdhKYtxuTRGc/ROn5YNSQGJ85MV2sm9hFvMYzIjm5yk=
=9ptY
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
