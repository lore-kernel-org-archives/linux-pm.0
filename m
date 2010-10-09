From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 01:02:19 +0200
Message-ID: <201010100102.19862.rjw__33821.1934468292$1286665431$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1010091834420.21785-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1010091834420.21785-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, October 10, 2010, Alan Stern wrote:
> On Sat, 9 Oct 2010, Rafael J. Wysocki wrote:
> 
> > On Wednesday, October 06, 2010, Alan Stern wrote:
> > > On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > Mobile folks wish to power down some devices (most often input -
> > > > > touchscreen, keypad) under certain circumstances to save power.
> > > > > So far they were doing that by adding "disable" hook to individual
> > > > > drivers and while I did allow that in for some devices I feel that we
> > > > > need more standardised solution, preferably one that could re-use
> > > > > existing PM hooks in drivers.
> > > > 
> > > > There's no interface for that at the PM core level, but I think we should
> > > > add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> > > > flag for drivers who want to make their suspend/resume callbacks to be
> > > > reachable directly from user space.  Setting that flag would enable a sysfs
> > > > attribute in /sys/devices/.../power/ allowing user space to invoke
> > > > pm_runtime_suspend() and pm_runtime_resume() for the given device.
> > > 
> > > We already have power/control.  If the subsystem sets it to "on" by 
> > > default and the driver suspends the device whenever it is idle, then 
> > > userspace can control the power level by writing "auto" or "on" to 
> > > power/control.
> > 
> > The problem is that with the 'auto' setting the driver decides when to suspend
> > and the driver need not know it's the right time.
> > 
> > Suspending a graphics adapter when the user presses a "turn screen off"
> > button it a good example of this.  The graphics driver may not know the button
> > was pressed and it has to be told about that.  OTOH the button driver need
> > not know what exactly should be done when it is pressed.  There may be a user
> > space component in between that processes the button event and should be able
> > to tell the graphics driver to suspend.
> 
> You are clearly right; userspace has to tell the driver when it is okay
> to suspend.  My point was that we already have a mechanism in the PM
> core for doing this -- assuming the driver is written appropriately (to 
> assume that it should try to suspend whenever possible).  We shouldn't 
> need to add another mechanism.

OK, so how is a graphics driver going to figure out it should suspend when the
button is pressed in the example above?

Rafael
