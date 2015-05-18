From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: devicetree: Add TI BQ25890 bindings
Date: Mon, 18 May 2015 09:54:46 +0300
Message-ID: <20150518065446.GD14396@lpalcu-linux>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
 <1431698778-29462-2-git-send-email-laurentiu.palcu@intel.com>
 <CAJKOXPeprMYOgd1uHpdV3TjVdP9g+-SmV8q7A-127LQ7V_hAkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPeprMYOgd1uHpdV3TjVdP9g+-SmV8q7A-127LQ7V_hAkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Sat, May 16, 2015 at 08:53:42PM +0900, Krzysztof Kozlowski wrote:
> 2015-05-15 23:06 GMT+09:00 Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  .../devicetree/bindings/power/bq25890.txt          | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/bq25890.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/bq25890.txt b/Documentation/devicetree/bindings/power/bq25890.txt
> > new file mode 100644
> > index 0000000..44f50a7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/bq25890.txt
> > @@ -0,0 +1,45 @@
> > +Binding for TI bq25890 Li-Ion Charger
> > +
> > +Required properties:
> > +- compatible: Should contain one of the following:
> > +    * "ti,bq25890"
> > +- reg: integer, i2c address of the device.
> > +- ti,battery-regulation-voltage: integer, maximum charging voltage (in uV);
> > +- ti,charge-current: integer, maximum charging current (in uA);
> > +- ti,termination-current: integer, charge will be terminated when current in
> > +    constant-voltage phase drops below this value (in uA);
> > +- ti,precharge-current: integer, maximum charge current during precharge
> > +    phase (in uA);
> > +- ti,minimum-sys-voltage: integer, when battery is charging and it is below
> > +    minimum system voltage, the system will be regulated above
> > +    minimum-sys-voltage setting (in uV);
> > +- ti,boost-voltage: integer, VBUS voltage level in boost mode (in uV);
> > +- ti,boost-max-current: integer, maximum allowed current draw in boost mode
> > +    (in uA).
> > +
> > +Optional properties:
> > +- ti,boost-low-freq: boolean, if present boost mode frequency will be 500kHz,
> > +    otherwise 1.5MHz;
> > +- ti,use-ilim-pin: boolean, if present the ILIM resistor will be used and the
> > +    input current will be the lower between the resistor setting and the IINLIM
> > +    register setting;
> > +- ti,thermal-regulation-threshold: integer, temperature above which the charge
> > +    current is lowered, to avoid overheating (in degrees Celsius);
> 
> What if property is absent? The temperature will be ignored? If so,
> maybe consider adding such short statement about the default state?
You're right, I should've mentioned it here. If it's missing, the
default value will be used (120 degrees Celsius). I'll add a comment
about it in v2.

Thanks for reviewing,
laurentiu

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
