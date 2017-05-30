From: Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dts: uniphier: add nodes of thermal monitor and thermal zone for PXs2
Date: Tue, 30 May 2017 18:25:51 +0900
Message-ID: <20170530182550.6869.4A936039@socionext.com>
References: <1496049345-14649-4-git-send-email-hayashi.kunihiko@socionext.com> <20170529163007.GA14413@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170529163007.GA14413-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,
Thank you for your comment.

On Mon, 29 May 2017 09:30:09 -0700 Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Mon, May 29, 2017 at 06:15:44PM +0900, Kunihiko Hayashi wrote:
> > Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
> > The thermal monitor is included in sysctrl.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 21 +++++++++++++++++++++
> >  arch/arm/boot/dts/uniphier-pxs2-vodka.dts  | 21 +++++++++++++++++++++
> >  arch/arm/boot/dts/uniphier-pxs2.dtsi       |  6 ++++++
> >  3 files changed, 48 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
> > index 373818a..89ccb88 100644
> > --- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
> > +++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
> > @@ -70,6 +70,27 @@
> >  		i2c5 = &i2c5;
> >  		i2c6 = &i2c6;
> >  	};
> > +
> > +	thermal-zones {
> > +		cpu_thermal {
> > +			polling-delay-passive = <250>;	/* 250ms */
> > +			polling-delay = <1000>;		/* 1000ms */
> > +			thermal-sensors = <&pvtctl>;
> > +
> > +			trips {
> > +				cpu_crit: cpu_crit {
> > +					temperature = <95000>;	/* 95C */
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +				cpu_alert: cpu_alert {
> > +					temperature = <85000>;	/* 85C */
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +			};
> These are missing cooling-maps section.

I see. I'll add the section including another nodes.

> > +		};
> > +	};
> >  };
> >  
> >  &serial2 {
> > diff --git a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
> > index 51a3eac..0201584 100644
> > --- a/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
> > +++ b/arch/arm/boot/dts/uniphier-pxs2-vodka.dts
> > @@ -68,6 +68,27 @@
> >  		i2c5 = &i2c5;
> >  		i2c6 = &i2c6;
> >  	};
> > +
> > +	thermal-zones {
> > +		cpu_thermal {
> > +			polling-delay-passive = <250>;	/* 250ms */
> > +			polling-delay = <1000>;		/* 1000ms */
> > +			thermal-sensors = <&pvtctl>;
> > +
> > +			trips {
> > +				cpu_crit: cpu_crit {
> > +					temperature = <95000>;	/* 95C */
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +				cpu_alert: cpu_alert {
> > +					temperature = <85000>;	/* 85C */
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +			};
> 
> same
> 
> > +		};
> > +	};
> >  };
> >  
> >  &serial2 {
> > diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > index e9e031d..072e3b4 100644
> > --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> > @@ -387,6 +387,12 @@
> >  				compatible = "socionext,uniphier-pxs2-reset";
> >  				#reset-cells = <1>;
> >  			};
> > +
> > +			pvtctl: pvtctl {
> > +				compatible = "socionext,uniphier-pxs2-thermal";
> > +				interrupts = <0 3 1>;
> > +				#thermal-sensor-cells = <0>;
> > +			};
> >  		};
> >  	};
> >  };
> > -- 
> > 2.7.4
> > 

Best Regards,
Kunihiko Hayashi



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
