From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: Suspend without the freezer
Date: Wed, 1 Aug 2007 13:50:35 +1000
Message-ID: <18096.779.270253.318946@cargo.ozlabs.ibm.com>
References: <200707311105.40449.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0707311112590.3520-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707311112590.3520-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Stern writes:

> I think this is subject to the same weakness Dmitry mentions: By the
> time the driver would block on the new rwsem, it has already started
> mucking with the device.  Worse yet, it may hold a mutex that the 
> suspend method needs, thereby deadlocking the suspend.  (That's what 
> would happen with serio->drv_mutex in the input layer.)
> 
> Maybe the best answer is simply to fail all attempts at device
> registration while a suspend is underway.  At least that is a known
> error path which drivers are prepared (in theory) to deal with.  It
> could be implemented quite easily with an rwsem, by making the
> registration code use down_read_trylock.

What about making a list of devices that drivers have attempted to
register?  While the system is suspending, if a driver attempts to
register a device, put it on a list and return success.  Then, after
resuming, run through the list and actually process them.

I guess removal during suspend/resume should remove the list entry, if
the device is one of the ones on the list.  Otherwise, is there a
problem with letting removals proceed during suspend/resume?  (In
general removal can be notified after the device has physically
disappeared IIRC, so driver unbind functions have to avoid touching
the device or at least be prepared to deal with it not responding.)

Paul.
