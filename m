From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Suspend without the freezer
Date: Wed, 1 Aug 2007 10:33:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0708011013260.3764-100000@iolanthe.rowland.org>
References: <18096.779.270253.318946@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18096.779.270253.318946@cargo.ozlabs.ibm.com>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Paul Mackerras wrote:

> Alan Stern writes:
> 
> > I think this is subject to the same weakness Dmitry mentions: By the
> > time the driver would block on the new rwsem, it has already started
> > mucking with the device.  Worse yet, it may hold a mutex that the 
> > suspend method needs, thereby deadlocking the suspend.  (That's what 
> > would happen with serio->drv_mutex in the input layer.)
> > 
> > Maybe the best answer is simply to fail all attempts at device
> > registration while a suspend is underway.  At least that is a known
> > error path which drivers are prepared (in theory) to deal with.  It
> > could be implemented quite easily with an rwsem, by making the
> > registration code use down_read_trylock.
> 
> What about making a list of devices that drivers have attempted to
> register?  While the system is suspending, if a driver attempts to
> register a device, put it on a list and return success.  Then, after
> resuming, run through the list and actually process them.

I'm not sure it's safe to lie to drivers, telling them that their 
device has been registered when in fact it hasn't.  For instance, what 
if the driver then calls device_create_file()?  Safe or not, it 
certainly isn't transparent and therefore isn't a good thing to do.

Of course, the problem with my approach is that it puts the burden on
drivers of blocking threads which want to register devices.  This turns
out to be distressingly difficult -- easier just to let them fail.  I
was hoping to find a centralized solution but apparently there isn't
one.

A better approach would be to fail registrations only if the parent is
already suspended.  Maybe that can be made to work... but I'm doubtful.  
(What if the parent gets suspended _during_ the child's registration?)

> I guess removal during suspend/resume should remove the list entry, if
> the device is one of the ones on the list.  Otherwise, is there a
> problem with letting removals proceed during suspend/resume?  (In
> general removal can be notified after the device has physically
> disappeared IIRC, so driver unbind functions have to avoid touching
> the device or at least be prepared to deal with it not responding.)

I don't think removal during suspend poses a serious problem.  It can
never lead to a situation where a suspended parent has an unsuspended
child, which is what we need to avoid.

Alan Stern
