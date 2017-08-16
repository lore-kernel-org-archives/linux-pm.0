From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/5] devicetree: power: Add docs for TI BQ24190
 battery charger
Date: Wed, 16 Aug 2017 08:47:02 -0700
Message-ID: <20170816154701.GR3930@atomide.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-3-liam@networkimprov.net>
 <20170811025038.5qnhbabyybx7rgu5@rob-hp-laptop>
 <CAKvHMgSuwm5UFivbsq9dQn_wfd7kbs63UuuQSHVdGxDf_WReUA@mail.gmail.com>
 <20170812164233.won7fairxmrnblps@earth>
 <CAKvHMgR+GxSqhy+iwdYmku2600HzoF__oXV7_w72ZJg-aK7O-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgR+GxSqhy+iwdYmku2600HzoF__oXV7_w72ZJg-aK7O-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Breck <kernel-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

* Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> [170812 12:00]:
> On Sat, Aug 12, 2017 at 9:42 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Aug 11, 2017 at 02:57:10PM -0700, Liam Breck wrote:
> >> >> +Other features:
> >> >> +- Use gpio-hog to set the OTG pin high to enable 500mA charge current on USB SDP port.
> >> >
> >> > Why doesn't the charger driver control this?
> >>
> >> This pin/gpio has to be high when USB is plugged in to make the
> >> charger chip negotiate 500mA from a SDP port. It should generally be
> >> configured that way even if the driver is not loaded, as the chip does
> >> not require a driver to function. Some boards may do that with a
> >> pull-up. Also the user may want to change this via sysfs and not have
> >> the driver "fix" it.
> >
> > drivers/power/supply/qcom_smbb.c exposes the otg feature as
> > regulator. I think in this case it could be exposed as
> > gpio-regulator.
> 
> Hans is doing that here:
> https://patchwork.kernel.org/patch/9883717/
> 
> The datasheet labels one pin "OTG" but that's misleading; it really
> enables negotiation of 500mA input current, but does not turn on OTG
> mode. If this pin is low, it only prevents the driver from starting
> OTG mode via I2C msg.

Yeah so before the device has enumerated this pin keeps the
max current at 100mA as required by the USB spec. This pin
should be only toggled after enumerating in bootloader or
by the kernel driver. I tink the USB PHY driver can also
be wired to control this line.

Probably best to set it up as just a GPIO that the bq24190
driver controls optionally.

Then later on we should have some Linux generic way for
USB gadget subsystem to tell the charger that we have
enumerated, and then bq24190 driver can toggle this GPIO
to enable higher charge rates.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
