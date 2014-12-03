From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 24/26] cpu_cooling: Store frequencies in descending order
Date: Wed, 3 Dec 2014 09:41:59 -0400
Message-ID: <20141203134157.GB4325@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
 <20141202232128.GA3645@developer>
 <CAKohpo=ew8wUeJ4Mf567BNP70AS8uHDWmBEFzL4Uo_ze0UtJ+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35021 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbaLCNmI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 08:42:08 -0500
Received: by mail-qg0-f43.google.com with SMTP id q108so10801609qgd.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 05:42:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpo=ew8wUeJ4Mf567BNP70AS8uHDWmBEFzL4Uo_ze0UtJ+A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 10:22:30AM +0530, Viresh Kumar wrote:
> On 3 December 2014 at 04:51, Eduardo Valentin <edubezval@gmail.com> wrote:
>=20
> >> +static unsigned int find_next_max(struct cpufreq_frequency_table *tab=
le,
> >> +                               unsigned int prev_max)
> >> +{
> >> +     struct cpufreq_frequency_table *pos;
> >> +     unsigned int max =3D 0;
> >> +
> >> +     cpufreq_for_each_valid_entry(pos, table) {
> >> +             if (pos->frequency > max && pos->frequency < prev_max)
> >
> > What happens if, for some random reason, the cpufreq table is in
> > ascending order and this function is called with prev_max =3D=3D (unsig=
ned
> > int) -1 ? What would be the returned max?
>=20
> The last frequency of the table, i.e. the max value. What bug did you cat=
ch,
> that I am not able to see..

Well, passing -1 to unsigned int will make it max unsigned int, your
function will return the first freq, which in the scenario I gave, it
would be the min freq, not the first max, right?


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfxMdAAoJEMLUO4d9pOJWmfQIAJIbVyR327gSadwqwukvE0Ne
tAWWlTOEowdA5TELLdsLgk64stfv4h9cJ5+klzd8n/JQAG8xKwFdyi0cWFO4bxCr
Y0agE1h50pIATjsG7pB0cAD2tx2r7JaFCsYOE5Xl1bUv6T1YHux5njv/H0U4D8cQ
bONnDx71/oseg5LNWA9IKYv7KbNNsbf5uAPKTvVHMJEFPPknkS+wfHXtHWYBCwRm
wIg0nXWE8mRls/eMgvSHYKPvMgZu5JaJF7AMhC9B40BEsX72/KrfQhgCFu8q+fSg
1FgPGrHhc4YpXb7eGKDiOwyVjGXlMMTd10H5lGy3TsUW3ot5JO39qt9g+YkzeSc=
=eLHl
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
