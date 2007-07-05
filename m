From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 16:43:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051628380.2557-100000__37774.132556706$1183668244$gmane$org@iolanthe.rowland.org>
References: <E1I6VLD-0001Ks-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6VLD-0001Ks-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Miklos Szeredi wrote:

> > > Alan Stern writes:
> > > 
> > > > Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> > > > wanting to resume devices during a system suspend transition?  This is
> > > > exactly what happens when those threads aren't frozen.
> > > 
> > > So, I wonder why I don't see that error on my powerbook?
> > 
> > That's a good question.  Miklos, can you please reproduce the suspend 
> > error using a kernel built with CONFIG_USB_DEBUG turned on?
> 
> Here's the full dmesg.  First there was a successful suspend/resume,
> then a couple of unsuccessful ones:

Okay, good.  It's not a coincidence that the first one worked and later 
ones didn't.  Here's what happened:

You suspended the system.  Upon resuming, the USB host controller 
drivers detected that their device sessions had been interrupted and 
consequently marked your two USB devices (the optical mouse and the 
biometric thingy) for removal.  Normally that removal would take place 
when khubd wakes up, i.e., after the resume is complete and the thread 
is taken out of the freezer.

But in this case khubd was already awake.  It resumed the two root hubs
in response to their remote wakeup requests and saw that the devices
were gone.  So it unregistered the device structures immediately --
even before the PM core tried to resume them -- and then registered new
data structures to embody the new device connections.  As far as I can
tell, the fact that these new device structures were created while the
suspend-list was in flux must have caused one of them (the biometric
coprocessor) not to be added to the appropriate list.

Thus the next time you tried to suspend, the PM core didn't call the
device's suspend method.  It was left awake, and as a result its parent 
hub refused to suspend (since it had an unsuspended child).  This 
caused the overall system suspend to fail.

This illustrates the folly of allowing other threads to perform 
driver-core-type operations in the middle of a system sleep transition.

Alan Stern
