From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Wed, 08 Jul 2015 00:06:22 +0200
Message-ID: <9291571.JSDgNsKidJ@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507071028480.1692-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48589 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754468AbbGGVj4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 17:39:56 -0400
In-Reply-To: <Pine.LNX.4.44L0.1507071028480.1692-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tuesday, July 07, 2015 10:55:59 AM Alan Stern wrote:
> On Tue, 7 Jul 2015, Rafael J. Wysocki wrote:
> 
> > > > All right, we can make a decision and document it.  The following seems
> > > > reasonable to me:
> > > > 
> > > > 	If dev->power.direct_complete is set then the PM core will
> > > > 	assume that dev->power.rpm_status is accurate even when
> > > > 	dev->power.disable_depth > 0.  The core will obey the
> > > > 	.direct_complete setting regardless of .disable_depth.
> > > > 
> > > > 	As a consequence, devices that support system sleep but don't 
> > > > 	support runtime PM must _never_ have .direct_complete set.
> > > > 
> > > > 	On the other hand, if a device (such as a "virtual" device)
> > > > 	requires no callbacks for either system sleep or runtime PM, 
> > > > 	then there is no harm in setting .direct_complete.  Indeed,
> > > > 	doing so may help speed up an ancestor device's sleep
> > > > 	transition.
> > > > 
> > > > How does that sound?
> > > 
> > > It would be workable I think, but I'd prefer the core to be told directly
> > > about devices whose runtime PM status doesn't matter (because nothing changes
> > > between "suspended" and "active"), so they may be treated in a special way
> > > safely.
> > > 
> > > If we had that information, no special rules other than "that is a device
> > > whose runtime PM status doesn't matter, so treat it accordingly" would be
> > > necessary.
> > 
> > That said, a situation to consider is when device X is just a software device,
> > but it has children that correspond to physical hardware.  If that is the case,
> > the usual parent-children rules should apply to X and its children (ie. X should
> > only be marked as "suspended" if all of its children are suspended) and I see
> > no reason why the parent-children rules for direct_resume should not apply here.
> 
> Yes, this illustrates that in some ways we must not treat "virtual" or 
> "software" devices specially.  Being "virtual" is not the same as 
> having the ignore_children flag set.
> 
> The change I'm proposing is not related to whether a device is 
> "virtual".  I'm just suggesting that the normal direct_complete rules 
> should apply even when devices are runtime-PM-disabled.
> 
> This doesn't mean that their runtime PM status doesn't matter.  Just
> the opposite, in fact -- it means that the PM core should pay attention
> to the runtime PM status during a sleep transition even though
> disabled_depth > 0.

I seem to have lost the context here, sorry about that.

The idea seems to be to rely on the fact that the RPM status for all devices
is initially RPM_SUSPENDED and that never changes if runtime PM is never
enabled for the device, so in that particular case it would be OK to treat
the "power.direct_complete set + RPM status == RPM_SUSPENDED" combination
as valid even though runtime PM has never been enabled for the device in
question (provided that power.direct_complete will never be set for "real"
devices that don't support runtime PM).  Is that correct?

That seems to be fragile, but I have no strong opinion.

Let's do that change if it allows us to make forward progress here.  Please
feel free to submit a documentation patch along the lines you've suggested.

Thanks,
Rafael

