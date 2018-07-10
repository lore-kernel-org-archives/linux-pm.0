From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 7/8] dt-bindings: Introduce interconnect consumers
 bindings
Date: Tue, 10 Jul 2018 15:34:51 -0700
Message-ID: <CAE=gft7tDYB172LTMuS4JPPaTFasT22zLBx4XjpYne2PNNz+kQ@mail.gmail.com>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-8-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180709155104.25528-8-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: georgi.djakov@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, linux-pm@vger.kernel.org, seansw@qti.qualcomm.com, gregkh@linuxfoundation.org, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, Bjorn Andersson <bjorn.andersson@linaro.org>, robh+dt@kernel.org, Saravana Kannan <skannan@codeaurora.org>, Alexandre Bailon <abailon@baylibre.com>, khilman@baylibre.com, linux-arm-msm@vger.kernel.org, tfiga@chromium.org, daidavid1@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 9, 2018 at 8:51 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add documentation for the interconnect consumer bindings, that will allow
> to link a device node (consumer) to its interconnect controller hardware.
>
> Tha aim is to enable drivers to request a framework API to configure an
> interconnect path by providing their struct device pointer and a name.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> index 6e2b2971b094..0ad65dccbe8b 100644
> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -31,3 +31,30 @@ Example:
>                         clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>                                  <&rpmcc RPM_SMD_SNOC_A_CLK>;
>                 };
> +
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which consume the interconnect
> +path(s) provided by the interconnect provider. There can be multiple

I wonder if this sentence could be more descriptive. Maybe something like:

The interconnect consumers are device nodes which dynamically express
their bandwidth requirements along interconnect paths they are
connected to.

...or choose a better one if this one's a mouthful.

> +interconnect providers on a SoC and the consumer may consume multiple paths
> +from different providers depending on use case and the components it has to
> +interact with.
> +
> +Required properties:
> +interconnects : Pairs of phandles and interconnect provider specifier to denote
> +               the edge source and destination ports of the interconnect path.
> +
> +Optional properties:
> +interconnect-names : List of interconnect path name strings sorted in the same
> +                    order as the interconnects property. Consumers drivers will use
> +                    interconnect-names to match interconnect paths with interconnect
> +                    specifiers.
> +
> +Example:
> +
> +       sdhci@7864000 {
> +               ...
> +               interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> +               interconnect-names = "ddr";
> +       };
