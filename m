From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] pm_ops: add system quiesce/activate hooks
Date: Fri, 13 Apr 2007 10:59:16 +0200
Message-ID: <1176454756.7052.98.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176306867.19348.4.camel@johannes.berg> <461D494D.3080808@gmail.com>
	<1176367352.5764.2.camel@localhost.localdomain>
	<20070412101653.GB26473@elf.ucw.cz>
	<1176377017.5764.15.camel@localhost.localdomain>
	<461E6E07.5020408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1535716609=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <461E6E07.5020408@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1535716609==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+yxe9AZgNLn7osoBChWN"


--=-+yxe9AZgNLn7osoBChWN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 21:36 +0400, Dmitry Krivoschekov wrote:

> For example, I'd like to enter back to suspend mode
> right from "activate" stage, because I've woken up just
> to update some data and I do not want to resume all devices
> for that, is it ok for "activate"?

Come to think of it, this sounds more like a confusion of terms instead
of actually thinking "activate" would be good.

quiesce here is mostly to turn off IRQs and activate mostly to turn them
back on. The enter callback is what should actually enter suspend. I can
see how you can confused "enter" suspend and "activate" suspend though.

The docs in the patch I posted should make it clear enough, but if
somebody can come up with a better name for "activate" I'm all ears.

johannes

--=-+yxe9AZgNLn7osoBChWN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGH0Zk/ETPhpq3jKURAkd8AKCsnGAcI5m8WpSRtSl+di0k4kPVMQCfbcr+
JbrNnOTFA6HAzsHXddAgTK8=
=jork
-----END PGP SIGNATURE-----

--=-+yxe9AZgNLn7osoBChWN--


--===============1535716609==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1535716609==--
