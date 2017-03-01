From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/7] PM / OPP: Introduce "domain-performance-state"
 binding to OPP nodes
Date: Wed, 1 Mar 2017 11:42:28 +0530
Message-ID: <20170301061228.GD24323@vireshk-i7>
References: <cover.1487926924.git.viresh.kumar@linaro.org>
 <ceb1bf5f696138c30b30743c24b619336d438d7c.1487926924.git.viresh.kumar@linaro.org>
 <20170228003948.ihf4c2ppu2rf3lt2@rob-hp-laptop>
 <20170228065711.GD19417@vireshk-i7>
 <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33757 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdCAGlM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 01:41:12 -0500
Received: by mail-pf0-f181.google.com with SMTP id w189so7922380pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Feb 2017 22:40:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_JsqLx6Y=JgaVtJPFwERQ_=5qwqp5EY1+B=cdfBJO55Vct4w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 28-02-17, 08:10, Rob Herring wrote:
> On Tue, Feb 28, 2017 at 12:57 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > That's what I did in V2, but then I turned it down considering the parent/child
> > relationships we may have.
> >
> > There are multiple cases we can have:
> >
> > A.) DeviceX  --->  Parent-domain-1 (Contains Perfomance states)
> >
> > B.) DeviceX  --->  Parent-domain-1  ---> Parent domain-2 (Contains Perfomance states)

Okay, how about this case first? Should we still use a phandle or an index
value?

> >
> >                                     ---> Parent domain-2 (Contains Perfomance states)
> >                                     |
> >                                     |
> > C.) DeviceX  --->  Parent-domain-1  |
> >                                     |
> >                                     |
> >                                     ---> Parent domain-3 (Contains Perfomance states)
> 
> I'm a bit confused. How does a domain have 2 parent domains?

The framework supported it and so I thought it should be fairly common. Even in
the last version, I coded the notifier to handle cases where we have only one
parent domain. But then Kevin pointed out that we shouldn't be doing any such
special things. But binding doesn't say anything about it though, and I was just
presenting an example.

> You have the same problem either way. If I have performance state 2
> for the device, that corresponds to domain 2 or 3?

Right now I have used the same performance state for both the domains in the
code, as I am not sure if we will have such a case. And probably we can figure
this out when we have a case with separate levels for both parents. It would be
trivial to extend the bindings to include a list instead of a single value here.

So, to conclude, should I use a phandle here or it is fine the way it is written
right now ? With direct numbers, its easy to parse it in the OPP framework for
example, as that's the value the QoS framework will use. Else we need to parse
the phandle and read the "reg" value from there.

-- 
viresh
