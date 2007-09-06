From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm 2/5] Hibernation: Rework platform support
	ioctls
Date: Thu, 6 Sep 2007 01:57:29 +0000
Message-ID: <20070906015729.GB5097@ucw.cz>
References: <200709022315.59652.rjw@sisk.pl> <200709022319.38762.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709022319.38762.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!
> Modify the hibernation userland interface by adding two new ioctls to it,
> SNAPSHOT_PLATFORM_SUPPORT and SNAPSHOT_POWER_OFF, that can be used,
> respectively, to switch the hibernation platform support on/off and to make the
> kernel transition the system to the hibernation state (eg. ACPI S4) using the
> platform (eg. ACPI) driver.
> 
> These ioctls are intended to replace the misdesigned SNAPSHOT_PMOPS ioctl,
> which from now is regarded as obsolete and will be removed in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> +/*
> + * NOTE: The SNAPSHOT_PMOPS ioctl is obsolete and will be removed in the
> + * future.  It is only preserved here for compatibility with existing userland
> + * utilities.
> + */

Perhaps that paragraph from Documentation should be moved here, so
that people know what this obsolete ioctl() is expected to do?

> @@ -95,24 +101,6 @@ SNAPSHOT_S2RAM - suspend to RAM; using t
>  	to resume the system from RAM if there's enough battery power or restore
>  	its state on the basis of the saved suspend image otherwise)
>  
> -SNAPSHOT_PMOPS - enable the usage of the hibernation_ops->prepare,
> -	hibernate_ops->enter and hibernation_ops->finish methods (the in-kernel
> -	swsusp knows these as the "platform method") which are needed on many
> -	machines to (among others) speed up the resume by letting the BIOS skip
> -	some steps or to let the system recognise the correct state of the
> -	hardware after the resume (in particular on many machines this ensures
> -	that unplugged AC adapters get correctly detected and that kacpid does
> -	not run wild after the resume).  The last ioctl() argument can take one
> -	of the three values, defined in kernel/power/power.h:
> -	PMOPS_PREPARE - make the kernel carry out the
> -		hibernation_ops->prepare() operation
> -	PMOPS_ENTER - make the kernel power off the system by calling
> -		hibernation_ops->enter()
> -	PMOPS_FINISH - make the kernel carry out the
> -		hibernation_ops->finish() operation
> -	Note that the actual constants are misnamed because they surface
> -	internal kernel implementation details that have changed.
> -
>  The device's read() operation can be used to transfer the snapshot image from
>  the kernel.  It has the following limitations:
>  - you cannot read() more than one virtual memory page at a time

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
