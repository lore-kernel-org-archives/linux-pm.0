From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Wed, 31 Aug 2016 16:04:02 +0100
Message-ID: <20160831150402.GA27374@brendan-thinkstation>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
 <20160831101644.GA2508@brendan-thinkstation>
 <CAPDyKFq-WCJoew1ba7hK+Z+9r5CHecscR7zecaqD4aFaphRnGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934880AbcHaPEI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Aug 2016 11:04:08 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFq-WCJoew1ba7hK+Z+9r5CHecscR7zecaqD4aFaphRnGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Axel Haslam <ahaslam@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

(I know I suggested switching to the other thread but I just want to explain my
reasoning here!)

On Wed, Aug 31, 2016 at 04:19:41PM +0200, Ulf Hansson wrote:
> On 31 August 2016 at 12:16, Brendan Jackman <brendan.jackman@arm.com> wrote:
[...]
> > There was some previous discussion of whether device idle state bindings are
> > necessary. It was proposed that rather than adding a whole new binding, we could
> > just use the power domain idle state binding from [2]. We suggested that any
> > device that has an idle state is, by definition, in a power domain of its own:
> > rather than add a device-idle-states property to that device, we just put it in
> > a power domain with a domain-idle-states property.
>
> Yes, we can do that software wise, but is that really a proper
> description of the HW!?
>

It's probably not what SoC docs would explicitly list under "power domains" but
I think "set of components that are bound by a common power state" is a
reasonable definition for a power domain.

I think (?) your objection is that a device could have idle states that it
controls by itself and does not switch "off", for example in the case of a
device that has an idle state where it gates its clock but does not cut voltage,
or WFI in an ARM CPU. My thinking is: just because the transitions into those
power states isn't triggered by a separate power controller, I don't think that
means no "power domain" exists.

Perhaps that's a glitch in my vocabulary.
