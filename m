From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Mon, 29 Aug 2016 14:11:24 +0200
Message-ID: <20160829121124.GA7079@amd>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
 <20160826135842.GA9303@amd>
 <CAPDyKFpQ-kG0jkOXwVWJkwT41JjTg=KwNv4z-E7UUBqfKMNHgg@mail.gmail.com>
 <20160829104019.GA16212@amd>
 <CAPDyKFpwDR25G=9RTsEZ5nzMMuRKpEPTK=V1E5mMXKfWA-yvEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpwDR25G=9RTsEZ5nzMMuRKpEPTK=V1E5mMXKfWA-yvEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Brendan Jackman <Brendan.Jackman-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Axel Haslam <ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2016-08-29 13:55:56, Ulf Hansson wrote:
> On 29 August 2016 at 12:40, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> > On Mon 2016-08-29 11:34:34, Ulf Hansson wrote:
> >> On 26 August 2016 at 15:58, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> wrote:
> >> > Hi!
> >> >
> >> >> @@ -0,0 +1,102 @@
> >> >> +Device idle states
> >> >> +========================
> >> >> +
> >> >> +A device are often capable of entering a low power state(s) when it becomes
> >> >> +idle, hence the terminology of device idle states. Entering an idle state for a
> >> >> +device helps it to avoid wasting power and reduces the leakage of current.
> >> >
> >> > First things first: what do these states _really_ represent? We have
> >> > GPIOs in device tree, we have clock domains. What are these?
> >>
> >> On most ARM SoCs which I am familiar of and which isn't using ACPI,
> >> these kind of resources may can be considered as "power resources"
> >> connected to a generic device. Although it's of course highly
> >> dependent on the SoC. Other typical resources are clocks, pinctrls,
> >> regulators etc.
> >>
> >> To enter a low power state, these devices may not explicitly have to
> >> change some internal logic, but instead relies on external "power
> >> resources " to be put into low power mode.
> >>
> >> I guess one could compare this to what can be described in the ACPI's
> >> Device Power Management.
> >
> > If they are clocks, describe them as clocks, DT supports that. If they
> > are regulators, describe them as regulators.
> >
> > We don't want to have "we have these magic somethings here". We want
> > to know whether it is clock, regulator, or what.
> 
> This isn't something that will *replace* clocks etc. If those
> resources are needed, of course those needs to be described.
> 
> What is missing in DT, and what I suggest to add, is to be able to
> describe the actual idle states of a device and the HW characteristics
> related to that.

What is "actual idle state"?

That's what i'm asking. You told me it is clocks, now you are telling
me it is not.

> And... we also have devices that have internal logics that must be
> changed to enter and wakeup from a low power state. For example WLAN
> circuits, PCI devices, etc. So this isn't all about clocks/regulators
> etc, but devices in general.

Again. What is this describing? If you have device that has internal
logic, the driver needs to know how to drive the device, and this
binding is not needed. We are not describing "this x86 cpu has eax
register inside it, and it takes 12 nanoseconds to read it".

Real world example would help here.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
