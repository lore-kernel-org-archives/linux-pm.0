From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 4/8] interconnect: qcom: Add RPM communication
Date: Tue, 10 Jul 2018 15:34:23 -0700
Message-ID: <CAE=gft6pPcxfYqEcb-yQpf7S6CDTZNavhqYaKi37962U78qO3Q@mail.gmail.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org> <20180709155104.25528-5-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709155104.25528-5-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Alexandre Bailon <abailon@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mka@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, tfiga@chromium.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Kconfig             | 11 +++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 15 +++
>  5 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> new file mode 100644
> index 000000000000..88a5aeb50935
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
> @@ -0,0 +1,32 @@
> +Qualcomm SMD-RPM interconnect driver binding
> +------------------------------------------------
> +The RPM (Resource Power Manager) is a dedicated hardware engine
> +for managing the shared SoC resources in order to keep the lowest
> +power profile. It communicates with other hardware subsystems via
> +the shared memory driver (SMD) back-end and accepts requests for
> +various resources.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,interconnect-smd-rpm"
> +
> +Example:
> +       smd {
> +               compatible = "qcom,smd";
> +
> +               rpm {
> +                       interrupts = <0 168 1>;
> +                       qcom,ipc = <&apcs 8 0>;
> +                       qcom,smd-edge = <15>;
> +
> +                       rpm_requests {
> +                               compatible = "qcom,rpm-msm8916";
> +                               qcom,smd-channels = "rpm_requests";
> +
> +                               interconnect-smd-rpm {
> +                                       compatible = "qcom,interconnect-smd-rpm";
> +                               };
> +
> +                       };
> +               };
> +       };
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> new file mode 100644
> index 000000000000..b0c2ff928d88
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -0,0 +1,11 @@
> +config INTERCONNECT_QCOM
> +       bool "Qualcomm Network-on-Chip interconnect drivers"
> +       depends on INTERCONNECT
> +       depends on ARCH_QCOM || COMPILE_TEST
> +
> +config INTERCONNECT_QCOM_SMD_RPM
> +       tristate "Qualcomm SMD RPM interconnect driver"
> +       depends on INTERCONNECT_QCOM

Should this also depend on CONFIG_QCOM_SMD_RPM, since it uses
qcom_rpm_smd_write?

> +       help
> +         This is a driver for communicating interconnect related configuration
> +         details with a remote processor (RPM) on Qualcomm platforms.
...
> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
> new file mode 100644
> index 000000000000..c33b91a3dd51
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_RPM_H
> +#define __DRIVERS_INTERCONNECT_QCOM_RPM_H

Nit: this still doesn't quite match, it would need an _SMD like:
__DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H

> +
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +bool qcom_icc_rpm_smd_available(void);
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +
> +#endif
