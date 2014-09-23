From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 2/4] amba: Add helper macros for (un)preparing AMBA clock
Date: Tue, 23 Sep 2014 09:30:36 +0200
Message-ID: <1411457436.8863.3.camel@AMDC1943>
References: <1411379189-3017-1-git-send-email-k.kozlowski@samsung.com>
 <1411379189-3017-3-git-send-email-k.kozlowski@samsung.com>
 <CAPDyKFpADBgR90_4s6Dxa8GSQ3F2kQFf6Az-J85D_1ZVD6=A5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <CAPDyKFpADBgR90_4s6Dxa8GSQ3F2kQFf6Az-J85D_1ZVD6=A5A@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pon, 2014-09-22 at 20:56 +0200, Ulf Hansson wrote:
> On 22 September 2014 11:46, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > Add amba_pclk_prepare() and amba_pclk_unprepare() macros for handling
> > the AMBA bus clock by device drivers.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  include/linux/amba/bus.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> > index fdd7e1b61f60..ad52027a9cbf 100644
> > --- a/include/linux/amba/bus.h
> > +++ b/include/linux/amba/bus.h
> > @@ -92,6 +92,12 @@ void amba_release_regions(struct amba_device *);
> >  #define amba_pclk_disable(d)   \
> >         do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
> >
> > +#define amba_pclk_prepare(d)   \
> > +       (IS_ERR((d)->pclk) ? 0 : clk_prepare((d)->pclk))
> 
> You don't need the IS_ERR, because amba_probe will fail if it won't be
> able to fetch the clock.
> 
> Same comment below.

Right, I followed the convention for amba_pclk_enable but this is not
needed. I'll change it and send new version.

Best regards,
Krzysztof

> 
> Kind regards
> Uffe
> 
> > +
> > +#define amba_pclk_unprepare(d) \
> > +       do { if (!IS_ERR((d)->pclk)) clk_unprepare((d)->pclk); } while (0)
> > +
> >  /* Some drivers don't use the struct amba_device */
> >  #define AMBA_CONFIG_BITS(a) (((a) >> 24) & 0xff)
> >  #define AMBA_REV_BITS(a) (((a) >> 20) & 0x0f)
> > --
> > 1.9.1
> >

