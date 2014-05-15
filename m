From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 09/10] thermal: exynos: remove redundant pdata checks from
 exynos_tmu_control()
Date: Thu, 15 May 2014 19:06:58 +0200
Message-ID: <2117889.Z2oDTHJSPp@amdc1032>
References: <1399288539-1793-1-git-send-email-b.zolnierkie@samsung.com>
 <1399288539-1793-10-git-send-email-b.zolnierkie@samsung.com>
 <20140515150308.GC27690@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140515150308.GC27690@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, May 15, 2014 11:03:08 AM Eduardo Valentin wrote:
> Hello Bartlomiej,

Hi,

> On Mon, May 05, 2014 at 01:15:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > pdata->reference_voltage and pdata->gain are always defined
> > to non-zero values so remove the redundant checks from
> > exynos_tmu_control().
> > 
> 
> In all existing SoCs? 

Yes.

> Should this be considered to any upcoming SoCs?

Yes, if/when it changes we will update the code.

> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index a8d9524..45d7c6f 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -215,15 +215,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
> >  	if (pdata->test_mux)
> >  		con |= (pdata->test_mux << reg->test_mux_addr_shift);
> >  
> > -	if (pdata->reference_voltage) {
> > -		con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
> > -		con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
> > -	}
> > +	con &= ~(reg->buf_vref_sel_mask << reg->buf_vref_sel_shift);
> > +	con |= pdata->reference_voltage << reg->buf_vref_sel_shift;
> >  
> > -	if (pdata->gain) {
> > -		con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
> > -		con |= (pdata->gain << reg->buf_slope_sel_shift);
> > -	}
> > +	con &= ~(reg->buf_slope_sel_mask << reg->buf_slope_sel_shift);
> > +	con |= (pdata->gain << reg->buf_slope_sel_shift);
> 
> The way it is put, looks like gain and reference_voltage are mandatory
> pdata fields. Should these checks be moved to initialization phase?

Yes, they should be considered mandatory pdata fields but I'm against
adding any superfluous pdata checks for initialization phase (I will
update struct exynos_tmu_platform_data documentation to indicate that
these fields cannot be zero instead).

> >  	if (pdata->noise_cancel_mode) {
> >  		con &= ~(reg->therm_trip_mode_mask <<

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
