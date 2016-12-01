From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Fix compatible for domain idle state
Date: Thu, 01 Dec 2016 22:21:59 +0100
Message-ID: <1616414.c1s7NxTqJS@aspire.rjw.lan>
References: <1478210075-92045-1-git-send-email-lina.iyer@linaro.org> <20161110195832.4nz7lxlmshaemcbb@rob-hp-laptop> <CAPDyKFqFnk6+Rfdzp-4wzEy8KNkq=03q5qfbkQD4pPNF0Pc6ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53746 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759542AbcLAVZf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 16:25:35 -0500
In-Reply-To: <CAPDyKFqFnk6+Rfdzp-4wzEy8KNkq=03q5qfbkQD4pPNF0Pc6ww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tuesday, November 29, 2016 09:47:03 AM Ulf Hansson wrote:
> On 10 November 2016 at 20:58, Rob Herring <robh@kernel.org> wrote:
> > On Mon, Nov 07, 2016 at 12:14:28PM +0100, Ulf Hansson wrote:
> >> On 3 November 2016 at 22:54, Lina Iyer <lina.iyer@linaro.org> wrote:
> >> > Re-using idle state definition provided by arm,idle-state for domain
> >> > idle states creates a lot of confusion and limits further evolution of
> >> > the domain idle definition. To keep things clear and simple, define a
> >> > idle states for domain using a new compatible "domain-idle-state".
> >> >
> >> > Fix existing PM domains code to look for the newly defined compatible.
> >> >
> >> > Cc: <devicetree@vger.kernel.org>
> >> > Cc: Rob Herring <robh@kernel.org>
> >> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> >> > ---
> >> >  .../bindings/power/domain-idle-state.txt           | 33 ++++++++++++++++++++++
> >> >  .../devicetree/bindings/power/power_domain.txt     |  8 +++---
> >> >  drivers/base/power/domain.c                        |  2 +-
> >> >  3 files changed, 38 insertions(+), 5 deletions(-)
> >> >  create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
> >> >
> >> > diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.txt b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> >> > new file mode 100644
> >> > index 0000000..eefc7ed
> >> > --- /dev/null
> >> > +++ b/Documentation/devicetree/bindings/power/domain-idle-state.txt
> >> > @@ -0,0 +1,33 @@
> >> > +PM Domain Idle State Node:
> >> > +
> >> > +A domain idle state node represents the state parameters that will be used to
> >> > +select the state when there are no active components in the domain.
> >> > +
> >> > +The state node has the following parameters -
> >> > +
> >> > +- compatible:
> >> > +       Usage: Required
> >> > +       Value type: <string>
> >> > +       Definition: Must be "domain-idle-state".
> >> > +
> >> > +- entry-latency-us
> >> > +       Usage: Required
> >> > +       Value type: <prop-encoded-array>
> >> > +       Definition: u32 value representing worst case latency in
> >> > +                   microseconds required to enter the idle state.
> >> > +                   The exit-latency-us duration may be guaranteed
> >> > +                   only after entry-latency-us has passed.
> >>
> >> As we anyway are going to change this, why not use an u64 and have the
> >> value in ns instead of us?
> >
> > I can't imagine that you would need more resolution or range. For times
> > less than 1us, s/w and register access times are going to dominate the
> > time.
> >
> > Unless there is a real need, I'd keep alignment with the existing
> > binding.
> 
> Rob, are you fine with this? I thought it would be great to get this
> in for 4.10 rc1.

Rob, any objections here?

Thanks,
Rafael

