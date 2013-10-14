From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 3/5] thermal: exynos: Provide initial setting for TMU's
 test MUX address at Exynos4412
Date: Mon, 14 Oct 2013 17:00:32 +0200
Message-ID: <20131014170032.7ed18cad@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-4-git-send-email-l.majewski@samsung.com>
 <525BFEB0.9080609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <525BFEB0.9080609@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, kgene.kim@samsung.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> On 09-10-2013 02:29, Lukasz Majewski wrote:
> > The commit d0a0ce3e77c795258d47f9163e92d5031d0c5221 ("thermal:
> > exynos: Add missing definations and code cleanup") has removed
> > setting of test MUX address value at TMU configuration setting.
> > 
> > This field is not present on Exynos4210 and Exynos5 SoCs. However
> > on Exynos4412 SoC it is required to set this field after reset
> > because without it TMU shows maximal available temperature, which
> > causes immediate platform shutdown.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> > 
> > ---
> > Changes for v2:
> > - Define test_mux and test_mux_addr_shift to not use direct
> > register access
> > - Remove pdata->type == SOC_ARCH_EXYNOS4412 check at
> > exynos_tmu_control() and use only generic code
> > 
> >  drivers/thermal/samsung/exynos_tmu.c      |    3 +++
> >  drivers/thermal/samsung/exynos_tmu.h      |    4 ++++
> >  drivers/thermal/samsung/exynos_tmu_data.c |    2 ++
> >  drivers/thermal/samsung/exynos_tmu_data.h |    4 ++++
> >  4 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > b/drivers/thermal/samsung/exynos_tmu.c index 1312b34..32f38b9 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -317,6 +317,9 @@ static void exynos_tmu_control(struct
> > platform_device *pdev, bool on) 
> >  	con = readl(data->base + reg->tmu_ctrl);
> >  
> > +	if (pdata->test_mux)
> 
> 
> test_mux field is in fact an address, correct? Can 0 be a valid
> address?

No it isn't an address. It is the value which shall be written to
test_mux field of TMU_CONTROL register.

> 
> Why not using the feature flags to test for capabilities,

It is easier to assign value to test_mux tmu_data struct, than write
separate set of features for Exynos4412 and Exynos5250, which share the
code.

Also .features seems to define SoC independent features of TMU IP (like
TMU_SUPPORT_EMULATION).

The TEST_MUX setting is platform dependent (only Exynos4412 uses it),
so this is the rationale to define it at tmu platform data.

> features and
> required configurations instead of assuming obscure domain and address
> ranges?

TMU_MUX only uses 

(test_mux << test_mux_addr_shift) at tmu_ctrl register.


> 
> 
> > +		con |= (pdata->test_mux <<
> > reg->test_mux_addr_shift); +
> >  	if (pdata->reference_voltage) {
> >  		con &= ~(reg->buf_vref_sel_mask <<
> > reg->buf_vref_sel_shift); con |= pdata->reference_voltage <<
> > reg->buf_vref_sel_shift; diff --git
> > a/drivers/thermal/samsung/exynos_tmu.h
> > b/drivers/thermal/samsung/exynos_tmu.h index b42ece4..3fb6554
> > 100644 --- a/drivers/thermal/samsung/exynos_tmu.h +++
> > b/drivers/thermal/samsung/exynos_tmu.h @@ -85,6 +85,7 @@ enum
> > soc_type {
> >   * @triminfo_reload_shift: shift of triminfo reload enable bit in
> > triminfo_ctrl reg.
> >   * @tmu_ctrl: TMU main controller register.
> > + * @test_mux_addr_shift: shift bits of test mux address.
> >   * @buf_vref_sel_shift: shift bits of reference voltage in
> > tmu_ctrl register.
> >   * @buf_vref_sel_mask: mask bits of reference voltage in tmu_ctrl
> > register.
> >   * @therm_trip_mode_shift: shift bits of tripping mode in tmu_ctrl
> > register. @@ -151,6 +152,7 @@ struct exynos_tmu_registers {
> >  	u32	triminfo_reload_shift;
> >  
> >  	u32	tmu_ctrl;
> > +	u32     test_mux_addr_shift;
> >  	u32	buf_vref_sel_shift;
> >  	u32	buf_vref_sel_mask;
> >  	u32	therm_trip_mode_shift;
> > @@ -258,6 +260,7 @@ struct exynos_tmu_registers {
> >   * @first_point_trim: temp value of the first point trimming
> >   * @second_point_trim: temp value of the second point trimming
> >   * @default_temp_offset: default temperature offset in case of no
> > trimming
> > + * @test_mux; information if SoC supports test MUX
> >   * @cal_type: calibration type for temperature
> >   * @cal_mode: calibration mode for temperature
> >   * @freq_clip_table: Table representing frequency reduction
> > percentage. @@ -287,6 +290,7 @@ struct exynos_tmu_platform_data {
> >  	u8 first_point_trim;
> >  	u8 second_point_trim;
> >  	u8 default_temp_offset;
> > +	u8 test_mux;
> >  
> >  	enum calibration_type cal_type;
> >  	enum calibration_mode cal_mode;
> > diff --git a/drivers/thermal/samsung/exynos_tmu_data.c
> > b/drivers/thermal/samsung/exynos_tmu_data.c index d8de5c1..073c292
> > 100644 --- a/drivers/thermal/samsung/exynos_tmu_data.c
> > +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> > @@ -98,6 +98,7 @@ static const struct exynos_tmu_registers
> > exynos4412_tmu_registers = { .triminfo_ctrl =
> > EXYNOS_TMU_TRIMINFO_CON, .triminfo_reload_shift =
> > EXYNOS_TRIMINFO_RELOAD_SHIFT, .tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
> > +	.test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
> >  	.buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
> >  	.buf_vref_sel_mask = EXYNOS_TMU_REF_VOLTAGE_MASK,
> >  	.therm_trip_mode_shift = EXYNOS_TMU_TRIP_MODE_SHIFT,
> > @@ -174,6 +175,7 @@ struct exynos_tmu_init_data const
> > exynos4412_default_tmu_data = { {
> >  			EXYNOS4412_TMU_DATA,
> >  			.type = SOC_ARCH_EXYNOS4412,
> > +			.test_mux = EXYNOS4412_MUX_ADDR_VALUE,
> >  		},
> >  	},
> >  	.tmu_count = 1,
> > diff --git a/drivers/thermal/samsung/exynos_tmu_data.h
> > b/drivers/thermal/samsung/exynos_tmu_data.h index b130b1e..a1ea19d
> > 100644 --- a/drivers/thermal/samsung/exynos_tmu_data.h
> > +++ b/drivers/thermal/samsung/exynos_tmu_data.h
> > @@ -95,6 +95,10 @@
> >  
> >  #define EXYNOS_MAX_TRIGGER_PER_REG	4
> >  
> > +/* Exynos4412 specific */
> > +#define EXYNOS4412_MUX_ADDR_VALUE          6
> 
> > +#define EXYNOS4412_MUX_ADDR_SHIFT          20
> > +
> >  /*exynos5440 specific registers*/
> >  #define EXYNOS5440_TMU_S0_7_TRIM		0x000
> >  #define EXYNOS5440_TMU_S0_7_CTRL		0x020
> > 
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
