From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 1/2] dts: Documentation: Add documentation for Exynos7
 SoC thermal bindings
Date: Thu, 29 Jan 2015 08:45:49 +0100
Message-ID: <20150129084549.56300738@amdc2363>
References: <1422337703-11289-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voan-aoVQtRCFaB2rLLOgm+CEXg+Mc2gwfokUTu5eeQDo+g@mail.gmail.com>
 <20150128172319.GG29600@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150128172319.GG29600@developer.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Abhilash Kesavan <kesavan.abhilash@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> On Wed, Jan 28, 2015 at 04:21:49PM +0530, Abhilash Kesavan wrote:
> > Hi Eduardo,
> > 
> > On Tue, Jan 27, 2015 at 11:18 AM, Abhilash Kesavan
> > <a.kesavan@samsung.com> wrote:
> > > Add documentation for exynos7 thermal bindings including
> > > compatible name and special clock properties.
> > >
> > > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > > ---
> > >  .../devicetree/bindings/thermal/exynos-thermal.txt |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > > b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > > index 0f44932..695150a 100644 ---
> > > a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > > +++
> > > b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt @@
> > > -12,6 +12,7 @@ "samsung,exynos5420-tmu-ext-triminfo" for TMU
> > > channels 2, 3 and 4 Exynos5420 (Must pass triminfo base and
> > > triminfo clock) "samsung,exynos5440-tmu"
> > > +              "samsung,exynos7-tmu"
> > >  - interrupt-parent : The phandle for the interrupt controller
> > >  - reg : Address range of the thermal registers. For soc's which
> > > has multiple instances of TMU and some registers are shared
> > > across all TMU's like @@ -32,10 +33,13 @@
> > >  - clocks : The main clocks for TMU device
> > >         -- 1. operational clock for TMU channel
> > >         -- 2. optional clock to access the shared registers of
> > > TMU channel
> > > +       -- 3. optional special clock for functional operation
> > >  - clock-names : Thermal system clock name
> > >         -- "tmu_apbif" operational clock for current TMU channel
> > >         -- "tmu_triminfo_apbif" clock to access the shared
> > > triminfo register for current TMU channel
> > > +       -- "tmu_sclk" clock for functional operation of the
> > > current TMU
> > > +               channel
> > >  - vtmu-supply: This entry is optional and provides the regulator
> > > node supplying voltage to TMU. If needed this entry can be placed
> > > inside board/platform specific dts file.
> > 
> > Can you kindly consider applying these two patches to your next tree
> > if they look OK ?
> 
> Abhilash, can you please get at least one Reviewed-by from one of the
> active developers of exynos thermal driver?

I will review your patches. :-)

> 
> 
> > 
> > Regards,
> > Abhilash
> > > --
> > > 1.7.9.5
> > >



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
