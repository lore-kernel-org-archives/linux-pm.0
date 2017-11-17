From: James Hogan <james.hogan@mips.com>
Subject: Re: [PATCH] cpufreq: Add Loongson machine dependencies
Date: Fri, 17 Nov 2017 09:37:10 +0000
Message-ID: <20171117093710.GB27368@jhogan-linux.mipstec.com>
References: <20171115211755.25102-1-james.hogan@mips.com>
 <CAAhV-H5Bhwxtec7cZKuov2i1F1mHaPHPOV0cD4ZZzWMJVkD1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:45352 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdKQJhg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Nov 2017 04:37:36 -0500
Content-Disposition: inline
In-Reply-To: <CAAhV-H5Bhwxtec7cZKuov2i1F1mHaPHPOV0cD4ZZzWMJVkD1Zw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huacai Chen <chenhuacai@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Huacai

On Fri, Nov 17, 2017 at 12:37:30PM +0800, Huacai Chen wrote:
> I think it is better to make LOONGSON1_CPUFREQ depends on
> CPU_LOONGSON1, and LOONGSON2_CPUFREQ depends on CPU_LOONGSON2

Yes, that may well be preferable, however as stated below both drivers
have stricter dependencies than that which break the build for certain
configurations:

> On Thu, Nov 16, 2017 at 5:17 AM, James Hogan <james.hogan@mips.com> wrote:
> > More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
> > neither of which is defined in asm/mach-loongson32/regs-clk.h unless
> > CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
> > loongson2_clockmod_table[], which is only defined in
> > arch/mips/loongson64/lemote-2f/clock.c, i.e. when
> > CONFIG_LEMOTE_MACH2F=y.

If those issues are fixed such that the drivers build on any respective
loongson1 / loongson2 configuration then the dependencies can always be
updated again to reflect that.

Cheers
James

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloOrb0ACgkQbAtpk944
dnrjVA//fKmSzwAE6mZE712mk2kRI/9EXptpipRyZhheDfd551tgxf78zP2c/U0c
GBfoW9giX9wYfpnr5ku9jmE4sXmkUANlwSRJbOXHWwNKSQK1uhPV3uqeB8Z6fBl8
q3zMW37QlSQJU/ISG4pYyud/0PSgE6NS1mqfa9o4FmkFlgtrYJn6ouEKRHBIRWAx
65FaQtWUPq0y/tBR6K61dj6pLvoI1koZyZftJ4AIY7ptRZkve0niId6vIopw5Mk1
Z7tWt21VTrNH56F+jk9UKYnlAIPKX2PdmWAKNVwDNlVliKqD5fciiJKtF0L0CaBk
pG8cEdjtOY1//ObJd2zFy5l1zJ9mfWg1sIkHpzJdhB9UqvKSV8MET5nfeqjKbCsS
1mcvjckVPLbbgfRrVwLidRF3Ik7NtJHBDa8w597y7D577hIY+RIcK5RPSa1zKqxW
lta3InF84KVe1rnipdALe7Z8WZiuE5ZtCZmXbN0hrCEBDIqSDG+tYshGJshAXS95
QndCXnGp6MKx5o09JCu9VBpCT9cQqQlswrJHqC92Gmh16wJFisMDtTUkwN3WVGTh
0IC8TADj5Kk2O3o89nDVYXaCB1/I874gl5ZE0ZRY+phhAe+GcfL4K+l7dX1H/NfM
iFz/+qWeWE46MSk/a79w1SqRYxfHRJyEClVE5hdUk7oKbi4lSAA=
=IqZA
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
