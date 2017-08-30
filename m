From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Wed, 30 Aug 2017 02:29:39 +0200
Message-ID: <20170830002939.ns43wldvffmwqhuv@earth>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth>
 <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
 <20170829212259.gs4bljwscrprsfjl@earth>
 <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqb5fxhr5baxgtdy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57379 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdH3A3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 20:29:44 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgTEe_xBP2ENMTU5BNwWaRjfqbAuRJC32sHYL_Mh5oJOsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr
Cc: Liam Breck <liam@networkimprov.net>, "Andrew F. Davis" <afd@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org


--xqb5fxhr5baxgtdy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 29, 2017 at 04:07:12PM -0700, Liam Breck wrote:
> I don't see a Julia in CC list...

<_< let's try that again.

> On Tue, Aug 29, 2017 at 2:22 PM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > [adding Julia to Cc for Coccinelle question]
> >
> > Hi,
> >
> > On Tue, Aug 29, 2017 at 10:31:57AM -0500, Andrew F. Davis wrote:
> >> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
> >> > On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
> >> >> Overview:
> >> >> * Reorganizes chip data definitions
> >> >> * Enables features landed in these patches:
> >> >>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
> >> >>   power: supply: bq27xxx: Add chip data memory read/write support
> >> >>   power: supply: bq27xxx: Add power_supply_battery_info support
> >> >> * Supports the following chips (only BQ27425 is active)
> >> >>   BQ27500, 545, 425, 421, 441, 621
> >> >>
> >> >> Changes in v3:
> >> >> * BQ27425 tested; workaround minor chip bug
> >> >> * Dropped driver_version
> >> >> * Fixed dbg_dupes logic for .props & .dm_regs
> >> >> * Dropped two props array dupes
> >> >>
> >> >> Changes in v2:
> >> >> * Added di->opts flags for remaining chip features
> >> >> * Commented out untested bq27xxx_dm_regs parameters
> >> >> * Changed dbg_dupes to run only once
> >> >>
> >> >> Notes on v1:
> >> >> * Not fully tested (hence RFC tag)
> >> >
> >> > Thanks, full series queued.
> >> >
> >> > -- Sebastian
> >>
> >> Anyway, I've not got the time to fight these changes anymore, but at
> >> very least could you drop 4/5, it's static analysis code made into a
> >> runtime check built into a kernel driver, if not at least add my
> >> nacked-by. :)
> >
> > Since it's not critical at all and nobody depends on it, I dropped 4/5
> > for now. I agree, that checking it at runtime is not nice. On the other
> > hand I do think a duplication check makes sense. Doing a static
> > check should be possible, but I have no idea how to implement this
> > (without much effort). I suspect Coccinelle can do it, so I added
> > Julia.
> >
> > For reference this is the runtime check:
> > https://patchwork.kernel.org/patch/9918953/
>
> [...]

-- Sebastian

--xqb5fxhr5baxgtdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmmBvAACgkQ2O7X88g7
+pr13A//XvAxL+c1D13NLuFwUcCZR3MkGT35lA07zTnkrYuXRzex846LYMN4xqYK
MTx5hxJZsh3e3Mz9+L4jel8Gx7biUBtxJu8gad3CPxh3kuZRA+l/F60w0+ZbrgMa
lJkOwXFIdOrigqlj489X1bGpLcxOqHZlwKo+6+ESAwUgHWABtjI9YjvTY669OL3w
oQIz7CYHtFrJ/ZIr+8xrxykn80LtoYjZ7HSAgBZb6URGHvqqq9MYiX66GKzNlqtN
/Xlw+DC8oznC31xkt12HKNsSRuInpB4RoffG1HqD+wJoDq50Yh2AI5VVDrfw4vsz
+oYBYDlZPPzksTbXaDha3FxRHSl8QJmj1vgg1g0jnNvGpzYyHZ6chzLgqZzFvdGb
/yPWrpUuYlrOTtHePATMx9sRF1B2B06Hl6BPXR7vP55MGDSw2fLk5HL2omolBexR
vyG1m5FGoYvRaILw4dmIBvgA5ATpQko9q2jq+NftbUkdmKml7LBbcUeezkpJ1CJh
JP3zS1eFwqvjhfDY426PLW2Posq5t9X5Rrzw4lUEleLmBAkocoWqz2JnhsXZOyh2
FRQZ79YKfvP2Hbv0lRMf0Mpyn+LmVt9vGn1nMn3pcE7W5Al2y5sToHh7YhyV3nBX
sRDu+cULXA9WRIGN6O9QmxI3isNr0WPhISZxMSRGgaZURQiuw2Y=
=3pc2
-----END PGP SIGNATURE-----

--xqb5fxhr5baxgtdy--
