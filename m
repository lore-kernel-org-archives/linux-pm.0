From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 12:34:04 +0200
Message-ID: <20060614103404.GC28536@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The old code was terminally broken, and would do extremely bad things if =

> you used netconsole, for example. Like sending out packets when the devic=
e =

> had already been suspended etc.
> =

> The new version may not be perfect either, but it seems fundamentally lik=
e =

> a better design: we just hold on to the primary console semaphore over th=
e =

> whole suspend event, forcing printk() to just buffer up its data until we =

> can show it again. The code is also much simpler and more obvious.

Okay, but we probably do not want to be in SYSTEM_BOOTING state,
right?

> -	orig_kmsg =3D kmsg_redirect;
> -	kmsg_redirect =3D SUSPEND_CONSOLE;
> +	console_suspended =3D 1;
> +	system_state =3D SYSTEM_BOOTING;
>  	return 0;
>  }
>  =

>  void pm_restore_console(void)
>  {
> -	acquire_console_sem();
> -	set_console(orig_fgconsole);
> +	console_suspended =3D 0;
> +	system_state =3D SYSTEM_BOOTING;

And we definitely want to go back to SYSTEM_RUNNING or how is it
called here.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
