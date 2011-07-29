From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC v2]: Issues implementing clock handling
 mechanism within UART driver
Date: Fri, 29 Jul 2011 12:55:13 +0300
Message-ID: <20110729095512.GE31013__42311.0493146398$1312057849$gmane$org@legolas.emea.dhcp.ti.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5336734855076164969=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
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
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============5336734855076164969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Content-Disposition: inline


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
> Proposal:
> --------
> 	1. For the UART, follow the current approach of locking the console in
> 	   Idle/Suspend path before cutting the clock but using pm_runtime_putsy=
nc.
> 	   That is, continue using the prepare/resume Idle calls in idle path.

I believe you should be using ->prepare() to prevent that any other
work on UART won't trigger a console_write() right now. Maybe only
queueing the work for after ->complete() or, maybe, just ignoring the
work and loosing some prints, dunno.

> 	2. Other Approach would be adding conditions to debug prints from
> 	   omap_device/ omap_hwmod/clock_framework avoid calling these debug
> 	   prints for uart.
> 	   Or Even a debug macro that would not debug prints if the context is
> 	   from uart.

yeah, that might work but then again, if we were using 8250.c, would we
have this limitation ??

I think that, maybe, your best call would be to capture console_write()
calls into an internal temporary buffer on ->prepare() and flush it once
->complete() is called ?

BTW, where are the patches ? :-)

--=20
balbi

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOMoOAAAoJEAv8Txj19kN16FAH/RaPeEYhHbADkBrNm7vHHAIq
CYYUXN8jZ0IiUUUpo7Z7H98nWXuq92KeaScP6OYgDg8WcyZT3TM0wWPsznT+Raov
U9VnhNO6vhE1GbGUj2rt/jw2CeLGU8Zm7x6LG3UcL6jPACUigN69+WVlDUs8kGM/
AzmIOXjaSyWZdT9vXa0evAHLNYtDXsJzTZnXyb39abBJ8czTRsW809HdR3kFLXJ7
N+gc/oHG6WigC4R65k3Z/Kp7CeBiKgtaUdY9W2wNoGbcsb7x8oY7mSa0qU9BFrw4
p1uPU8fgC4EJ3EHJarzeu0+AdEBDNpsKwoTN/MH55Tz9cW+T3ak2FduJFhDSO7o=
=5/TQ
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--

--===============5336734855076164969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5336734855076164969==--
