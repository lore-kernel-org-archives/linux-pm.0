From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Tue, 18 Feb 2014 08:48:16 +0900
Message-ID: <20140217234816.GC2669@sirena.org.uk>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140216013956.GV4451@sirena.org.uk>
 <20140217163421.GD20125@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5099062454696658546=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140217163421.GD20125@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org


--===============5099062454696658546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 04:34:21PM +0000, Lorenzo Pieralisi wrote:
> On Sun, Feb 16, 2014 at 01:39:56AM +0000, Mark Brown wrote:

> > > +	- cache-state-retained
> > > +		Usage: See definition
> > > +		Value type: <none>
> > > +		Definition: if present cache memory is retained on power down,
> > > +			    otherwise it is lost.

> > Might be better to define which caches?

> I do not expect caches in the same power domain to have different retention
> capabilities, so a flag per-state should be enough. If anyone is unhappy
> about this please flag it up. List of caches affected can be retrieved by
> walking the power-domain specifiers and check those against the caches power
> domains.

OK, so it's caches located within the power domains referenced by the
state node?  Might be good to say that say that just for clarity since
the power domains are indirected.

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAp+9AAoJELSic+t+oim9vNQP/iavmPVh9EzJ497LQvWlRsZ6
JHaggKvVBrNTb9i5AtX9DInevb1e470LNUxIF5+XtH6dQEXhS45dBDxtaf1TZGAA
NQKTVs/QwvRDsIHM6wZz751dTdwxqP7AkN48Yhbng5yLdKHm+uaq7/8LkBmacI0h
ACRTF/vXin6YRgA0JfCbxxSIJdj1zYtZeWIcoeKGS49AzanNDPssntwiyoA1hW0p
er+IqZ7rNCBbbU6MlolEhLPNkaTN1CJMJ9/DqOO3QTlEasf/L4MMs0aY5wQwub9U
j2LAMmLKLil3QXosX0HtXQVyifvVjVQzfPEgdNWuIR7BI7aTZg3Ma78W3R1TquEC
JBldsuicJpTJZRj4Y99kvFJ6WztTaXgfoAliPtqeP1b2UElteuRhENy496NjoZWj
lk5lfAZVrENX9O6YorhdCwpHyxqxyy6k93L9C7CsvsguetNvtjcM8MrZPig/7Umt
tbwnBpGbmeIP6QoYd2K6oRcQtC2c+kaQU2Ffu3PetYkwEfnTvKJJfHn73tQ6KQEh
dXN/1KwUe/JF5BYp7q6G7BLa/x5nXgXEV+OzjOt+hzygiVV5r5bYX3dTcoJe7iH7
W91tWNX2OeSJhQcw8yuN+EeDg8F8nNfIGzJIOWnJONogc2PPkOFQH15khs5aiqby
kSjN5EAkBb6XnspscbwX
=qVRM
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--


--===============5099062454696658546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5099062454696658546==--
