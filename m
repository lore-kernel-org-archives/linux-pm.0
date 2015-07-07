From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Tue, 07 Jul 2015 02:07:47 +0200
Message-ID: <14963352.fDKd3nIddf@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507041021080.19175-100000@netrider.rowland.org> <1714292.iHVMDeHUzi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56548 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756229AbbGFXlX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 19:41:23 -0400
In-Reply-To: <1714292.iHVMDeHUzi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday, July 06, 2015 01:36:46 AM Rafael J. Wysocki wrote:
> On Saturday, July 04, 2015 10:37:55 AM Alan Stern wrote:
> > On Sat, 4 Jul 2015, Rafael J. Wysocki wrote:
> > 
> > > > >> > Perhaps the pm_runtime_suspended_if_enabled() test should be changed to
> > > > >> > pm_runtime_status_suspended().  Then it won't matter whether the
> > > > >> > descendant devices are enabled for runtime PM.
> > > > >>
> > > > >> Yeah, that would remove the need for messing with the runtime PM
> > > > >> enable status of descendant devices, but I wonder why Rafael went that
> > > > >> way initially.
> > > > >
> > > > > I forget the details.  Probably it was just to be safe.  We probably
> > > > > thought that if a device was disabled for runtime PM then its runtime
> > > > > PM status might not be accurate.  But if direct_complete is set then it
> > > > > may be reasonable to assume that the runtime PM status _is_ accurate.
> > > > 
> > > > Cool.
> > > 
> > > We're walking a grey area here.  What exactly does power.direct_complete mean
> > > for devices whose runtime PM is disabled?
> > 
> > > > Let's see what Rafael thinks about these two issues.  It seems to me
> > > > that the hardest part is dealing with drivers/subsystems that have no
> > > > runtime PM support.  In such cases, we have to be very careful not to
> > > > use direct_complete unless we know that the device does no power
> > > > management at all.
> > > 
> > > Precisely.
> > 
> > All right, we can make a decision and document it.  The following seems
> > reasonable to me:
> > 
> > 	If dev->power.direct_complete is set then the PM core will
> > 	assume that dev->power.rpm_status is accurate even when
> > 	dev->power.disable_depth > 0.  The core will obey the
> > 	.direct_complete setting regardless of .disable_depth.
> > 
> > 	As a consequence, devices that support system sleep but don't 
> > 	support runtime PM must _never_ have .direct_complete set.
> > 
> > 	On the other hand, if a device (such as a "virtual" device)
> > 	requires no callbacks for either system sleep or runtime PM, 
> > 	then there is no harm in setting .direct_complete.  Indeed,
> > 	doing so may help speed up an ancestor device's sleep
> > 	transition.
> > 
> > How does that sound?
> 
> It would be workable I think, but I'd prefer the core to be told directly
> about devices whose runtime PM status doesn't matter (because nothing changes
> between "suspended" and "active"), so they may be treated in a special way
> safely.
> 
> If we had that information, no special rules other than "that is a device
> whose runtime PM status doesn't matter, so treat it accordingly" would be
> necessary.

That said, a situation to consider is when device X is just a software device,
but it has children that correspond to physical hardware.  If that is the case,
the usual parent-children rules should apply to X and its children (ie. X should
only be marked as "suspended" if all of its children are suspended) and I see
no reason why the parent-children rules for direct_resume should not apply here.

Thanks,
Rafael

