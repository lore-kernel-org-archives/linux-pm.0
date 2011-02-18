From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PM: Make system-wide PM and runtime PM treat
 subsystems consistently
Date: Fri, 18 Feb 2011 11:22:41 -0800
Message-ID: <20110218192241.GA6172__3611.34433555907$1298057111$gmane$org@kroah.com>
References: <201102170045.48975.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1102170951330.2153-100000@iolanthe.rowland.org>
	<20110217170441.GA31809@kroah.com>
	<201102180054.25603.rwys@fuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102180054.25603.rwys@fuw.edu.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 18, 2011 at 12:54:25AM +0100, R. J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The code handling system-wide power transitions (eg. suspend-to-RAM)
> can in theory execute callbacks provided by the device's bus type,
> device type and class in each phase of the power transition.  In
> turn, the runtime PM core code only calls one of those callbacks at
> a time, preferring bus type callbacks to device type or class
> callbacks and device type callbacks to class callbacks.
> 
> It seems reasonable to make them both behave in the same way in that
> respect.  Moreover, even though a device may belong to two subsystems
> (eg. bus type and device class) simultaneously, in practice power
> management callbacks for system-wide power transitions are always
> provided by only one of them (ie. if the bus type callbacks are
> defined, the device class ones are not and vice versa).  Thus it is
> possible to modify the code handling system-wide power transitions
> so that it follows the core runtime PM code (ie. treats the
> subsystem callbacks as mutually exclusive).
> 
> On the other hand, the core runtime PM code will choose to execute,
> for example, a runtime suspend callback provided by the device type
> even if the bus type's struct dev_pm_ops object exists, but the
> runtime_suspend pointer in it happens to be NULL.  This is confusing,
> because it may lead to the execution of callbacks from different
> subsystems during different operations (eg. the bus type suspend
> callback may be executed during runtime suspend of the device, while
> the device type callback will be executed during system suspend).
> 
> Make all of the power management code treat subsystem callbacks in
> a consistent way, such that:
> (1) If the device's type is defined (eg. dev->type is not NULL)
>     and its pm pointer is not NULL, the callbacks from dev->type->pm
>     will be used.
> (2) If dev->type is NULL or dev->type->pm is NULL, but the device's
>     class is defined (eg. dev->class is not NULL) and its pm pointer
>     is not NULL, the callbacks from dev->class->pm will be used.
> (3) If dev->type is NULL or dev->type->pm is NULL and dev->class is
>     NULL or dev->class->pm is NULL, the callbacks from dev->bus->pm
>     will be used provided that both dev->bus and dev->bus->pm are
>     not NULL.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Kevin Hilman <khilman@ti.com>
> Reasoning-sounds-sane-to: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

You are going to take this through your tree, right?

thanks,

greg k-h
