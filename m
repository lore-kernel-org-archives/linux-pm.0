From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] power_supply: Add support for TI BQ25890 charger chip
Date: Tue, 19 May 2015 12:14:42 +0300
Message-ID: <20150519091442.GF14396@lpalcu-linux>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
 <1431698778-29462-3-git-send-email-laurentiu.palcu@intel.com>
 <CAJKOXPfDcTMEd576cVspXKT2kb__49rQSk-BbxXy5ZinO8n5yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPfDcTMEd576cVspXKT2kb__49rQSk-BbxXy5ZinO8n5yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Tue, May 19, 2015 at 05:40:25PM +0900, Krzysztof Kozlowski wrote:
> > +
> > +static int bq25890_chip_reset(struct bq25890_device *bq)
> > +{
> > +       int ret;
> > +
> > +       ret = bq25890_field_write(bq, F_REG_RST, 1);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       do {
> > +               ret = bq25890_field_read(bq, F_REG_RST);
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               usleep_range(5, 10);
> > +       } while (ret == 1);
> 
> Is it possible to loop here indefinetely?
According to specifications, this field is "Reset to 0 after register
reset is completed", so I'm trusting the chip will behave as advertised!
:) We could implement a safety mechanism to avoid looping in case the
chip misbehaves but I don't think it's worth it. What do you think?

I'll address the other comments in v2.

Thanks for reviewing,
laurentiu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
