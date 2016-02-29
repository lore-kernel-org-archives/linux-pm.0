From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 29 Feb 2016 23:22:12 +0900
Message-ID: <20160229142212.GB18327@sirena.org.uk>
References: <cover.1451876014.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k7s2XbGn4TQUKPSc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1451876014.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--k7s2XbGn4TQUKPSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2016 at 11:04:26AM +0800, Baolin Wang wrote:

> Currently the Linux kernel does not provide any standard integration of this
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kernels
> or USB gadget devices based on Linux (such as mobile phones) may not behave
> as they should. Thus provide a standard framework for doing this in kernel.

So, the review of this seems to have ground to a bit of a halt - we're
really not seeing any engagement or comments here, people aren't raising
any problems or suggesting alternative approaches but this isn't moving
forwards either.  This means that nothing running mainline that isn't
totally offloaded to hardware can charge at even 500mA, let alone more,
which seems like a failure to me.  What do we need to move this
forwards?

If there are concerns around ABI we could either make sure it's as basic
as possible (so that it'll be easy to maintain compatibility if we think
of something better) or just hide things from userspace so that we just
have the in kernel implementation.

--k7s2XbGn4TQUKPSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1FQTAAoJECTWi3JdVIfQHuEH/jgfiG1Crl2R60xEAVsnW/4t
P0Z8kzqLT4qHog3zpM9Z5yxUp5OwcWeLw71mbJSalx6mV04pgi5uTDNlK8FyurBd
U9ZRRow7nsRxNaUsy4eQj28lW97AjhYAThmty3waYPca/zxPhlC8pctAPYJ5M7Pd
R7mmB2BYsvgICSee1PfYpy4xDH4xNZLTT+v4+rUH4y2ecB0E/vzuUwhvIsXEW9FB
AacwktaOFeDDGMlgDQQeiFk95m1vCyLrnPh7dO2hz3yXtm3jj6uMfrWiGuGJYbbQ
GfgNjnCTPXyZSMh171i//7wzAssuS6wQ1O0Rf6LuYnUSvAP87ZBOEMXFYUMLBTE=
=rc1Z
-----END PGP SIGNATURE-----

--k7s2XbGn4TQUKPSc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
