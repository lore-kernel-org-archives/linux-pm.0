From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Date: Sun, 26 Aug 2007 11:08:30 +1000
Message-ID: <20070826110830.dfe6ea24.sfr__36484.9667101682$1188156667$gmane$org@canb.auug.org.au>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8644263111478209511=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============8644263111478209511==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R"

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Aug 2007 02:03:49 +0200 (CEST) Guennadi Liakhovetski <g.liakhove=
tski@gmx.de> wrote:
>
> +static int ls_pm_enter(suspend_state_t state)
> +{
> +	char ier;
> +	int ret =3D 0;
> +	u64 tb;
> +
> +	if ((ret =3D mpc10x_suspend(state)) < 0)
> +		return ret;
> +
> +	/* Get timebase */
> +	tb =3D get_tb();
> +
> +	/* put CPU to sleep, re-enabling interrupts */
> +	mpc6xx_enter_sleep();
> +
> +	local_irq_disable();
> +
> +	set_tb(tb >> 32, tb & 0xfffffffful);
> +
> +fail:

Unused label?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0NKUTgG2atn1QN8RAoV8AJ4zFSSVpZh54FVgXYo9sPYnt7Hr3ACfRkJC
RjlQLdK9pglb/EMO0awtVIY=
=9GuF
-----END PGP SIGNATURE-----

--Signature=_Sun__26_Aug_2007_11_08_30_+1000_cH7VJvUkjfhc5E_R--

--===============8644263111478209511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644263111478209511==--
