From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 23 Jan 2015 18:25:05 +0530
Message-ID: <CAKohponBQkhoSDi1RT5nW=TfKO7rgjbz1DjVHpUS+nYKs4RYjA@mail.gmail.com>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
	<1422013154.29475.11.camel@pengutronix.de>
	<20150123115206.GT21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61747 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbAWMzG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 07:55:06 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so4839961obc.4
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2015 04:55:05 -0800 (PST)
In-Reply-To: <20150123115206.GT21293@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Mike Turquette <mike.turquette@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On 23 January 2015 at 17:22, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jan 23, 2015 at 12:39:14PM +0100, Lucas Stach wrote:

> I tend to agree that this is clearer.  It might be nice to have variants
> for specifying directly as a percentage but I don't think it's really
> worth the complexity.

> If we change the binding to be typ/min/max rather than min/typ/max then
> we could also do this by allowing either one or three values to be
> specified.  That might be more worth the complexity especially given...

+1

>> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
>> Please let's drop this.
>
> DT bindings are supposed to be stable, this means the code should accept
> old bindings and they should be documented as deprecated.

Yes, I have marked the earlier OPP bindings as deprecated. Will mark
this one too separately.
