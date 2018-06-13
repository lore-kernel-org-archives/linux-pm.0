From: Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Wed, 13 Jun 2018 17:00:18 +0100
Message-ID: <20180613160018.GB10090@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180607181306.9766-1-ctatlor97@gmail.com>
 <20180607181306.9766-3-ctatlor97@gmail.com>
 <20180611181515.GA32546@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611181515.GA32546@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 11, 2018 at 12:15:15PM -0600, Rob Herring wrote:
> On Thu, Jun 07, 2018 at 07:12:51PM +0100, Craig Tatlor wrote:
> > Add bindings for the Qualcomm Battery Monitoring system.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> > ---
> > * Changes from v4:
> >   Uses proper units and expands some definitions,
> >   along with changing vadc@ to adc@.
> > 
> >  .../bindings/power/supply/qcom_bms.txt        | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/qcom_bms.txt b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > new file mode 100644
> > index 000000000000..a1a32d6ab460
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms.txt
> > @@ -0,0 +1,91 @@
> > +Qualcomm Battery Monitoring System
> > +
> > +The Qualcomm Battery Monitoring System is found inside of Qualcomm PM8941
> > +PMICs. It provides open circuit voltage (OCV) and coulomb counter registers
> > +that allow the OS to infer a capacity level.
> > +
> > +Required properties:
> > +- compatible:                   Should contain "qcom,pm8941-bms".
> > +- reg:                          Specifies the SPMI address and length of the
> > +				controller's registers.
> > +- interrupts:                   OCV threshold interrupt.
> > +- io-channels:                  Should contain IIO channel specifier for the
> > +				ADC channel that reports battery temperature.
> > +- io-channel-names:             Should contain "temp".
> > +- qcom,fcc-temp-legend-celcius: An array containing the temperature, in degC,
> > +				for each column of the full charge capacity
> > +				lookup table.
> > +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity values in uah,
> > +				one entry for each temperature defined in in
> > +				qcom,fcc-temp-legend-celcius.
> > +- qcom,ocv-temp-legend-celcius: An array containing the temperature, in degC,
> > +				for each column of the OCV lookup table.
> > +- qcom,ocv-capacity-legend:     An array containing the capacity for each
> > +				row of the OCV lookup table.
> > +- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one entry for each
> > +				capacity defined in qcom,ocv-capacity-legend.
> 
> Need to say which of these are 8-bit values.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for the review, will mark as 8 bit in v6
