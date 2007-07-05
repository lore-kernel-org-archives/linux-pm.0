From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Thu, 5 Jul 2007 10:35:51 +1000
Message-ID: <18060.15591.556676.28935@cargo.ozlabs.ibm.com>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041104140.25704-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707041104140.25704-100000@netrider.rowland.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> > > Yes, the code could be changed to keep track of the reason for a device
> > > suspend.  But that just raises the old problem of what to do when
> > > there's an I/O request for a suspended device during STR.
> > 
> > Is this actually a real problem?  I would think the policy would be
> > "block" for block devices (pun not intended :), "drop" for network
> > devices, etc.
> 
> It is indeed a real problem, or at least, it can be.

How so?  Can you give me an example?

> > How did the device get suspended if it didn't have a driver?  If it
> > did have a driver, why didn't the bind attempt fail?
> 
> Bus subsystems can suspend devices with no drivers.

Interesting.  I assume this is for buses for which there is a
bus-specific but device-independent suspend procedure defined.

It would seem sensible to me that the PM core should get the bus to
resume such a device before calling a driver probe routine.  The
resume should be blocked or deferred while a system suspend is
underway.  In fact I think that all driver bind/unbind and probe
operations should be deferred while the system is suspending (i.e. put
on a list to be done after the system resumes).

> It would help.  It would help even more if the sysfs core also blocked
> all I/O while suspend is under way.  (Although this might be tricky, 
> considering that the suspend is initiated by a sysfs write...)

I didn't think sysfs got involved at all in normal read and write
requests, so I don't know how it would block them...

> The fact remains that lots of drivers would still need to be changed.  
> In the read and write methods someone would have to add code amounting
> to this:
> 
> 	if (suspend_is_under_way()) {
> 		mutex_unlock(...);
> 		block_until_resume();
> 		goto restart;
> 	}
> 
> Freezing userspace is a small amount of code by comparison.

Normally devices have some sort of queue of pending operations.  So
all that is required on suspend is to stop processing the queue and
wait for any currently-underway operations to complete.  The blocking
then happens naturally using the normal I/O wait mechanisms.

Paul.
