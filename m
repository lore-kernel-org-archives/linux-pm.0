From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: Exynos5420: Add device nodes for TMU blocks
Date: Thu, 07 Nov 2013 17:45:16 +0100
Message-ID: <6654895.bR12A8qC1P@amdc1227>
References: <1382004240-3282-1-git-send-email-l.krishna@samsung.com>
 <22321712.GIyJDTupbe@amdc1227>
 <CAHfPSqARSJqbXv9F+Fgro_=k3P2xE3XNsF-KYOW43WdVtKeSEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAHfPSqARSJqbXv9F+Fgro_=k3P2xE3XNsF-KYOW43WdVtKeSEA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, amit.daniel@samsung.com, Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Naveen,

On Thursday 07 of November 2013 22:02:10 Naveen Krishna Ch wrote:
> Hello Tomasz,
> 
> On 7 November 2013 19:53, Tomasz Figa <t.figa@samsung.com> wrote:
> > Hi Naveen,
> >
> > On Thursday 07 of November 2013 18:37:49 Naveen Krishna Chatradhi wrote:
> >> Exynos5420 SoC has per core thermal management unit.
> >> 5 TMU channels 4 for CPUs and 5th for GPU.
> >>
> >> This patch adds the device tree nodes to the DT device list.
> >>
> >> Nodes carry the misplaced second base address and the second
> >> clock to access the misplaced base address.
> >>
> >> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >> ---
> >> Changes since v1:
> >> 1. Nodes carry the misplaced second base address and the second
> >>    clock to access the misplaced base address.
> >> 2. Correct the clock number for the TMU4
> >
> > First of all, this patch should be a part of the whole series adding
> > support for thermal on Exynos 5420.
> Right, Reason why i posted this patch myself fixing the nits (As Leela
> and i work closely)
> Should have been along with the set.

OK.

> >
> > In addition, see my comment below.
> >
> >>  arch/arm/boot/dts/exynos5420.dtsi |   48 +++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> >> index 6ffefd1..d736b40 100644
> >> --- a/arch/arm/boot/dts/exynos5420.dtsi
> >> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> >> @@ -369,4 +369,52 @@
> >>               clock-names = "gscl";
> >>               samsung,power-domain = <&gsc_pd>;
> >>       };
> >> +
> >> +     /* tmu for CPU0 */
> >> +     tmu@10060000 {
> >> +             compatible = "samsung,exynos5420-tmu";
> >> +             reg = <0x10060000 0x100>;
> >> +             interrupts = <0 65 0>;
> >> +             clocks = <&clock 318>;
> >> +             clock-names = "tmu_apbif";
> >> +     };
> >> +
> >> +     /* tmu for CPU1 */
> >> +     tmu@10064000 {
> >> +             compatible = "samsung,exynos5420-tmu";
> >> +             reg = <0x10064000 0x100>;
> >> +             interrupts = <0 183 0>;
> >> +             clocks = <&clock 318>;
> >> +             clock-names = "tmu_apbif";
> >> +     };
> >> +
> >> +     /* tmu for CPU2 */
> >> +     tmu@10068000 {
> >> +             compatible = "samsung,exynos5420-tmu";
> >> +             /* 2nd reg is for the misplaced TRIMINFO register */
> >
> > Instead of this comment, such broken TMU variant should use a separate
> > compatible value, like "samsung,exynos5420-tmu-broken-triminfo", like
> > I mentioned in my comments to your other patch.
> Will make a note of it.

OK.

> >
> > For this compatible value, both second reg entry and second clock would
> > be required.
> >
> >> +             reg = <0x10068000 0x100>, <0x1006c000 0x4>;
> >> +             interrupts = <0 184 0>;
> >> +             clocks = <&clock 318>;
> >> +             clock-names = "tmu_apbif";
> >> +     };
> >> +
> >> +     /* tmu for CPU3 */
> >> +     tmu@1006c000 {
> >> +             compatible = "samsung,exynos5420-tmu";
> >> +             /* 2nd reg is for the misplaced TRIMINFO register */
> >> +             reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
> >> +             interrupts = <0 185 0>;
> >> +             clocks = <&clock 318>, <&clock 319>;
> >> +             clock-names = "tmu_apbif", "tmu_apbif_triminfo";
> >
> > The "tmu_apbif_triminfo" clock is not specified in exynos-thermal binding
> > documentation. In addition, the patch of yours adding support for second
> > clock uses another name - "tmu_apbif_sec".
> >
> > As for the name itself, I would prefer "tmu_apbif_triminfo" as it's more
> > meaningful.
> TMU hardware on Exynos5440 and Exynos5420 has two different abnormalities
> On Exynos5440 Some registers are interleaved between the channels
> On Exynos5420, TRIMINFO is misplaced between, channels 2, 3 and 4.

I know that those cases are different, but my point was not about it.

In your patch adding support for this second clock, you add following call
to devm_clk_get():

	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_apbif_sec");

However in device tree nodes added by this patch, you have

	clock-names = "tmu_apbif", "tmu_apbif_triminfo";

and this where my confusion comes from.

> having second_base was for the fix by Amit to address Exynos5440 problem,
> Which was already merged.
> After several reviews i tried to solve it by reusing the second_base
> for Exynos5420 aswell.
> Hence, I tried to use the "clk_sec" or "clk_second" which will rhyme
> along with the
> "second_base" in the driver.
> 
> I'm still not sure this having second clock is needed for Exynos5440 aswell.
> Will figure it out tomorrow.

Even if Exynos 5440 does not need the second clock, it uses a different
compatible value, so you can easily distinguish the cases when the second
clock is required or not.

Best regards,
Tomasz
