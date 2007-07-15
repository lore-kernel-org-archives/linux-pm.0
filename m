From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 19:28:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707151918340.30402-100000__1716.32804344899$1184542237$gmane$org@netrider.rowland.org>
References: <200707152040.33836.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707152040.33836.a1426z@gawab.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Boldi <a1426z@gawab.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Al Boldi wrote:

> Alan Stern wrote:
> > On Sun, 15 Jul 2007, Al Boldi wrote:
> > > >     If possible, during a restore devices should be brought back to
> > > > the same state in which they were before the corresponding
> > > > hibernation.  Of course in some situations it might be impossible to
> > > > do that (eg. the user connected the hibernated system to a different
> > > > IP subnet and then restored), but as a general rule, we should do our
> > > > best to restore the state of devices, which is directly related to
> > > > point (5) above.
> > >
> > > This part could easily be handled by the normal kernel before and after
> > > resume.
> >
> > I agree with you except for the word "easily".  And there are some
> > things the kernel simply punts on (I'm thinking of the current VGA
> > font).
> 
> Why; can you explain?

>From personal experience I can assure you that it hasn't been easy
getting the USB subsystem to restore devices following a hibernate.  
(In fact the current implementation goes against the spirit, if not the
letter, of the USB spec.)  And making it work requires user
intervention.

As for the VGA font, the effect is easy to see: Run setfont before 
hibernating; when you resume the original font will be back.  The 
kernel simply does not bother to save the VGA font information across a 
hibernate.

> > > This should be the responsibility of the kexec'd hibernating kernel. 
> > > Note though in (6), the normal kernel takes care of preparing devices,
> > > then the hibernating kernel dumps the image and either calls S4 or S3. 
> > > On resume from S3 it can immediately switch over to the normal kernel,
> > > and from S4 the known bootup would occur.
> >
> > Is it really that simple?  Somehow I doubt it.  In order for some
> > devices to remain available for the kexec'd kernel to use, they cannot
> > be suspended at the ACPI level.  So the kexec'd kernel will have to
> > handle the ACPI requirements for those devices.  Likewise, it would
> > have to handle the ACPI interactions which need to be done after all
> > devices are prepared for the transition to S3 or S4.
> 
> Ok, after applying the latest kexec patches, I was able to use the kexec'd 
> kernel to suspend to ram and resume to the normal kernel, while working 
> under a full-blown X session.  It went without a hitch.  All that is needed 
> now are the dump/restore hibernation-image routines.

That's exactly my point.  While doing suspend-to-RAM from a kexec'd 
kernel may be simple, saving the hibernation image will add 
complications.

> > > The latest hibernating kexec patches boot a kexec'd modular kernel with
> > > initramfs into crashkernel=16M@16M in less than one second.  Switch-back
> > > is almost instant.  Add to this the time required to either store or
> > > restore the image, and it may be obvious that this approach isn't
> > > slower, but maybe even faster than the current swsusp.
> >
> > Does that include the time required for probing PCI buses?  On my
> > desktop system, PCI probing incurs a five-second timeout delay because
> > of a bug in the BIOS's USB firmware.
> 
> Using a modular kernel you would only insmod those modules that you need to 
> dump the image, which is mainly the diskdriver.  If you wanted to dump it 
> onto USB flash, then you would insmod that driver, and if that driver is 
> slow due to a bug, then a fix should be in order.

I said nothing about dumping onto USB flash.  I was referring to PCI 
probing; presumably any reasonable kernel for desktop/laptop systems 
will include PCI support.

And the bug isn't in Linux; it is in the firmware.  There's no way to 
fix it short of a BIOS upgrade (and this particular BIOS is no longer 
supported).

Alan Stern
