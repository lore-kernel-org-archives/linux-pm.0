From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
Date: Tue, 26 Jun 2018 17:55:23 -0700
Message-ID: <20180627005523.GS129942@google.com>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
 <20180620121141.15403-5-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180620121141.15403-5-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 20, 2018 at 03:11:37PM +0300, Georgi Djakov wrote:
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle comminication

s/comminication/communication/

> with this remote processor.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
>  drivers/interconnect/qcom/Makefile            |  2 +
>  drivers/interconnect/qcom/smd-rpm.c           | 90 +++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h           | 15 ++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
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
> +			"qcom,interconnect-smd-rpm"
> +
> +Example:
> +	smd {
> +		compatible = "qcom,smd";
> +
> +		rpm {
> +			interrupts = <0 168 1>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests {
> +				compatible = "qcom,rpm-msm8916";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				interconnect-smd-rpm {
> +					compatible = "qcom,interconnect-smd-rpm";
> +				};
> +
> +			};
> +		};
> +	};
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> new file mode 100644
> index 000000000000..2a0c41db91c4
> --- /dev/null
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-y += smd-rpm.o
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> new file mode 100644
> index 000000000000..0cf772f51642
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPM over SMD communication wrapper for interconects

s/interconects/interconnects/
