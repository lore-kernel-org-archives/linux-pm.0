From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add devfreq driver for interconnect
 bandwidth voting
Date: Thu, 23 Aug 2018 16:00:18 +0300
Message-ID: <4fcac639-cba9-1a71-9b78-326ebb9242da@linaro.org>
References: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533171465-25508-2-git-send-email-skannan@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, vincent.guittot@linaro.org, daidavid1@codeaurora.org, bjorn.andersson@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Saravana,

On 08/02/2018 03:57 AM, Saravana Kannan wrote:
> This driver registers itself as a devfreq device that allows devfreq
> governors to make bandwidth votes for an interconnect path. This allows
> applying various policies for different interconnect paths using devfreq
> governors.
> 
> Example uses:
> * Use the devfreq performance governor to set the CPU to DDR interconnect
>   path for maximum performance.
> * Use the devfreq performance governor to set the GPU to DDR interconnect
>   path for maximum performance.
> * Use the CPU frequency to device frequency mapping governor to scale the
>   DDR frequency based on the needs of the CPUs' current frequency.

Usually CPUs and GPUs have dedicated cpufreq/devfreq drivers and i was
wondering if the interconnect support could be put into these drivers
directly?

> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/devfreq/icbw.txt |  21 ++++
>  drivers/devfreq/Kconfig                            |  13 +++
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/devfreq_icbw.c                     | 116 +++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/icbw.txt
>  create mode 100644 drivers/devfreq/devfreq_icbw.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/icbw.txt b/Documentation/devicetree/bindings/devfreq/icbw.txt
> new file mode 100644
> index 0000000..36cf045
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/icbw.txt
> @@ -0,0 +1,21 @@
> +Interconnect bandwidth device
> +
> +icbw is a device that represents an interconnect path that connects two
> +devices. This device is typically used to vote for BW requirements between
> +two devices. Eg: CPU to DDR, GPU to DDR, etc
> +
> +Required properties:
> +- compatible:		Must be "devfreq-icbw"
> +- interconnects:	Pairs of phandles and interconnect provider specifier
> +			to denote the edge source and destination ports of
> +			the interconnect path. See also:
> +		Documentation/devicetree/bindings/interconnect/interconnect.txt
> +- interconnect-names:	Must have one entry with the name "path".
> +
> +Example:
> +
> +	qcom,cpubw {
> +		compatible = "devfreq-icbw";
> +		interconnects = <&snoc MASTER_APSS_1 &bimc SLAVE_EBI_CH0>;
> +		interconnect-names = "path";

interconnect-names is optional when there is only a single path.

> +	};
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 3d9ae68..590370e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -121,6 +121,19 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config DEVFREQ_ICBW
> +	bool "DEVFREQ device for making bandwidth votes on interconnect paths"

Can this be a module?

> +	select DEVFREQ_GOV_PERFORMANCE
> +	select DEVFREQ_GOV_POWERSAVE
> +	select DEVFREQ_GOV_USERSPACE
> +	default n

There's no need to specify this default. It is 'n' by default anyway.
Also maybe you want to add something like:
	depends on INTERCONNECT=y

Thanks,
Georgi

> +	help
> +	  Different devfreq governors use this devfreq device to make
> +	  bandwidth votes for interconnect paths between different devices
> +	  (Eg: CPU to DDR, GPU to DDR, etc). This driver provides a generic
> +	  interface so that the devfreq governors can be shared across SoCs
> +	  and architectures.
> +
>  source "drivers/devfreq/event/Kconfig"
