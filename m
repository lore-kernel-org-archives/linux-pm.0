From: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon, 12 Sep 2016 15:27:18 +0200
Message-ID: <87inu11c5l.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <20160909110727.GI27946@sirena.org.uk> <87pooc7n3t.fsf@notabene.neil.brown.name> <20160912122549.GZ27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160912122549.GZ27946-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-m
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Sep 12 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Sat, Sep 10, 2016 at 07:57:26AM +1000, NeilBrown wrote:
>> On Fri, Sep 09 2016, Mark Brown wrote:
>
>> > The wm831x driver in the patch series is an example of such hardware -
>> > it is purely a power manager, it has no USB PHY hardware at all.  It's a
>
>> The "probe" routine calls
>
>>  +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);
>
>> Presumably wm831x_pdata is initialised by a board file?
>
> Yes.
>
>> I strongly suspect it is initialized to  "usb-charger.0" because the
>> names given to usb chargers are "usb-charger.%d" in discovery order.
>> I don't see this being at all useful if there is ever more than one
>> usb-charger.
>> Do you?
>
> It's no worse than any other board file situation - if someone has that
> problem they get to fix it.

My point is that the present design does not appear to scale beyond a
single USB power supply (as if there were two, they would be named in
discovery order, which is not reliably stable).

Your point is, I think, that when someone actually cares about that lack
of scaling, they can fix it.

I am perfectly happy with that approach.  However if the code doesn't
scale beyond one charger, it shouldn't pretend that it does.
i.e.
  Don't have "usb_charger_find_by_name()", just a global "usb_charger"
  (or similar).
  The first charger to register gets to be the "usb_charger".  The
  second one gets an error.
I could be quite happy with that sort of interface.

>
>> So how can this wm831x driver actually find out what sort of charger is
>> connected and so set the power limit?  I just don't see this working *at*
>> *all*.
>
> The whole point from the point of view of the wm831x driver is that it
> just wants something to tell it how much current it's allowed to draw, I
> appreciate that doesn't change your analysis of the bit in the middle
> but the consumer driver bit seems fine here.

Yes, the wm831x driver probably does the right thing.
Other drivers might want to know not only the minimum they are allowed
to draw, but also the maximum they should try even if they are carefully
monitoring the voltage.
So wm831x is doing the right thing with the wrong interface.  Maybe you
can describe that as "fine".

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1q02AAoJEDnsnt1WYoG54roP/2wI8wrF+/mho2M7g9ipyyhA
eWL139YRL7yTmVE+nn9rHZ0HcljsibTNZFs0P0QLb2HLF30W2Yo7RFSTtS9ljaEb
ZWpj/mlByWfemBSjFvd96BEWVrpjsytcbRs3qhQwXKfOatMOiUIo6QvOjmVQLmvk
qgOFf41vpYZoXvEACpCuGZeZVgQvZ3mLBjaOwwbYai4286gn2JusAe9LAVAEgghU
66guPizqOgLszkQ4Qfh9h0fh2/qXhjvFZA8v+42TpjOoEIVhAOpT5LDlFleBrXLc
OCyx5kmDy/EhwYMuXu22Bj1Vs9rpgHY2iO1JXB36nnA/cMW1+Hos6u+2Dkd7WssN
BYMOnSiGpLzrn5WwYLk+sD3pUBgIjX9lXsd35EStaKhQOMqTHFk9W7yvcGjm0vkh
xWOmuvHIbBSEfQNKaof4GyLoXz7HnGa5RYkQfxI0acBImIyugY1vAKfJYv7ZuzzS
COmRFeWHncxZzeLZjjEa7ck5trI8GjlxhqCOowqiJFBpUtDAekJ9oaUW5YyNhNw6
80PAL+pNiQyQP15M7Q9nzs3ugVWHKRg0muLB7HsLe5agoDuARuJjt9syZn8o8C7X
207zxUwvmWgGxOKxDO7epi1dWcc6m8f5Ps7w4W/f/zcZA1SPfbGmnt2K9fAJmeN4
8BKqQLiym7mnmAau1OIJ
=0XkI
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
