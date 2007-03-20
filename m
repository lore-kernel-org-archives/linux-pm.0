From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] rework pm_ops pm_disk_modes foo
Date: Tue, 20 Mar 2007 10:31:05 +0100
Message-ID: <20070320093105.GD3922@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070320084744.984025000@sipsolutions.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Cliff Brake <cbrake@accelent.com>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>, Ben Dooks <ben@simtec.co.uk>, Patrick Mochel <mochelp@infinity.powertie.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> --- linux-2.6.orig/include/linux/pm.h	2007-03-20 02:18:54.830252495 +0100
> +++ linux-2.6/include/linux/pm.h	2007-03-20 09:45:16.760886698 +0100
> @@ -112,6 +112,8 @@ typedef int __bitwise suspend_state_t;
>  =

>  typedef int __bitwise suspend_disk_method_t;
>  =

> +/* invalid must be 0 so struct pm_ops initialisers can leave it out */
> +#define PM_DISK_INVALID		((__force suspend_disk_method_t) 0)
>  #define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
>  #define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
>  #define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
> @@ -137,17 +139,18 @@ typedef int __bitwise suspend_disk_metho
>   * @finish: Called when the system has left the given state and all devi=
ces
>   *	are resumed. The return value is ignored.
>   *
> - * @pm_disk_mode: Set to the disk method that the user should be able to
> - *	configure for suspend-to-disk. Since %PM_DISK_SHUTDOWN,
> - *	%PM_DISK_REBOOT, %PM_DISK_TEST and %PM_DISK_TESTPROC
> - *	are always allowed, currently only %PM_DISK_PLATFORM
> - *	makes sense. If the user then choses %PM_DISK_PLATFORM,
> - *	the @prepare call will be called before suspending to disk
> - *	(if present), the @enter call should be present and will
> - *	be called after all state has been saved and the machine
> - *	is ready to be shut down/suspended/..., and the @finish
> - *	callback is called after state has been restored. All
> - *	these calls are called with %PM_SUSPEND_DISK as the state.
> + * @pm_disk_mode: The generic code always allows one of the shutdown met=
hods
> + *	%PM_DISK_SHUTDOWN, %PM_DISK_REBOOT, %PM_DISK_TEST and
> + *	%PM_DISK_TESTPROC. If this variable is set, the mode it is set
> + *	to is allowed in addition to those modes and is also made default.
> + *	When this mode is sent selected, the @prepare call will be called
> + *	before suspending to disk (if present), the @enter call should be
> + *	present and will be called after all state has been saved and the
> + *	machine is ready to be powered off; the @finish callback is called
> + *	after state has been restored. All these calls are called with
> + *	%PM_SUSPEND_DISK as the state.

Is the pm_disk_mode still bitmask? If yes, say so.

...no, it does not appear so.

> --- linux-2.6.orig/kernel/power/main.c	2007-03-20 02:18:54.850252495 +0100
> +++ linux-2.6/kernel/power/main.c	2007-03-20 09:44:44.610886698 +0100
> @@ -30,7 +30,7 @@
>  DEFINE_MUTEX(pm_mutex);
>  =

>  struct pm_ops *pm_ops;
> -suspend_disk_method_t pm_disk_mode =3D PM_DISK_PLATFORM;
> +suspend_disk_method_t pm_disk_mode =3D PM_DISK_SHUTDOWN;

Please don't do this. We want to keep the "use platform if available"
behaviour. [Changing platform->shutdown is really _big_ change,
independend from any cleanups, and it needs to go separate at the very
least. It will break some machines.]

										Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
