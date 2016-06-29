From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
Date: Wed, 29 Jun 2016 11:01:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <57737AA1.7050201@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-438052120-1467210361=:24439"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <57737AA1.7050201@linaro.org>
Content-ID: <alpine.LFD.2.20.1606291045410.24439@knanqh.ubzr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, David.Laight@ACULAB.COM, anton@samba.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

--8323328-438052120-1467210361=:24439
Content-Type: text/plain; charset=KOI8-R
Content-ID: <alpine.LFD.2.20.1606291045411.24439@knanqh.ubzr>
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jun 2016, Daniel Lezcano wrote:

> On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
> > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > index f87f399..c8ea5ad 100644
> > --- a/drivers/cpuidle/cpuidle.h
> > +++ b/drivers/cpuidle/cpuidle.h
> > @@ -68,4 +68,27 @@ static inline void
> > cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
> >   }
> >   #endif
> >
> > +/*
> > + * Used for calculating last_residency in usec. Optimized for case
> > + * where last_residency in nsecs is < INT_MAX/2 by using faster
> > + * approximation. Approximated value has less than 1% error.
> > + */
> > +static inline int convert_nsec_to_usec(u64 nsec)
> > +{
> > +	if (likely(nsec < INT_MAX / 2)) {
>=20
> UINT_MAX ?

Actually this can be better than that.

> > +		int usec =3D (int)nsec;

First, you'll want an unsigned type. Given the provided argument is u64,=20
we can assume there won't be any negative values here.

Then it would be wise to use a type with an explicit width, like U32.

> > +		usec +=3D usec >> 5;
> > +		usec =3D usec >> 10;
> > +		return usec;

And now you want to maximize the available range. So not to overflow the=20
first addition, we must respect:

	usec + (usec >> 5) <=3D 0xffffffff=20
	usec + usec/32 <=3D 0xffffffff
	usec <=3D (0xffffffff * 32) / 33

Therefore:

	nsec <=3D 0xf83e0f82

This is much better than INT_MAX/2.

> > +	} else {
> > +		u64 usec =3D div_u64(nsec, 1000);
> > +
> > +		if (usec > INT_MAX)
> > +			usec =3D INT_MAX;
> > +		return (int)usec;
> > +	}
> > +}
>=20
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =81 Open source software for ARM S=
oCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
>=20
--8323328-438052120-1467210361=:24439
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--8323328-438052120-1467210361=:24439--
