From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] cpufreq: enable ARM drivers on arm64
Date: Tue, 11 Mar 2014 12:53:51 +0000
Message-ID: <20140311125351.GQ28112@sirena.org.uk>
References: <1393208877-15797-1-git-send-email-broonie@kernel.org>
 <531F0115.4000109@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D/OsFc5Lho6vfD9M"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46007 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984AbaCKMyL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 08:54:11 -0400
Content-Disposition: inline
In-Reply-To: <531F0115.4000109@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--D/OsFc5Lho6vfD9M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 12:27:01PM +0000, Sudeep Holla wrote:

> Sorry for late response, looks like Rafael has pulled this change, but ...

> >+menu "Power management options"
> >+
> >+source "kernel/power/Kconfig"
> >+
> >+source "drivers/cpufreq/Kconfig"
> >+
> >+endmenu

> Is this patch based on recent kernels ? If so, either it should have caused
> conflicts or silently duplicated the entries. "Power management options" are
> already present.

Yes, it was against -next.  It looks like either the original patch had
the duplication or it crept in there during the rather lengthy time
between submission and acceptance.

> Also to be more consistent it with menu options, I would prefer this to be
> placed under "CPU Power Management" like CPUIdle.

I'll submit an incremental patch for this; in general the best thing to
do once things have been applied is to send a patch.

--D/OsFc5Lho6vfD9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHwdbAAoJELSic+t+oim9vBwP/jXa6MXNlq+2E5iUHN6HfcMC
wcUo4wPhIuthw9wqzK68ansYB/d8VBu0UkvRXQuyuL6iobIvAo8+nucxXgGOWVk1
t6W66GzmRy6WedWuH+T6HLa7D5InEKBqZ7hc5DwidOFU0Cv46b+GF1BP7sPJRmFK
sD5Adr9TyUx8tDcvNuHmgqhyAlcr37/KpbBhGgZrPJeOxNXRgLvSTsELjkmHaZPN
QKqcT537aoyHKybP+XrpQK51V0hQJNbtuonn3OdpAQsVCn0zYuIVANnOvXdn7rSk
fnpmCl1uenqfASql7q1GFXgIKD2YCRjMm94hCydmxi6q2eOuFgXdU+MlpHe2crR+
ANdolQu9ZebyCe+3Hm45IE/x2+9jSwFNi/NrJHzDaKbE+oyqeRoHbIh6AX/LziEo
kerSkRPdAYxSVd6Tbi1kT1aAcPb4DqugkJtWhPaJb+MbKjpffE2wqkEFt3NVAX+8
j62cTtpRe4thd05fS/f8RUdKGQBSB2AGNfMMJg1Th/PxwAYUlBwwn53jzuvsfoUW
d0nDtE9dFB00pUTbucwXDBxKNbhAki45D3G8GszS4iqjpZCDAU/O9YnweCRBpJAG
kJ26qTUQoH9TlFMLUa9YJl+rhckzl1kKOfZCzYhGZgW91IOjqou+j3szxtJxWHbp
fSfwFy4toC+id5Wslesk
=+VaA
-----END PGP SIGNATURE-----

--D/OsFc5Lho6vfD9M--
