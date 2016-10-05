From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [RESEND PATCH v2 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
 driver for Broadcom STB SoCs
Date: Wed, 5 Oct 2016 14:04:40 -0700
Message-ID: <CAGt4E5s9UBam4RKsq3k1P77-81NR-8AeQi==7dBNnp37xxtr_g@mail.gmail.com>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-3-git-send-email-mmayer@broadcom.com> <20161005032509.GG4664@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36834 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbcJEVEm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2016 17:04:42 -0400
Received: by mail-ua0-f170.google.com with SMTP id r64so58786857uar.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Oct 2016 14:04:41 -0700 (PDT)
In-Reply-To: <20161005032509.GG4664@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 4 October 2016 at 20:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-09-16, 14:56, Markus Mayer wrote:
>> This driver supports voltage and frequency scaling on Broadcom STB SoCs
>> using AVS firmware with DFS and DVFS support.
>>
>> Actual frequency or voltage scaling is done exclusively by the AVS
>> firmware. The driver merely provides a standard CPUfreq interface to
>> other kernel components and userland, and instructs the AVS firmware to
>> perform frequency or voltage changes on its behalf.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  Documentation/cpu-freq/brcmstb-avs-cpufreq.txt |  27 +
>>  MAINTAINERS                                    |   2 +
>>  drivers/cpufreq/Kconfig.arm                    |  10 +
>>  drivers/cpufreq/Makefile                       |   1 +
>>  drivers/cpufreq/brcmstb-avs-cpufreq.c          | 707 ++++++++++++++++++=
+++++++
>>  5 files changed, 747 insertions(+)
>>  create mode 100644 Documentation/cpu-freq/brcmstb-avs-cpufreq.txt
>>  create mode 100644 drivers/cpufreq/brcmstb-avs-cpufreq.c
>>
>> diff --git a/Documentation/cpu-freq/brcmstb-avs-cpufreq.txt b/Documentat=
ion/cpu-freq/brcmstb-avs-cpufreq.txt
>> new file mode 100644
>> index 0000000..c6503e1
>> --- /dev/null
>> +++ b/Documentation/cpu-freq/brcmstb-avs-cpufreq.txt
>> @@ -0,0 +1,27 @@
>> +Broadcom STB AVS CPUfreq driver
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +"AVS" is the name of a firmware developed at Broadcom. It derives its
>> +name from the technique called "Adaptive Voltage Scaling". Adaptive
>> +voltage scaling was the original purpose of this firmware. The AVS
>> +firmware still supports "AVS mode", where all it does is adaptive
>> +voltage scaling. However, on some newer Broadcom SoCs, the AVS
>> +Firmware, despite its unchanged name, also supports DFS mode and DVFS
>> +mode.
>> +
>> +In the context of this document and the related driver, "AVS" by itself
>> +always means the Broadcom firmware and never refers to the technique
>> +called "Adaptive Voltage Scaling".
>> +
>> +The Broadcom STB AVS CPUfreq driver provides voltage and frequency
>> +scaling on Broadcom SoCs using AVS firmware with support for DFS and
>> +DVFS. The AVS firmware is running on its own co-processor. The driver
>> +supports both uniprocessor (UP) and symmetric multiprocessor (SMP)
>> +systems which share clock and voltage across all CPUs.
>> +
>> +Actual voltage and frequency scaling is done solely by the AVS firmware=
.
>> +This driver does not change frequency or voltage itself. It provides a
>> +standard CPUfreq interface to the rest of the kernel and to userland. I=
t
>> +interfaces with the AVS firmware to effect the requested changes and to
>> +report back the current system status in a way that is expected by exis=
ting
>> +tools.
>
> Do we really need this file? Can't part of it go to the binding
> document? I am not sure I see any useful information here which is
> mandatory. If the DT file doesn't work well, a big comment at the top
> of the driver's .c file should do..

The reason I created a separate file was because Rob didn't want Linux
specifics in a binding document (https://lkml.org/lkml/2016/8/16/403).

I am okay sticking it into a comment in the driver.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 557f839..708b2bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2695,6 +2695,8 @@ M:      bcm-kernel-feedback-list@broadcom.com
>>  L:   linux-pm@vger.kernel.org
>>  S:   Maintained
>>  F:   Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-cpu-freq.tx=
t
>> +F:   Documentation/cpu-freq/brcmstb-avs-cpufreq.txt
>> +F:   drivers/cpufreq/brcm-avs-cpufreq.c
>>
>>  BROADCOM SPECIFIC AMBA DRIVER (BCMA)
>>  M:   Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index d89b8af..4177f45 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -12,6 +12,16 @@ config ARM_BIG_LITTLE_CPUFREQ
>>       help
>>         This enables the Generic CPUfreq driver for ARM big.LITTLE platf=
orms.
>>
>> +config ARM_BRCMSTB_AVS_CPUFREQ
>> +     tristate "Broadcom STB AVS CPUfreq driver"
>> +     depends on ARCH_BRCMSTB || COMPILE_TEST
>> +     help
>> +       Some Broadcom STB SoCs use a co-processor running proprietary fi=
rmware
>> +       ("AVS") to handle voltage and frequency scaling. This driver pro=
vides
>> +       a standard CPUfreq interface to to the firmware.
>> +
>> +       Say Y, if you have a Broadcom SoC with AVS support for DFS or DV=
FS.
>> +
>>  config ARM_DT_BL_CPUFREQ
>>       tristate "Generic probing via DT for ARM big LITTLE CPUfreq driver=
"
>>       depends on ARM_BIG_LITTLE_CPUFREQ && OF
>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>> index 0a9b6a09..ac54f64 100644
>> --- a/drivers/cpufreq/Makefile
>> +++ b/drivers/cpufreq/Makefile
>> @@ -51,6 +51,7 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)        +=3D arm_b=
ig_little.o
>>  # LITTLE drivers, so that it is probed last.
>>  obj-$(CONFIG_ARM_DT_BL_CPUFREQ)              +=3D arm_big_little_dt.o
>>
>> +obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)        +=3D brcmstb-avs-cpufreq.o
>>  obj-$(CONFIG_ARCH_DAVINCI)           +=3D davinci-cpufreq.o
>>  obj-$(CONFIG_UX500_SOC_DB8500)               +=3D dbx500-cpufreq.o
>>  obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ) +=3D exynos5440-cpufreq.o
>> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brc=
mstb-avs-cpufreq.c
>> new file mode 100644
>> index 0000000..ddf5dd1
>> --- /dev/null
>> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
>> @@ -0,0 +1,707 @@
>> +/*
>> + * CPU frequency scaling for Broadcom SoCs with AVS firmware that
>> + * supports DVS or DVFS
>> + *
>> + * Copyright (c) 2016 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>
> Since you have kept the rest in ascending order, it might be better to
> put this one after io.h.

Done.

>> +#include <linux/cpufreq.h>
>> +#include <linux/cpu.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/slab.h>
>> +
>> +/* Max number of arguments AVS calls take */
>> +#define AVS_MAX_CMD_ARGS     4
>> +/*
>> + * This macro is used to generate AVS parameter register offsets. For
>> + * x >=3D AVS_MAX_CMD_ARGS, it returns 0 to protect against accidental =
memory
>> + * access outside of the parameter range. (Offset 0 is the first parame=
ter.)
>> + */
>> +#define AVS_PARAM_MULT(x)    ((x) < AVS_MAX_CMD_ARGS ? (x) : 0)
>> +
>> +/* AVS Mailbox Register offsets */
>> +#define AVS_MBOX_COMMAND     0x00
>> +#define AVS_MBOX_STATUS              0x04
>> +#define AVS_MBOX_VOLTAGE0    0x08
>> +#define AVS_MBOX_TEMP0               0x0c
>> +#define AVS_MBOX_PV0         0x10
>> +#define AVS_MBOX_MV0         0x14
>> +#define AVS_MBOX_PARAM(x)    (0x18 + AVS_PARAM_MULT(x) * sizeof(u32))
>> +#define AVS_MBOX_REVISION    0x28
>> +#define AVS_MBOX_PSTATE              0x2c
>> +#define AVS_MBOX_HEARTBEAT   0x30
>> +#define AVS_MBOX_MAGIC               0x34
>> +#define AVS_MBOX_SIGMA_HVT   0x38
>> +#define AVS_MBOX_SIGMA_SVT   0x3c
>> +#define AVS_MBOX_VOLTAGE1    0x40
>> +#define AVS_MBOX_TEMP1               0x44
>> +#define AVS_MBOX_PV1         0x48
>> +#define AVS_MBOX_MV1         0x4c
>> +#define AVS_MBOX_FREQUENCY   0x50
>> +
>> +/* AVS Commands */
>> +#define AVS_CMD_AVAILABLE    0x00
>> +#define AVS_CMD_DISABLE              0x10
>> +#define AVS_CMD_ENABLE               0x11
>> +#define AVS_CMD_S2_ENTER     0x12
>> +#define AVS_CMD_S2_EXIT              0x13
>> +#define AVS_CMD_BBM_ENTER    0x14
>> +#define AVS_CMD_BBM_EXIT     0x15
>> +#define AVS_CMD_S3_ENTER     0x16
>> +#define AVS_CMD_S3_EXIT              0x17
>> +#define AVS_CMD_BALANCE              0x18
>> +/* PMAP and P-STATE commands */
>> +#define AVS_CMD_GET_PMAP     0x30
>> +#define AVS_CMD_SET_PMAP     0x31
>> +#define AVS_CMD_GET_PSTATE   0x40
>> +#define AVS_CMD_SET_PSTATE   0x41
>> +
>> +/* Different modes AVS supports (for GET_PMAP/SET_PMAP) */
>> +#define AVS_MODE_AVS         0x0
>> +#define AVS_MODE_DFS         0x1
>> +#define AVS_MODE_DVS         0x2
>> +#define AVS_MODE_DVFS                0x3
>> +
>> +/*
>> + * PMAP parameter p1
>> + * unused:31-24, mdiv_p0:23-16, unused:15-14, pdiv:13-10 , ndiv_int:9-0
>> + */
>> +#define NDIV_INT_SHIFT               0
>> +#define NDIV_INT_MASK                0x3ff
>> +#define PDIV_SHIFT           10
>> +#define PDIV_MASK            0xf
>> +#define MDIV_P0_SHIFT                16
>> +#define MDIV_P0_MASK         0xff
>> +/*
>> + * PMAP parameter p2
>> + * mdiv_p4:31-24, mdiv_p3:23-16, mdiv_p2:15:8, mdiv_p1:7:0
>> + */
>> +#define MDIV_P1_SHIFT                0
>> +#define MDIV_P1_MASK         0xff
>> +#define MDIV_P2_SHIFT                8
>> +#define MDIV_P2_MASK         0xff
>> +#define MDIV_P3_SHIFT                16
>> +#define MDIV_P3_MASK         0xff
>> +#define MDIV_P4_SHIFT                24
>> +#define MDIV_P4_MASK         0xff
>> +
>> +/* Different P-STATES AVS supports (for GET_PSTATE/SET_PSTATE) */
>> +#define AVS_PSTATE_P0                0x0
>> +#define AVS_PSTATE_P1                0x1
>> +#define AVS_PSTATE_P2                0x2
>> +#define AVS_PSTATE_P3                0x3
>> +#define AVS_PSTATE_P4                0x4
>> +#define AVS_PSTATE_MAX               AVS_PSTATE_P4
>> +
>> +/* CPU L2 Interrupt Controller Registers */
>> +#define AVS_CPU_L2_SET0              0x04
>> +#define AVS_CPU_L2_INT_MASK  BIT(31)
>> +
>> +/* AVS Command Status Values */
>> +#define AVS_STATUS_CLEAR     0x00
>> +/* Command/notification accepted */
>> +#define AVS_STATUS_SUCCESS   0xf0
>> +/* Command/notification rejected */
>> +#define AVS_STATUS_FAILURE   0xff
>> +/* Invalid command/notification (unknown) */
>> +#define AVS_STATUS_INVALID   0xf1
>> +/* Non-AVS modes are not supported */
>> +#define AVS_STATUS_NO_SUPP   0xf2
>> +/* Cannot set P-State until P-Map supplied */
>> +#define AVS_STATUS_NO_MAP    0xf3
>> +/* Cannot change P-Map after initial P-Map set */
>> +#define AVS_STATUS_MAP_SET   0xf4
>> +/* Max AVS status; higher numbers are used for debugging */
>> +#define AVS_STATUS_MAX               0xff
>> +
>> +/* Other AVS related constants */
>> +#define AVS_LOOP_LIMIT               10000
>> +#define AVS_TIMEOUT          300 /* in ms; expected completion is < 10m=
s */
>> +#define AVS_FIRMWARE_MAGIC   0xa11600d1
>> +
>> +#define BRCM_AVS_CPUFREQ_NAME        "brcmstb-avs-cpufreq"
>> +#define BRCM_AVS_CPU_DATA    "brcm,avs-cpu-data-mem"
>> +#define BRCM_AVS_CPU_INTR    "brcm,avs-cpu-l2-intr"
>> +#define BRCM_AVS_HOST_INTR   "sw_intr"
>> +
>> +struct pmap {
>> +     unsigned int mode;
>> +     unsigned int p1;
>> +     unsigned int p2;
>> +     unsigned int state;
>> +};
>> +
>> +struct private_data {
>> +     void __iomem *base;
>> +     void __iomem *avs_intr_base;
>> +     struct device_node *base_np;
>> +     struct device_node *intr_base_np;
>> +     struct device *dev;
>> +     struct completion done;
>> +     struct semaphore sem;
>> +     struct pmap pmap;
>> +};
>> +
>> +static void __iomem *__map_region(const char *name, struct device_node =
**node)
>> +{
>> +     struct device_node *np;
>> +
>> +     np =3D of_find_compatible_node(NULL, NULL, name);
>> +     if (!np)
>> +             return NULL;
>> +
>> +     if (node)
>> +             *node =3D np;
>> +
>> +     return of_iomap(np, 0);
>> +}
>> +
>> +static int __issue_avs_command(struct private_data *priv, int cmd, bool=
 is_send,
>> +     u32 args[])
>
> checkpatch --strict will ask you to align the u32 to the opening ( in
> the above line.

Done (all instances).

>> +{
>> +     unsigned long time_left =3D msecs_to_jiffies(AVS_TIMEOUT);
>> +     void __iomem *base =3D priv->base;
>> +     unsigned int i;
>> +     int ret;
>> +     u32 val;
>> +
>> +     ret =3D down_interruptible(&priv->sem);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * Make sure no other command is currently running: cmd is 0 if AV=
S
>> +      * co-processor is idle. Due to the guard above, we should almost =
never
>> +      * have to wait here.
>> +      */
>> +     for (i =3D 0, val =3D 1; val !=3D 0 && i < AVS_LOOP_LIMIT; i++)
>> +             val =3D readl(base + AVS_MBOX_COMMAND);
>
> Please add a blank line here..

Done.

>> +     /* Give the caller a chance to retry if AVS is busy. */
>> +     if (i >=3D AVS_LOOP_LIMIT) {
>
> Isn't =3D=3D sufficient here ?

Yes, it is. Changed to "=3D=3D".

>> +             ret =3D -EAGAIN;
>> +             goto out;
>> +     }
>> +
>> +     /* Clear status before we begin. */
>> +     writel(AVS_STATUS_CLEAR, base + AVS_MBOX_STATUS);
>> +
>> +     /* We need to send arguments for this command. */
>> +     if (args && is_send)
>
> Though its not compulsory as per C coding standards, but its better to
> use {} for multi-line body..

Done.

>> +             for (i =3D 0; i < AVS_MAX_CMD_ARGS; i++)
>> +                     writel(args[i], base + AVS_MBOX_PARAM(i));
>> +
>> +     /* Protect from spurious interrupts. */
>> +     reinit_completion(&priv->done);
>
> Blank line here...

Done.

>> +     /* Now issue the command & tell firmware to wake up to process it.=
 */
>> +     writel(cmd, base + AVS_MBOX_COMMAND);
>> +     writel(AVS_CPU_L2_INT_MASK, priv->avs_intr_base + AVS_CPU_L2_SET0)=
;
>
> and here would make it easily readable IMO.

Done.

>> +     /* Wait for AVS co-processor to finish processing the command. */
>> +     time_left =3D wait_for_completion_timeout(&priv->done, time_left);
>> +
>> +     /*
>> +      * If the AVS status is not in the expected range, it means AVS di=
dn't
>> +      * complete our command in time, and we return an error. Also, if =
there
>> +      * is no "time left", we timed out waiting for the interrupt.
>> +      */
>> +     val =3D readl(base + AVS_MBOX_STATUS);
>> +     if (time_left =3D=3D 0 || val =3D=3D 0 || val > AVS_STATUS_MAX) {
>> +             dev_err(priv->dev, "AVS command %#x didn't complete in tim=
e\n",
>> +                     cmd);
>> +             dev_err(priv->dev, "    Time left: %u ms, AVS status: %#x\=
n",
>> +                     jiffies_to_msecs(time_left), val);
>> +             ret =3D -ETIMEDOUT;
>> +             goto out;
>> +     }
>> +
>> +     /* This command returned arguments, so we read them back. */
>> +     if (args && !is_send)
>
> Please use {} ..

Done.

>> +             for (i =3D 0; i < AVS_MAX_CMD_ARGS; i++)
>> +                     args[i] =3D readl(base + AVS_MBOX_PARAM(i));
>> +
>> +     /* Clear status to tell AVS co-processor we are done. */
>> +     writel(AVS_STATUS_CLEAR, base + AVS_MBOX_STATUS);
>> +
>> +     /* Convert firmware errors to errno's as much as possible. */
>> +     switch (val) {
>> +     case AVS_STATUS_INVALID:
>> +             ret =3D -EINVAL;
>> +             break;
>> +     case AVS_STATUS_NO_SUPP:
>> +             ret =3D -ENOTSUPP;
>> +             break;
>> +     case AVS_STATUS_NO_MAP:
>> +             ret =3D -ENOENT;
>> +             break;
>> +     case AVS_STATUS_MAP_SET:
>> +             ret =3D -EEXIST;
>> +             break;
>> +     case AVS_STATUS_FAILURE:
>> +             ret =3D -EIO;
>> +             break;
>> +     }
>> +
>> +out:
>> +     up(&priv->sem);
>> +
>> +     return ret;
>> +}
>> +
>> +static irqreturn_t irq_handler(int irq, void *data)
>> +{
>> +     struct private_data *priv =3D data;
>> +
>> +     /* AVS command completed execution. Wake up __issue_avs_command().=
 */
>> +     complete(&priv->done);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static char *brcm_avs_mode_to_string(unsigned int mode)
>> +{
>> +     switch (mode) {
>> +     case AVS_MODE_AVS:
>> +             return "AVS";
>> +     case AVS_MODE_DFS:
>> +             return "DFS";
>> +     case AVS_MODE_DVS:
>> +             return "DVS";
>> +     case AVS_MODE_DVFS:
>> +             return "DVFS";
>> +     }
>> +     return NULL;
>> +}
>> +
>> +static void brcm_avs_parse_p1(u32 p1, unsigned int *mdiv_p0, unsigned i=
nt *pdiv,
>> +                             unsigned int *ndiv)
>> +{
>> +     *mdiv_p0 =3D (p1 >> MDIV_P0_SHIFT) & MDIV_P0_MASK;
>> +     *pdiv =3D (p1 >> PDIV_SHIFT) & PDIV_MASK;
>> +     *ndiv =3D (p1 >> NDIV_INT_SHIFT) & NDIV_INT_MASK;
>> +}
>> +
>> +static void brcm_avs_parse_p2(u32 p2, unsigned int *mdiv_p1,
>> +                             unsigned int *mdiv_p2, unsigned int *mdiv_=
p3,
>> +                             unsigned int *mdiv_p4)
>> +{
>> +     *mdiv_p4 =3D (p2 >> MDIV_P4_SHIFT) & MDIV_P4_MASK;
>> +     *mdiv_p3 =3D (p2 >> MDIV_P3_SHIFT) & MDIV_P3_MASK;
>> +     *mdiv_p2 =3D (p2 >> MDIV_P2_SHIFT) & MDIV_P2_MASK;
>> +     *mdiv_p1 =3D (p2 >> MDIV_P1_SHIFT) & MDIV_P1_MASK;
>> +}
>> +
>> +static int brcm_avs_get_pmap(struct private_data *priv, struct pmap *pm=
ap)
>> +{
>> +     u32 args[AVS_MAX_CMD_ARGS];
>> +     int ret;
>> +
>> +     ret =3D __issue_avs_command(priv, AVS_CMD_GET_PMAP, false, args);
>> +     if (ret || !pmap)
>> +             return ret;
>> +
>> +     pmap->mode =3D args[0];
>> +     pmap->p1 =3D args[1];
>> +     pmap->p2 =3D args[2];
>> +     pmap->state =3D args[3];
>> +
>> +     return 0;
>> +}
>> +
>> +static int brcm_avs_set_pmap(struct private_data *priv, struct pmap *pm=
ap)
>> +{
>> +     u32 args[AVS_MAX_CMD_ARGS];
>> +
>> +     args[0] =3D pmap->mode;
>> +     args[1] =3D pmap->p1;
>> +     args[2] =3D pmap->p2;
>> +     args[3] =3D pmap->state;
>> +
>> +     return __issue_avs_command(priv, AVS_CMD_SET_PMAP, true, args);
>> +}
>> +
>> +static int brcm_avs_get_pstate(struct private_data *priv, unsigned int =
*pstate)
>> +{
>> +     u32 args[AVS_MAX_CMD_ARGS];
>> +     int ret;
>> +
>> +     ret =3D __issue_avs_command(priv, AVS_CMD_GET_PSTATE, false, args)=
;
>> +     if (ret)
>> +             return ret;
>> +     *pstate =3D args[0];
>> +
>> +     return 0;
>> +}
>> +
>> +static int brcm_avs_set_pstate(struct private_data *priv, unsigned int =
pstate)
>> +{
>> +     u32 args[AVS_MAX_CMD_ARGS];
>> +
>> +     args[0] =3D pstate;
>> +     return __issue_avs_command(priv, AVS_CMD_SET_PSTATE, true, args);
>> +}
>> +
>> +static unsigned long brcm_avs_get_voltage(void __iomem *base)
>> +{
>> +     return readl(base + AVS_MBOX_VOLTAGE1);
>> +}
>> +
>> +static unsigned long brcm_avs_get_frequency(void __iomem *base)
>> +{
>> +     return readl(base + AVS_MBOX_FREQUENCY) * 1000; /* in kHz */
>> +}
>> +
>> +/*
>> + * We determine which frequencies are supported by cycling through all =
P-states
>> + * and reading back what frequency we are running at for each P-state.
>> + */
>> +static struct cpufreq_frequency_table *
>> +brcm_avs_get_freq_table(struct device *dev, struct private_data *priv)
>> +{
>> +     struct cpufreq_frequency_table *table;
>> +     unsigned int pstate;
>> +     int i, ret;
>> +
>> +     /* Remember P-state for later */
>> +     ret =3D brcm_avs_get_pstate(priv, &pstate);
>> +     if (ret)
>> +             return ERR_PTR(ret);
>> +
>> +     table =3D devm_kzalloc(dev, (AVS_PSTATE_MAX + 1) * sizeof(*table),
>> +                     GFP_KERNEL);
>
> Same alignment issue here as well. Please fix that for all the
> patches.

Done, as mentioned above.

>> +     if (!table)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     for (i =3D AVS_PSTATE_P0; i <=3D AVS_PSTATE_MAX; i++) {
>> +             ret =3D brcm_avs_set_pstate(priv, i);
>> +             if (ret)
>> +                     return ERR_PTR(ret);
>> +             table[i].frequency =3D brcm_avs_get_frequency(priv->base);
>> +             table[i].driver_data =3D i;
>> +     }
>> +     table[i].frequency =3D CPUFREQ_TABLE_END;
>> +     table[i].driver_data =3D i;
>> +
>> +     /* Restore P-state */
>> +     ret =3D brcm_avs_set_pstate(priv, pstate);
>> +     if (ret)
>> +             return ERR_PTR(ret);
>> +
>> +     return table;
>> +}
>> +
>> +/*
>> + * To ensure the right firmware is running we need to
>> + *    - check the MAGIC matches what we expect
>> + *    - brcm_avs_get_pmap() doesn't return -ENOTSUPP or -EINVAL
>> + */
>> +static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
>> +{
>> +     u32 magic;
>> +     int rc;
>> +
>> +     rc =3D brcm_avs_get_pmap(priv, NULL);
>> +     magic =3D readl(priv->base + AVS_MBOX_MAGIC);
>> +
>> +     return (magic =3D=3D AVS_FIRMWARE_MAGIC) && (rc !=3D -ENOTSUPP) &&
>> +             (rc !=3D -EINVAL);
>> +}
>> +
>> +static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>> +{
>> +     struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
>> +
>> +     return policy->cur;
>
> Can't you read the value right from the hardware? The purpose of this
> routine is to get the exact frequency the hardware is running at. And
> there are cases when software/hardware aren't in sync.

Fixed. Changed to read from the hardware.

>> +}
>> +
>> +static int brcm_avs_target_index(struct cpufreq_policy *policy,
>> +                             unsigned int index)
>> +{
>> +     int ret;
>> +
>> +     ret =3D brcm_avs_set_pstate(policy->driver_data,
>> +             policy->freq_table[index].driver_data);
>> +     if (ret)
>> +             return ret;
>> +
>> +     policy->cur =3D policy->freq_table[index].frequency;
>
> This isn't supposed to be done by the drivers. Core handles it by
> itself.

Fixed.

>> +
>> +     return 0;
>> +}
>> +
>> +static int brcm_avs_suspend(struct cpufreq_policy *policy)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +
>> +     return brcm_avs_get_pmap(priv, &priv->pmap);
>> +}
>> +
>> +static int brcm_avs_resume(struct cpufreq_policy *policy)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +     int ret;
>> +
>> +     ret =3D brcm_avs_set_pmap(priv, &priv->pmap);
>> +     if (ret =3D=3D -EEXIST) {
>> +             struct platform_device *pdev  =3D cpufreq_get_driver_data(=
);
>> +             struct device *dev =3D &pdev->dev;
>> +
>> +             dev_warn(dev, "PMAP was already set\n");
>> +             ret =3D 0;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int brcm_avs_cpu_init(struct cpufreq_policy *policy)
>> +{
>> +     struct cpufreq_frequency_table *freq_table;
>> +     struct platform_device *pdev;
>> +     struct private_data *priv;
>> +     struct device *dev;
>> +     int host_irq;
>> +     int ret;
>
> Maybe merge above two lines.

Done.

>> +
>> +     /*
>> +      * Register on CPU 0 only. If this fails, there is no reason to tr=
y on
>> +      * other cores, since it would just fail again.
>> +      */
>> +     if (policy->cpu > 0)
>> +             return -ENODEV;
>
> This is not the right way of doing it. What if CPU 0 is offline while
> this function gets called?

Is there an easy way for me to know via the framework whether init is
being called for the first time vs. init is being called on a
different core after a previous attempt to initialize on another core
failed?

I could use a driver-global variable for the driver to remember if it
has been initialized, but that seems a bit hacky.

>> +
>> +     pdev =3D cpufreq_get_driver_data();
>> +     dev =3D &pdev->dev;
>> +
>> +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     priv->dev =3D dev;
>> +     policy->driver_data =3D priv;
>> +     sema_init(&priv->sem, 1);
>> +     init_completion(&priv->done);
>> +     platform_set_drvdata(pdev, priv);
>> +
>> +     priv->base =3D __map_region(BRCM_AVS_CPU_DATA, &priv->base_np);
>> +     if (!priv->base) {
>> +             dev_err(dev, "Couldn't find property %s in device tree.\n"=
,
>> +                     BRCM_AVS_CPU_DATA);
>> +             return -ENOENT;
>> +     }
>> +
>> +     priv->avs_intr_base =3D __map_region(BRCM_AVS_CPU_INTR,
>> +                             &priv->intr_base_np);
>> +     if (!priv->avs_intr_base) {
>> +             dev_err(dev, "Couldn't find property %s in device tree.\n"=
,
>> +                     BRCM_AVS_CPU_INTR);
>> +             ret =3D -ENOENT;
>> +             goto unmap_base;
>> +     }
>> +
>> +     host_irq =3D platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
>> +     if (host_irq < 0) {
>> +             dev_err(dev, "Couldn't find interrupt %s -- %d\n",
>> +                     BRCM_AVS_HOST_INTR, host_irq);
>> +             ret =3D host_irq;
>> +             goto unmap_intr_base;
>> +     }
>> +     ret =3D devm_request_irq(dev, host_irq, irq_handler, IRQF_TRIGGER_=
RISING,
>> +             BRCM_AVS_HOST_INTR, priv);
>> +     if (ret) {
>> +             dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
>> +                     BRCM_AVS_HOST_INTR, host_irq, ret);
>> +             goto unmap_intr_base;
>> +     }
>> +
>> +     if (!brcm_avs_is_firmware_loaded(priv)) {
>
> Shouldn't this be checked before requesting irqs ?

Fixed. Moved it up right after mapping priv->base.

>> +             dev_err(dev,
>> +                     "AVS firmware is not loaded or doesn't support DVF=
S\n");
>> +             ret =3D -ENODEV;
>> +             goto unmap_intr_base;
>> +     }
>> +
>> +     freq_table =3D brcm_avs_get_freq_table(dev, priv);
>> +     if (IS_ERR(freq_table)) {
>> +             dev_err(dev, "Couldn't determine frequency table (%ld).\n"=
,
>> +                     PTR_ERR(freq_table));
>> +             ret =3D PTR_ERR(freq_table);
>> +             goto unmap_intr_base;
>> +     }
>> +
>> +     ret =3D cpufreq_table_validate_and_show(policy, freq_table);
>> +     if (ret) {
>> +             dev_err(dev, "invalid frequency table: %d\n", ret);
>> +             goto unmap_intr_base;
>> +     }
>> +
>> +     /* All cores share the same clock and thus the same policy. */
>> +     cpumask_setall(policy->cpus);
>> +
>> +     ret =3D __issue_avs_command(priv, AVS_CMD_ENABLE, false, NULL);
>> +     if (!ret) {
>> +             unsigned int pstate;
>> +
>> +             ret =3D brcm_avs_get_pstate(priv, &pstate);
>> +             if (!ret) {
>> +                     policy->cur =3D freq_table[pstate].frequency;
>> +                     dev_info(dev, "registered\n");
>> +                     goto out;
>> +             }
>> +     }
>> +     dev_err(dev, "couldn't initialize driver (%d)\n", ret);
>> +
>> +unmap_intr_base:
>> +     iounmap(priv->avs_intr_base);
>> +     of_node_put(priv->intr_base_np);
>> +unmap_base:
>> +     iounmap(priv->base);
>> +     of_node_put(priv->base_np);
>> +out:
>> +     return ret;
>> +}
>> +
>> +static int brcm_avs_cpu_exit(struct cpufreq_policy *policy)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +
>> +     iounmap(priv->base);
>> +     iounmap(priv->avs_intr_base);
>> +     of_node_put(priv->base_np);
>> +     of_node_put(priv->intr_base_np);
>
> What about clearing platform-data which you have set earlier ?

You  mean "platform_set_drvdata(pdev, NULL)"? Added to
brcm_avs_cpu_init() and brcm_avs_cpufreq_remove().

>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t show_brcm_avs_pstate(struct cpufreq_policy *policy, char=
 *buf)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +     unsigned int pstate;
>> +
>> +     if (brcm_avs_get_pstate(priv, &pstate))
>> +             return sprintf(buf, "<unknown>\n");
>> +
>> +     return sprintf(buf, "%u\n", pstate);
>> +}
>> +
>> +static ssize_t show_brcm_avs_mode(struct cpufreq_policy *policy, char *=
buf)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +     struct pmap pmap;
>> +
>> +     if (brcm_avs_get_pmap(priv, &pmap))
>> +             return sprintf(buf, "<unknown>\n");
>> +
>> +     return sprintf(buf, "%s %u\n", brcm_avs_mode_to_string(pmap.mode),
>> +             pmap.mode);
>> +}
>> +
>> +static ssize_t show_brcm_avs_pmap(struct cpufreq_policy *policy, char *=
buf)
>> +{
>> +     unsigned int mdiv_p0, mdiv_p1, mdiv_p2, mdiv_p3, mdiv_p4;
>> +     struct private_data *priv =3D policy->driver_data;
>> +     unsigned int ndiv, pdiv;
>> +     struct pmap pmap;
>> +
>> +     if (brcm_avs_get_pmap(priv, &pmap))
>> +             return sprintf(buf, "<unknown>\n");
>> +
>> +     brcm_avs_parse_p1(pmap.p1, &mdiv_p0, &pdiv, &ndiv);
>> +     brcm_avs_parse_p2(pmap.p2, &mdiv_p1, &mdiv_p2, &mdiv_p3, &mdiv_p4)=
;
>> +
>> +     return sprintf(buf, "0x%08x 0x%08x %u %u %u %u %u %u %u\n",
>> +             pmap.p1, pmap.p2, ndiv, pdiv, mdiv_p0, mdiv_p1, mdiv_p2,
>> +             mdiv_p3, mdiv_p4);
>> +}
>> +
>> +static ssize_t show_brcm_avs_voltage(struct cpufreq_policy *policy, cha=
r *buf)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +
>> +     return sprintf(buf, "0x%08lx\n", brcm_avs_get_voltage(priv->base))=
;
>> +}
>> +
>> +static ssize_t show_brcm_avs_frequency(struct cpufreq_policy *policy, c=
har *buf)
>> +{
>> +     struct private_data *priv =3D policy->driver_data;
>> +
>> +     return sprintf(buf, "0x%08lx\n", brcm_avs_get_frequency(priv->base=
));
>> +}
>> +
>> +cpufreq_freq_attr_ro(brcm_avs_pstate);
>> +cpufreq_freq_attr_ro(brcm_avs_mode);
>> +cpufreq_freq_attr_ro(brcm_avs_pmap);
>> +cpufreq_freq_attr_ro(brcm_avs_voltage);
>> +cpufreq_freq_attr_ro(brcm_avs_frequency);
>> +
>> +struct freq_attr *brcm_avs_cpufreq_attr[] =3D {
>> +     &cpufreq_freq_attr_scaling_available_freqs,
>> +     &brcm_avs_pstate,
>> +     &brcm_avs_mode,
>> +     &brcm_avs_pmap,
>> +     &brcm_avs_voltage,
>> +     &brcm_avs_frequency,
>> +     NULL
>> +};
>> +
>> +static struct cpufreq_driver brcm_avs_driver =3D {
>> +     .flags          =3D CPUFREQ_NEED_INITIAL_FREQ_CHECK,
>> +     .verify         =3D cpufreq_generic_frequency_table_verify,
>> +     .target_index   =3D brcm_avs_target_index,
>> +     .get            =3D brcm_avs_cpufreq_get,
>> +     .suspend        =3D brcm_avs_suspend,
>> +     .resume         =3D brcm_avs_resume,
>> +     .init           =3D brcm_avs_cpu_init,
>> +     .exit           =3D brcm_avs_cpu_exit,
>> +     .name           =3D BRCM_AVS_CPUFREQ_NAME,
>> +     .attr           =3D brcm_avs_cpufreq_attr,
>> +};
>> +
>> +static int brcm_avs_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     int ret;
>> +
>> +     brcm_avs_driver.driver_data =3D pdev;
>> +     ret =3D cpufreq_register_driver(&brcm_avs_driver);
>> +
>> +     return ret;
>> +}
>> +
>> +static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
>> +{
>> +     return cpufreq_unregister_driver(&brcm_avs_driver);
>> +}
>> +
>> +static const struct of_device_id brcm_avs_cpufreq_match[] =3D {
>> +     { .compatible =3D BRCM_AVS_CPU_DATA },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, brcm_avs_cpufreq_match);
>> +
>> +static struct platform_driver brcm_avs_cpufreq_platdrv =3D {
>> +     .driver =3D {
>> +             .name   =3D BRCM_AVS_CPUFREQ_NAME,
>> +             .of_match_table =3D brcm_avs_cpufreq_match,
>> +     },
>> +     .probe          =3D brcm_avs_cpufreq_probe,
>> +     .remove         =3D brcm_avs_cpufreq_remove,
>> +};
>> +module_platform_driver(brcm_avs_cpufreq_platdrv);
>> +
>> +MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
>> +MODULE_DESCRIPTION("CPUfreq driver for Broadcom AVS");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.7.4
>
> --
> viresh
