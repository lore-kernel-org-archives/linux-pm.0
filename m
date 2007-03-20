From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] add firmware disk state and clean up
Date: Tue, 20 Mar 2007 11:25:51 +0100
Message-ID: <20070320102551.GB19283@elf.ucw.cz>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174385865.3770.20.camel@johannes.berg>
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
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, Dirk Behme <dirk.behme@de.bosch.com>, linux-pm@lists.osdl.org, Nicolas Pitre <nico@cam.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch adds a new state PM_SUSPEND_FIRMWAREDISK state and cleans up
> all pm_ops users to include a .valid callback which in most cases allows
> only mem suspend since except ACPI they all don't differentiate between
> standby/mem which are currently allowed.

> This new state has no users yet but I think APM could be converted

The person doing the conversion should add the state,
sorry... ... actually it makes sense, but I'd prefer not to have it,
yet.

> --- linux-2.6.orig/arch/arm/common/sharpsl_pm.c	2007-03-20 10:51:02.05321=
4909 +0100
> +++ linux-2.6/arch/arm/common/sharpsl_pm.c	2007-03-20 10:51:58.963214909 =
+0100
> @@ -765,10 +765,16 @@ static void sharpsl_apm_get_power_status
>  	info->battery_life =3D sharpsl_pm.battstat.mainbat_percent;
>  }
>  =

> +static int pxa_pm_valid(suspend_state_t state)
> +{
> +	return state =3D=3D PM_SUSPEND_MEM;
> +}

create static inline pm_valid_only_mem() somewhere in header, then
share it around the code?

> --- linux-2.6.orig/kernel/power/main.c	2007-03-20 11:13:31.173214909 +0100
> +++ linux-2.6/kernel/power/main.c	2007-03-20 11:15:30.153214909 +0100
> @@ -157,11 +157,14 @@ static void suspend_finish(suspend_state
>  =

>  =

>  static const char * const pm_states[PM_SUSPEND_MAX] =3D {
> -	[PM_SUSPEND_STANDBY]	=3D "standby",
> -	[PM_SUSPEND_MEM]	=3D "mem",
> +	"standby",
> +	"mem",
>  #ifdef CONFIG_SOFTWARE_SUSPEND
> -	[PM_SUSPEND_DISK]	=3D "disk",
> +	"disk",
> +#else
> +	NULL,
>  #endif
> +	"firmware-disk",
>  };

I'd keep the c99 syntax here. (And we do not need firmware-disk just
yet).
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
