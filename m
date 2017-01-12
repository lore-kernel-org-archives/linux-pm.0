From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Thu, 12 Jan 2017 15:03:42 -0500
Message-ID: <1484251422.23901.1.camel@redhat.com>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
         <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y51Y9FsWN1CmpTEhF6OH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdALUE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Jan 2017 15:04:29 -0500
In-Reply-To: <1484227624-6740-4-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, vincent.guittot@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>


--=-Y51Y9FsWN1CmpTEhF6OH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2017-01-12 at 21:27 +0800, Alex Shi wrote:
> Kernel or user may have special requirement on cpu response time,
> like
> if a interrupt is pinned to a cpu, we don't want the cpu goes too
> deep
> sleep. This patch can prevent this thing happen by consider per cpu
> resume_latency setting in cpu sleep state selection in menu governor.
>=20
> The pm_qos_resume_latency ask device to give reponse in this time.
> That's
> similar with cpu cstates' entry_latency + exit_latency. But since
> most of cpu cstate either has no entry_latency or add it into
> exit_latency
> So, we just can restrict this time requirement as states
> exit_latency.
>=20
> We can set a wanted latency value according to the value of
> /sys/devices/system/cpu/cpuX/cpuidle/stateX/latency. to just a bit
> less than related state's latency value. Then cpu can get to this
> state
> or higher.
>=20
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> To: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20

Acked-by: Rik van Riel <riel@redhat.com>

--=20
All rights reversed

--=-Y51Y9FsWN1CmpTEhF6OH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYd+EfAAoJEM553pKExN6DfI8H+gJQyhYI8IPZtErE4EmVMmHM
eivl4WThtUsSdw0B14Xy+KNoKpSBFPi8MZmEuR6pMWeO+GJZ20RHIYfrNci1O1qh
K/rjgmG5UI0z++XyGVV18ThRkssM+g7vOoCdi7ldKQiIGcmtGR8hFH2zVJ6lZMyN
JC9sDU++h9w6e16WDzaGiicNfqSrvfTHL5V9pMGuRAsj0OYKcM23v7CUuuWw09dV
tZ5CenWki0WHsbLd4QImK3Q/sS02/HSXqqQi3L6i2dHiqwmNq/UsG5m9PYVhAdH5
wkwNYTXjUpQ/5xF2CgYGi7HMHMyQjfYtfH/vKGcJ6V63fwSfuVFqNC6w4Yf1uF0=
=Wv46
-----END PGP SIGNATURE-----

--=-Y51Y9FsWN1CmpTEhF6OH--

