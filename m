From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Suspend without the freezer
Date: Tue, 31 Jul 2007 11:24:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707311112590.3520-100000@iolanthe.rowland.org>
References: <200707311105.40449.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707311105.40449.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007, Rafael J. Wysocki wrote:

> > > One thought was to have the PM core acquire and hold the dpm_list_mutex 
> > > throughout the suspend.  This would block registration attempts at the 
> > > point where the new device is added to the PM core's device-list.
> > >
> > 
> > I think blocking at this point is too late - many drivers muck with
> > the device in different ways before registering the "result" with
> > driver core. The device may be half-awaken by then.

> An alternative could be to have a rwsem taken for writing by the PM core and
> for reading by registration/binding/unbinding (and other suspend-sensitive code
> paths).

I think this is subject to the same weakness Dmitry mentions: By the
time the driver would block on the new rwsem, it has already started
mucking with the device.  Worse yet, it may hold a mutex that the 
suspend method needs, thereby deadlocking the suspend.  (That's what 
would happen with serio->drv_mutex in the input layer.)

Maybe the best answer is simply to fail all attempts at device
registration while a suspend is underway.  At least that is a known
error path which drivers are prepared (in theory) to deal with.  It
could be implemented quite easily with an rwsem, by making the
registration code use down_read_trylock.

Binding and unbinding aren't an issue once the PM core owns all the
device semaphores.

Alan Stern
