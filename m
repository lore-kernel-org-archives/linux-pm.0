From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V7 1/2] OPP: Allow OPP table to be used for power-domains
Date: Thu, 30 Nov 2017 10:18:00 +0530
Message-ID: <20171130044800.GH11413@vireshk-i7>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
 <2b244ea0a09deaf50237fb8b7578273a8284499e.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqJr9pTkwODqxc1CKRv-zNr3B_kfy4U0g6imaV67oaca4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdK3EsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 23:48:06 -0500
Received: by mail-pf0-f195.google.com with SMTP id j28so2608768pfk.8
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2017 20:48:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJr9pTkwODqxc1CKRv-zNr3B_kfy4U0g6imaV67oaca4A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29-11-17, 10:46, Rob Herring wrote:
> On Tue, Oct 31, 2017 at 7:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +- power-domain-opp: This contains phandle to one of the OPP nodes of the master
> > +  power domain. This specifies the minimum required OPP of the master domain for
> > +  the functioning of the device in this OPP (where this property is present).
> > +  This property can only be set for a device if the device node contains the
> > +  "power-domains" property. Also, either all or none of the OPP nodes in an OPP
> > +  table should have it set.
> 
> This is a "this device requires OPP n" property. Couldn't we want this
> for cases other than a powerdomain OPP? What if a device has
> requirements 2 different OPPs?

Hmm, I agree. We can/should make it more generic.

> On the flipside, I don't think we want devices picking things like CPU
> OPPs and putting policy here. But I'd rather things be extendable than
> reviewing yet another OPP property next month.

Sure, I would rename this property and make necessary changes to it.

-- 
viresh
