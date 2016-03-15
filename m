From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 15 Mar 2016 16:39:18 +0000
Message-ID: <20160315163918.GQ2566@sirena.org.uk>
References: <cover.1451876014.git.baolin.wang@linaro.org>
 <20160229142212.GB18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160229142212.GB18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 29, 2016 at 11:22:12PM +0900, Mark Brown wrote:
> On Mon, Jan 04, 2016 at 11:04:26AM +0800, Baolin Wang wrote:

I see Felipe is no longer at TI so his e-mail was bouncing - let's
resend this with his kernel.org address:

> > Currently the Linux kernel does not provide any standard integration of this
> > feature that integrates the USB subsystem with the system power regulation
> > provided by PMICs meaning that either vendors must add this in their kernels
> > or USB gadget devices based on Linux (such as mobile phones) may not behave
> > as they should. Thus provide a standard framework for doing this in kernel.

> So, the review of this seems to have ground to a bit of a halt - we're
> really not seeing any engagement or comments here, people aren't raising
> any problems or suggesting alternative approaches but this isn't moving
> forwards either.  This means that nothing running mainline that isn't
> totally offloaded to hardware can charge at even 500mA, let alone more,
> which seems like a failure to me.  What do we need to move this
> forwards?

> If there are concerns around ABI we could either make sure it's as basic
> as possible (so that it'll be easy to maintain compatibility if we think
> of something better) or just hide things from userspace so that we just
> have the in kernel implementation.



--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6Dq1AAoJECTWi3JdVIfQq88H/23GKtRduaM92szNSLg6jCHA
qHGplA+5sl0E/HvVrrFRgVPI4Rch4wbIuPHuo22cpCO/KxFx4kS2L5M6mTIRfO2y
nfai/yYIUex6gJchU6SXk3VyRyxzzJribdtUGNTVj51u8BaU7Fql6WyTGVDK46sK
2/NIbGiPJVk2zgZBPr5ew7KpJh90r24cz+micXN6ndTBDyMfC++braEiyJZ/l8H4
8ri3v2yXhaUJeGk+EaIBtveQlePN4sZp9Cxhpvw2eItJeWR6a/NMVb6mrNS4TbgW
ROYQlFpSG1Lykth1u4f6q1OcJqahNBoHR0pBVHpop8slfJ3mc/WVwWG478logpc=
=xNZL
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
