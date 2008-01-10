From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] PM: invoke suspend notifications after
	console switch
Date: Thu, 10 Jan 2008 14:14:36 +0100
Message-ID: <1199970876.3861.66.camel@johannes.berg>
References: <1197853799.4885.7.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2810112638074927485=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1197853799.4885.7.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============2810112638074927485==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LQoyjSrNruQlQiFFY8/R"


--=-LQoyjSrNruQlQiFFY8/R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2007-12-17 at 02:09 +0100, Johannes Berg wrote:
> A subsequent patch will enable apm-emulation notification for suspends
> triggered in any way by using the suspend notifications. This causes
> the system to lock up between X being needed to switch away from the
> VT and X already waiting for resume in the apm ioctl.
>=20
> This patch moves the console switch (if enabled) before the suspend
> notification (and after the resume notification) to avoid this issue.

I don't see this in the suspend git tree yet, anything wrong with it?

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
>  kernel/power/main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> --- everything.orig/kernel/power/main.c	2007-12-17 01:52:29.617085178 +01=
00
> +++ everything/kernel/power/main.c	2007-12-17 01:53:23.547064887 +0100
> @@ -73,12 +73,12 @@ static int suspend_prepare(void)
>  	if (!suspend_ops || !suspend_ops->enter)
>  		return -EPERM;
> =20
> +	pm_prepare_console();
> +
>  	error =3D pm_notifier_call_chain(PM_SUSPEND_PREPARE);
>  	if (error)
>  		goto Finish;
> =20
> -	pm_prepare_console();
> -
>  	if (suspend_freeze_processes()) {
>  		error =3D -EAGAIN;
>  		goto Thaw;
> @@ -98,9 +98,9 @@ static int suspend_prepare(void)
> =20
>   Thaw:
>  	suspend_thaw_processes();
> -	pm_restore_console();
>   Finish:
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
> +	pm_restore_console();
>  	return error;
>  }
> =20
> @@ -192,8 +192,8 @@ int suspend_devices_and_enter(suspend_st
>  static void suspend_finish(void)
>  {
>  	suspend_thaw_processes();
> -	pm_restore_console();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
> +	pm_restore_console();
>  }
> =20
>=20
>=20
>=20
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>=20

--=-LQoyjSrNruQlQiFFY8/R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR4YaO6Vg1VMiehFYAQKJaBAAtHjXw3hc/ETnwQzL0wTqYZAnX6JHoyMM
1Uv52j/sWwxsAR37N56SqnXwTaeN6oP4U4itMs88kVnp5nWG6hkhD3H1eXBg76X0
PSuon41JltmI6yccJejE3wDs8irj4tx5tzSIq86HCYruyDBaSYn+60jAhIT/sqSs
tuAmu4BajmJXs2e4HRkB1+AwlAlyivhZIPLVi8D7ys1+L1Y8LBqvyif7cy6fQpLO
+qLr7d9glmAzEx+rJCkXV7O4vyIQZYG12+0jktwmkLiFcwdccDbas+NXs/hN6SWl
jnoIzGxo+sDkclBT+6NQCS5A2nPd5oJ2XFo2BebKXwARVxHiKJp+84dzFWH7CkpT
BqJ5KN+YXGVJakmZ6mKguUlCZHdKI5zlcsl9FHHodgsXWtmfIXa0mNhkxU/C4CCn
STLYgIlGFXN/0c5Z6Op4Dkx4q4pKHCCGIlYy0E8ICoNAPmDYJ2UdpqslwpfFZUGS
gSSe2U1nlKQ27uyKuNnQU+PrXx5mRvdOQJkC2w8qon01On0H7U6znPABqwyeKShx
zG2uqbSkSlLQ6S6LbScx7Mki98ljnbPT8sYO4GFj0CTDUQ54jVlgEy+eOHgyldfz
XfhH/qwztJ4Z/GIJ1TM9SI29pockJWAF120WY72KbvevfFg9zuRT1w7d/k3RnKzX
fva0yab0FIE=
=qHWY
-----END PGP SIGNATURE-----

--=-LQoyjSrNruQlQiFFY8/R--


--===============2810112638074927485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2810112638074927485==--
