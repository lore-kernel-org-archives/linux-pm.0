From: Henry Chen <henryc.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] PM / AVS: thermal: MT8173: Introduce support
 for SVS engine
Date: Fri, 19 Feb 2016 13:31:25 +0800
Message-ID: <1455859885.17104.21.camel@mtksdaap41>
References: <1453452029-20843-1-git-send-email-pi-cheng.chen@linaro.org>
	 <1453452029-20843-5-git-send-email-pi-cheng.chen@linaro.org>
	 <CAGS+omAYPhJ80kHG=bW4AjFsQzhwUfC6C+nAXa=Ny5UyoCid=w@mail.gmail.com>
	 <20160218030049.GA8780@gmail.com> <1455858482.17104.13.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455858482.17104.13.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-02-19 at 13:08 +0800, Henry Chen wrote:
> On Thu, 2016-02-18 at 11:00 +0800, Pi-Cheng Chen wrote:
> 
> > > > +               vboot = regulator_get_voltage(svs->reg) / 1000;
> > > > +               if (mvolt_to_config(vboot) !=
> > > > +                   mvolt_to_config(svs_bank_cfgs[i].vboot)) {
> > > > +                       dev_err(svs->dev, "Vboot value mismatch!\n");
> > > > +                       ret = -EINVAL;
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               ret = regulator_set_mode(svs->reg, REGULATOR_MODE_FAST);
> > > > +               if (ret) {
> > > > +                       dev_err(svs->dev,
> > > > +                               "Failed to set regulator in PWM mode\n");
> > > > +                       ret = -EINVAL;
> > > > +                       break;
> > > > +               }
> > > 
> > > Shouldn't this be best effort?
> > > If we can't set the regulator to fast mode, can we continue anyway?
> > > 
> > 
> > AFAIK, we need to set the regulator to fast mode to get stable voltage as
> > possible. I am sure about the details.
> > 
> > @Henry,
> > Would you please comment it?
> 

Hi,

Correct typos.Sorry for the wrong module name. 

Yes, as you said, SVS need the more precisely voltage as possible when
driver initialize, there has two mode in mt6397: pwm/auto mode, the pwm
mode which can get the more stable Vout than auto mode.

Thanks,
Henry

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
