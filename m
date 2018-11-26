From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 5/5] power: supply: sc27xx: Save last battery capacity
Date: Mon, 26 Nov 2018 14:18:27 +0800
Message-ID: <CAMz4kuJ+7J+MYh02YhP9j8Tf6ntdL6tOLiJO6yN0a4Qot4t4Jg@mail.gmail.com>
References: <cover.1542185618.git.baolin.wang@linaro.org> <db2aa7892d7ecfae563ef22de5bbc7587ea3471f.1542185618.git.baolin.wang@linaro.org>
 <20181125214823.GB9913@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181125214823.GB9913@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,
On Mon, 26 Nov 2018 at 05:48, Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Our charger manager can optimize the battery capacity periodically, so
> > we can save last battery capacity into registers. Then next system
> > power-on, we can read the last saved battery capacity as the initial
> > battery capacity, which can make the battery capacity more accurate.
> >
> > Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  drivers/power/supply/sc27xx_fuel_gauge.c |  143 +++++++++++++++++++++++++++++-
> >  1 file changed, 142 insertions(+), 1 deletion(-)
> >
>
> > +static int sc27xx_fgu_set_property(struct power_supply *psy,
> > +                                enum power_supply_property psp,
> > +                                const union power_supply_propval *val)
> > +{
> > +     struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             ret = sc27xx_fgu_save_last_cap(data, val->intval);
> > +             if (ret < 0)
> > +                     dev_err(data->dev, "failed to save battery capacity\n");
> > +             break;
> > +
> > +     default:
> > +             ret = -EINVAL;
> > +     }
> > +
> > +     mutex_unlock(&data->lock);
> > +     return ret;
>
> if (psp != ....) return -EINVAL; And you can do that outside
> lock...
>
> Ok, OTOH this is easier to extend in future. Do you expect more
> writable properties?

Until now I think there are no writable properties, I think I can
change it like you suggested.

>
> > +static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
> > +                                         enum power_supply_property psp)
> > +{
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             return 1;
> > +
> > +     default:
> > +             return 0;
> > +     }
> > +}
>
>
> Same here. return psp == POWER_SUPPLY_PROP_CAPACITY; really looks
> strange written like this.

Sure. Thanks.

-- 
Baolin Wang
Best Regards
