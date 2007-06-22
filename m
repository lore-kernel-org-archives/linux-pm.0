From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Fri, 22 Jun 2007 10:22:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706221007180.3290-100000__26172.4809221507$1182522265$gmane$org@iolanthe.rowland.org>
References: <200706220302.11081.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706220302.11081.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Mattia Dongili <malattia@linux.it>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Jun 2007, David Brownell wrote:

> On Wednesday 20 June 2007, Mattia Dongili wrote:
> 
> > http://www.linux.it/~malattia/logs/dmesg-suspend-ehci-debug-log
> 
> which includes
> 
> > [18014387.734703] psmouse serio1: resuming
> > [18014388.257990] usb_endpoint usbdev5.1_ep00: PM: resume from 0, parent usb5 still 2
> > [18014388.257994] usb_endpoint usbdev5.1_ep81: PM: resume from 0, parent 5-0:1.0 still 2
> > [18014388.258004] usb_endpoint usbdev5.2_ep00: PM: resume from 0, parent 5-4 still 2
> > [18014388.258007] usb_endpoint usbdev5.4_ep00: PM: resume from 0, parent 5-6 still 2
> > [18014388.258011] usb_endpoint usbdev5.4_ep81: PM: resume from 0, parent 5-6:1.0 still 2
> > [18014388.258014] usb_endpoint usbdev5.4_ep86: PM: resume from 0, parent 5-6:1.0 still 2
> > [18014388.258019] sony-laptop sony-laptop: resuming 
> > [18014388.258022] platform bluetooth: resuming
> > [18014388.258034] usb_endpoint usbdev5.2_ep02: PM: resume from 0, parent 5-4:1.0 still 2
> > [18014388.258037] usb_endpoint usbdev5.2_ep82: PM: resume from 0, parent 5-4:1.0 still 2
> > [18014388.310276] Restarting tasks ... <7>usb usb5: usb resume
> > [18014388.310514] usb usb5: finish resume
> > [18014388.310524] ehci_hcd 0000:00:1d.7: resume root hub
> > [18014388.312058] done.
> > [18014388.437263] hub 5-0:1.0: hub_resume
> > [18014388.437314] hub 5-0:1.0: state 7 ports 8 chg 0000 evt 0000
> 
> That looks pretty darn goofy.  Resumes out of order:  endpoints for child
> devices, then the downstream root hub, then finally the PCI dev.  Which
> is completely the reverse of the correct direction.
> 
> Or am I missing something?

You are.  I've seen lots of logs like this, and it all makes sense even 
if the logic isn't obvious.

First, note that the portion of the log you excerpted doesn't include
the resume message for the PCI device.  If you look higher up, you'll
see that 0000:00:1d.7 does indeed get resumed as expected.  The
appearance of the PCI name above is an artifact caused by calling
ehci_dbg(ehci) instead of dev_dbg(&hcd->root_hub.dev) in
ehci_bus_resume().

Second, bear in mind that the PM core doesn't try to resume devices if
they were already asleep at the time of the system suspend.  That
explains why usb5 and its child devices aren't resumed when you might
expect.

Next, bear in mind that the endpoint pseudo-devices don't have any
suspend/resume support at all.  That's why you see "resume from 0"  
above.

Finally, bear in mind that root-hub remote wakeup events are handled by 
a kernel thread which is frozen during hibernation.  When tasks get 
restarted the thread is able to run, and it then does a remote-wakeup 
resume of the usb5 root hub.  The first three messages following 
"Restarting tasks..." show this, and the last two lines show the root 
hub's interface being resumed.

Alan Stern
