From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Wed, 30 Mar 2016 10:44:58 -0700
Message-ID: <20160330174458.GP2350@sirena.org.uk>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uc2nn8srCdMFAHlk"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87h9foqnur.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--Uc2nn8srCdMFAHlk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 01:09:00PM +0300, Felipe Balbi wrote:
> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>

> not very nice to depend on either of or platform_device here. What about
> PCI-based devices ?

The header inclusion shouldn't be conditional though.  But looking at
the patch I can't immediately see any use of these in the code anyway.

> > +static DEVICE_ATTR_RW(sdp_limit);

> why RW ? Who's going to use these ? Also, you're not documenting this
> new sysfs file.

If they end up not writeable should we just remove them entirely since
they should just be the spec values?

--Uc2nn8srCdMFAHlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/BCRAAoJECTWi3JdVIfQVRAH/04NkweSyILzir/w7glvhIQR
LIgVc2KvRQ0637Ce2NKDJ8XedXvY7642E8tVMT1ieFd/DaIk0VwaUolmcmw0c4pi
4kbtoWy9YYKi1K72oTUbFnEbuZgiNZTXnY8VEFmbnRy9yJOznrnc3dt3CwHw1Eqx
QpoeGEiZLD9p+uMOw2J01KQKfatLkVKYPstNz0vkFTb+ibLMzurEe0X99Fd3iPVL
niiH1+ExzmnjkAQuTCZ6F/AJSRMYIQr0I8RvWrr2iwGXR+4hTNlpj01g1VLHiMPq
Xy//VXMbcM2HmCgMdMFBIeBflwBdiMZnVswzD9mlQUOlNqMVCyxSOk6cIrK3JjE=
=6eD0
-----END PGP SIGNATURE-----

--Uc2nn8srCdMFAHlk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
