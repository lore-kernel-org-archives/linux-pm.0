From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC v0 1/2] interconnect: Add generic interconnect controller
 API
Date: Thu, 09 Mar 2017 10:56:40 +0100
Message-ID: <1489053400.32329.43.camel@pengutronix.de>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
         <20170301182235.19154-2-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301182235.19154-2-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, gregkh@linuxfoundation.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, den 01.03.2017, 20:22 +0200 schrieb Georgi Djakov:
> This patch introduce a new API to get the requirement and configure the
> interconnect buses across the entire chipset to fit with the current demand.
> 
> The API is using a consumer/provider-based model, where the providers are
> the interconnect controllers and the consumers could be various drivers.
> The consumers request interconnect resources (path) to an endpoint and set
> the desired constraints on this data flow path. The provider(s) receive
> requests from consumers and aggregate these requests for all master-slave
> pairs on that path. Then the providers configure each participating in the
> topology node according to the requested data flow path, physical links and
> constraints. The topology could be complicated and multi-tiered and is SoC
> specific.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt         |  91 +++++++
>  Documentation/interconnect/interconnect.txt        |  68 +++++
>  drivers/Kconfig                                    |   2 +
>  drivers/Makefile                                   |   1 +
>  drivers/interconnect/Kconfig                       |  10 +
>  drivers/interconnect/Makefile                      |   1 +
>  drivers/interconnect/interconnect.c                | 285 +++++++++++++++++++++
>  include/linux/interconnect-consumer.h              |  70 +++++
>  include/linux/interconnect-provider.h              |  92 +++++++
>  9 files changed, 620 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>  create mode 100644 Documentation/interconnect/interconnect.txt
>  create mode 100644 drivers/interconnect/Kconfig
>  create mode 100644 drivers/interconnect/Makefile
>  create mode 100644 drivers/interconnect/interconnect.c
>  create mode 100644 include/linux/interconnect-consumer.h
>  create mode 100644 include/linux/interconnect-provider.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..c62d86e4c52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,91 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the usecase.
> +
> +Required properties:
> +- compatible : contains the interconnect provider vendor specific compatible
> +	       string
> +- reg : register space of the interconnect controller hardware
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +		       encode the interconnect node id.
> +
> +
> +Optional properties:
> +interconnect-port : A phandle and interconnect provider specifier as defined by
> +		bindings of the interconnect provider specified by phandle.
> +		This denotes the port to which the interconnect consumer is
> +		wired. It is used when there are multiple interconnect providers
> +		that have one or multiple links between them.

I think this isn't required. We should try to get a clear definition for
both the provider, as well as the consumer without mixing them in the
binding.

Hierarchical interconnect nodes can always be both a provider and a
consumer of interconnect ports at the same time.
 
> +
> +Example:
> +
> +		snoc: snoc@0580000 {
> +			compatible = "qcom,msm-bus-snoc";
> +			reg = <0x580000 0x14000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>, <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&bimc MAS_SNOC_CFG>,
> +					<&bimc SNOC_BIMC_0_MAS>,
> +					<&bimc SNOC_BIMC_1_MAS>,
> +					<&pnoc SNOC_PNOC_SLV>;
> +		};
> +		bimc: bimc@0400000 {
> +			compatible = "qcom,msm-bus-bimc";
> +			reg = <0x400000 0x62000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>, <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&snoc BIMC_SNOC_MAS>;
> +		};
> +		pnoc: pnoc@500000 {
> +			compatible = "qcom,msm-bus-pnoc";
> +			reg = <0x500000 0x11000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>, <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +			status = "okay";
> +			interconnect-port = <&snoc PNOC_SNOC_SLV>;
> +		};
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which consume the interconnect
> +path(s) provided by the interconnect provider. There can be multiple
> +interconnect providers on a SoC and the consumer may consume multiple paths
> +from different providers depending on usecase and the components it has to
> +interact with.
> +
> +Required-properties:
> +interconnect-port : A phandle and interconnect provider specifier as defined by
> +		bindings of the interconnect provider specified by phandle.
> +		This denotes the port to which the interconnect consumer is
> +		wired.
> +interconnect-path : List of phandles to the data path endpoints.
> +interconnect-path-names : List of interconnect path name strings sorted in the
> +		same order as the interconnect-path property.  Consumers drivers
> +		will use interconnect-path-names to match the link names with
> +		interconnect specifiers.
> +
> +Example:
> +
> +	sdhci@07864000 {
> +		...
> +		interconnect-port = <&pnoc MAS_PNOC_SDCC_2>;
> +		interconnect-path = <&blsp1_uart2>;
> +		interconnect-path-names = "spi";
> +	};

Sorry, but this binding is not entirely clear to me. What do the paths
do?

>From a device perspective you have 1..n master ports, that are wired to
1..n slave ports on the interconnect side. Wouldn't it be sufficient to
specify the phandles to the interconnect slave ports?

Also this should probably be a plural "ports", as a device might have
multiple master ports. This would need a "port-names" property, so the
device can reference the correct slave port when making QoS requests.
For devices with one read and one write port the QoS requirements of
both ports may be vastly different.

Regards,
Lucas
