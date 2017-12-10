From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH 1/8] iio: adc: axp20x_adc: put ADC rate
 setting in a per-variant function
Date: Sun, 10 Dec 2017 16:37:41 +0000
Message-ID: <20171210163741.3a8ed5aa@archlinux>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <e97d7332790facf3d10a58feabbfe7b2c0b90db7.1512396054.git-series.quentin.schulz@free-electrons.com>
        <CAGb2v64er1xMXCFDfNKqGjGN-TysQyjK+vfHdx0t+kaCchQfCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGb2v64er1xMXCFDfNKqGjGN-TysQyjK+vfHdx0t+kaCchQfCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Dec 2017 11:35:49 +0800
Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:

> On Mon, Dec 4, 2017 at 10:12 PM, Quentin Schulz
> <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > To prepare for a new comer that set a different register with different
> > values, move rate setting in a function that is specific to each AXP
> > variant.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index a30a972..7274f4f 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -470,14 +470,18 @@ static const struct iio_info axp22x_adc_iio_info = {
> >         .read_raw = axp22x_read_raw,
> >  };
> >
> > -static int axp20x_adc_rate(int rate)
> > +static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
> >  {
> > -       return AXP20X_ADC_RATE_HZ(rate);
> > +       return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > +                                 AXP20X_ADC_RATE_MASK,
> > +                                 AXP20X_ADC_RATE_HZ(rate));
> >  }
> >
> > -static int axp22x_adc_rate(int rate)
> > +static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
> >  {
> > -       return AXP22X_ADC_RATE_HZ(rate);
> > +       return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
> > +                                 AXP20X_ADC_RATE_MASK,
> > +                                 AXP22X_ADC_RATE_HZ(rate));
> >  }
> >
> >  struct axp_data {
> > @@ -485,7 +489,7 @@ struct axp_data {
> >         int                             num_channels;
> >         struct iio_chan_spec const      *channels;
> >         unsigned long                   adc_en1_mask;
> > -       int                             (*adc_rate)(int rate);
> > +       int                             (*adc_rate)(struct axp20x_adc_iio *info, int rate);  
> 
> Could you also change the name of the callback, to say, adc_set_rate?
> This would make it much clearer what the callback does. Previously
> it was just a conversion helper.
> 
Agreed.

With that change you can add my
Acked-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

Thanks,

Jonathan

> ChenYu
> 
> >         bool                            adc_en2;
> >         struct iio_map                  *maps;
> >  };
> > @@ -554,8 +558,7 @@ static int axp20x_probe(struct platform_device *pdev)
> >                                    AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> >
> >         /* Configure ADCs rate */
> > -       regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
> > -                          info->data->adc_rate(100));
> > +       info->data->adc_rate(info, 100);
> >
> >         ret = iio_map_array_register(indio_dev, info->data->maps);
> >         if (ret < 0) {
> > --
> > git-series 0.9.1
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> > For more options, visit https://groups.google.com/d/optout.  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
