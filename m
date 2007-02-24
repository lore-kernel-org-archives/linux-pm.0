From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: SMP suspend broken due to "swsusp: Change code
	ordering in	disk.c" et al.
Date: Sat, 24 Feb 2007 01:31:20 +0100
Message-ID: <1172277080.3870.108.camel@johannes.berg>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702231425.38217.rjw@sisk.pl>
	<1172262219.3870.63.camel@johannes.berg>
	<200702240101.12846.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0796339805=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702240101.12846.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Dave Vasilevsky <djvasi@gmail.com>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0796339805==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DhyUXA1A4k57KCO+h4iR"


--=-DhyUXA1A4k57KCO+h4iR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Could you please try the appended patch?  It's somewhat hackish, but may =
work.

Not before Monday or Tuesday unfortunately, I'm away from the machine.
Maybe I can find someone else willing to test who has the same box.

> The idea is to do nothing on CPU unplug if the CPU's worker thread is fro=
zen
> and later check in the thread itself if it has been replaced by another o=
ne.

Yeah that should work. That patch won't apply to my tree though unless I
actually go to -mm2 as well :)

> Greetings,
> Rafael
>=20
>=20
>  kernel/workqueue.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> Index: linux-2.6.20-mm2/kernel/workqueue.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.20-mm2.orig/kernel/workqueue.c	2007-02-23 22:48:50.00000000=
0 +0100
> +++ linux-2.6.20-mm2/kernel/workqueue.c	2007-02-24 00:58:57.000000000 +01=
00
> @@ -316,7 +316,13 @@ static int worker_thread(void *__cwq)
>  	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
> =20
>  	for (;;) {
> -		try_to_freeze();
> +		if (try_to_freeze()) {
> +			/* We've just exited the refrigerator.  If our CPU is
> +			 * a nonboot one, we might have been replaced.
> +			 */
> +			if (cwq->thread !=3D current)
> +				break;
> +		}
> =20
>  		prepare_to_wait(&cwq->more_work, &wait, TASK_INTERRUPTIBLE);
>  		if (!cwq->should_stop && list_empty(&cwq->worklist))
> @@ -713,7 +719,7 @@ static void cleanup_workqueue_thread(str
>  	int alive =3D 0;
> =20
>  	spin_lock_irq(&cwq->lock);
> -	if (cwq->thread !=3D NULL) {
> +	if (cwq->thread !=3D NULL && !frozen(cwq->thread)) {
>  		insert_wq_barrier(cwq, &barr, 1);
>  		cwq->should_stop =3D 1;
>  		alive =3D 1;
>=20

--=-DhyUXA1A4k57KCO+h4iR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF34dY/ETPhpq3jKURAk3DAJ0bJpxDLfdIkgQLBxclI0fvfVHXhgCglaAs
YAG5UXT3gwHa1OGuYmt2BrE=
=cw43
-----END PGP SIGNATURE-----

--=-DhyUXA1A4k57KCO+h4iR--


--===============0796339805==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0796339805==--
