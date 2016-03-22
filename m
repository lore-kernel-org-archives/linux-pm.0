From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/4] devicetree: bindings: let thermal-sensor point to
 other thermal zones
Date: Tue, 22 Mar 2016 08:13:34 -0700
Message-ID: <20160322151333.GA2977@localhost.localdomain>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-3-git-send-email-javi.merino@arm.com>
 <20160104141709.GB19256@pengutronix.de>
 <20160303032152.GD3379@localhost.localdomain>
 <20160321115511.GA6590@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160321115511.GA6590@e104805>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 21, 2016 at 11:55:11AM +0000, Javi Merino wrote:
> On Wed, Mar 02, 2016 at 07:21:53PM -0800, Eduardo Valentin wrote:
> > On Mon, Jan 04, 2016 at 03:17:09PM +0100, Sascha Hauer wrote:
> > > On Wed, Nov 25, 2015 at 03:09:44PM +0000, Javi Merino wrote:
> > > > The thermal-sensor property of the thermal zone node accepts phandles to
> > > > thermal sensors.  However, thermal zones can be created as an
> > > > +
> > > > +		thermal-sensors = <&cpu_thermal &gpu_thermal &lcd_thermal>
> > > 
> > > This seems inconsistent. Why can a thermal zone only have multiple
> > > thermal sensors when they are thermal zones themselves? Either we assume
> > > that one thermal zone has a single sensor or we assume that it can have
> > > multiple sensors, but this should not depend on the zone being a sub zone
> > > or not.
> > > 
> > > I think the thermal-sensors property should always point to one or
> > > multiple sensors. I see no point in "This property either points to
> > > exactly one sensor or multiple other thermal zones (from which we only
> > > use the temperature)"
> > 
> > 
> > Agreed here. In fact, if we are going to allow thermal zones to be
> > treated as sensors, it means there should be no limits on what you put
> > of there, as long as all items have #thermal-sensor-cells. So, mixing
> > one (or more) regular sensors, with other thermal zones shall be
> > allowed, if we agree in this semantics.
> 
> Eduardo, thanks for the review.  There doesn't seem to be much
> interest in this and I currently have no time to work on it so I am
> dropping this series for the time being.  I'm happy for this to be
> picked up by somebody else (or who knows, maybe I will be able to work
> on it again in the future).

Ok Javi, as this was one of the topics agreed for a change, I will take it over.

Thanks for your help.

> 
> Javi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
