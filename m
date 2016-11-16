From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Wed, 16 Nov 2016 08:48:44 +0530
Message-ID: <20161116031844.GD17245@vireshk-i7>
References: <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7>
 <20161110225126.GK16026@codeaurora.org>
 <20161111031120.GE11670@vireshk-i7>
 <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
 <20161115021302.GR5177@codeaurora.org>
 <20161115033151.GG4178@vireshk-i7>
 <20161115185645.GA25626@codeaurora.org>
 <032e1bb4-c9e9-c588-a8c0-dd019bb64254@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33178 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbcKPDSs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 22:18:48 -0500
Received: by mail-pg0-f49.google.com with SMTP id 3so73966392pgd.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2016 19:18:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <032e1bb4-c9e9-c588-a8c0-dd019bb64254@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Viresh Kumar <vireshk@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org

On 15-11-16, 16:11, Dave Gerlach wrote:
> On 11/15/2016 12:56 PM, Stephen Boyd wrote:
> >On 11/15, Viresh Kumar wrote:
> >>There are two important pieces of information we need for multiple
> >>regulator support:
> >>- Which regulator in the consumer node corresponds to which entry in
> >>  the OPP table. As Mark mentioned earlier, DT should be able to get
> >>  us this.
> >
> >This is also possible from C code though. Or is there some case
> >where it isn't possible if we're sharing the same table with two
> >devices? I'm lost on when this would ever happen.
> >
> >It feels like trying to keep the OPP table agnostic of the
> >consuming device and the device's binding is more trouble than
> >it's worth. Especially considering we have opp-shared and *-name
> >now.
> 
> I agree with this, I do not like having to pass a list of regulator names to
> the opp core that I *hope* the device I am controlling has provided.

What do you mean by that? Are you saying this from DT's point of view
or of the code? i.e. Are you saying that you don't like the
dev_pm_opp_set_regulators() API ?

> The
> intent seems to be to use the cpufreq-dt driver as is and not pass any

I would like to kill all regulators code from cpufreq-dt sometime
soon. All that is left there is making sure we have a regulator in
place, but I strongly feel OPP core is the right place for doing that
now.

> cpu-supply anymore so the cpufreq-dt driver has no knowledge of what
> regulators are present (it operates as it would today on a system with no
> regulator required). But as is it will move forward regardless of whether or
> not we actually intended to provide a multi regulator set up or platform
> set_opp helper, and this probably isn't ideal.

Yes and that's why I am more inclined towards my above comment. We
shall make it consistent.

> I would think cpufreq-dt/opp
> core should be have knowledge of what regulators are needed to achieve these
> opp transitions and make sure everything is in place before moving ahead.

The last patch in my series does what you are looking for:

PM / OPP: Don't assume platform doesn't have regulators

Isn't it ?

-- 
viresh
