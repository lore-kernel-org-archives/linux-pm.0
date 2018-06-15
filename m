From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
Date: Fri, 15 Jun 2018 15:02:30 +0300
Message-ID: <CAHLCerNeWjBY=ZHyrA7RYW6_qSk9SZoxE7P6fr43Z8-pTv-c4Q@mail.gmail.com>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org> <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 12, 2018 at 2:02 PM, Taniya Das <tdas@codeaurora.org> wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |   9 +
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c | 336 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 52f5f1a..2683716 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -312,3 +312,12 @@ config ARM_PXA2xx_CPUFREQ
>           This add the CPUFreq driver support for Intel PXA2xx SOCs.
>
>           If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_FW
> +       bool "QCOM CPUFreq FW driver"
> +       help
> +        Support for the CPUFreq FW driver.
> +        The CPUfreq FW preset in some QCOM chipsets offloads the steps

s/preset/present

> +        necessary for changing the frequency of CPUs. The driver

I'd rephrase this a bit to address Sudeep's comment. Something like:

"Some QCOM chipsets have a HW engine to offload the steps necessary
for changing the frequency of the CPUs. Firmware loaded in this engine
exposes a programming interface to the high-level OS. This driver
exposes a cpufreq abstraction for this HW engine. Say Y ....."

> +        implements the cpufreq driver interface for this firmware.
> +        Say Y if you want to support CPUFreq FW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index fb4a2ec..34691a2 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)    += tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)     += tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)           += ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ) += vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)      += qcom-cpufreq-fw.o
>

<snip>

> +static const struct of_device_id match_table[] = {
> +       { .compatible = "qcom,cpufreq-fw" },
> +       {}
> +};
> +
> +static struct platform_driver qcom_cpufreq_fw_driver = {
> +       .probe = qcom_cpufreq_fw_driver_probe,
> +       .driver = {
> +               .name = "qcom-cpufreq-fw",
> +               .of_match_table = match_table,
> +               .owner = THIS_MODULE,
> +       },
> +};
> +
> +static int __init qcom_cpufreq_fw_init(void)
> +{
> +       return platform_driver_register(&qcom_cpufreq_fw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_fw_init);
> +
> +MODULE_DESCRIPTION("QCOM CPU Frequency FW");

This can be a bit more descriptive, e.g.

"QCOM firmware-based CPU Frequency  driver"

> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
