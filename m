From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider bindings
Date: Thu, 2 Aug 2018 15:02:16 -0600
Message-ID: <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-3-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731161340.13000-3-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org, maxime.ripard@bootlin.com
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, skannan@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alexandre Bailon <abailon@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 10:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This binding is intended to represent the interconnect hardware present
> in some of the modern SoCs. Currently it consists only of a binding for
> the interconnect hardware devices (provider).

If you want the bindings reviewed, then you need to send them to the
DT list. CC'ing me is pointless, I get CC'ed too many things to read.

The consumer and producer binding should be a single patch. One is not
useful without the other.

There is also a patch series from Maxime Ripard that's addressing the
same general area. See "dt-bindings: Add a dma-parent property". We
don't need multiple ways to address describing the device to memory
paths, so you all had better work out a common solution.

Rob

>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..6e2b2971b094
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,33 @@
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
> +depending on the use case. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly
> +
> +Required properties:
> +- compatible : contains the interconnect provider compatible string
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +                       encode the interconnect node id
> +
> +Example:
> +
> +               snoc: snoc@580000 {
> +                       compatible = "qcom,msm8916-snoc";
> +                       #interconnect-cells = <1>;
> +                       reg = <0x580000 0x14000>;
> +                       clock-names = "bus_clk", "bus_a_clk";
> +                       clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                                <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +               };
