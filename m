From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] remove software_suspend() and fix compile w/
	SOFTWARE_SUSPEND disabled
Date: Sun, 25 Mar 2007 16:34:17 +0000
Message-ID: <20070325163417.GB9958@ucw.cz>
References: <1174571192.32051.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174571192.32051.5.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch kills off software_suspend() and all it's users,
> pm_suspend(PM_SUSPEND_DISK) is much cleaner anyway. Also, this
> makes the kernel compile again w/o CONFIG_SOFTWARE_SUSPEND after
> Rafael's patches to kill the suspend pageflags broke it.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>


>  	return error;
>  }
>  =

> -/*
> - * This is main interface to the outside world. It needs to be
> - * called from process context.
> - */
> -int software_suspend(void)
> -{
> -	return enter_state(PM_SUSPEND_DISK);
> -}
> -
> -
...
> @@ -60,7 +60,7 @@ acpi_system_write_sleep(struct file *fil
>  	state =3D simple_strtoul(str, NULL, 0);
>  #ifdef CONFIG_SOFTWARE_SUSPEND
>  	if (state =3D=3D 4) {
> -		error =3D software_suspend();
> +		error =3D pm_suspend(PM_SUSPEND_DISK);
>  		goto Done;
>  	}

Is enter_state and pm_suspend equivalent? Why the change?

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
