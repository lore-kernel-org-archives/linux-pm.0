From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Add sysfs switch for
 disabling device run-time PM (rev. 2)
Date: Thu, 21 Jan 2010 22:02:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001212157500.29627-100000__18928.631328936$1264129412$gmane$org@netrider.rowland.org>
References: <201001212359.38886.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001212359.38886.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Jan 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add new device sysfs attribute, power/control, allowing the user
> space to block the run-time power management of devices.  If this
> attribute is set to "on", the driver of the device won't be able to power
> manage it at run time (without breaking the rules) and the device will
> always be in the full power state (except when the entire system goes
> into a sleep state).

...

> --- linux-2.6.orig/drivers/base/power/power.h
> +++ linux-2.6/drivers/base/power/power.h
> @@ -2,11 +2,15 @@
>  
>  extern void pm_runtime_init(struct device *dev);
>  extern void pm_runtime_remove(struct device *dev);
> +extern void pm_runtime_allow(struct device *dev);
> +extern void pm_runtime_forbid(struct device *dev);

Can you write a follow-up patch that moves these declarations to a
public header file like include/linux/pm_runtime.h and EXPORTs the two
new routines?  It is sometimes useful for drivers to be able to call
the routines directly.

For example, we disable runtime PM for most USB devices by default.  
But a few drivers may know that their devices are able to handle it, so 
they want to change the default setting when they are bound.

Alan Stern
