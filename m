From: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 22:24:57 +1000
Message-ID: <200602012225.01695.nigel@suspend2.net>
References: <200602010141.53974.rjw@sisk.pl> <20060201114717.GA1768@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34291494601921113=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060201114717.GA1768@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============34291494601921113==
Content-Type: multipart/signed; boundary="nextPart1931601.ndYnoNJB0l";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1931601.ndYnoNJB0l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 01 February 2006 21:47, Pavel Machek wrote:
> Hi!
>
> > This is an experimantal patch aimed at the "unable to freeze processes
> > under load" problem.
> >
> > On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> > "dd if=3D/dev/hda of=3D/dev/null" test.
> >
> > Please have a look.
>
> It makes it better (well, I used my own, simpler variant, but that
> should not matter; patch is attached). I now can't reproduce hangs
> with simple stress testing, but running kernel make alongside that
> makes it hang sometimes. Example of non-frozen gcc:
>
> gcc           D EEE06A70     0  1750   1749  1751
> (NOTLB)
> df85df38 00000046 bf878130 eee06a70 00004111 eee06a70 eee06a70
> 003d0900
>        00000000 c0137cf5 df85c000 00000000 c058ada2 c012503e ef2c915c
> ef2c9030
>        c1c0b480 7c3b8500 003d0927 df85c000 00000a98 7c3b8500 003d0927
> c0770800
> Call Trace:
>  [<c0137cf5>] attach_pid+0x25/0xb0
>  [<c058ada2>] _write_unlock_irq+0x12/0x30
>  [<c012503e>] copy_process+0xe5e/0x11b0
>  [<c0588f74>] wait_for_completion+0x94/0xd0
>  [<c0121690>] default_wake_function+0x0/0x10
>  [<c01254d9>] do_fork+0x149/0x210
>  [<c0101218>] sys_vfork+0x28/0x30
>  [<c0103231>] syscall_call+0x7/0xb
>
> ...maybe solving this would solve journalling problems, too? It is
> similar AFAICT.

What exactly is the journalling problem?

>
> diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> index e24446f..90d6c1a 100644
> --- a/kernel/power/disk.c
> +++ b/kernel/power/disk.c
> @@ -87,7 +87,6 @@ static int prepare_processes(void)
>  	int error;
>
>  	pm_prepare_console();
> -	sys_sync();
>  	disable_nonboot_cpus();
>
>  	if (freeze_processes()) {

That will help speed up freezing, but it won't help the integrity of your d=
ata=20
if you don't resume.

> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 02a1b3a..bd16e44 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -16,7 +16,7 @@
>  /*
>   * Timeout for stopping processes
>   */
> -#define TIMEOUT	(6 * HZ)
> +#define TIMEOUT	(60 * HZ)

You're kidding, right?

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1931601.ndYnoNJB0l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4KidN0y+n1M3mo0RAm74AJ9vzzzdfH8m86pqd6PWO1KrCQ2/PwCg3iyr
gWKeZxaYycFyWcIoITIXi7A=
=wCCe
-----END PGP SIGNATURE-----

--nextPart1931601.ndYnoNJB0l--

--===============34291494601921113==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34291494601921113==--
