From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Thu, 20 Apr 2017 15:03:01 +0530
Message-ID: <20170420093301.GI5436@vireshk-i7>
References: <e772e67a5445319bb8e0f312846ace666adc097f.1490001099.git.viresh.kumar@linaro.org>
 <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <20170419114740.GD5436@vireshk-i7>
 <9dee7c0d-e5f4-9fcd-3c92-bf7ec9d43a3b@arm.com>
 <20170420052533.GF5436@vireshk-i7>
 <CAPDyKFq5xwv5Vy6wNfjFYi_4+immDH9UKTS1EG2j6c4OwnQONg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33364 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943995AbdDTJdF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 05:33:05 -0400
Received: by mail-oi0-f48.google.com with SMTP id y11so10466536oie.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Apr 2017 02:33:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPDyKFq5xwv5Vy6wNfjFYi_4+immDH9UKTS1EG2j6c4OwnQONg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 20-04-17, 10:23, Ulf Hansson wrote:
> Viresh, Sudeep,
> 
> Sorry for jumping in late.
> 
> [...]
> 
> >> On the contrary(playing devil's advocate here), we can treat all
> >> existing regulators alone as OPP then if you strip the voltages and
> >> treat it as abstract number.
> >
> > But then we are going to have lots of platform specific code which
> > will program the actual hardware, etc. Which is all handled by the
> > regulator framework. Also note that the regulator core selects the
> > common voltage selected by all the children, while we want to select
> > the highest performance point here.
> 
> If I understand correctly, Sudeep is not convinced that this is about
> PM domain regulator(s), right?
> 
> To me there is no doubt, these regulators is exactly the definition of
> PM domain regulators.
> 
> That said, long time ago we have decided PM domain regulator shall be
> modeled as exactly that. From DT point of view, this means the handle
> to the PM domain regulator belongs in the node of the PM domain
> controller - and not in each device's node of those belonging to the
> PM domain.
> 
> Isn't that what this discussion really boils down to? Or maybe I am
> not getting it.

Maybe not. I think Sudeep understands that this is about PM domain
regulators only but he is asking why aren't we solving this problem
using regulators framework but performance-levels instead.

> >
> > Even if we have to configure both clock and voltage for the power
> > domain using standard clk/regulator frameworks, OPP will work just
> > fine as it will do that then. So, its not that we are bypassing the
> > regulator framework here. It will be used if we have the voltages
> > available for the power-domain's performance states.
> >
> >> So if the firmware handles more than just
> >> regulators, I agree.
> >
> > I don't know the internals of that really.
> >
> >> At the same time, I would have preferred firmware
> >> to even abstract the frequency like ACPI CPPC.
> >
> > Frequency isn't required to be configured for the cases I know, but it
> > can be in future implementations.
> 
> To me using OPP tables makes sense as it gives us the flexibility that
> is needed. If I understand correct, that was also Kevin's point.

Right.

-- 
viresh
