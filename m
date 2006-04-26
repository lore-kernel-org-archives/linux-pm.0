From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 11:07:49 +0200
Message-ID: <20060426090747.GC6676@elf.ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<200604251404.30228.david-b@pacbell.net>
	<20060425214119.GA6542@elf.ucw.cz>
	<200604251613.42388.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200604251613.42388.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On =DAt 25-04-06 16:13:41, David Brownell wrote:
> On Tuesday 25 April 2006 2:41 pm, Pavel Machek wrote:
>=20
> > > Well, if we had a pm_should_I_spin_down_drives() it would make sens=
e to me
> > > that it return FALSE during kernel_restart_prepare() too ... surely=
 kexec
> > > users have the same issues!
> >=20
> > pm_should_I_spin_down_drives() is incredibly ugly hack, sorry.
>=20
> The name was chosen to be ugly.  I'd expect someone to make it prettier=
;
> maybe draw ponies around the name or somesuch.  ;)

:-).

> However, by the way your pm_message_t changes removed all information a=
bout
> system states, you've forced that family of approach in every driver th=
at needs
> to know about such states in order to behave correctly.  For example, "=
don't
> turn off clock X in PM_STANDBY" ... since no driver has a standard way =
to know
> about PM_STANDBY, it needs some function accessing state set up by pm_o=
ps.prepare
> or else it's not going to be able to behave right.

Or you can simply adds flags field to pm_message_t.

> You still haven't come up with a response to my point that starting up =
a
> new kernel via swsusp snapshot resume is a system restart in exactly
> the

After kexec, you hit device-init path, while after swsusp resume, you
hit... well resume(). That's quite different.

> same way as it is for kexec() ... at this point, there is no better fix
> for the problem than my original patch, AND you haven't actually identi=
fied
> a single real problem with it.

You identified that problem yourselves: it will break drivers.

Add flags field and be done with it... please?
								Pavel
--=20
Thanks for all the (sleeping) penguins.
