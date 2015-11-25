From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/4] devicetree: bindings: let thermal-sensor point to
 other thermal zones
Date: Wed, 25 Nov 2015 18:41:44 +0000
Message-ID: <20151125184144.GA24866@e104805>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-3-git-send-email-javi.merino@arm.com>
 <20151125175441.GA32343@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151125175441.GA32343@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 25, 2015 at 05:54:41PM +0000, Mark Rutland wrote:
> On Wed, Nov 25, 2015 at 03:09:44PM +0000, Javi Merino wrote:
> > The thermal-sensor property of the thermal zone node accepts phandles to
> > thermal sensors.  However, thermal zones can be created as an
> > aggregation of other thermal zones.  Extend the thermal-sensors property
> > to allow phandles to other thermal zones.  This patch also adds an
> > example that showcases how a board thermal zone can be created from the
> > aggregation of the cpu, gpu and lcd thermal zones.
> > 
> > Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> > Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> > Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
> > Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
> > ---
> > 
> > Notes:
> >     Hi devicetree,
> >     
> >     Is it ok to extend the definition of the thermal-sensors property like
> >     this?  IOW are phandles strongly typed?
> 
> I think it's OK so long as each thermal zone has #thermal-sensor-cells
> set explicitly, if used as a sensor, and we can agree on the semantics
> of what it means for a thermal zone to be a sensor.
> 
> I don't really follow why you need the zone to be a sensor, and can't
> simply refer to the sensor from two zones. Are you trying to imply an
> ordering of trip points (e.g. that the sub-zones' trips should be taken
> into account first)?

No, it doesn't affect the ordering of trip points.

This came out of a discussion at LPC.  Currently thermal zones can
only have on thermal sensor associated with them.  After some
discussion, Mike Turquette suggested that we could use an approach
similar to what it's done with power domains and stack them.

> >  .../devicetree/bindings/thermal/thermal.txt        | 154 ++++++++++++++++++++-
> >  1 file changed, 151 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> > index 41b817f7b670..52b7e9ae3b4d 100644
> > --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> > @@ -145,9 +145,12 @@ Required properties:
> >    Size: one cell
> >  
> >  - thermal-sensors:	A list of thermal sensor phandles and sensor specifier
> > -  Type: list of 	used while monitoring the thermal zone.
> > -  phandles + sensor
> > -  specifier
> > +  Type: list of 	used while monitoring the thermal zone. The phandles
> > +  phandles + sensor	can point to thermal sensors or other thermal zone
> > +  specifier		nodes. If it points to other thermal zone
> > +			nodes you should omit the sensor specifier
> > +			and set #thermal-sensor-cells to 0 for the
> > +			thermal zone.
> 
> The example misses #thermal-sensor-cells = <0> for each of the zones.

You're right, I'll fix it for the next version

> Can a zone normal have multiple sensors? If so, what is the aggregate
> value if a zone is used as a sensor? Max? Min? Scaled by contribution
> somehow?

No, currently a thermal zone can only specify one sensor in its
thermal-sensors property

Cheers,
Javi
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
