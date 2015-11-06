From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/5] PM / OPP: Add
 {opp-microvolt|opp-microamp|turbo-mode|opp-suspend}-<name> binding
Date: Fri, 6 Nov 2015 07:23:21 +0530
Message-ID: <20151106015321.GF3773@ubuntu>
References: <cover.1446687367.git.viresh.kumar@linaro.org>
 <17a4388be606f21fe1d31b23180d41f6cabdd4b5.1446687367.git.viresh.kumar@linaro.org>
 <20151105030245.GA20613@rob-hp-laptop>
 <20151105031913.GA29491@ubuntu>
 <CAL_Jsq+sKbn9Jsp6LjfwO59Ceps3zrL8eABXw74m3A25M8bjJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36050 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965402AbbKFBx1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 20:53:27 -0500
Received: by pacdm15 with SMTP id dm15so80906112pac.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2015 17:53:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+sKbn9Jsp6LjfwO59Ceps3zrL8eABXw74m3A25M8bjJg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, open list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 05-11-15, 17:33, Rob Herring wrote:
> On Wed, Nov 4, 2015 at 9:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 04-11-15, 21:02, Rob Herring wrote:
> >> > +- turbo-mode-<name>: Named turbo-mode property. Similar to opp-microvolt-<name>
> >> > +  property, but for turbo mode instead.
> >> > +
> >> >  - opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
> >> >    the table should have this.
> >> >
> >> > +- opp-suspend-<name>: Named opp-suspend property. Similar to
> >> > +  opp-microvolt-<name> property, but for suspend opp instead.
> >> > +
> >>
> >> I don't think these last 2 make sense. turbo-mode is a flag that the
> >> mode has restrictions such as other cores have to be idle or something.
> >> Similarly, opp-suspend should not vary by <name>.
> >
> > Based on what version of the hardware you are running, via
> > opp-supported-hw property, the platform can enable a different set of
> > OPPs. And in that case we may want to select different OPPs marked as
> > turbo or suspend freq. That's what I thought at least.
> >
> > For example, on version A of the hardware we have following available
> > frequencies: 800, 1000, 1100, 1200 MHz. Where 800 MHz is the suspend
> > freq and 1200 is the turbo one.
> >
> > But on a slightly different version of hardware B, we have two more
> > OPPs available: 700 and 1400 MHz. And in that case we want the suspend
> > freq to be 700 and turbo OPP to be only 1400 MHz.
> 
> But different frequencies are different OPP nodes (since that is the
> unit address now), so it is not going to hurt to set turbo-mode on
> both 1200 and 1400.

Yeah, but in that case 1200 *may* not be a turbo frequency anymore, as
the voltage constraints might have changed.

So turbo frequency is something that should be used only in small
bursts, as they are consume lot of power. They aren't available to be
used freely. They may also have thermal side effects..

In a similar way, for suspend-freq, we may or may not want the lowest
frequency to be used during suspend and so that can change as well.
And we shouldn't have suspend-freq set for two OPP nodes.

-- 
viresh
