From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 [fix]] PM / doc: Update device documentation for devices in IRQ safe PM domains
Date: Mon, 24 Oct 2016 23:22:46 +0200
Message-ID: <3700155.5AlzjeyN5H@vostro.rjw.lan>
References: <20161021152313.GC72940@linaro.org> <1900178.E2KGyKAlTm@vostro.rjw.lan> <20161024161605.GD72940@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42926 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752186AbcJXVPo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 17:15:44 -0400
In-Reply-To: <20161024161605.GD72940@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com

On Monday, October 24, 2016 10:16:05 AM Lina Iyer wrote:
> On Sat, Oct 22 2016 at 18:19 -0600, Rafael J. Wysocki wrote:
> >On Friday, October 21, 2016 03:52:55 PM Lina Iyer wrote:
> >> Update documentation to reflect the changes made to support IRQ safe PM
> >> domains.
> >>
> >> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> >> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >> Changes since v3:
> >> - Moved para to the end of the section
> >> - Added clause for all IRQ safe devices in a domain
> >> - Cleanup explanation of nested domains
> >> ---
> >>  Documentation/power/devices.txt | 11 ++++++++++-
> >>  1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> >> index 8ba6625..9218ce6 100644
> >> --- a/Documentation/power/devices.txt
> >> +++ b/Documentation/power/devices.txt
> >> @@ -607,7 +607,9 @@ individually.  Instead, a set of devices sharing a power resource can be put
> >>  into a low-power state together at the same time by turning off the shared
> >>  power resource.  Of course, they also need to be put into the full-power state
> >>  together, by turning the shared power resource on.  A set of devices with this
> >> -property is often referred to as a power domain.
> >> +property is often referred to as a power domain. A power domain may also be
> >> +nested inside another power domain. The nested domain is referred to as the
> >> +sub-domain of the parent domain.
> >>
> >>  Support for power domains is provided through the pm_domain field of struct
> >>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> >> @@ -629,6 +631,13 @@ support for power domains into subsystem-level callbacks, for example by
> >>  modifying the platform bus type.  Other platforms need not implement it or take
> >>  it into account in any way.
> >>
> >> +Devices and PM domains may be defined as IRQ-safe, if they can be powered
> >> +on/off even when the IRQs are disabled.
> >
> >What IRQ-safe means for devices is that their runtime PM callbacks may be
> >invoked with interrupts disabled on the local CPU.  I guess the meaning of
> >IRQ-safe for PM domains is analogous, but the above isn't precise enough to me.
> >
> >> An IRQ-safe device in a domain will
> >> +disallow power management on the domain, unless the domain is also defined as
> >> +IRQ-safe. In other words, a domain containing all IRQ-safe devices must also
> >> +be defined as IRQ-safe. Another restriction this framework imposes on the
> >> +parent domain of an IRQ-safe domain is that the parent domain must also be
> >> +defined as IRQ-safe.
> >
> >What about this:
> >
> >"Devices may be defined as IRQ-safe which indicates to the PM core that their
> >runtime PM callbacks may be invoked with disabled interrupts (see
> >Documentation/power/runtime_pm.txt for more information).  If an IRQ-safe
> >device belongs to a PM domain, the runtime PM of the domain will be disallowed,
> >unless the domain itself is defined as IRQ-safe.  However, a PM domain can only
> >be defined as IRQ-safe if all of the devices in it are IRQ-safe. 
> >
> This is correct. But the last line may need a bit of modification. If
> all devices in a PM domain are IRQ-safe and the domain is NOT, then it
> it is a valid combination just that the domain would never do runtime
> PM.

That doesn't contradict the last sentence of mine above.  I guess what you mean
is that having a non-IRQ-safe device in an IRQ-safe domain is a valid
configuration.  I wonder how it works then. :-)

In any case, what about changing that sentence to something like:

"However, it only makes sense to define a PM domain as IRQ-safe if all devices
in it are IRQ-safe."

Thanks,
Rafael

