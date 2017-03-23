From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v11 07/10] power: bq27xxx_battery: Keep track of specific
 chip id
Date: Thu, 23 Mar 2017 14:06:51 +0100
Message-ID: <20170323130651.ruvs4j3kpf4moxrr@earth>
References: <20170320094335.19224-1-liam@networkimprov.net>
 <20170320094335.19224-8-liam@networkimprov.net>
 <20170323102825.vvxfzvuvvnhyzlna@earth>
 <CAKvHMgQsuTNcGUXZL7qk_YZ+qcdcLJ1+1xPB0zP97DqiitHJXA@mail.gmail.com>
 <20170323123054.jyngk44mea435cal@earth>
 <CAKvHMgSpkfgQxMMLmw7MdLqP_LFMt-V9k63oRg5SsDDXTN5rXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxpg7p7p4c2zfsiu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbdCWNG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:56 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSpkfgQxMMLmw7MdLqP_LFMt-V9k63oRg5SsDDXTN5rXQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>


--wxpg7p7p4c2zfsiu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 05:39:09AM -0700, Liam Breck wrote:
> On Thu, Mar 23, 2017 at 5:30 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Thu, Mar 23, 2017 at 03:35:33AM -0700, Liam Breck wrote:
> >> On Thu, Mar 23, 2017 at 3:28 AM, Sebastian Reichel <sre@kernel.org> wr=
ote:
> >> > Hi,
> >> >
> >> > On Mon, Mar 20, 2017 at 02:43:32AM -0700, Liam Breck wrote:
> >> >> From: Liam Breck <kernel@networkimprov.net>
> >> >>
> >> >> Pass actual chip ID into _setup(), which translates it to a group I=
D,
> >> >> to allow support for all chips by the power_supply_battery_info cod=
e.
> >> >> There are no functional changes to the driver.
> >> >>
> >> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> >
> >> > This is really ugly. If we need chip ID and group ID let's store
> >> > them in different variables. For example put the detailed chipid
> >> > into di->realchip and then do
> >>
> >> I tried this in a previous version, and Andrew rejected it as
> >> confusing to have two IDs. That was while you were away on business
> >> :-)
> >
> > now we have two IDs in the same variable.
> > That definitely more confusing. We can name the second variable
> > group to reduce confusion.
>=20
> I was trying not to rename every instance of di->chip; there's a lot.
>=20
> But we can pass real_chip as an argument to this function, so that
> gets you what you wanted.

That's fine with me.

-- Sebastian

--wxpg7p7p4c2zfsiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTyGsACgkQ2O7X88g7
+po5HQ//TKTSfRiridzm16miFPqVVxM2noJv1FyH389z3ow/9JXD/1P4w7KCeSYC
jCCOT1NatuWHRTRmk7aZ1NIbmZYdZL4CWY5ZwTf1rudnkRbNjKCEEJMXC7xTtrEY
p4Oxp+ffUc6q8TrJgBXX8moT7mHDwkmUPZ4/ZAi/Vx+Un3LheXy8fMl9K5Ba4LA2
Af0S3OKPhIeRXp5XJ8Kj3NnX6fQyJWo7uN5dpG3C5KXe2zUFMeKZRnH1q6ASnWXJ
VNd5jzBDxvZYCJmZm/YDc6rl9qHjzTYHAmROfJ1IHlaPCQ+NRIT3WPeYQyqsoj8n
3DKBN+4ITXHcI2C88EWYlrksLHdt9/AD/4csG2vr4tcAtcmi6ah07+sr/YxYHkRj
xMXSfiVWtekCxgbxkhCxVwsI2cixdk23R2J2B5KftI7vICZgbKW+ZU5CybEKynap
avoD6+SLK5zF4fCW2AJ9pn/GGlcRI7IFDafL58nkttIZ148LiXH2D0Ab0woqItmU
6azhs8xnRl9YgHoutPNgwpgo/eV/Zp1yAdZJ6Ed6L9deSDx0ffb7YGz72WVztRNq
YJeQ6cym6Y3QgIXagAALnjH+pQK3UDrYxwcb7NozHKrNbyBVGwSkw0AUOz9dQ3mv
2SAnBlJnsXa40J50QOceDuPEmgIW1fBCNEnSb8w1bdbHW5uP/yg=
=MEvV
-----END PGP SIGNATURE-----

--wxpg7p7p4c2zfsiu--
