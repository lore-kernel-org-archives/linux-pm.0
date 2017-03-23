From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 05/10] power: bq27xxx_battery: Make error reporting
 consistent
Date: Thu, 23 Mar 2017 11:33:15 +0100
Message-ID: <20170323103315.u5mcxzmme6g5izhf@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-6-liam@networkimprov.net>
 <6e387ba3-c5ce-ef88-d5ab-560b190e8352@ti.com>
 <CAKvHMgSvUo+7CdsCRyHFgTEBKbZq7LeQokkGFs1P+6_4oPLqvg@mail.gmail.com>
 <20170323101154.eixbsbeyjywwozws@earth>
 <CAKvHMgSKrPnJNLRN-61u_BRYAHQuMc1WNU4binjTMMTLGq95Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ckrnzzlttxrhr2ea"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbdCWKdU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 06:33:20 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSKrPnJNLRN-61u_BRYAHQuMc1WNU4binjTMMTLGq95Kg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--ckrnzzlttxrhr2ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 03:24:40AM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 3:11 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Mon, Mar 20, 2017 at 10:59:18AM -0700, Liam Breck wrote:
> >> On Mon, Mar 20, 2017 at 9:57 AM, Andrew F. Davis <afd@ti.com> wrote:
> >> > On 03/20/2017 04:43 AM, Liam Breck wrote:
> >> >> From: Liam Breck <kernel@networkimprov.net>
> >> >>
> >> >> Previously errors were reported in a mix of styles via both dev_err=
() & dev_dbg().
> >> >> Report all errors with dev_err() and include error code in message.
> >> >> Report register ID separately in dev_dbg() message.
> >> >>
> >> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> >> ---
> >> >>  drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++----=
------------
> >> >>  1 file changed, 19 insertions(+), 16 deletions(-)
> >> >>
> >> >> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power=
/supply/bq27xxx_battery.c
> >> >> index 398801a..2e2a3a8 100644
> >> >> --- a/drivers/power/supply/bq27xxx_battery.c
> >> >> +++ b/drivers/power/supply/bq27xxx_battery.c
> >> >> @@ -794,11 +794,17 @@ MODULE_PARM_DESC(poll_interval,
> >> >>  static inline int bq27xxx_read(struct bq27xxx_device_info *di, int=
 reg_index,
> >> >>                              bool single)
> >> >>  {
> >> >> -     /* Reports EINVAL for invalid/missing registers */
> >> >> +     int ret;
> >> >> +
> >> >>       if (!di || di->regs[reg_index] =3D=3D INVALID_REG_ADDR)
> >> >>               return -EINVAL;
> >> >>
> >> >> -     return di->bus.read(di, di->regs[reg_index], single);
> >> >> +     ret =3D di->bus.read(di, di->regs[reg_index], single);
> >> >> +     if (ret < 0)
> >> >> +             dev_dbg(di->dev, "failed to read register 0x%02x (ind=
ex %d)\n",
> >> >> +                     di->regs[reg_index], reg_index);
> >> >> +
> >> >
> >> > If we print out the error code here we don't have to do that in each=
 of
> >> > the below printouts.
> >>
> >> This is a dev_dbg, the below are dev_err, and I think you want error
> >> code in dev_err. BTW the above addresses your request to learn which
> >> register was in play in the event of a DM read/write failure.
> >
> > Just make it dev_err and also print ret. Then we can remove all
> > other prints. That will result in some information-loss (name
> > of the register), but
>=20
> Andrew specifically asked for error reporting that gives the error
> context elsewhere in the patchset. In complying with that request, I
> filed this patch.
>=20
> We could pass a context string into read() ...

That's fine with me.

-- Sebastian

--ckrnzzlttxrhr2ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTpGsACgkQ2O7X88g7
+poYow//bGt4OeHInDgSjqO2D5LmpmVHX0fYsCXvIAizJrqz6oOqOqgfGY8+P+AC
B1htVf3t9zegpU5W8HxFNm/eOW0a+qRBO2ixg/kA3Dw+nJVnresJKAZ++3P9ugTp
1veMnea8njb+SazHrs1yIyxNpP/kbbxuiuHtIqcbGAtWhSsa3yMeqlBOKEb6lSA+
vhyEnjivY8HFkCYfSN1eQMfaIz37W7Vk4sIq/r4+6g6uEr/8T1nHtwE+zEKPASeH
pjslP4RBLLQFgI79keaN0nGCh0kk2DfGageuUlu7N61XdZGXj95pLw8cbk2Vzow5
ECqzIFBf8OWzkfQ9PREz2WSoIjNWASGrQt8wdEolpD3jxCrPGaYrzwTGbHN2k8vV
f4OVMckuDVM5pnBIuTAbX2AisMqxlPG+0HclZW34E9tBB5E06+N0ZbW1V/VbFKr/
eKdP68nqqzs7E9YYdEDVHBvZ/kdBZRqpFVFHLp4uMSHF/BNiZ90Ocwa6lrS95TxQ
GaW+D4hK+89ILQ4nQzcks/rlwCK2Kr8BonO/SxkgPWnA6JcBmsblxHRYWONiVoxG
SBYgEEbyJy3xJ6YjK/kIYd2q7Dm1uT15wC0m870WhDeBCA6iurRfDyAHR2+b4wWU
fx5ra/ce/FgZ++X6khaR8Rfs5S0Kg1Jxe+B0wFpGvCC7uIcMkIo=
=x+Lu
-----END PGP SIGNATURE-----

--ckrnzzlttxrhr2ea--
