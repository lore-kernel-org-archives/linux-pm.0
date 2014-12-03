From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 19/26] cpu_cooling: find max level during device
 registration
Date: Wed, 3 Dec 2014 09:40:10 -0400
Message-ID: <20141203134008.GA4325@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <e2cb864949d833ab30c24b2bf039c682c8820040.1417167599.git.viresh.kumar@linaro.org>
 <20141202233936.GB3969@developer>
 <CAKohpomo_kqvubwoJ2BUnOvAmCk8XgnP_5x-ws55G0Uf_F1OnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:34893 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaLCNkT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 08:40:19 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so12483475qcw.9
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 05:40:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohpomo_kqvubwoJ2BUnOvAmCk8XgnP_5x-ws55G0Uf_F1OnA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 10:27:43AM +0530, Viresh Kumar wrote:
> On 3 December 2014 at 05:09, Eduardo Valentin <edubezval@gmail.com> wrote:
> > Could you please update me regarding the story behind the opp del patch
> > set?
> >
> > http://permalink.gmane.org/gmane.linux.power-management.general/53348
>=20
> Its merged by Rafael, should be in next now.

OK. Good. But does it mean we can remove OPPs after cpufreq
registration? Meaning, is the cpufreq table changing over time?


BR,

Eduardo Valentin


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfxKvAAoJEMLUO4d9pOJWluIH/10eCCOTYUOsquMD1bbPlOEU
1nZXdSrcdXwndmtbUhIe941R1ykPaeod0UbRj4lVH9o4DzqiIbqWLx0U7Shz4HX8
Embvwj5wbQX1c8dEQ1GzHK9qJgS9F+Esbi/HXoNjOGoKSNEj4J07CgU/osuLwlf1
SST6VDh8b/M1H84Y7XfwfZKud85NEWhvc7/xId7x7gysT04dFzwMUPsd7HN6rmTh
+mfEQX5tvVzoyzJelOsnDYAhk3wNSYoBq35Fyo8y2ZKrxomUGoKv5Wel3lyonBGP
6QFc+jDv+UFyjQqTpRPFRgoHORI4bDid3BKGYihMb7Mlzx+zZmpCd0sdgbwId+M=
=eG4z
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
