From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 6/6] arm64: add sysfs cpu_capacity attribute
Date: Fri, 5 Feb 2016 17:19:11 +0000
Message-ID: <56B4D98F.3090103@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-7-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49320 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbcBERTQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 12:19:16 -0500
In-Reply-To: <1454500799-18451-7-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, broonie@kernel.org, Mark Brown <broonie@linaro.org>

Hi Juri,

On 03/02/16 11:59, Juri Lelli wrote:
> Add a sysfs cpu_capacity attribute with which it is possible to read =
and
> write (thus over-writing default values) CPUs capacity. This might be
> useful in situation where there is no way to get proper default value=
s
> at boot time.
>=20
> The new attribute shows up as:
>=20
>  /sys/devices/system/cpu/cpu*/cpu_capacity
>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Brown <broonie@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm64/kernel/topology.c | 68 ++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 68 insertions(+)
>=20
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topolog=
y.c
> index f2513a6..f05cc07 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -40,6 +40,74 @@ bool arch_wants_init_cpu_capacity(void)
>  	return true;
>  }
> =20
> +#ifdef CONFIG_PROC_SYSCTL
> +#include <asm/cpu.h>
> +#include <linux/string.h>
> +static ssize_t show_cpu_capacity(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct cpu *cpu =3D container_of(dev, struct cpu, dev);
> +	ssize_t rc;
> +	int cpunum =3D cpu->dev.id;
> +	unsigned long capacity =3D arch_scale_cpu_capacity(NULL, cpunum);

Gives me an implicit declaration of function =91arch_scale_cpu_capacity=
=92
error [without the commit fbc899610e1a ("arm64: Update
arch_scale_cpu_capacity() to reflect change to define") on your
git://linux-arm.org/linux-jl.git upstream/default_caps_v3 branch].

Why don't you just return cpu_scale

@@ -49,10 +49,8 @@ static ssize_t show_cpu_capacity(struct device *dev,
 {
        struct cpu *cpu =3D container_of(dev, struct cpu, dev);
        ssize_t rc;
-       int cpunum =3D cpu->dev.id;
-       unsigned long capacity =3D arch_scale_cpu_capacity(NULL, cpunum=
);

-       rc =3D sprintf(buf, "%lu\n", capacity);
+       rc =3D sprintf(buf, "%lu\n", per_cpu(cpu_scale, cpu->dev.id));

        return rc;
 }

to get rid of this dependency?

-- Dietmar

[...]
