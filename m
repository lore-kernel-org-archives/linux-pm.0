From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 22 Nov 2016 13:52:42 -0800
Message-ID: <20161122215240.GA52900@google.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
 <20161122205737.GB45366@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161122205737.GB45366@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: heiko@sntech.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 22, 2016 at 12:57:37PM -0800, Brian Norris wrote:
> On Tue, Nov 22, 2016 at 08:34:46PM +0800, Caesar Wang wrote:
> > The temp_to_code function will return 0 when we set the trip points value
> > or valid temperature.
> 
> I'm not quite sure what you mean by "when we set the trip points value
> or valid temperature." Do you mean "when we set the trip point's value
> to an invalid temperature"?
> 
> Assuming that's what you meant...
> 
> > This patch will prevent this case happening.
> 
> This is good to change, but IMO, it's better to actually pick a close
> value, instead of the max. e.g., if you support temperatures at degree
> intervals of 80, 85, 90, ..., 125, but someone lists 82 in the device
> tree, we should pick either 80 or 85, not 125.

I see that's what you're doing in a patch later in this series. Good.

> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > ---
> > 
> >  drivers/thermal/rockchip_thermal.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> > index 766486f..535f1fa 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -401,17 +401,15 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
> >  				   int temp)
> >  {
> >  	int high, low, mid;
> > -	u32 error = 0;
> > +	u32 error = table->data_mask;
> >  
> >  	low = 0;
> >  	high = table->length - 1;
> >  	mid = (high + low) / 2;
> >  
> >  	/* Return mask code data when the temp is over table range */
> > -	if (temp < table->id[low].temp || temp > table->id[high].temp) {
> > -		error = table->data_mask;
> > +	if (temp < table->id[low].temp || temp > table->id[high].temp)
> >  		goto exit;

I was revisiting the logic here though, and I don't understand your
error case. You're treating "too low" and "too high" the same, and in
either case, you're choosing a value of ->data_mask. That doesn't make
sense to me, especially for ADC_DECREMENT cases like rk3288. In that
case, you're programming the trip to the lowest possible temperature.

It seems like either you should make this conditional, so that "too low"
and "too high" make sane alternative choices (like MAX or MIN temp), or
else restructure this to pass error codes back to the upper layers.

Brian

> > -	}
> >  
> >  	while (low <= high) {
> >  		if (temp == table->id[mid].temp)
> > -- 
> > 2.7.4
> > 
