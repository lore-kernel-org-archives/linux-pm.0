From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Fri, 28 Oct 2016 18:03:02 +0100
Message-ID: <20161028170302.au73yu2fplfig36a@sirena.org.uk>
References: <cover.1476780088.git.baolin.wang@linaro.org>
 <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name>
 <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="42amaels6ebn7ksv"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dev
List-Id: linux-pm@vger.kernel.org


--42amaels6ebn7ksv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 28, 2016 at 08:51:41PM +0800, Baolin Wang wrote:
> On 28 October 2016 at 06:00, NeilBrown <neilb-IBi9RG/b67k@public.gmane.org> wrote:

> > 1/ I think we agreed that it doesn't make sense for there to be
> >  two chargers registered in a system.

> Yes, until now...

> >  However usb_charger_register() still allows that, and assigns
> >  and arbitrary name to each based on discovery order.
> >  This *cannot* make sense.

> Fine, I can change that to allow only one charger to register.

Yeah, it's a reasonable change.  I'm not sure the prior discussion was
100% conclusive on the issue (I remember there being some debate about
leaving things there to avoid any need for future refactoring to touch
the interface).

> > 2/ Why do you have usb_charger_set_current()??
> >   No code ever calls it.
> >   This updates the min and max current which are defined in a
> >   standard.  It never makes sense to change the min and max
> >   for a particular cable type.

> Mark, do we have some scenarios which want to change the current
> limitation? If not, okay, I agree with you to remove this function.

I'm not aware of any, we can always add it back if the need arises.

> >  Related:  I don't like charger_type_show().  I don't think
> >  the usb-charger should export that information to user-space because
> >  extcon already does that, and duplication is confusing and pointless.

> I think we should combine all charger related information into one
> place for user. Moreover if we don't get charger type from extcon, we
> should also need one place to export the charger type.

I had also thought there was some software negotation as well as the
physical charger in cases where the device is plugged into an active
host?  I could be wrong.

> > 5/ There is no convincing example usage of this framework.
> >   wm8931x_power.c just scratches the surface.
> >   If it is so good, it should be easy to convert a lot of other
> >   drivers over to it.  If you did that it would be much easier
> >   to see how it works and what the strengths/weaknesses were.

> Jun have send out one patchset[1] based on my patchset, and he tested
> mypatchset. Thanks for your comments.
> [1]http://www.spinics.net/lists/linux-usb/msg139809.html

I think it's a good idea to pick up Jun's patches into your patch set,
that way Jun doesn't need to rebase and it might help with review of
your patches too.

--42amaels6ebn7ksv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE4TFAAoJECTWi3JdVIfQeiUH/AhJEjOuEBHtgFYVAJxql/VG
64mY8DdZxHBTRptPeCVz/2y7QmjpYEfX9obfSRKfeOkANwm4z4wfj15TvywQCQsu
H4YH9lC7GYKa4jWwE+xnXVByB/SR7NFYvbxmsB1rcmw6bG8EKjsmfEUyO3erG/7e
posGLzIFp47eEpN6LZfMXYHQSNz3DRToMfqF1DGTGGyNnGcY9aRUb59tG/Toqi4e
D5IKWfCP30PxuSVv9vMmY2YfYbAe6y8Kogo4m0A2J3VTiA2DdrNg5BeHdZ569HqY
IvP/IgiYRAOJavXkOuLAjrboqMYJqPtu0onSs+XXf4IgPSPK2e3HFstRPl+hQQk=
=ia7K
-----END PGP SIGNATURE-----

--42amaels6ebn7ksv--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
