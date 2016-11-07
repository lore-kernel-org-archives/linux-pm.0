From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 08 Nov 2016 07:36:32 +1100
Message-ID: <87a8dbni27.fsf@notabene.neil.brown.name>
References: <cover.1476780088.git.baolin.wang@linaro.org> <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com> <87k2cttptn.fsf@notabene.neil.brown.name> <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com> <87a8dls7yn.fsf@notabene.neil.brown.name> <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com> <871sytqrqh.fsf@notabene.neil.brown.name> <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbcKGUjw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Nov 2016 15:39:52 -0500
In-Reply-To: <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07 2016, Baolin Wang wrote:

> On 3 November 2016 at 09:25, NeilBrown <neilb@suse.com> wrote:
>> On Tue, Nov 01 2016, Baolin Wang wrote:
>
> I agree with your most opinions, but these are optimization.=20

I see them as bug fixes, not optimizations.

>                                                              Firstly I
> think we should upstream the USB charger driver.

I think you missed the point.  The point is that we don't *need* your
"USB charger driver" because all the infrastructure we need is *already*
present in the kernel.  It is buggy and not used uniformly, and could
usefully be polished and improved.  But the structure is already
present.

If everyone just added new infrastructure when they didn't like, or
didn't understand, what was already present, the kernel would become
like the Mad Hatter's tea party, full of dirty dishes.

>                                                  What I want to ask is
> how can we notify power driver if we don't set the
> usb_register_notifier(), then I think you give the answer is: power
> driver can register by 'struct usb_phy->notifier'. But why usb phy
> should notify the power driver how much current should be drawn, and I
> still think we should notify the current in usb charger driver which
> is better, and do not need to notify current for power driver in usb
> phy driver.

I accept that it isn't clear that the phy *should* be involved in
communicating the negotiated power availability, but nor is it clear
that it shouldn't.  The power does travel through the physical
interface, so physically it plays a role.

But more importantly, it already *does* get told (in some cases).
There is an interface "usb_phy_set_power()" which exists explicitly to
tell the phy what power has been negotiated.  Given that infrastructure
exists and works, it make sense to use it.

If you think it is a broken design and should be removed, then fine:
make a case for that.  Examine the history.  Make sure you know why it
is there (or make sure that information cannot be found), and then
present a case as to why it should be removed and replaced with
something else.  But don't just leave it there and pretend it doesn't
exist and create something similar-but-different and hope people will
know why yours is better.  That way lies madness.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYIOXQAAoJEDnsnt1WYoG5OrkQAIydklU1Kr3SX42iw75868+X
tMZLTDzWZ8mU9uXpkmSv6HZxYmb/2SXv0i4/Z8ugOerT5VP1Wv97L+gg44XZCD0d
9B7dXLVdOS7O34XWQOcyiBY4rqj42Ljk1gWMp0QXhvxhYZk/YUmMwoWfRnZH1HuC
Itre2Sci1SNMWY8lXlWTykbTl67KmLuQChHG4EUUem9pcy0SfFwywNJ0UaQLk10S
Q+MFj0zSD2Hdqbwsx6NAtSEYUXt0Y825LxY2vKEVAScVUkcZEPtMSOWTAPVm5fRc
vOVlt49Ut+aHwCUHkbw5qYqteexAOb2oVrDXOmdWdVVUqZBrX5RAwv4IGoRr/r+W
DXZnuJRmGS9ofEc0+v38wCbNV4x4U/OYAm11165zzYsuVeC+vAO4/J3W74K2g8pN
XFCqChsneIm70Bbi3d2Ei+zedomfkRdUv1Eh/TzJlPrgpPf9ZlphR2HZ1KTdqkG2
pHXBNWek7mTja6nZ4/WR5D9m8zo+OxjfuM589dEi5bKhRPTB85VdB7G6EwvGv1qp
k9Kj+rO2YRCV5qb3xwIci9DI70QX/9YdYTkURzW5ImSRyci2cK/rWu7Igq7oQeKB
O33ncngAQXoi29iuBgmUvUHrmQ2uvzuQaZynp/VFmKVngJ7kunJZqh0lOYFti/bx
JOlCS08Q/g46rbpn4/Kl
=Q+aq
-----END PGP SIGNATURE-----
--=-=-=--
