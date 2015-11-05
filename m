From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/5] PM / OPP: Add
 {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
Date: Thu, 5 Nov 2015 08:49:13 +0530
Message-ID: <20151105031913.GA29491@ubuntu>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <17a4388be606f21fe1d31b23180d41f6cabdd4b5.1446687367.git.viresh.kumar@linaro.org>
 <20151105030245.GA20613@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36523 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031616AbbKEDTT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2015 22:19:19 -0500
Received: by pacdm15 with SMTP id dm15so48433529pac.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2015 19:19:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151105030245.GA20613@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, robh+dt@kernel.org, sboyd@codeaurora.org, lee.jones@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, nm@ti.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 04-11-15, 21:02, Rob Herring wrote:
> > +- turbo-mode-<name>: Named turbo-mode property. Similar to opp-microvolt-<name>
> > +  property, but for turbo mode instead.
> > +
> >  - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
> >    the table should have this.
> >  
> > +- opp-suspend-<name>: Named opp-suspend property. Similar to
> > +  opp-microvolt-<name> property, but for suspend opp instead.
> > +
> 
> I don't think these last 2 make sense. turbo-mode is a flag that the 
> mode has restrictions such as other cores have to be idle or something. 
> Similarly, opp-suspend should not vary by <name>.

Based on what version of the hardware you are running, via
opp-supported-hw property, the platform can enable a different set of
OPPs. And in that case we may want to select different OPPs marked as
turbo or suspend freq. That's what I thought at least.

For example, on version A of the hardware we have following available
frequencies: 800, 1000, 1100, 1200 MHz. Where 800 MHz is the suspend
freq and 1200 is the turbo one.

But on a slightly different version of hardware B, we have two more
OPPs available: 700 and 1400 MHz. And in that case we want the suspend
freq to be 700 and turbo OPP to be only 1400 MHz.

-- 
viresh
