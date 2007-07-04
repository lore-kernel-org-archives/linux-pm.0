From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Wed, 4 Jul 2007 11:12:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707041104140.25704-100000__40462.8402357504$1183562035$gmane$org@netrider.rowland.org>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Jul 2007, Paul Mackerras wrote:

> Whether or not to resume a suspended device when an I/O request comes
> in is a policy decision, and there could be cases where the user wants
> I/O requests to be blocked, or to fail, or to be dropped while the
> device is suspended, even for runtime power management.  For example,
> a sound card could be suspended due to a low-battery condition, and in
> that case you would want the driver to just drop any data that
> userspace tries to write to the soundcard.

We have provisions for that (my earlier description was somewhat 
incomplete).

> > Yes, the code could be changed to keep track of the reason for a device
> > suspend.  But that just raises the old problem of what to do when
> > there's an I/O request for a suspended device during STR.
> 
> Is this actually a real problem?  I would think the policy would be
> "block" for block devices (pun not intended :), "drop" for network
> devices, etc.

It is indeed a real problem, or at least, it can be.

> > Consider a particularly troublesome case: During STR, a non-frozen task
> > writes to /sys/bus/BBB/drivers/DDD/bind.  The sysfs core grabs the
> > device semaphore and calls the driver's probe routine.  If the driver
> > isn't PM-aware it simply tries to initialize the device and fails
> > because the device is already suspended.  That's no good; it isn't
> > transparent.
> 
> How did the device get suspended if it didn't have a driver?  If it
> did have a driver, why didn't the bind attempt fail?

Bus subsystems can suspend devices with no drivers.

> Suppose the device-model core code simply blocked all bind and unbind
> requests while suspend is under way, until resume is finished.
> Wouldn't that solve the problem?

It would help.  It would help even more if the sysfs core also blocked
all I/O while suspend is under way.  (Although this might be tricky, 
considering that the suspend is initiated by a sysfs write...)

The fact remains that lots of drivers would still need to be changed.  
In the read and write methods someone would have to add code amounting
to this:

	if (suspend_is_under_way()) {
		mutex_unlock(...);
		block_until_resume();
		goto restart;
	}

Freezing userspace is a small amount of code by comparison.

Alan Stern
