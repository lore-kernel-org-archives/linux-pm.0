From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC 1/3] devfreq: dt-bindings: Document Exynos3250 devfreq driver
Date: Mon, 08 Dec 2014 10:46:17 +0100
Message-ID: <1418031977.6084.13.camel@AMDC1943>
References: <1647680679.696101418015213383.JavaMail.weblogic@epmlwas04c>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1647680679.696101418015213383.JavaMail.weblogic@epmlwas04c>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?UTF-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

On pon, 2014-12-08 at 05:06 +0000, MyungJoo Ham wrote:
> >   
> >  Add documentation for bindings used by Exynos3250 devfreq driver.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  .../bindings/arm/samsung/exynos3250-devfreq.txt    | 66 ++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> > new file mode 100644
> > index 000000000000..047955e9e371
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung/exynos3250-devfreq.txt
> > @@ -0,0 +1,66 @@
> > +Samsung Exynos3250 devfreq driver
> > +=================================
> > +
> > +The driver support changing frequencies and voltage for:
> > + - memory controller and bus,
> > + - peripheral buses (left and right).
> > +
> > +Memory controller and bus
> > +=========================
> > +Required properties:
> > + - compatible : should be "samsung,exynos3250-busfreq-mif"
> > + - reg : two sets (offset and length of the register) for PPMU registers
> > +	used by this devfreq driver
> > + - clock-names : one clock of name "dmc" to manage frequency
> > + - clocks : phandle and specifier for clock listed in clock-names property
> > + - vdd_mif-supply : phandle to MIF voltage regulator
> > +
> > +Peripheral buses
> > +================
> > +Required properties:
> > + - compatible : should be "samsung,exynos3250-busfreq-int"
> > + - reg : two sets (offset and length of the register) for PPMU registers
> > +	used by this devfreq driver
> > + - clock-names : names for PPMU clocks and bus clocks to manage frequencies;
> > +	All following clock names (and corresponding phandles) must be
> > +	provided:
> > +	- "ppmu_left", "ppmu_right",
> > +	- "aclk_400", "aclk_266", "aclk_200", "aclk_160", "aclk_gdl", "aclk_gdr", "mfc";
> > + - clocks : phandles and specifiers for clocks listed in clock-names property
> > + - vdd_mif-supply : phandle to INT voltage regulator
> > +
> > +Example
> > +=======
> > +	busfreq_mif: busfreq@106A0000 {
> > +		compatible = "samsung,exynos3250-busfreq-mif";
> > +		reg = <0x106A0000 0x2000>, <0x106B0000 0x2000>;
> > +		clocks = <&cmu_dmc CLK_DIV_DMC>;
> > +		clock-names = "dmc";
> > +		vdd_mif-supply = <&buck1_reg>;
> > +		status = "okay";
> > +	};
> 
> The hardware you are binding hereby is "Exynos PPMU".
> You may consider to bind PPMU (DMC PPMU or BUS PPMU whichever hardware
> you want to use) with DT and then let exynos bus devfreq driver use
> the already-bound devices if found, ... in principle.
> In other words or point of view, you may implement PPMU driver in
> devfreq class device driver so that you let it bind PPMU device with DT.
> It may be done similarly with the device below.

Yes, you're right. I saw also similar case for Tegra Activity Monitor. 

Thanks for pointing this,
Krzysztof


> 
> 
> Cheers,
> MyungJoo.
> 
> 
> > +
> > +	busfreq_int: busfreq@116A0000 {
> > +		compatible = "samsung,exynos3250-busfreq-int";
> > +		reg = <0x116A0000 0x2000>, <0x112A0000 0x2000>;
> > +		clocks = <&cmu CLK_PPMULEFT>,
> > +			<&cmu CLK_PPMURIGHT>,
> > +			<&cmu CLK_DIV_ACLK_400_MCUISP>,
> > +			<&cmu CLK_DIV_ACLK_266>,
> > +			<&cmu CLK_DIV_ACLK_200>,
> > +			<&cmu CLK_DIV_ACLK_160>,
> > +			<&cmu CLK_DIV_GDL>,
> > +			<&cmu CLK_DIV_GDR>,
> > +			<&cmu CLK_DIV_MFC>;
> > +		clock-names = "ppmuleft",
> > +			"ppmuright",
> > +			"aclk_400",
> > +			"aclk_266",
> > +			"aclk_200",
> > +			"aclk_160",
> > +			"aclk_gdl",
> > +			"aclk_gdr",
> > +			"mfc";
> > +		vdd_int-supply = <&buck3_reg>;
> > +		status = "okay";
> > +	};
> > -- 
> > 1.9.1
> > 
