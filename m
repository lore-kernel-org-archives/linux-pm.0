From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 11:25:07 -0800
Message-ID: <54EA2D13.3070709@gmail.com>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com> <20150222082654.GB24441@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:32874 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbBVTZK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 14:25:10 -0500
In-Reply-To: <20150222082654.GB24441@norris-Latitude-E6410>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Cernekee <cernekee@gmail.com>, Chirantan Ekbote <chirantan@chromium.org>

Le 22/02/2015 00:26, Brian Norris a =E9crit :
> When CONFIG_PM_DEBUG=3Dy, we provide a sysfs file (/sys/power/pm_test=
) for
> selecting one of a few suspend test modes, where rather than entering=
 a
> full suspend state, the kernel will perform some subset of suspend
> steps, wait 5 seconds, and then resume back to normal operation.
>=20
> This mode is useful for (among other things) observing the state of t=
he
> system just before entering a sleep mode, for debugging or analysis
> purposes. However, a constant 5 second wait is not sufficient for som=
e
> sorts of analysis; for example, on an SoC, one might want to use
> external tools to probe the power states of various on-chip controlle=
rs
> or clocks.
>=20
> This patch turns this 5 second delay into a configurable module
> parameter, so users can determine how long to wait in this
> pseudo-suspend state before resuming the system.
>=20
> Example (wait 30 seconds);
>=20
>   # echo 30 > /sys/module/suspend/parameters/pm_test_delay
>   # echo core > /sys/power/pm_test
>   # time echo mem  > /sys/power/state
>   ...
>   [   17.583625] suspend debug: Waiting for 30 second(s).
>   ...
>   real	0m30.381s
>   user	0m0.017s
>   sys	0m0.080s
>=20
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
> v2: - make this a module param instead of an explicit sysfs file
>     - drop the for loop; mdelay() does the same loop internally
>     - decrease +36 lines of code and +2 lines of doc, to +6 lines of =
code and
>       +2 lines of doc
>=20
>  kernel/power/suspend.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c347e3ce3a55..aee23dab0a55 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -28,6 +28,7 @@
>  #include <linux/ftrace.h>
>  #include <trace/events/power.h>
>  #include <linux/compiler.h>
> +#include <linux/moduleparam.h>
> =20
>  #include "power.h"
> =20
> @@ -204,12 +205,20 @@ static bool platform_suspend_again(suspend_stat=
e_t state)
>  		suspend_ops->suspend_again() : false;
>  }
> =20
> +#ifdef CONFIG_PM_DEBUG
> +static unsigned int pm_test_delay =3D 5;
> +module_param(pm_test_delay, uint, 0644);
> +MODULE_PARM_DESC(pm_test_delay,
> +		 "Number of seconds to wait before resuming from suspend test");
> +#endif
> +
>  static int suspend_test(int level)
>  {
>  #ifdef CONFIG_PM_DEBUG
>  	if (pm_test_level =3D=3D level) {
> -		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
> -		mdelay(5000);
> +		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
> +				pm_test_delay);
> +		mdelay(pm_test_delay * 1000);
>  		return 1;
>  	}
>  #endif /* !CONFIG_PM_DEBUG */
>=20
