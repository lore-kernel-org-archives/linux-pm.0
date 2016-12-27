From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 5/9] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Tue, 27 Dec 2016 17:39:49 +0200
Message-ID: <20161227153949.wbxvaabawquscpsn@kozik-lap>
References: <CGME20161223122531epcas1p4b8fad6664dad3408acb7a1b9f140884a@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
 <CA+Ln22HQPHF_Vj0kS834SH=4=hcNOpe_vL8P3fbS-jFhQLVyXA@mail.gmail.com>
 <5d09e29f-5796-cce6-75d5-ed5a0145092f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d09e29f-5796-cce6-75d5-ed5a0145092f@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 27, 2016 at 11:12:26AM +0100, Marek Szyprowski wrote:
> Hi Tomasz,
> 
> 
> On 2016-12-26 06:55, Tomasz Figa wrote:
> > 2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> > > Pad retention control after suspend/resume cycle should be done from pin
> > > controller driver instead of PMU (power management unit) driver to avoid
> > > possible ordering and logical dependencies. Till now it worked fine only
> > > because PMU driver registered its sys_ops after pin controller.
> > > 
> > > This patch moves pad retention control from PMU driver to Exynos pin
> > > controller driver. This is a preparation for adding new features to Exynos
> > > pin controller driver, like runtime power management and suspending
> > > individual pin controllers, which might be a part of some power domain.
> > > 
> > It looks like this change will essentially break the compatibility
> > with DTBs that don't have the pmu syscon specified in pin controller
> > nodes.
> > 
> > On the other hand, moving this code to where it actually belongs
> > really makes sense, so maybe we could just avoid the need of having
> > this property, by looking up the PMU manually, by hardcoded string or
> > so, if the proper property is not present?
> 
> Well, once again the topic of mythical device tree compatibility appearch.
> 
> There are imho following possibilities:
> 
> 1. https://patchwork.kernel.org/patch/9477963/ ("Explicitly mark Samsung
>    Exynos SoC bindings as unstable"), simply apply this approach and ignore
>    users, who don't update their device tree blobs (are there any??).

That is not how it works. Assuming that there was this "mythical
compatibility" then you would have to wait a few moments between marking
something "to be broken" and actually breaking it. In other words, if
you wanted to silence the "breaking compatibility" folks, then the patch
above should have been sent a while ago.

> 2. Switch to syscon_regmap_lookup_by_compatible() lookup and hardcode PMU
>    compatible id for all Exynos SoCs in the pin control driver. Then maybe,
>    while unifying the code, switch other Exynos drivers to this approach
>    and remove PMU phandles from device tree to make the code a bit more
>    consistent across drivers and easier to understand.
> 
> 3. Mixed approach, which combines drawbacks of both approaches. Additional
>    dead code for handling mythical compatibility and harder to understand
>    relations between the drivers.
> 
> 
> > [...]
> > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > index 1baf19eecabf..b7bd2e12a269 100644
> > > --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> > > @@ -43,6 +43,10 @@ Required Properties:
> > >                  };
> > >          };
> > > 
> > > +- samsung,pmu-syscon: Phandle to the PMU system controller, to let driver
> > > +  to control pad retention after system suspend/resume cycle (only for Exynos
> > > +  SoC series).
> > > +
> > Ah, here it is. I think adding relevant binding documentation at the
> > beginning of the series would make it much easier for reviewers to
> > understand the change.
> 
> I already pointed that patches are ordered to make the changes bisectable,
> what
> usually means that new properties are added first, before being required by
> the
> drivers.

I saw the explanation for this order and I don't have problems with it.
However you can always split to separate patch the documentation for
bindings. It won't break bisectability.

Best regards,
Krzysztof
