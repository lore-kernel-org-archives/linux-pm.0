From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Sat, 17 Oct 2015 09:40:55 +0530
Message-ID: <20151017041055.GZ19018@linux>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
 <20151016191658.GA16437@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36115 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbJQELC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 00:11:02 -0400
Received: by pacfv9 with SMTP id fv9so39828334pac.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 21:11:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151016191658.GA16437@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 16-10-15, 12:16, Stephen Boyd wrote:
> On 10/16, Viresh Kumar wrote:
> > On 15-10-15, 17:22, Stephen Boyd wrote:
> > > I'm lost why we need this property at all. What happened to using
> > > 
> > >  opp-microvolt-0 = <1 2 3>;
> > >  opp-microvolt-1 = <1>;
> > >  opp-microvolt-2 = <3 4 5>;
> > >  etc.
> > 
> > Perhaps you are confusing this with the bindings we came up for
> > picking right voltage levels based on the cuts/version of the hardware
> > we are running on. The problem that Lee Jones mentioned and that can
> > be used in your case as well.
> 
> Isn't that what this patch series is for?

Hehe, no.

Okay here is the problem statement:

We have two supplies for a device and the device node will have
something like:

name1-supply = <&supply1>;
name2-supply = <&supply2>;

And the OPP node needs to have voltages for both of them:

opp-microvolt = <X1 Y1 Z1>, <X2 Y2 Z2>;

Where XYZ(1) are for supply1 and XYZ(2) are for supply2.

Now we need to identify the supplies for which the values are present
here and their order as well. How do we do that?

The way I am suggesting is to add a property in opp node which will
keep "name1" and "name2" in it.

-- 
viresh
