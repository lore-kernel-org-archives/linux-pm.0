From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Sun, 29 Jan 2017 17:47:19 +0100
Message-ID: <20170129164719.eulijkfarzrm2o6j@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4517363215245720219=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-17-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============4517363215245720219==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mukm6o4sdvqxauxt"
Content-Disposition: inline


--mukm6o4sdvqxauxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Jan 27, 2017 at 09:54:49AM +0100, Quentin Schulz wrote:
>  - added x-powers,constant-charge-current property to set the
>  maximal default constant current charge of the battery,

Since this is information about the battery and not the fuel-gauge,
it should use the WIP "framework" for information about batteries.

Have a look at the following patchset:

http://marc.info/?l=linux-pm&m=148411561025684&w=2

-- Sebastian

--mukm6o4sdvqxauxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOHJUACgkQ2O7X88g7
+pqaFg/5AVesLB79ONhBfPfg6kUhv6wp4BXb1AVMLVFvL2Y6paxbG8XKHUvf6f1v
c5eE1o/bIi8ypjPEOZA7oA2DbcZDi5JlSU1E3ZHo0aC20SQ+olYqmHEvDPtP/s6n
mdCNiGGc3yUlzpISSglgdi1ApHYXMeGccBvbt7O8UcXK9ql6QcBLL8VQk0JOeUSr
3sfuy8pxOmheV+SaYImy1ZYxuMJlw5FQ1YxKqzk39pid2hwgpoZJVUStICBaVU4h
NdKCyM7b3qMye9L7Gj5nwnB9muZL2ptuyMa154dTZ+qfh3AmyYqbNacFUQqr4VsW
D5N+Jn7kIoaYYxBQYi/5St9Sv8/tdAf/gYdX60Dpbw0UzKXorF8W6mE3a0ugPPbb
VTN92DsIPZrkot6EI2wa8RdefGkl6nwCRG+928vot/Ubj9mr+jqJRQtHXdGb9gtc
LKSPrnj7jDd2MU4X6czgGP4ohdM/dY14GgK5D1ovAYF+r8S+GIu8gbkZiVYBFqUI
+AevtilowEctQ6igtHHdTOpkVM8VfX6QNXDz87mu1fs7gyj7Hx6hKvRqkVAXPM5A
1eS91GlXby6y4y+wg4NR1XO+6zTJzaw/T/+BtXrYQod1zXxaho6kCKONOaE8WDPN
gUpI0UVUQAaIrAftI854qcv8tSu6h+D5UW3ZMycMyA5oUme7Nl4=
=YaD6
-----END PGP SIGNATURE-----

--mukm6o4sdvqxauxt--


--===============4517363215245720219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4517363215245720219==--
