From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] tps65090-charger: Fix module autoload for OF platform
 driver
Date: Tue, 22 Sep 2015 17:17:40 +0200
Message-ID: <20150922151740.GE2533@earth>
References: <20150918165407.GA27491@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44176 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757964AbbIVPRo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:17:44 -0400
Content-Disposition: inline
In-Reply-To: <20150918165407.GA27491@goodgumbo.baconseed.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Sep 18, 2015 at 06:54:07PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.

Thanks, queued.

-- Sebastian

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXEUAAoJENju1/PIO/qaVW0P/jw+yW0HN8P9k3elxHA3ijCD
gN9bpu1u1ZWh0dzKwBe7ILE/ku4XREbaOd6Xe7iqx5gr12vAwDTlG99wP5rbWh5H
jIIHYITTjn8DkjWvD5fasJASrmGz76LXjUajZy0QJSDKe4VUAuK7siAMUgSSkRWB
J27GlYokfJxbXNcJPHtZlSl2O8oGaea2/PXV2L4+p9aWOphtCut6LHdasZHlMpgg
2kJF+q1uCL4rnq8JFNLq0llmhHTW32m6lxAG5T8R5h7q2+yGCUd4/E9hcu1e6Ft6
NiGNqrkLLQBmgg99OmPwVN+9yzasJIN9mSoJ/ssOs5QYyYIhnE2ah/LhRvzxUbOl
Td7Yy7rbxguaXyjdCMRZtDndPRJ+2VlizyeF+20bVq+bEMsHP6IIElJxoocYD2s6
0xIqOe5/6hRhMc82HRDSnw9e8gt3/D3wUDCiKdgUwBapF/+Ytfa3vG3aGcK97A0A
IQULFDA9l7DO7hwe7RSDP9Peu/c/zQGYKVMR7Nb4dvBDk5QwcC9St3TT0/WpBakG
tkkviaoJJutTzcMns2ik320kJNGHJvnbwbqOYR8BB8P0KnzgSBbGW+huz1eIEfBv
p+9c6fnhuJHmmRK8pie5WMQKSFz/PiMHZYEHKTJ8eY7HTz+RSzSJepTwGDAWUzeE
iA+RMIOamQzoM3swBodZ
=RI8r
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
