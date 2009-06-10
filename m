From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
 Rearrange core suspend code)
Date: Wed, 10 Jun 2009 16:48:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906101636180.2589-100000__236.64163095436$1244666951$gmane$org@iolanthe.rowland.org>
References: <200906100057.04473.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906100057.04473.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Jun 2009, Rafael J. Wysocki wrote:

> > By the way, a legitimate reason for aborting an autosuspend is if the
> > device's driver requires remote wakeup to be enabled during suspend but
> > the user has disabled it.
> 
> Do you mean the user has disabled the remote wakeup?

Yes, by writing to the power/wakeup attribute.


> > > > There should be a sysfs interface (like the one in USB) to allow
> > > > userspace to prevent a device from being autosuspended -- and perhaps
> > > > also to force it to be suspended.
> > > 
> > > To prevent a device from being suspended - yes.  To force it to stay suspended
> > > - I'm not sure.
> > 
> > I'm not sure either.  Oliver Neukum requested it originally and it has
> > been useful for debugging, but I haven't seen many places where it
> > would come in useful in practice.

I did think of one use for this feature.  It's unique to USB,
however...

In Windows, you're not supposed to unplug a hot-unpluggable device
without first telling the OS -- there's a "Safely Remove Hardware"  
applet.  When you tell the applet you want to remove a USB device, the
system disables the device's port and then says it's okay to unplug the
device.  Now Linux doesn't have any user API for disabling USB ports,
but suspending a port has the same effect (the device can't distinguish
a disable from a suspend).

It turns out that some devices (MP3 players, for instance) have
incorporated this into their design.  They display a "Safe to unplug"  
message when their port is disabled or suspended.  People like to see
this message -- it makes them feel good about unplugging the device --
and the only way to get it under Linux is by forcing the device to be
suspended.  :-)

> The problem with it is that the user space may not know if it is safe to keep
> a device suspended and if it is not, the kernel will have to ignore the setting
> anyway, so I'm not sure what's the point (except for debugging).

This falls into the category of "The user knows better".  If the user
specifically tells the kernel to suspend a device (rather than just
letting it autosuspend), and this causes a problem, then it's the
user's own fault.

After all, who's really the master?  Us or the kernel?

Alan Stern
