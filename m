From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH]switching off autosuspend
	through sysfs
Date: Wed, 24 Jan 2007 11:51:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
References: <20070124003221.GA3755@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070124003221.GA3755@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <gregkh@suse.de>
Cc: oneukum@suse.de, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Jan 2007, Greg KH wrote:

> On Tue, Jan 23, 2007 at 04:22:43PM -0800, David Brownell wrote:
> > > > >  static struct attribute *dev_attrs[] =3D {
> > > > > +	/* power management attributes */
> > > > > +	&dev_attr_autosuspend.attr,
> > > > =

> > > > Belongs in /sys/devices/.../power/... then, right?
> > >
> > > No, I thought we want to drop that power/ directory.
> > =

> > Dropping that directory hasn't AFAIK ever been discussed.
> > If it were to be dropped, where would the per-device wakeup
> > flags live?
> =

> I don't know, it just really annoys me to see that power directory there
> with no use for it for a lot of devices :)

Would it help to add a flag somewhere in struct device (or struct
dev_pm_info) for indicating that the device is not cognizant of PM?  For
instance, all those USB endpoint pseudo-devices we create -- it's a waste
of time to try doing power management on them and it generates a bunch of
useless and distracting warning messages in the system log.

> > >	I have no
> > > objection to it going into the USB device directory, as that is the
> > > proper place for it.
> > =

> > It'd be OK for a USB-specific mechanism, but there was at
> > one point some discussion about this mechanism being more
> > generally appropriate.
> =

> Hm, I missed that.  This seems to be a very usb-specific thing at the
> moment.

It is USB-specific because I wanted to start out in a well-defined =

environment where the mechanisms could get tested and shaken out.  When =

the problems are gone, it will make sense to think about moving the whole =

autosuspend infrastructure into the PM core.

>  And an annoying one too for some of my devices...powering off
> the bus for USB devices with no drivers might start causing devices that
> use usbfs to do wierd things.  Still trying to work it all out though...

If it does then we need to know and find a way to deal with it.

Alan Stern
