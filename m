From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH]switching off autosuspend
	through sysfs
Date: Thu, 25 Jan 2007 11:09:12 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0701251103290.3958-100000@iolanthe.rowland.org>
References: <200701241815.22007.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200701241815.22007.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: oneukum@suse.de, Greg KH <gregkh@suse.de>, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Jan 2007, David Brownell wrote:

> =

> > > > I don't know, it just really annoys me to see that power directory =
there
> > > > with no use for it for a lot of devices :)
> > > =

> > > Would it help to add a flag somewhere in struct device (or struct
> > > dev_pm_info) for indicating that the device is not cognizant of PM? =

> =

> If it would, the semantics would need to be clarified.  Is the problem
> that they can't suspend/resume at all?  Or is the problem instead that
> they (or their drivers) don't know how to do that without any loss of
> functionality ... without a complete reset or whatever?

The semantics I intended was that the flag should indicate the driver was =

completely ignorant of PM.  It has no suspend or resume methods and no way =

of enabling or disabling remote wakeup.  As is true, for example, of those =

USB endpoint pseudo-devices.

Maybe this means the flag belongs in the driver's structure instead of the
device's.  But the PM core tries to avoid looking at drivers...

> Most devices can -- if poked and prodded appropriately, and if no
> BIOS or uploaded firmware interferes badly enough -- make it through
> some kind of system suspend state.  Whether that's the one the user
> has chosen ... different issue!  And whether the driver knows how to
> do that ... also a different issue!
> =

> But the specific problems we're seeing right now with the USB autosuspend
> stuff relate to _runtime_ suspend.  I believe some of them are just bugs
> in the stack; where better coddling of the devices would let them make it
> through unscathed.  But some of them, likewise, probably _do_ have real
> problems with real runtime suspend states (that don't map to "off").

That would be a separate issue.  For now there's a (large?) set of devices
whose drivers don't know Power Management from a hole in the wall.

Alan Stern
