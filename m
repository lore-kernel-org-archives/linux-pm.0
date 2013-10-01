From: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/6] thermal: exynos: Provide initial setting for TMU's
 test MUX address at Exynos4412
Date: Tue, 01 Oct 2013 08:55:02 +0200
Message-ID: <20131001085502.187f54ab@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1380010102-25817-4-git-send-email-l.majewski@samsung.com>
 <CADGdYn6a1jSR17v0N6kVFZFsn71FUbXJHjeSya-xy_wX9GtYpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CADGdYn6a1jSR17v0N6kVFZFsn71FUbXJHjeSya-xy_wX9GtYpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: amit daniel kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

> Hi,
> 
> On Tue, Sep 24, 2013 at 1:38 PM, Lukasz Majewski
> <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > The commit d0a0ce3e77c795258d47f9163e92d5031d0c5221 ("thermal:
> > exynos: Add missing definations and code cleanup") has removed
> > setting of test MUX address value at TMU configuration setting.
> >
> > This field is not present on Exynos4210 and Exynos5 SoCs. However
> > on Exynos4412 SoC it is required to set this field after reset
> > because without it TMU shows maximal available temperature, which
> > causes immediate platform shutdown.
> Right In 5250 this field is not defined so didn't catch this. The
> changes looks fine but I have a minor comment that if this field is
> defined in 4412 in detail then you can add a field entry in
> exynos_tmu_registers with proper name and populate this field. 

It seems, that only at Exynos4412 (and Exynos4212) this field is valid.
When I extent exynos_tmu_registers structure, then all other Samsung
SoCs will be aware of it.
Define with explicit EXYNOS4412 seems more readable. 


Also at exynos_tmu_control() function we use constructs like:
data->base + EXYNOS_TMU_REG_CONTROL, not data->base + regs->tmu_ctrl.

> The
> good thing is that in 5250 also this field is reserved and the default
> value is 0x6 so same TMU_DATA can be used for 5250 and 4412.

I'm not keen to this kind of hacks. This field is only valid on
Exynos4x12. And for Exynos5250 is reserved, which means that we shall
not touch it.

> The main
> idea of this suggestion is to reduce the soc checks in the driver.

Correct me if I'm wrong, but this MUX_ADDR initialization is performed
at exynos_tmu_control() which is called at probe and thermal power
management functions. Therefore, it seems that checking if SoC ==
Exynos4412 there is not an overkill.

If you don't mind I would leave those patches as they are and kindly
ask thermal maintainers for pulling them to v3.12.

> 
> Thanks,
> Amit Daniel
> >
> > Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c      |    3 +++
> >  drivers/thermal/samsung/exynos_tmu_data.h |    4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c index a858cc4..21b89e4 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -317,6 +317,9 @@ static void exynos_tmu_control(struct
> > platform_device *pdev, bool on)
> >
> >         con = readl(data->base + reg->tmu_ctrl);
> >
> > +       if (pdata->type == SOC_ARCH_EXYNOS4412)
> > +               con |= (EXYNOS4412_MUX_ADDR_VALUE <<
> > EXYNOS4412_MUX_ADDR_SHIFT); +
> >         if (pdata->reference_voltage) {
> >                 con &= ~(reg->buf_vref_sel_mask <<
> > reg->buf_vref_sel_shift); con |= pdata->reference_voltage <<
> > reg->buf_vref_sel_shift; diff --git
> > a/drivers/thermal/samsung/exynos_tmu_data.h
> > b/drivers/thermal/samsung/exynos_tmu_data.h index b130b1e..a1ea19d
> > 100644 --- a/drivers/thermal/samsung/exynos_tmu_data.h +++
> > b/drivers/thermal/samsung/exynos_tmu_data.h @@ -95,6 +95,10 @@
> >
> >  #define EXYNOS_MAX_TRIGGER_PER_REG     4
> >
> > +/* Exynos4412 specific */
> > +#define EXYNOS4412_MUX_ADDR_VALUE          6
> > +#define EXYNOS4412_MUX_ADDR_SHIFT          20
> > +
> >  /*exynos5440 specific registers*/
> >  #define EXYNOS5440_TMU_S0_7_TRIM               0x000
> >  #define EXYNOS5440_TMU_S0_7_CTRL               0x020
> > --
> > 1.7.10.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> On Tue, Sep 24, 2013 at 1:38 PM, Lukasz Majewski
> <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > The commit d0a0ce3e77c795258d47f9163e92d5031d0c5221 ("thermal:
> > exynos: Add missing definations and code cleanup") has removed
> > setting of test MUX address value at TMU configuration setting.
> >
> > This field is not present on Exynos4210 and Exynos5 SoCs. However
> > on Exynos4412 SoC it is required to set this field after reset
> > because without it TMU shows maximal available temperature, which
> > causes immediate platform shutdown.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c      |    3 +++
> >  drivers/thermal/samsung/exynos_tmu_data.h |    4 ++++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c index a858cc4..21b89e4 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -317,6 +317,9 @@ static void exynos_tmu_control(struct
> > platform_device *pdev, bool on)
> >
> >         con = readl(data->base + reg->tmu_ctrl);
> >
> > +       if (pdata->type == SOC_ARCH_EXYNOS4412)
> > +               con |= (EXYNOS4412_MUX_ADDR_VALUE <<
> > EXYNOS4412_MUX_ADDR_SHIFT); +
> >         if (pdata->reference_voltage) {
> >                 con &= ~(reg->buf_vref_sel_mask <<
> > reg->buf_vref_sel_shift); con |= pdata->reference_voltage <<
> > reg->buf_vref_sel_shift; diff --git
> > a/drivers/thermal/samsung/exynos_tmu_data.h
> > b/drivers/thermal/samsung/exynos_tmu_data.h index b130b1e..a1ea19d
> > 100644 --- a/drivers/thermal/samsung/exynos_tmu_data.h +++
> > b/drivers/thermal/samsung/exynos_tmu_data.h @@ -95,6 +95,10 @@
> >
> >  #define EXYNOS_MAX_TRIGGER_PER_REG     4
> >
> > +/* Exynos4412 specific */
> > +#define EXYNOS4412_MUX_ADDR_VALUE          6
> > +#define EXYNOS4412_MUX_ADDR_SHIFT          20
> > +
> >  /*exynos5440 specific registers*/
> >  #define EXYNOS5440_TMU_S0_7_TRIM               0x000
> >  #define EXYNOS5440_TMU_S0_7_CTRL               0x020
> > --
> > 1.7.10.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
