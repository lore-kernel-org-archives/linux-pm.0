From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Date: Mon, 12 Nov 2018 10:51:21 +0100
Message-ID: <20181112095121.GA5695@amd>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Oleg Nesterov <oleg@redhat.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>, Inkyu Hwang <inkyu.hwang@lge.com>, Donghwan Jung <donghwan.jung@lge.com>, Jongsung Kim <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-11-12 12:54:45, Chanho Min wrote:
> Suspend fails due to the exec family of functions blocking the freezer.
> The casue is that de_thread() sleeps in TASK_UNINTERRUPTIBLE waiting for
> all sub-threads to die, and we have the deadlock if one of them is frozen.
> This also can occur with the schedule() waiting for the group thread lead=
er
> to exit if it is frozen.
>=20
> In our machine, it causes freeze timeout as bellows.
>=20
> Freezing of tasks failed after 20.010 seconds (1 tasks refusing to freeze=
, wq_busy=3D0):
> setcpushares-ls D ffffffc00008ed70     0  5817   1483 0x0040000d
>  Call trace:
> [<ffffffc00008ed70>] __switch_to+0x88/0xa0
> [<ffffffc000d1c30c>] __schedule+0x1bc/0x720
> [<ffffffc000d1ca90>] schedule+0x40/0xa8
> [<ffffffc0001cd784>] flush_old_exec+0xdc/0x640
> [<ffffffc000220360>] load_elf_binary+0x2a8/0x1090
> [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> [<ffffffc00021c584>] load_script+0x20c/0x228
> [<ffffffc0001ccff4>] search_binary_handler+0x9c/0x240
> [<ffffffc0001ce8e0>] do_execveat_common.isra.14+0x4f8/0x6e8
> [<ffffffc0001cedd0>] compat_SyS_execve+0x38/0x48
> [<ffffffc00008de30>] el0_svc_naked+0x24/0x28
>=20
> To fix this, make de_thread() freezable. It looks safe and works fine.
>=20
> Changes in v2:
>  - changes for the same reason in "if (!thread_group_leader(tsk))" branch.
>    (reported by Oleg)
>=20
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Acked-by: Pavel Machek <pavel@ucw.cz>


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvpTRkACgkQMOfwapXb+vLcLwCeOd2jytn3uSdvAQWh2K8+RkKK
UYkAnREFbYw3qGUcs0CX79xse5VLdBGU
=L4si
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
