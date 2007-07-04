From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync from within the
	freezer during suspend to RAM
Date: Thu, 5 Jul 2007 08:48:15 +1000
Message-ID: <200707050848.16163.nigel__7634.3250497759$1183589341$gmane$org@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1075091870521018173=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707041658.59588.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

--===============1075091870521018173==
Content-Type: multipart/signed; boundary="nextPart7692759.9nY2pkrZJM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7692759.9nY2pkrZJM
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 05 July 2007 00:58:58 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> The syncing of filesystems from within the freezer in not needed for susp=
end=20
to
> RAM.  Change freeze_processes() so that it doesn't execute sys_sync() and
> introduce the "syncing" version of it to be called from the hibernation c=
ode
> paths.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  include/linux/freezer.h |   14 ++++++++++++--
>  kernel/power/disk.c     |    2 +-
>  kernel/power/main.c     |    6 ++++++
>  kernel/power/process.c  |    8 +++++---
>  kernel/power/user.c     |    2 +-
>  5 files changed, 25 insertions(+), 7 deletions(-)

Looks ok, except that I wonder if you want the following fragment. It looks=
 to=20
me (looking at rc6) like with this code, you'll currently call sys_sync twi=
ce=20
when suspending to ram. Maybe I'm misreading it. Also, shouldn't it be done=
=20
after taking the mutex?

Regards,

Nigel

> @@ -231,6 +232,11 @@ static int enter_state(suspend_state_t s
> =20
>  	if (!valid_state(state))
>  		return -ENODEV;
> +
> +	printk("Syncing filesystems ... ");
> +	sys_sync();
> +	printk("done.\n");
> +
>  	if (!mutex_trylock(&pm_mutex))
>  		return -EBUSY;
> =20


=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart7692759.9nY2pkrZJM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjCOwN0y+n1M3mo0RAmW9AJ9NzS9aCKFkpdexUPU0UzOQ3RIncACePJvx
gxoZJun4JnpmzDREKDC43Fc=
=iP8p
-----END PGP SIGNATURE-----

--nextPart7692759.9nY2pkrZJM--

--===============1075091870521018173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1075091870521018173==--
