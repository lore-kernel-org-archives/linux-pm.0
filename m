From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH]switching off autosuspend through sysfs
Date: Wed, 24 Jan 2007 17:15:24 -0800
Message-ID: <20070125011523.GA4542@suse.de>
References: <20070124003221.GA3755@suse.de>
	<Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701241145140.4368-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, oneukum@suse.de, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 24, 2007 at 11:51:17AM -0500, Alan Stern wrote:
> On Tue, 23 Jan 2007, Greg KH wrote:
> 
> > On Tue, Jan 23, 2007 at 04:22:43PM -0800, David Brownell wrote:
> > > > > >  static struct attribute *dev_attrs[] = {
> > > > > > +	/* power management attributes */
> > > > > > +	&dev_attr_autosuspend.attr,
> > > > > 
> > > > > Belongs in /sys/devices/.../power/... then, right?
> > > >
> > > > No, I thought we want to drop that power/ directory.
> > > 
> > > Dropping that directory hasn't AFAIK ever been discussed.
> > > If it were to be dropped, where would the per-device wakeup
> > > flags live?
> > 
> > I don't know, it just really annoys me to see that power directory there
> > with no use for it for a lot of devices :)
> 
> Would it help to add a flag somewhere in struct device (or struct
> dev_pm_info) for indicating that the device is not cognizant of PM?  For
> instance, all those USB endpoint pseudo-devices we create -- it's a waste
> of time to try doing power management on them and it generates a bunch of
> useless and distracting warning messages in the system log.

Yes.  In fact we should just make it a "has pm" type flag, as the
majority of devices do not.

So, what kind of devices do support these files?  I can think of:
	PCI
	USB
and that's it right now.  Do platform devices really use those files?

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
