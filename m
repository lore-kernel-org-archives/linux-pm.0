From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Tue, 7 Jul 2015 10:55:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507071028480.1692-100000@iolanthe.rowland.org>
References: <14963352.fDKd3nIddf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14963352.fDKd3nIddf@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 7 Jul 2015, Rafael J. Wysocki wrote:

> > > All right, we can make a decision and document it.  The following seems
> > > reasonable to me:
> > > 
> > > 	If dev->power.direct_complete is set then the PM core will
> > > 	assume that dev->power.rpm_status is accurate even when
> > > 	dev->power.disable_depth > 0.  The core will obey the
> > > 	.direct_complete setting regardless of .disable_depth.
> > > 
> > > 	As a consequence, devices that support system sleep but don't 
> > > 	support runtime PM must _never_ have .direct_complete set.
> > > 
> > > 	On the other hand, if a device (such as a "virtual" device)
> > > 	requires no callbacks for either system sleep or runtime PM, 
> > > 	then there is no harm in setting .direct_complete.  Indeed,
> > > 	doing so may help speed up an ancestor device's sleep
> > > 	transition.
> > > 
> > > How does that sound?
> > 
> > It would be workable I think, but I'd prefer the core to be told directly
> > about devices whose runtime PM status doesn't matter (because nothing changes
> > between "suspended" and "active"), so they may be treated in a special way
> > safely.
> > 
> > If we had that information, no special rules other than "that is a device
> > whose runtime PM status doesn't matter, so treat it accordingly" would be
> > necessary.
> 
> That said, a situation to consider is when device X is just a software device,
> but it has children that correspond to physical hardware.  If that is the case,
> the usual parent-children rules should apply to X and its children (ie. X should
> only be marked as "suspended" if all of its children are suspended) and I see
> no reason why the parent-children rules for direct_resume should not apply here.

Yes, this illustrates that in some ways we must not treat "virtual" or 
"software" devices specially.  Being "virtual" is not the same as 
having the ignore_children flag set.

The change I'm proposing is not related to whether a device is 
"virtual".  I'm just suggesting that the normal direct_complete rules 
should apply even when devices are runtime-PM-disabled.

This doesn't mean that their runtime PM status doesn't matter.  Just
the opposite, in fact -- it means that the PM core should pay attention
to the runtime PM status during a sleep transition even though
disabled_depth > 0.

Alan Stern
