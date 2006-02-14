From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 21:41:10 +0100
Message-ID: <200602142141.10545.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0602141417350.1419-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602141417350.1419-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday 14 February 2006 20:26, Alan Stern wrote:
> On Mon, 13 Feb 2006, Rafael J. Wysocki wrote:
> > On Monday 13 February 2006 22:24, Alan Stern wrote:
> > > On Mon, 13 Feb 2006, Phillip Susi wrote:
> > }-- snip --{
> > > You are complaining because you don't like the way USB was designed.  
> > > That's fine, but it leaves you advocating a non-standardized position.
> > > 
> > > Can you suggest a _reliable_ way to tell if the USB device present at a 
> > > port after resuming is the same device as was there before suspending?
> > 
> > It seems to follow from your discussion that if I have a mounted filesystem
> > on a USB device and I suspend to disk, I can lose data unless the filesystem
> > has been mounted with "sync".
> 
> That's right.  It depends on your hardware, and it could be true even for
> suspend-to-RAM.  In fact, even with "-o sync" you can lose data if your
> programs have information in buffers they haven't written out to disk.
> 
> If you're lucky, your hardware will support low-power modes for USB
> controllers while the system is asleep.  Lots of hardware doesn't,
> however.  Shutting off the power to a USB controller is equivalent to 
> unplugging all the attached devices.
> 
> Remember that it's always a bad idea to unplug a disk drive containing a
> mounted filesystem.  With USB that's true even when your system is asleep!
> The safest thing is to unmount all USB-based filesystems before suspending 
> and remount them after resuming.

Still, this may be impossible if the box is suspending because of its
battery running critical.

I'm afraid this behavior will cause support problems to appear in the long
run.   [BTW, I wonder if it's USB-only, or some other subsystems behave
in a similar way, like ieee1394 or external SATA.  And how about
NFS/CIFS/whatever network filesystems mounted on the suspending box?]

I think one solution to consider could be to add an abstract fs layer
on top of the removable filesystem, like subfs in SuSE, with the ability
to retain the user information accross device disconnects and to update
the fs state from the actual device when it reappears in the system and
to resolve possible conflicts (to a reasonable extent).

> > If this is the case, there should be a big fat warning in the swsusp
> > documentation, but there's nothing like that in there (at lease I can't find
> > it easily).
> > 
> > [If this is not the case, I've missed something and sorry for the noise.]
> 
> I'm not aware of any warnings about this in the documentation.  If you 
> would like to add something, please go ahead.

I'm going to do this.  Can I use your explanation above?

Rafael
