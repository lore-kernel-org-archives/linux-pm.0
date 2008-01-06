From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sat, 5 Jan 2008 23:04:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801052249060.8784-100000__41572.6721672856$1199592355$gmane$org@netrider.rowland.org>
References: <200801052258.52272.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801052258.52272.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:

> On Saturday, 5 of January 2008, Alan Stern wrote:
> > On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:

> > > Still, even doing that is not enough, since someone can call
> > > destroy_suspended_device() from a .suspend() routine and then the device
> > > will end up on a wrong list just as well.
> > 
> > That should never happen.  The whole idea of destroy_suspended_device()
> > is that the device couldn't be resumed and in fact should be
> > unregistered because it is no longer working or no longer present.  A
> > suspend routine won't detect this sort of thing since it doesn't try to
> > resume the device.
> > 
> > But it wouldn't hurt to mention in the kerneldoc that 
> > destroy_suspended_device() is meant to be called only during a system 
> > resume.
> 
> Hmm.  Please have a look at the appended patch.
> 
> I have removed the warning from device_del() and used list_empty() to detect
> removed devices in the .suspend() routines.  Is that viable?

It's not good.

The warning in device_del() is vital.  It's what will tell people where
the problem is when a deadlock occurs during system resume because some
driver has mistakenly tried to unregister a device at the wrong time.  
It would have pointed immediately to the msr driver in the case of the
bug Andrew found, for instance.

If you can figure out a way to disable the warning in device_del() for 
just the one device being unregistered by 
device_pm_destroy_suspended(), I suppose that would be okay.

Alan Stern
