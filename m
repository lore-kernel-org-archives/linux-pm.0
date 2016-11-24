From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Wed, 23 Nov 2016 18:03:22 -0800
Message-ID: <20161124020322.GI6095@codeaurora.org>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
 <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
 <20161122031717.GE10014@vireshk-i7>
 <m260nfz8mr.fsf@baylibre.com>
 <CAKfTPtDR6Y5UgaqJ+D5T0yBeFRSYWm6OT1+r4ZABrtqtvF2D0w@mail.gmail.com>
 <m2wpfuw5wq.fsf@baylibre.com>
 <CAKfTPtBMro7+UruF0-E26TJPu6pEAvkjF9V7SKriNBm5q+K9+A@mail.gmail.com>
 <m2fumhx21h.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2fumhx21h.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/23, Kevin Hilman wrote:
> Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> 
> > On 23 November 2016 at 16:51, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> >> Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> >>
> >>> On 22 November 2016 at 19:12, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> >>>> Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
> >>>>
> >>>>> On 21-11-16, 09:07, Rob Herring wrote:
> >>>>>> On Fri, Nov 18, 2016 at 02:53:12PM +0530, Viresh Kumar wrote:
> >>>>>> > Some platforms have the capability to configure the performance state of
> >>>>>> > their Power Domains. The performance levels are represented by positive
> >>>>>> > integer values, a lower value represents lower performance state.
> >>>>>> >
> >>>>>> > The power-domains until now were only concentrating on the idle state
> >>>>>> > management of the device and this needs to change in order to reuse the
> >>>>>> > infrastructure of power domains for active state management.
> >>>>>> >
> >>>>>> > This patch introduces a new optional property for the consumers of the
> >>>>>> > power-domains: domain-performance-state.
> >>>>>> >
> >>>>>> > If the consumers don't need the capability of switching to different
> >>>>>> > domain performance states at runtime, then they can simply define their
> >>>>>> > required domain performance state in their node directly. Otherwise the
> >>>>>> > consumers can define their requirements with help of other
> >>>>>> > infrastructure, for example the OPP table.
> >>>>>> >
> >>>>>> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>>>>> > ---
> >>>>>> >  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
> >>>>>> >  1 file changed, 6 insertions(+)
> >>>>>> >
> >>>>>> > diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> >>>>>> > index e1650364b296..db42eacf8b5c 100644
> >>>>>> > --- a/Documentation/devicetree/bindings/power/power_domain.txt
> >>>>>> > +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> >>>>>> > @@ -106,6 +106,12 @@ domain provided by the 'parent' power controller.
> >>>>>> >   - power-domains : A phandle and PM domain specifier as defined by bindings of
> >>>>>> >                     the power controller specified by phandle.
> >>>>>> >
> >>>>>> > +Optional properties:
> >>>>>> > +- domain-performance-state: A positive integer value representing the minimum
> >>>>>> > +  performance level (of the parent domain) required by the consumer for its
> >>>>>> > +  working. The integer value '1' represents the lowest performance level and the
> >>>>>> > +  highest value represents the highest performance level.
> >>>>>>
> >>>>>> How does one come up with the range of values?
> >>>>>
> >>>>> Why would we need a range here? The value here represents the minimum 'state'
> >>>>> and the assumption is that everything above that level would be fine. So the
> >>>>> range is automatically: domain-performance-state -> MAX.
> >>>>>
> >>>>>> It seems like you are
> >>>>>> just making up numbers. Couldn't the domain performance level be an OPP
> >>>>>> in the sense that it is a collection of clock frequencies and voltage
> >>>>>> settings?
> >>>>>
> >>>>> The clock is going to be handled by the device itself (at least for the case we
> >>>>> have today) and the performance-state lies with the power-domain which is
> >>>>> configured separately. If the performance level includes both clk and voltage,
> >>>>> then why would we need to show the clock rates in the DT ? Wouldn't a
> >>>>> performance level be enough in such cases?
> >>>>
> >>>> I think the question is: what does the performance-level of a domain
> >>>> actually mean?  Or, what are the units?
> >>>>
> >>>> Depending on the SoC, there's probably a few things this could mean.  It
> >>>> might mean is that an underlying bus/interconnect can be configured to
> >>>> guarantee a specific bandwidth or throughput.  That in turn might mean
> >>>> that that bus/interconnect might have to be set at a specific
> >>>> frequency/voltage.
> >>>>
> >>>> In your case, IIUC, you're just passing some magic value to some
> >>>> firmware running on a micro-controller, but under the hood that uC is
> >>>> probably configuring a frequency/voltage someplace.
> >>>
> >>> In the case described by Viresh, it's only about setting the voltage
> >>> of a power domain that is shared between different devices. these
> >>> devices wants to run at different frequency (set by the devices) but
> >>> we have to select a Volateg value that will match with the constraint
> >>> of all devices (in this case the highest voltage)
> >>
> >> Then, at least for this use case, we're talking about voltage, not some
> >> unspecified units.

In some cases we actually know the voltage of the domain and
would want to put some voltage mapping in DT. For example, level
1 is voltage 2V and level 2 is voltage 2.5V. In other cases we
don't know the voltage, all we know is the voltage "corner" which
is a number from 0 to N that is translated into a voltage by the
firmware but is otherwise unknown what that is outside of the
firmware. In this case we've lost the units, but otherwise we're
still interested in requesting some 'level' that the domain be
operating in.

> >>
> >> But that makes me wonder, this performance state sounds like something
> >> that is changing dynamically at runtime, so why do you want to describe
> >> this statically in DT?
> >>
> >> This sounds to me like the job of the genpd.  When any device in the
> >> domain does its pm_runtime_get(), the domain could check the device
> >> frequency and see if it needs to change the domain voltage in order for
> >> that device to operate at that frequency.

How do we check the device frequency? Does the domain need to
know about the clocks for all devices that are in the domain and
what clocks in there are contributing to the voltage requirement?

In out of tree solutions we've 'bucketized' the requirements of
the devices into an array sized to the number of levels of the
voltage domain. When a device requires a new level, we increment
the new level and decrement the old level and then look for the
largest non-zero index in the array. This is the inverse design
of iterating over all devices in the domain to see what frequency
they're running at to determine the voltage requirement. I guess
using PM QoS would be similar here to do the aggregation and then
tell the domain to go to that level.

> >> When the device goes away
> >> (using pm_runtime_put()) the domain can check again if it could lower
> >> the voltage and still meet the requirements of the remaining devices.
> >
> > That's only part of the job. The device can change its frequency and
> > as a result ask for a new voltage index while it is already running
> 
> That's fine.  Use clock notifiers, or better use QoS (with notifiers) so
> that the genpd knows when any of those change.
> 

>From my perspective clock notifiers are going to be ugly. At the
point we notify that a rate has changed we're deep in the clk
framework holding the prepare mutex and we're calling it from an
SRCU callback. If those callbacks need to turn on an i2c clk to
communicate with some PMIC to change voltages we're in a world of
pain due to our locking scheme. Maybe that's solvable with a
different clk locking scheme though so I may be overly concerned
here and everything will work out. Also, we don't have any
notification that a clock is turned on or off right now, which
sounds like we're going to assume is the case when a device gets
pm_runtime_put().

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
