From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / Domains: Fix compatible for domain idle state
Date: Thu, 10 Nov 2016 13:58:32 -0600
Message-ID: <20161110195832.4nz7lxlmshaemcbb@rob-hp-laptop>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org>
 <1478210075-92045-2-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFoCjf1qSBDWUY_wNx21_78fRrFqcqrFbsSmabzAZJxQAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoCjf1qSBDWUY_wNx21_78fRrFqcqrFbsSmabzAZJxQAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brendan Jackman <brendan.jackman-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Juri Lelli <Juri.Lelli-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 07, 2016 at 12:14:28PM +0100, Ulf Hansson wrote:
> On 3 November 2016 at 22:54, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > Re-using idle state definition provided by arm,idle-state for domain
> > idle states creates a lot of confusion and limits further evolution of
> > the domain idle definition. To keep things clear and simple, define a
> > idle states for domain using a new compatible "domain-idle-state".
> >
> > Fix existing PM domains code to look for the newly defined compatible.
> >
> > Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
> >  .../devicetree/bindings/power/power_domain.txt     |  8 +++---
> >  drivers/base/power/domain.c                        |  2 +-
> >  3 files changed, 38 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > new file mode 100644
> > index 0000000..eefc7ed
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> > @@ -0,0 +1,33 @@
> > +PM Domain Idle State Node:
> > +
> > +A domain idle state node represents the state parameters that will be used to
> > +select the state when there are no active components in the domain.
> > +
> > +The state node has the following parameters -
> > +
> > +- compatible:
> > +       Usage: Required
> > +       Value type: <string>
> > +       Definition: Must be "domain-idle-state".
> > +
> > +- entry-latency-us
> > +       Usage: Required
> > +       Value type: <prop-encoded-array>
> > +       Definition: u32 value representing worst case latency in
> > +                   microseconds required to enter the idle state.
> > +                   The exit-latency-us duration may be guaranteed
> > +                   only after entry-latency-us has passed.
> 
> As we anyway are going to change this, why not use an u64 and have the
> value in ns instead of us?

I can't imagine that you would need more resolution or range. For times 
less than 1us, s/w and register access times are going to dominate the 
time.

Unless there is a real need, I'd keep alignment with the existing 
binding.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
