From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] cpufreq: Add Tegra186 cpufreq driver
Date: Mon, 3 Apr 2017 16:47:04 +0200
Message-ID: <20170403144704.GB22966@ulmo.ba.sec>
References: <1491223345-24386-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491223345-24386-1-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 03:42:23PM +0300, Mikko Perttunen wrote:
> Add a new cpufreq driver for Tegra186 (and likely later).
> The CPUs are organized into two clusters, Denver and A57,
> with two and four cores respectively. CPU frequency can be
> adjusted by writing the desired rate divisor and a voltage
> hint to a special per-core register.
>=20
> The frequency of each core can be set individually; however,
> this is just a hint as all CPUs in a cluster will run at
> the maximum rate of non-idle CPUs in the cluster.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/cpufreq/Kconfig.arm        |   7 +
>  drivers/cpufreq/Makefile           |   1 +
>  drivers/cpufreq/tegra186-cpufreq.c | 277 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 285 insertions(+)
>  create mode 100644 drivers/cpufreq/tegra186-cpufreq.c
>=20
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 74fa5c5904d3..168d36fa4a58 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -247,6 +247,13 @@ config ARM_TEGRA124_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for Tegra124 SOCs.
> =20
> +config ARM_TEGRA186_CPUFREQ
> +	tristate "Tegra186 CPUFreq support"
> +	depends on ARCH_TEGRA && TEGRA_BPMP
> +	default y

I'd rather not default this to "y". We can use the defconfig to enable
this.

> +	help
> +	  This adds the CPUFreq driver support for Tegra186 SOCs.
> +
>  config ARM_TI_CPUFREQ
>  	bool "Texas Instruments CPUFreq support"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9f5a8045f36d..b7e78f063c4f 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+=3D spear-cpufreq.o
>  obj-$(CONFIG_ARM_STI_CPUFREQ)		+=3D sti-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+=3D tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+=3D tegra124-cpufreq.o
> +obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+=3D tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+=3D ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+=3D vexpress-spc-cpufreq.o
>  obj-$(CONFIG_ACPI_CPPC_CPUFREQ) +=3D cppc_cpufreq.o
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra18=
6-cpufreq.c
> new file mode 100644
> index 000000000000..794c1f2d8231
> --- /dev/null
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -0,0 +1,277 @@
> +/*
> + * Copyright (c) 2017, NVIDIA CORPORATION. All rights reserved
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +
> +#define EDVD_CORE_VOLT_FREQ(core)		(0x20 + (core) * 0x4)
> +#define EDVD_CORE_VOLT_FREQ_F_SHIFT		0
> +#define EDVD_CORE_VOLT_FREQ_F_MASK		0xff
> +#define EDVD_CORE_VOLT_FREQ_V_SHIFT		16
> +#define EDVD_CORE_VOLT_FREQ_V_MASK		0xff
> +
> +#define CLUSTER_DENVER				0
> +#define CLUSTER_A57				1
> +#define NUM_CLUSTERS				2
> +
> +struct tegra186_cpufreq_cluster {
> +	const char *name;
> +	unsigned int num_cores;
> +};
> +
> +static const struct tegra186_cpufreq_cluster CLUSTERS[] =3D {

We don't usually use uppercase letters for variable names.

> +	{
> +		.name =3D "denver",
> +		.num_cores =3D 2,
> +	},
> +	{
> +		.name =3D "a57",
> +		.num_cores =3D 4,
> +	}
> +};
> +
> +struct tegra186_cpufreq_data {
> +	void __iomem *regs[NUM_CLUSTERS];
> +	struct cpufreq_frequency_table *tables[NUM_CLUSTERS];
> +};

Given my comments regarding the aperture, perhaps it would be useful to
only have a single range of memory-mapped registers and add an offset to
struct tegra186_cpufreq_cluster that points into that region?

Also, you're somewhat mixing arrays of NUM_CLUSTERS elements and
dynamically sized ones (CLUSTERS[]). Probably best to just stick to one
of them.

Might be worth considering to dynamically allocate based on the cluster
table, but that could be done in a separate patch if we ever get a
configuration where NUM_CLUSTERS !=3D 2.

> +static void get_cluster_core(int cpu, int *cluster, int *core)

These can all be unsigned int.

> +{
> +	switch (cpu) {
> +	case 0:
> +		*cluster =3D CLUSTER_A57; *core =3D 0; break;
> +	case 3:
> +		*cluster =3D CLUSTER_A57; *core =3D 1; break;
> +	case 4:
> +		*cluster =3D CLUSTER_A57; *core =3D 2; break;
> +	case 5:
> +		*cluster =3D CLUSTER_A57; *core =3D 3; break;
> +	case 1:
> +		*cluster =3D CLUSTER_DENVER; *core =3D 0; break;
> +	case 2:
> +		*cluster =3D CLUSTER_DENVER; *core =3D 1; break;
> +	}
> +}

This is weirdly formatted. Also, what if cpu > 5? Do we need to be
careful and WARN_ON()?

Perhaps in order to make this more easily extensible this could go
into struct tegra186_cpufreq_cluster? Or a separate table that has
information about the cluster and a list of CPUs?

Again, probably not necessary right away, but something to keep in
mind for parameterization if we ever need to support other configs.

> +static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> +	struct cpufreq_frequency_table *table;
> +	int cluster, core;
> +
> +	get_cluster_core(policy->cpu, &cluster, &core);
> +
> +	table =3D data->tables[cluster];
> +	cpufreq_table_validate_and_show(policy, table);
> +
> +	policy->cpuinfo.transition_latency =3D 300 * 1000;
> +
> +	return 0;
> +}
> +
> +static void write_volt_freq(uint8_t vidx, uint8_t ndiv, void __iomem *re=
gs,

uint8_t -> u8

> +			unsigned int core)
> +{
> +	u32 val =3D 0;
> +
> +	val |=3D ndiv << EDVD_CORE_VOLT_FREQ_F_SHIFT;
> +	val |=3D vidx << EDVD_CORE_VOLT_FREQ_V_SHIFT;
> +
> +	writel(val, regs + EDVD_CORE_VOLT_FREQ(core));
> +}
> +
> +static int tegra186_cpufreq_set_target(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_frequency_table *tbl =3D policy->freq_table + index;
> +	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> +	uint16_t vidx =3D tbl->driver_data >> 16;
> +	uint16_t ndiv =3D tbl->driver_data & 0xffff;

uint16_t -> u16

Also it's slightly strange that you store u16 here and pass it to a
function that takes

> +	int cluster, core;
> +
> +	get_cluster_core(policy->cpu, &cluster, &core);
> +	write_volt_freq(vidx, ndiv, data->regs[cluster], core);
> +
> +	return 0;
> +}
> +
> +static struct cpufreq_driver tegra186_cpufreq_driver =3D {
> +	.name =3D "tegra186",
> +	.flags =3D CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify =3D cpufreq_generic_frequency_table_verify,
> +	.target_index =3D tegra186_cpufreq_set_target,
> +	.init =3D tegra186_cpufreq_init,
> +	.attr =3D cpufreq_generic_attr,
> +};
> +
> +static int init_vhint_table(struct platform_device *pdev,
> +			    struct tegra_bpmp *bpmp, uint32_t cluster_id,
> +			    struct cpufreq_frequency_table **table)
> +{
> +	struct mrq_cpu_vhint_request req;
> +	struct tegra_bpmp_message msg;
> +	struct cpu_vhint_data *data;
> +	int err, i, j, num_rates;
> +	dma_addr_t phys;
> +	void *virt;
> +
> +	virt =3D dma_alloc_coherent(bpmp->dev, MSG_DATA_MIN_SZ, &phys,
> +				  GFP_KERNEL | GFP_DMA32);
> +	if (!virt)
> +		return -ENOMEM;

This seems wrong. MSG_DATA_MIN_SZ is 120 but struct cpu_vhint_data is a
lot larger than that (836 bytes, if I'm not mistaken). It probably works
because dma_alloc_coherent() will always give you at least a whole page,
but you should still use the correct size here.

> +
> +	data =3D (struct cpu_vhint_data *)virt;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.addr =3D phys;
> +	req.cluster_id =3D cluster_id;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq =3D MRQ_CPU_VHINT;
> +	msg.tx.data =3D &req;
> +	msg.tx.size =3D sizeof(req);
> +
> +	err =3D tegra_bpmp_transfer(bpmp, &msg);
> +	if (err)
> +		goto end;
> +
> +	num_rates =3D 0;

This could be initialized when it is declared.

> +
> +	for (i =3D data->vfloor; i < data->vceil + 1; ++i) {

i <=3D data->vceil? That seems more intuitive to me. Also, please only use
pre-decrement if really necessary.

> +		uint16_t ndiv =3D data->ndiv[i];
> +
> +		if (ndiv < data->ndiv_min || ndiv > data->ndiv_max)
> +			continue;
> +
> +		/* Only store lowest voltage index for each rate */
> +		if (i > 0 && ndiv =3D=3D data->ndiv[i-1])

Needs spaces around '-', I think checkpatch would complain otherwise.

Also, why is this even happening? Why would MRQ_CPU_VHINT return the
same ndiv value twice?

> +			continue;
> +
> +		++num_rates;

Again, post-increment is preferred over pre-increment.

> +	}
> +
> +	*table =3D devm_kcalloc(&pdev->dev, num_rates + 1, sizeof(**table),
> +			      GFP_KERNEL);

There's a lot of dereferencing here and in the code below. Why not
simply return a struct cpufreq_frequency_table * from this function, and
an ERR_PTR()-encoded error on failure, rather than returning this in a
parameter, requiring the repeated deref?

> +	if (!*table) {
> +		err =3D -ENOMEM;
> +		goto end;
> +	}
> +
> +	for (i =3D data->vfloor, j =3D 0; i < data->vceil + 1; ++i) {
> +		struct cpufreq_frequency_table *point;
> +		uint16_t ndiv =3D data->ndiv[i];
> +
> +		if (ndiv < data->ndiv_min || ndiv > data->ndiv_max)
> +			continue;
> +
> +		/* Only store lowest voltage index for each rate */
> +		if (i > 0 && ndiv =3D=3D data->ndiv[i-1])
> +			continue;
> +
> +		point =3D &(*table)[j++];
> +		point->driver_data =3D (i << 16) | (ndiv);
> +		point->frequency =3D data->ref_clk_hz * ndiv / data->pdiv /
> +			data->mdiv / 1000;
> +	}
> +
> +	(*table)[j].frequency =3D CPUFREQ_TABLE_END;
> +
> +end:

free: would be a more accurate name for this label.

> +	dma_free_coherent(bpmp->dev, MSG_DATA_MIN_SZ, virt, phys);
> +
> +	return err;
> +}
> +
> +static int tegra186_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct tegra186_cpufreq_data *data;
> +	struct tegra_bpmp *bpmp;
> +	int i, err;

unsigned int i?

> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	bpmp =3D tegra_bpmp_get(&pdev->dev);
> +	if (IS_ERR(bpmp))
> +		return PTR_ERR(bpmp);
> +
> +	for (i =3D 0; i < NUM_CLUSTERS; ++i) {
> +		struct resource *res;
> +
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   CLUSTERS[i].name);
> +		if (!res) {
> +			err =3D -ENXIO;
> +			goto put_bpmp;
> +		}

No need for this check, devm_ioremap_resource() will take care of it.

> +
> +		data->regs[i] =3D devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(data->regs[i])) {
> +			err =3D PTR_ERR(data->regs[i]);
> +			goto put_bpmp;
> +		}
> +
> +		err =3D init_vhint_table(pdev, bpmp, i, &data->tables[i]);
> +		if (err)
> +			goto put_bpmp;

This could become something along the lines of:

		data->tables[i] =3D init_vhint_table(pdev, bpmp, i);
		if (IS_ERR(data->tables[i])) {
			err =3D PTR_ERR(data->tables[i]);
			goto put_bpmp;
		}

Which is slightly more verbose than the original, but you get a lot more
clarity in return because you can just deal with straight pointers above
in init_vhint_table().

> +	}
> +
> +	tegra_bpmp_put(bpmp);
> +
> +	tegra186_cpufreq_driver.driver_data =3D data;
> +
> +	err =3D cpufreq_register_driver(&tegra186_cpufreq_driver);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +
> +put_bpmp:
> +	tegra_bpmp_put(bpmp);
> +
> +	return err;
> +}
> +
> +static int tegra186_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&tegra186_cpufreq_driver);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra186_cpufreq_of_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra186-ccplex-cluster", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra186_cpufreq_of_match);
> +
> +static struct platform_driver tegra186_cpufreq_platform_driver =3D {
> +	.driver =3D {
> +		.name =3D "tegra186-cpufreq",
> +		.of_match_table =3D tegra186_cpufreq_of_match,
> +	},
> +	.probe =3D tegra186_cpufreq_probe,
> +	.remove =3D tegra186_cpufreq_remove,
> +};
> +module_platform_driver(tegra186_cpufreq_platform_driver);
> +
> +MODULE_AUTHOR("Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Tegra186 cpufreq driver");

NVIDIA Tegra186?

I very much like how simple this driver is compared to previous
generations.

Thierry

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljiYGYACgkQ3SOs138+
s6G62A//QhGMuNSJ61lS0B0+6lMgm+fVrQzYai/eyoA3/iz5MdIyK228Zc5ANnbF
RdqY+CB2JCWkg2aOjbJGgFkMoZ+X05BAjRW+D/GqWG/2zGM3V/ToYMHVyA+XXlpC
TavMpsRJ4gD8Dybp4qUEzlgHL5PhUVUdujDO3KotUDXHMn7XoqCr2Pv9mQWzQfjZ
h6fHzV/vNBPyHz9BZLaryz8XfVV8TtL19WXlKQ+ZyNRqY5S3XTc8IKdVDO/yfhtI
wFchhdshMsJEqBM3vo3tP6SJ90Yzf0Q/r4SftYutnI1pJOkFfOOgvTL8NRz/NmKF
snbWveQB1UETLzP+bNfqxcqCa0jl4ezxe6S5nKeNWh3qUEtg+oXIySB2VA8k1wN4
O3ol3xEBT49t1YYyXs9BNCEcAHgbnLqd5ueIK8YHvyd6xcvlZPFTATRWVA/BRMWA
YcIOlC7uQ4zv7KpEEC6WXBIErf7Ll2H7A4maYnu3s3j5JVRW3g0DbVGpC89PLzX6
vwM4HCSEuI/FeUgKoJTQORJvUPToneGV/1UNqEFj4EiVqQDOSOpsgLHNf0HLc+Ra
gQNyZbwOjVFLfFUVvLNj8ZBlGvLOWK5y/fvsbScFKV/roN49CXGyIiao62lrEh2a
Ee2k4Acpa20CqAYLL8EBPMuFuM3cvOIUuMVq8cRKMXrr4HobVxs=
=K67F
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
