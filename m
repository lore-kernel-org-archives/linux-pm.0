From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Sun, 10 Oct 2010 16:34:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010101626550.30042-100000__34726.5280005105$1286742926$gmane$org@netrider.rowland.org>
References: <201010100102.19862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010100102.19862.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 10 Oct 2010, Rafael J. Wysocki wrote:

> > > > > There's no interface for that at the PM core level, but I think we should
> > > > > add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> > > > > flag for drivers who want to make their suspend/resume callbacks to be
> > > > > reachable directly from user space.  Setting that flag would enable a sysfs
> > > > > attribute in /sys/devices/.../power/ allowing user space to invoke
> > > > > pm_runtime_suspend() and pm_runtime_resume() for the given device.
> > > > 
> > > > We already have power/control.  If the subsystem sets it to "on" by 
> > > > default and the driver suspends the device whenever it is idle, then 
> > > > userspace can control the power level by writing "auto" or "on" to 
> > > > power/control.

...

> > You are clearly right; userspace has to tell the driver when it is okay
> > to suspend.  My point was that we already have a mechanism in the PM
> > core for doing this -- assuming the driver is written appropriately (to 
> > assume that it should try to suspend whenever possible).  We shouldn't 
> > need to add another mechanism.
> 
> OK, so how is a graphics driver going to figure out it should suspend when the
> button is pressed in the example above?

The graphics driver doesn't have to figure that out at all.  It merely
has to suspend the display whenever it can, i.e., whenever the usage
count drops to 0 (or equivalently, whenever the runtime_idle callback
runs).

It's up to userspace to make sure that the display's usage count goes
to 0 at the proper time, i.e., when the button is pressed.  Contrary to
what you wrote above, we _do_ have an interface for this at the PM core
level: power/control.

Alan Stern
