From: Alan Stern <stern@rowland.harvard.edu>
Subject: Towards eliminating the freezer
Date: Mon, 23 Jul 2007 16:05:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707231124590.3545-100000__43855.3498279818$1185221253$gmane$org@iolanthe.rowland.org>
References: <200707231623.17958.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707231623.17958.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Note changed $SUBJECT]

On Mon, 23 Jul 2007, Oliver Neukum wrote:

> > > > You are correct about the need to delay/stop device addition.  I don't
> > > > know how this can be done in general; each code path calling
> > > > device_add() may have to be treated individually.
> > > 
> > > What about the old API?
> > 
> > What old API do you mean?
> 
> The find_device() stuff.

You mean like bus_find_device() or driver_find_device()?  I don't see 
any problem with them.  They aren't involved in device registration or 
locking.

> > >  Do we have to block module loading?
> > 
> > No.  Registering new drivers is okay, registering new devices is bad.
> 
> What if it is a driver for virtual devices that don't need probe()
> for actual hardware?

Like I said, registering the new driver is okay.  Registering the 
virtual devices could cause a problem.

> > Of course, some modules do want to register a new device in their init 
> > method.  I don't know what we should do about them.  Force the 
> > registration to fail, I suppose.  How often will people suspend while a 
> > module is loading?
> > 
> > > What happens if a scsi error handler is woken? If it cannot be woken,
> > > how are errors handled?
> > 
> > Why should the error handler wake up?  There isn't supposed to be any 
> > I/O going on, hence no errors to handle.
> 
> What about shared busses? Firewire, FibreChannel? They can get external
> resets, etc ...

The same reasoning applies: If no I/O is going on, why should there be
a reset?  If a reset or any other event is generated externally then it
is handled in the kernel by some device driver for the bus, which
should be smart enough not to register new devices or start up an error
handler until I/O is once again permitted.


=============================


Now here's an idea which might work.  Can we require every caller of
device_add() to hold some existing device's semaphore?  Normally it
would be the semaphore of the new device's parent, but it could be a
higher ancestor.  There even could be a single "root" semaphore for
drivers registering a top-level device with no parent.

(Some testing shows that during startup things like ACPI and IDE don't 
fulfill this requirement, so maybe we should require it only after 
userspace has begun running.  After all, the system can't suspend 
until then.)

It seems like a reasonable sort of thing to do.  Hotplugged devices
tend to be registered as they are discovered by their parent's driver,
so it shouldn't be too much to ask that the parent's semaphore be held
when the new device is registered.  Static devices generally aren't
quite so nice; the serial and floppy drivers in particular would need a
little work (and probably some other drivers too).

If we do this, then once the PM core has acquired the semaphore for 
every device it will be guaranteed that no new devices can be added.  
It would be a simple solution to a rather nasty problem.

Alan Stern
