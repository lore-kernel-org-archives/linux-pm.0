From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5 7/8] drivers: cpuidle: initialize Exynos driver
 through DT
Date: Wed, 25 Jun 2014 17:58:18 +0100
Message-ID: <20140625165818.GB15050@e102568-lin.cambridge.arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-8-git-send-email-lorenzo.pieralisi@arm.com>
 <20140625151333.GE15240@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:60387 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300AbaFYQ6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jun 2014 12:58:24 -0400
In-Reply-To: <20140625151333.GE15240@leverpostej>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gm>

On Wed, Jun 25, 2014 at 04:13:33PM +0100, Mark Rutland wrote:
> On Wed, Jun 25, 2014 at 03:10:20PM +0100, Lorenzo Pieralisi wrote:
> > With the introduction of DT based idle states, CPUidle drivers for
> > ARM can now initialize idle states data through properties in the device
> > tree.
> > 
> > This patch adds code to the Exynos CPUidle driver to dynamically
> > initialize idle states data through the updated device tree source
> > files.
> > 
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> > Compile tested, I am not sure I patched the right dts files, please check.
> > 
> >  .../devicetree/bindings/arm/exynos/idle-states.txt | 27 ++++++++++++++++++++
> >  arch/arm/boot/dts/exynos3250.dtsi                  | 16 ++++++++++++
> >  arch/arm/boot/dts/exynos5250.dtsi                  | 15 +++++++++++
> >  arch/arm/boot/dts/exynos5410.dtsi                  | 17 +++++++++++++
> >  drivers/cpuidle/Kconfig.arm                        |  1 +
> >  drivers/cpuidle/cpuidle-exynos.c                   | 29 +++++++++++++---------
> >  6 files changed, 93 insertions(+), 12 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/exynos/idle-states.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/exynos/idle-states.txt b/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
> > new file mode 100644
> > index 0000000..342ecb4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/exynos/idle-states.txt
> > @@ -0,0 +1,27 @@
> > +idle-states node
> > +----------------
> > +
> > +On Exynos platforms with power management capabilities, the device
> > +tree source file must contain the idle-states node[1]. As defined in [1] the
> > +idle-states node must contain an entry-method property that for Exynos
> > +platforms can be one of:
> > +
> > +	- "samsung,exynos"
> 
> Similarly to the TC2 binding, what does this mean?
> 
> What is a kernel expected to do when it sees this entry-method?
> 
> Using "samsung,exynos" as the entry-method feels like something that's
> going to bite us; it sounds far too wide-reaching.

Same story as TC2, it adds nothing to the patch, it is just there for
compliance with current DT bindings, but useless and will disappear.

> >  static int exynos_cpuidle_probe(struct platform_device *pdev)
> >  {
> > -	int ret;
> > +	int ret, i;
> > +	struct cpuidle_driver *drv = &exynos_idle_driver;
> >  
> >  	exynos_enter_aftr = (void *)(pdev->dev.platform_data);
> >  
> > -	ret = cpuidle_register(&exynos_idle_driver, NULL);
> > +	drv->cpumask = (struct cpumask *) cpu_possible_mask;
> 
> This assignment looks scary to me. Why do we need to do this, and why
> are we throwing away the constness of cpu_possible_mask?

Yes, that's how it is done in CPUidle core if the idle driver does not
initialize cpumask pointer, I guess it is to save some bytes, but I agree
with you, I do not like that either, I will allocate the mask and copy.

Thanks,
Lorenzo

