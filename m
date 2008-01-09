From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.24-rc7] remove obsolete
	/sys/devices/.../power/state docs
Date: Wed, 9 Jan 2008 22:55:09 +0100
Message-ID: <200801092255.09841.rjw__13039.5669992597$1199915752$gmane$org@sisk.pl>
References: <200801091212.24386.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801091212.24386.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 9 of January 2008, David Brownell wrote:
> The /sys/devices/.../power/state files have been gone for a while
> now, but I just noticed some documentation that still refers to
> them.  (Fortunately described as DEPRECATED and WILL REMOVE).
> 
> Time to remove that obsolete documentation too ...
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  Documentation/power/devices.txt |   49 ----------------------------------------
>  1 file changed, 49 deletions(-)
> 
> --- g26.orig/Documentation/power/devices.txt	2008-01-09 12:05:51.000000000 -0800
> +++ g26/Documentation/power/devices.txt	2008-01-09 12:06:33.000000000 -0800
> @@ -502,52 +502,3 @@ If the CPU can have a "cpufreq" driver, 
>  to shift to lower voltage settings and reduce the power cost of executing
>  a given number of instructions.  (Without voltage adjustment, it's rare
>  for cpufreq to save much power; the cost-per-instruction must go down.)
> -
> -
> -/sys/devices/.../power/state files
> -==================================
> -For now you can also test some of this functionality using sysfs.
> -
> -	DEPRECATED:  USE "power/state" ONLY FOR DRIVER TESTING, AND
> -	AVOID USING dev->power.power_state IN DRIVERS.
> -
> -	THESE WILL BE REMOVED.  IF THE "power/state" FILE GETS REPLACED,
> -	IT WILL BECOME SOMETHING COUPLED TO THE BUS OR DRIVER.
> -
> -In each device's directory, there is a 'power' directory, which contains
> -at least a 'state' file.  The value of this field is effectively boolean,
> -PM_EVENT_ON or PM_EVENT_SUSPEND.
> -
> -   *	Reading from this file displays a value corresponding to
> -	the power.power_state.event field.  All nonzero values are
> -	displayed as "2", corresponding to a low power state; zero
> -	is displayed as "0", corresponding to normal operation.
> -
> -   *	Writing to this file initiates a transition using the
> -   	specified event code number; only '0', '2', and '3' are
> -	accepted (without a newline); '2' and '3' are both
> -	mapped to PM_EVENT_SUSPEND.
> -
> -On writes, the PM core relies on that recorded event code and the device/bus
> -capabilities to determine whether it uses a partial suspend() or resume()
> -sequence to change things so that the recorded event corresponds to the
> -numeric parameter.
> -
> -   -	If the bus requires the irqs-disabled suspend_late()/resume_early()
> -	phases, writes fail because those operations are not supported here.
> -
> -   -	If the recorded value is the expected value, nothing is done.
> -
> -   -	If the recorded value is nonzero, the device is partially resumed,
> -	using the bus.resume() and/or class.resume() methods.
> -
> -   -	If the target value is nonzero, the device is partially suspended,
> -	using the class.suspend() and/or bus.suspend() methods and the
> -	PM_EVENT_SUSPEND message.
> -
> -Drivers have no way to tell whether their suspend() and resume() calls
> -have come through the sysfs power/state file or as part of entering a
> -system sleep state, except that when accessed through sysfs the normal
> -parent/child sequencing rules are ignored.  Drivers (such as bus, bridge,
> -or hub drivers) which expose child devices may need to enforce those rules
> -on their own.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
