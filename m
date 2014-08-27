From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v1 1/1] power: Add simple gpio-restart driver
Date: Wed, 27 Aug 2014 11:14:13 -0700
Message-ID: <20140827181413.GA2198@roeck-us.net>
References: <1409096705-24290-1-git-send-email-davidriley@chromium.org>
 <1409096705-24290-2-git-send-email-davidriley@chromium.org>
 <20140827014300.GA29512@earth.universe>
 <CAASgrz3ArGUJnPVvBcm2Hm0gwcUPYt2504M3t-3M5=c2DmKotA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAASgrz3ArGUJnPVvBcm2Hm0gwcUPYt2504M3t-3M5=c2DmKotA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Marc Carino <marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anders Berg <anders.berg-M7mHMAq9Yzo@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ivan Khoronzhuk <ivan.khoronzhuk-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jamie Lentin <jm-Pj/HzkgeCk7QXOPxS62xeg@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 27, 2014 at 10:56:20AM -0700, David Riley wrote:
> Hi Sebastian,
> 
> Thanks for the feedback.
> 
> On Tue, Aug 26, 2014 at 6:43 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > Hi David,
> >
> > On Tue, Aug 26, 2014 at 04:45:05PM -0700, David Riley wrote:
> >> This driver registers a restart handler to set a GPIO line high/low
> >> to reset a board based on devicetree bindings.
> >
> > Driver looks fine to me. I have some comments about the
> > Documentation, though:
> >
> >> [...]
> >> diff --git a/Documentation/devicetree/bindings/gpio/gpio-restart.txt b/Documentation/devicetree/bindings/gpio/gpio-restart.txt
> >> new file mode 100644
> >> index 0000000..7cd58788
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/gpio/gpio-restart.txt
> >> @@ -0,0 +1,48 @@
> >> +Driver a GPIO line that can be used to restart the system as a
> >> +restart handler.
> >
> > Please fix the Typo (first word).
> 
> Fixed.
> 
> >
> >> [...]
> >> +
> >> +The driver supports both level triggered and edge triggered power off.
> >> +At driver load time, the driver will request the given gpio line and
> >> +install a restart handler.
> >
> > The wording is too driver centric IMHO. You are supposed to document
> > the binding in a generic way. Maybe start with something like:
> >
> > "This binding supports level and edge triggered reset."
> >
> > (power off is the wrong word, since there is already gpio-poweroff).
> 
> I've cleaned this up for v2.
> 
> >> +If the optional properties 'input' is +not found, the GPIO line
> >> +will be driven in the inactive state. Otherwise its configured
> >> +as an input.
> >
> > What is this needed for?
> 
> This allows other hardware to be attached to the same line to reset
> the system.  Carried forward from the gpio-poweroff implementation I
> based this on.
> 
Maybe rephrase; the point isn't really that it is configured as input but
that it is an open source pin unless actively driven to reset the system.
That linux models the pin as input is really an implementation detail.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
