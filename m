From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Thu, 22 Nov 2012 22:40:21 +0100
Message-ID: <20121122214021.GA14771@avionic-0098.adnet.avionic-design.de>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <13540495.epaCf4JVn9@percival>
 <20121122133941.24B883E129E@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1875396289588321962=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121122133941.24B883E129E@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--===============1875396289588321962==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 01:39:41PM +0000, Grant Likely wrote:
[...]
> I do think that each sequence should be contained within a single
> property, but I'm open to other suggestions.

IIRC a very early prototype did implement something like that. However
because of the resource issues this had to be string based, so that the
sequences looked somewhat like (Alex, correct me if I'm wrong):

	power-on = <"REGULATOR", "power", 1, "GPIO", "enable", 1>;

Instead we could possibly have something like:

	power-on = <0 &reg 1,
		    1 &gpio 42 0 1>;

Where the first cell in each entry defines the type (0 = regulator, 1 =
GPIO) and the rest would be a regular OF specifier for the given type of
resource along with some defined parameter such as enable/disable,
voltage, delay in ms, ... I don't know if that sounds any better. It
looks sort of cryptic but it is more "in the spirit of" DT, right Grant?

Writing this down, it seems to me like even that proposal was already
discussed at some point. Again, Alex may remember better.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpvFAAoJEN0jrNd/PrOhhywP/AiT0Ylywbi9V9FNnZ6zwngi
WtclXo/ALSEifXqZxDDw4wxS3rhQpSN34+l75lu5mbYP2FDgglRuKBrdXDGZuy7M
fcQKA5SDJAypajIijGWSWLzHZCnKVXonfHOUKeVmfq+Oo7LXUSYKYT4W3yYV9LcK
xJLtxJKJDNpIuxhcI0FaUewXRYjzhB/IFAf1IUWhV3YZ6ZfbR5PXwx/Jg6qvo5Ns
Z8PDMyth0YY0LWMIJBMpvZZk1xlL3yw8imwNLw+P1seICh0mq8QATXf5zM07DXa1
Lf8JWn/d8ueto4jCm0gavWLjexpN9baC2PUNkS313hRhbWGcnI+c95bMlpUx8QjI
PN3WUXF2vPcfrrsgIZrFjr5PrEIS4vQfC9LfrCg44UxM0IlvCRVEiFhEgbyTEeW5
qiuBaDnUMY6l39pZx7EG/hOU207u9ZaSM+w66COb630WzzpKnJd2ZTsf1H4dZ7w3
Oyozguikk5Ohw2olOKsNkIncvRZEYa6GYpKIIDhmW3GoNE+/rC/dVSXM2CDBlQWJ
A/QLnww1K0sKc0VN+m83JK/R7EvslAAv4gKVJ5U3AQbZm02k7bzUqFMw6ZHlNEw7
CeHgOX35dN+SQHtaVwC5G27hNpBoKSjubd3xzrS+F+65Rdt97If0Q7FgmU1o+b/u
zQV/10Xw4kMSFyk8raC3
=8uOp
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

--===============1875396289588321962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1875396289588321962==--
