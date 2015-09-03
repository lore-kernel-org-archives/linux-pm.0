From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 13/13] dt: power: bq24257-charger: Cover additional
 devices
Date: Wed, 2 Sep 2015 20:47:41 -0500
Message-ID: <20150903014741.GA25605@borg>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-14-git-send-email-dannenberg@ti.com>
 <CAJKOXPeyMeUUon0E9Fhm18SHJEaQPEbGAWwU+MKwgt-30AXHiA@mail.gmail.com>
 <20150902140332.GA24076@borg>
 <55E7A2E8.2060306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200AbbICBsP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Sep 2015 21:48:15 -0400
Content-Disposition: inline
In-Reply-To: <55E7A2E8.2060306@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 03, 2015 at 10:31:20AM +0900, Krzysztof Kozlowski wrote:
> > Yes that's right. Some of the chargers can check the USB D+/D- lines to
> > determine what kind of charger is attached (DCP, CDP, SDP, other) - see
> > bq24257 device datasheet for more info:
> > http://www.ti.com/product/bq24257
> > 
> > And this feature is being used in the original driver Laurentiu
> > developed. However this detection mechanism (or any detection mechanism
> > in general) may not always be appropriate hence the new property to
> > disable it and manually provide an input current limit of how much can
> > be drawn from the charger. Plus it's needed for devices that don't have
> > the D+/D- detection feature.
> 
> Thanks for explanation. How about leaving only "ti,in-limit-current"
> (get rid of "ti,in-ilimit-autoset-disable"). If it is present then the
> autodetection/autoset would be disabled.

I had it separated out to make the DT declarations more explicit (so one
would immediately "see" that autoset is disabled) but other than that
there is no reason why this couldn't get folded together. Will change.

> > Yes I was thinking about this but then went with something that closely
> > reflects the device datasheets to maximize correlation. Removing the 'v'
> > would make it look cleaner and more universal and I suppose it's not to
> > far of a stretch for someone to associate "ti,ovp-voltag" with the VOVP
> > bit field in the devices register map. So let's change it.
> 
> Thanks. Bindings don't have to follow naming convention of company's
> datasheet.

Ok.

> > Yes that's right. Somebody might chose to do so because they don't want
> > to sacrifice the extra pin. And I need to accommodate for devices that
> > don't have a PG pin so the logic behind this had to be implemented
> > anyways. I just made it accessible. What about I work on improving that
> > explanation hopefully to make it less confusing.
> 
> I still don't get why you need extra "ti,pg-gpio-disable" property. It
> could work like this:
> 1. Get rid of "ti,pg-gpio-disable" and make "pg-gpio" optional.
> 2. If it is present, use it.
> 3. If it is not present, use software based approach (the same as
> setting "ti,pg-gpio-disable" previously).
> 
> Would that work?

Similar to the earlier comment - the idea was to have it more explicit.
Plus, the original driver would hard-fail when the "pg-gpio" pin is not
provided (since it was essential for that driver's ability to function).
If I change to automatically fallback to the SW solution such an error
case would in theory not be 100% backward compatible. I could however
more clearly indicate/log which method is being used (dev_info) so
somebody rummaging through the logs would still see it. Will simplify.

> > When I looked through the Kernel headers I found the boolean property
> > parse function and figured that's probably what I should be using. But
> > as I was implementing it I had similar concerns to what you mentioned.
> > If it's general practice to prefer the value based properties I'll be
> > happy to change that.
> 
> Usually the boolean is a good choice but here you used it for a
> numerical property. You are preparing a generic TI bindings so it is
> wise to think about other future drivers. Would they have other values
> for timer factor? Would you want to set it in common board DTSI and
> override it in some one specific child DTS?

Thanks again for the additional comments and the pointers.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc


> 
> Best regards,
> Krzysztof
> 
> > 
> >>
> >> Also please look at existing bindings:
> >> $ git grep "ti," Documentation/devicetree/bindings/power
> >> Maybe you could reuse some? Each of these existing and new bindings
> >> are made generic (not device specific) so they should be reused.
> > 
> > Already spent time with existing bqXXXXX drivers to see if I can recycle
> > properties. Will give it another run-through to make sure there is
> > maximum re-use.
> > 
> > Thanks,
> > 
> > --
> > Andreas Dannenberg
> > Texas Instruments Inc
> > 
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>> +- interrupt-parent: Should be the phandle for the interrupt controller. Use in
> >>> +    conjunction with "interrupts" and only in case "stat-gpio" is not used.
> >>> +- interrupts: Interrupt mapping for GPIO IRQ (configure for both edges). Use in
> >>> +    conjunction with "interrupt-parent" and only in case "stat-gpio" is not
> >>> +    used.
> >>>
> >>>  Example:
> >>>
> >>>  bq24257 {
> >>>         compatible = "ti,bq24257";
> >>>         reg = <0x6a>;
> >>> +       stat-gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> >>> +       pg-gpio = <&gpio1 28 GPIO_ACTIVE_HIGH>;
> >>>
> >>>         ti,battery-regulation-voltage = <4200000>;
> >>>         ti,charge-current = <1000000>;
> >>>         ti,termination-current = <50000>;
> >>>  };
> >>> +
> >>> +Example:
> >>> +
> >>> +bq24250 {
> >>> +       compatible = "ti,bq24250";
> >>> +       reg = <0x6a>;
> >>> +       interrupt-parent = <&gpio1>;
> >>> +       interrupts = <16 IRQ_TYPE_EDGE_BOTH>;
> >>> +
> >>> +       ti,battery-regulation-voltage = <4200000>;
> >>> +       ti,charge-current = <500000>;
> >>> +       ti,termination-current = <50000>;
> >>> +       ti,in-limit-current = <900000>;
> >>> +       ti,vovp-voltage = <9500000>;
> >>> +       ti,vindpm-voltage = <4440000>;
> >>> +};
> >>> --
> >>> 1.9.1
> >>>
> > 
> 
