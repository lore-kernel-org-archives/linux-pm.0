From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] intel_idle: Don't use on Lenovo Ideapad S10-3t
Date: Mon, 9 Nov 2015 12:28:43 +0200
Message-ID: <20151109102843.GU4437@intel.com>
References: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C9484693D228@fmsmsx115.amr.corp.intel.com>
 <20151104162100.GT4437@intel.com>
 <20151108192016.GA7063@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23292 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbbKIK2r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 05:28:47 -0500
Content-Disposition: inline
In-Reply-To: <20151108192016.GA7063@khazad-dum.debian.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Nov 08, 2015 at 05:20:16PM -0200, Henrique de Moraes Holschuh w=
rote:
> On Wed, 04 Nov 2015, Ville Syrj=E4l=E4 wrote:
> > On Tue, Nov 03, 2015 at 03:04:21AM +0000, Brown, Len wrote:
> > > > Lenovo Ideapad S10-3t hangs coming out of S3 with intel_idle.
> > > > The two workaround that seem to help are "intel_idle.max_cstate=
=3D0"
> > > > or "nohz=3Doff highres=3Doff".
> > > >=20
> > > > At a first glance quirk_tigerpoint_bm_sts() seemed promising, b=
ut
> > > > even when moved to early_resume it didn't do anything.
> > > >=20
> > > > I have no idea what's wrong here, so let's just disable intel_i=
dle
> > > > for these machines using a DMI match.
> > >=20
> > > Ville,=20
> > >=20
> > > It is great that several workarounds have been discovered.
> > >=20
> > > But it would be better to get a good idea of the root-cause
> > > before permanently ignoring the problem via a new
> > > black-list in the upstream kernel.
> > >=20
> > > Is it possible for you to file a bug at bugzilla.kernel.org
> > > against Product: power-management; component: intel_idle?
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D107151
>=20
> This is a shot in the dark, but...
>=20
> The Atom N450 public errata sheet is nightmare fuel, and Ville's Idea=
pad is
> running that hellish processor on outdated microcode.
>=20
> http://www.intel.com/content/dam/www/public/us/en/documents/specifica=
tion-updates/atom-processor-n400-specification-update.pdf
>=20
> Ville, you might want to insure you're at the latest BIOS for the S10=
-3t:
> http://support.lenovo.com/us/en/products/laptops-and-netbooks/ideapad=
-s-series-netbooks/ideapad-s10-3t/downloads/DS010786

Seems to require Windows, so no can do without major pain.

Considering acpi_idle works just fine, I doubt a new BIOS version would
have anything to fix this, except maybe by accident.

> (don't bother with changelogs to make any sort of update-or-not decis=
ions:
> Lenovo changelogs are known to often be incomplete).
>=20
> I also strongly recommend that you should install your distro's micro=
code
> update package: your microcode should have been revision 0x107 or hig=
her, it
> has been in the public microcode distribution since Q2/Q3-2010...

[    0.000000] microcode: CPU0 microcode updated early to revision 0x10=
7, date =3D 2009-08-25
[    0.990876] microcode: CPU0 sig=3D0x106ca, pf=3D0x4, revision=3D0x10=
7
[    0.990972] microcode: CPU1 sig=3D0x106ca, pf=3D0x4, revision=3D0x10=
7

No help unfortunately.

>=20
> Now, as I said, this is all a shot in the dark, and it might not help=
 at all
> with the hangs.  But it looks like something worth trying...
>=20
> --=20
>   "One disk to rule them all, One disk to find them. One disk to brin=
g
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh

--=20
Ville Syrj=E4l=E4
Intel OTC
