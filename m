From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 0/2] thermal: power allocator: add new divvy-up
 algorithm
Date: Tue, 23 May 2017 20:24:11 -0700
Message-ID: <20170524032409.GA2548@localhost.localdomain>
References: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36188 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965498AbdEXDYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 23:24:15 -0400
Received: by mail-pf0-f182.google.com with SMTP id m17so132179861pfg.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 20:24:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494575248-4166-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 08:47:26AM +0100, Lukasz Luba wrote:
> Hi,
>=20
> This patch set introduces a new algorithm in IPA.
> It distributes the power in different way.
> In first phase the spare power is splited between the same
> type of deveices. In the next phase the rest of the power
> is split among all other devices.
> More detailed description can be found in first patch.
> Second patch adds trace to the algorithm.


Cool! Sorry for the late answer, but can you please provide some sort of
expected improvement here? From a power/thermal perspective?

>=20
> Patch set is based on v4.11.
>=20
> Changes:
> v3
> - trace function call moved to second patch
> v2
> - change division to div_u64()
>=20
> Regards,
> Lukasz Luba
>=20
> Lukasz Luba (2):
>   thermal: IPA: add new divvy-up algorithm
>   trace: power allocator: add trace for divvyup algorithm
>=20
>  drivers/thermal/power_allocator.c              | 179 +++++++++++++++++++=
++----
>  include/trace/events/thermal_power_allocator.h |  40 ++++++
>  2 files changed, 195 insertions(+), 24 deletions(-)
>=20
> --=20
> 1.9.1
>=20

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJPzQAAoJEA6VkvSQfF5TJBcP/3yio6yXYXIYaDhXTJCdPnyL
rKh93cksdPYYtimu+v4XUlxvJ5g3SVXRnPU3dMWijAgJL0L63Z1jJh3yMUIBj5Xd
VmNtUqKeYPhUWz+hwZ4YR9zsajcPwYF+m2BU1PIAqRCFKjRfr1hM3iehrFzO8xoK
xOlEOqKHeztK7tsYZi5Jglg6ixnwoQW18DGZDvRrU5SYX24+BMlhxiIAbD8U/NpZ
ce1XAIorcsF2w3+hys33O0YAQz0wspcNbX28EW2am8yPO/3pQogAGZRgC5ZidQnq
I14j9UOUWsOV6PilNFtfEFVO6RVtu+90zMESCapUp8AfHmAEUX2kX36GNzifcRQr
bmwP0KdECOq5FMtP5eew1lt1xukh6EfFuY6iB8VHkljNTMgfMUUqPmi869zAqNWa
p+CyNIqasTB8jXAV6KLeWrOUe65sppoTW8M2j3jbuZHo1L+EI7f0J0nA+3ddSXlD
WmJzcUxpEEsNhLJCaDGetrqtScj4jSRpXPTmme0rk+WvWUENj444DVzxXmpWpI4e
1GaBYxnYxIA35+c+L9ipfL/N8m4N929UDkdD3VgorAx6w8Gv1JEUl9I5esY71Tm5
8dF2vYwSsEQT2lD19W0itcgf0wZZf+nyb1SjWI3K52zRvkAOQ6XTENJKKkNb2q50
qqchTSyygUfifEzxMQ6N
=j87a
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
