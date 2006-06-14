From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 08:21:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614103404.GC28536@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 14 Jun 2006, Pavel Machek wrote:
> =

> Okay, but we probably do not want to be in SYSTEM_BOOTING state,
> right?
> =

> > -	orig_kmsg =3D kmsg_redirect;
> > -	kmsg_redirect =3D SUSPEND_CONSOLE;
> > +	console_suspended =3D 1;
> > +	system_state =3D SYSTEM_BOOTING;
> >  	return 0;
> >  }
> >  =

> >  void pm_restore_console(void)
> >  {
> > -	acquire_console_sem();
> > -	set_console(orig_fgconsole);
> > +	console_suspended =3D 0;
> > +	system_state =3D SYSTEM_BOOTING;
> =

> And we definitely want to go back to SYSTEM_RUNNING or how is it
> called here.

Right. A bit too much cut-and-paste ;)

		Linus
