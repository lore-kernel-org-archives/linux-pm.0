From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date: Wed, 26 Sep 2018 08:34:33 -0600
Message-ID: <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180925180215.GA12435@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, robdclark@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 25, 2018 at 01:02:15PM -0500, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> > This binding is intended to represent the relations between the interconnect
> > controllers (providers) and consumer device nodes. It will allow creating links
> > between consumers and interconnect paths (exposed by interconnect providers).
> 
> As I mentioned in person, I want to see other SoC families using this 
> before accepting. They don't have to be ready for upstream, but WIP 
> patches or even just a "yes, this works for us and we're going to use 
> this binding on X".
> 
> Also, I think the QCom GPU use of this should be fully sorted out. Or 
> more generically how this fits into OPP binding which seems to be never 
> ending extended...

This is a discussion I wouldn't mind having now.  To jog memories, this is what
I posted a few weeks ago:

https://patchwork.freedesktop.org/patch/246117/

This seems like the easiest way to me to tie the frequency and the bandwidth
quota together for GPU devfreq scaling but I'm not married to the format and
I'll happily go a few rounds on the bikeshed if we can get something we can
be happy with.

Jordan

> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> >  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > new file mode 100644
> > index 000000000000..5cb7d3c8d44d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -0,0 +1,60 @@
> > +Interconnect Provider Device Tree Bindings
> > +=========================================
> > +
> > +The purpose of this document is to define a common set of generic interconnect
> > +providers/consumers properties.
> > +
> > +
> > += interconnect providers =
> > +
> > +The interconnect provider binding is intended to represent the interconnect
> > +controllers in the system. Each provider registers a set of interconnect
> > +nodes, which expose the interconnect related capabilities of the interconnect
> > +to consumer drivers. These capabilities can be throughput, latency, priority
> > +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> > +depending on the use case. Interconnect providers can also be interconnect
> > +consumers, such as in the case where two network-on-chip fabrics interface
> > +directly
> 
> missing '.'
> 
> > +
> > +Required properties:
> > +- compatible : contains the interconnect provider compatible string
> > +- #interconnect-cells : number of cells in a interconnect specifier needed to
> > +			encode the interconnect node id
> > +
> > +Example:
> > +
> > +		snoc: snoc@580000 {
> > +			compatible = "qcom,msm8916-snoc";
> > +			#interconnect-cells = <1>;
> > +			reg = <0x580000 0x14000>;
> > +			clock-names = "bus_clk", "bus_a_clk";
> > +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> > +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> > +		};
> > +
> > +
> > += interconnect consumers =
> > +
> > +The interconnect consumers are device nodes which dynamically express their
> > +bandwidth requirements along interconnect paths they are connected to. There
> > +can be multiple interconnect providers on a SoC and the consumer may consume
> > +multiple paths from different providers depending on use case and the
> > +components it has to interact with.
> > +
> > +Required properties:
> > +interconnects : Pairs of phandles and interconnect provider specifier to denote
> > +	        the edge source and destination ports of the interconnect path.
> > +
> > +Optional properties:
> > +interconnect-names : List of interconnect path name strings sorted in the same
> > +		     order as the interconnects property. Consumers drivers will use
> > +		     interconnect-names to match interconnect paths with interconnect
> > +		     specifiers.
> 
> specifier pairs.
> 
> > +
> > +Example:
> > +
> > +	sdhci@7864000 {
> > +		...
> > +		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> > +		interconnect-names = "ddr";
> > +	};

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
