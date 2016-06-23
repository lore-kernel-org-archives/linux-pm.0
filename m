From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 23 Jun 2016 19:19:28 +0100
Message-ID: <20160623181927.GB31170@leverpostej>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-3-git-send-email-lina.iyer@linaro.org>
 <20160623173312.GA22204@leverpostej>
 <20160623180451.GD1115@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160623180451.GD1115-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, ahaslam-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mtitinger-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 23, 2016 at 12:04:51PM -0600, Lina Iyer wrote:
> Hi Mark,
> 
> On Thu, Jun 23 2016 at 11:35 -0600, Mark Rutland wrote:
> >Hi,
> >
> >On Wed, Jun 22, 2016 at 01:36:37PM -0600, Lina Iyer wrote:
> >>From: Axel Haslam <ahaslam+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> >>
> >>Update DT bindings to describe idle states of PM domains.
> >>
> >>Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> >>Signed-off-by: Marc Titinger <mtitinger+renesas-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> >>Signed-off-by: Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>[Lina: Added state properties, removed state names, wakeup-latency,
> >>added of_pm_genpd_init() API, pruned commit text]
> >>Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >>[Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]
> >>---
> >> .../devicetree/bindings/power/power_domain.txt     | 70 ++++++++++++++++++++++
> >> 1 file changed, 70 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> >>index 025b5e7..41e8dda 100644
> >>--- a/Documentation/devicetree/bindings/power/power_domain.txt
> >>+++ b/Documentation/devicetree/bindings/power/power_domain.txt
> >>@@ -29,6 +29,43 @@ Optional properties:
> >>    specified by this binding. More details about power domain specifier are
> >>    available in the next section.
> >>
> >>+- power-states : A phandle of an idle-state that shall be soaked into a
> >>+                generic domain power state.
> >
> >It's somewhat unfortunate that this gives us two possible locations for
> >idle state lists (under the /cpus node and in a pm-domains node),
> >especially as it's not clear what would happen were a DT to have both.
> >
> >I would prefer that we extend the existing bindings such that states can
> >refer to the power domains which they affect.
> >
> I agree. The CPU idle states have become defined to be specific to CPUs.
> PM Domain idle states are generic for any type of domain. I am hoping at
> some point, we could converge and use the same idle state, but that
> would mean changing the CPU idle states to make it generic.

Outside of CPU idling, I don't fully understand how this will be used,
so it's not clear to me what would need to be made generic. Apologies
for my ignorance there.

> At some point, during my development, I did use the arm,idle-state for
> domains as well, but the binding definitions were too restrictive for
> a generic PM domain.
> 
> I would be willing to make the change to CPU idle states to make it
> generic and then we could just reference domain and CPU idle states
> using the same bindings. Are we okay with that, specifically,
> arm,psci-suspend-param? This binding is very restrictive in its
> description. What we pass to the platform driver upon choosing a domain
> state is very platform specific and therefore has to be generic in its
> description.

I was suggesting that for PSCI we should consistently us
arm,psci-suspend-param, not that this should be used for all power
domain state data.

I imagine that mechanisms for powering down power domains will have
varied requirements on data they require (and may require more than can
be encoded in a u32), and I don't think it's best to try to force a
single representation in the DT for that. It would be better to allow
them to define the properties which they require.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
