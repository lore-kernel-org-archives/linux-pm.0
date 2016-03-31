From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 09:21:59 +0300
Message-ID: <87vb43goag.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <20160330174458.GP2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160330174458.GP2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> writes:
> [ text/plain ]
> On Wed, Mar 30, 2016 at 01:09:00PM +0300, Felipe Balbi wrote:
>> Baolin Wang <baolin.wang@linaro.org> writes:
>
>> > +#include <linux/of.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/of_address.h>
>> > +#include <linux/platform_device.h>
>
>> not very nice to depend on either of or platform_device here. What about
>> PCI-based devices ?
>
> The header inclusion shouldn't be conditional though.  But looking at
> the patch I can't immediately see any use of these in the code anyway.

fair enough, seems like removal is the way.

>> > +static DEVICE_ATTR_RW(sdp_limit);
>
>> why RW ? Who's going to use these ? Also, you're not documenting this
>> new sysfs file.
>
> If they end up not writeable should we just remove them entirely since
> they should just be the spec values?

if they are really just spec values, why would even let them be modified
to start with ? ;-)

But yeah, seems like this is not interesting to userland.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/MIIAAoJEIaOsuA1yqREyyAQAIZS3RbSoPrbADykyFxk/+Yx
/85E7kpMhwwJk1gCvJCM5PIo+IViyelK7e9QSEFCir5c6spF3YVTKYhxm2OPCMAA
HUWLftDnAFc07UNYcl+scGxsIUrT01kllwYvdLPKx5tQY1t4VK/3bo67KQBT+x+J
p6vGhyf2bLYOVIIs/hyozi3sr24hTl2ggFn6VERXmMdgnCjQYavAsMRejOtKk6VZ
fzVKv1ogPT54JJ2L157nPjFb24sHTewxp7dVeCKufwspdSUXTOrCxytXfNroxuOa
cq4CpmES+w0Ywtl6GtmeMcbPvxgKNZUMNFt9Jww0RIrdSEkO5KhHNqgrPFWryY08
rUdWkJg4P1MdUP6/TnkY63JbZjY4Pn8dQ8fP/ckOmhpG+TILjsCOiUHw0DjAlrJ8
vwOTIFaSeGTOzZ4NeQdbIRiIqN/v/39iLkR8KHjHvvLcu0NG9ZeekLYi/D5FdWjr
D/ucF6aZ1IRnlO8jIB+HCKoCrb9QsBFuG6Vgt54ERCN17qLf2R84n95i0aYdzrXJ
lTeFRLYk3yUNiHZP1WurjpxXeV1tj7eUsTafZPsQDszsQbEwlmmlQBMX7SczYDV3
LOQlhbC+o3MqzNVXAPaju6njH+UtLYyepx4SoAMEKrGS8EdEmBJKL46bCnGoioDi
85ADTfIb16OHBs9v7cQr
=ibfE
-----END PGP SIGNATURE-----
--=-=-=--
