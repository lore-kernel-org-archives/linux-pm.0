From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Tue, 15 Sep 2015 12:03:30 +0100
Message-ID: <20150915110330.GA6507@leverpostej>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
 <20150914131448.GC7002@leverpostej>
 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
 <20150914134949.GE7002@leverpostej>
 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
 <1442251092.2850.53.camel@linaro.org>
 <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
 <1442313962.2917.25.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442313962.2917.25.camel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Punit Agrawal <Punit.Agrawal-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 15, 2015 at 11:46:02AM +0100, Jon Medhurst (Tixy) wrote:
> On Tue, 2015-09-15 at 10:37 +0100, Punit Agrawal wrote:
> > "Jon Medhurst (Tixy)" <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> > 
> > > On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> > >> Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> writes:
> > >> 
> [...]
> > >> The way the SCP interface is defined, the sensor identifiers are
> > >> contiguous,
> > >
> > > Is there any documentation other than DUI0922A? [1] From what I can seen
> > > that just says it's a 16-bit value and doesn't put any particular
> > > constraints on its value.
> > 
> > Although not explicitly stated, if you look at the Get Sensor Capability
> > [2] and Get Sensor Info [3] commands you can indirectly infer that the
> > Sensor IDs are contiguous.
> 
> I personally wouldn't even indirectly infer they are contiguous from
> what the document says. If I were implementing the firmware I would feel
> quite in my rights to, for example, use the top 8 bits of the ID for a
> sensor type and the bottom 8 for an index, if that made dispatching of
> requests more efficient. Or if some optional hardware was detected as
> missing, leaving some holes in ID space.
> 
> As a specification of a 'standard' the document seems to be rather
> lacking. So, Sensor ID should be documented as being "an unsigned
> integer less than then number of sensors returned by the Get Sensor
> Capability command", or something like that. I guess clocks and other
> devices suffer from similar lack of specificity.

I think from the PoV of the binding, this doesn't matter. The value is
just an arbitrary opaue token written down in a spec, that the FW
understands how to interpret.

I only asked about how the IDs were organised because I thought there
was additional translation in the kernel, but this is not the case.

The only potential problem is bit-width. Punit, I assume the value is
32-bit (or less) in the messages to the FW?

If for the moment we assume the values can index a small array, then we
can change that later (though ideally we'd handle the most geeneral case
we're aware of from the outset). We just need to not infer any semantics
from a value alone.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
