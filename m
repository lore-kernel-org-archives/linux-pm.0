From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC] swsusp for OSK
Date: Tue, 12 Jul 2005 11:17:51 +0200
Message-ID: <20050712091750.GJ1854@elf.ucw.cz>
References: <20050707.111613.107948201.kaminaga@sm.sony.co.jp>
	<20050709190837.GA1385@elf.ucw.cz>
	<20050712.173208.41653102.kaminaga@sm.sony.co.jp>
	<20050712.180441.104053811.kaminaga@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20050712.180441.104053811.kaminaga@sm.sony.co.jp>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On =DAt 12-07-05 18:04:41, Hiroki Kaminaga wrote:
> > > Perhaps I have to turn off MMU while copying pagedir_nosave, and tu=
rn
> > > on later?
> >=20
> > If it is easy for you... that should solve it.
>=20
> In kernel/power/swsusp.c, comment says
> ...
>    Warning: this is even more evil than it seems. Pagedirs this file
>    talks about are completely different from page directories used by
>    MMU hardware.
> ...
>=20
> If it is so, then turning MMU off doesn't sound like solving the
> problem... true?

No, I think turning MMU off will help you. This is just talking about
*different* problem.
								Pavel
--=20
teflon -- maybe it is a trademark, but it should not be.
