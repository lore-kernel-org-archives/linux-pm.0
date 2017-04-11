From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 03/17] thermal: cpu_cooling: Replace cpufreq_device with
 cpufreq_dev
Date: Tue, 11 Apr 2017 10:33:31 -0700
Message-ID: <20170411173330.GA5528@localhost.localdomain>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
 <1ebaf8113e79154e9b8e7696c4e1c70791d26e14.1489640000.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35549 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdDKRdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 13:33:35 -0400
Content-Disposition: inline
In-Reply-To: <1ebaf8113e79154e9b8e7696c4e1c70791d26e14.1489640000.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 10:59:38AM +0530, Viresh Kumar wrote:
> Objects of "struct cpufreq_cooling_device" are named a bit
> inconsistently. Lets use cpufreq_dev everywhere.
>=20

Naming is always a matter of taste.. but I frankly cannot see how this
patch improves anything here. cpufreq_dev is still misleading.

Here other options:
 cpufreq_cooling_dev: not misleading but, may a bit too long..
 cpufreq_cdev: better, but still, not a char dev

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7RNhAAoJEA6VkvSQfF5TIJIQAMcGvZkYWKi5OBDgE//4WWrJ
u9kU5E8kbVmreDhmTsY6ACHNWVM3zi+danjPxhWIu9bfYhYQz3nWw8EtsSmjWqHr
U1itxTBxbdG92gNoamUiDBN5YB+S+lPHQ+HqukgQ3CLZIZqNhgGpfgtOUNoIPAsI
QPkeieDu6Rc+CZHUzTFb4FlXJxDKgWWnkGpOiY5xnKrCpB0gtH6g+h+wSXrg+BpL
yPhHfThfuODAlRyPwkzWLaT0qxmwCHS06VeU2OQqmiry2taDqfse9lfL9FbFa24J
k5jjD+/gUg8Ntywe0Ad2ztmGajp7JL89gI0ZZtOEXes3jjgO7CnWZbymmoS8ON5D
5GlFwLsD6meJzdevjOQHBnvEnS2FaYDN/6Xo4bYjGvzH5BqLIm0o9XzOvhKzqs+S
WyRYe007SfuI/mIoxLxAv9i6WSc+ipWOEe8v9810w8HLxMMntQZiFCaooTkOEzlz
1HyvVzWMD9W1fedBeUePkiNJNLA/QRMO0kUJ8eF5WZTZxzzX93hELLxQViqVrHIZ
E6g4LaCYbGqz6DyP7LZIy/XgmsSnlP0keQuwAFXhFHIIxRfZ47OaXL5FW4wrlAeL
lh686cnD2ivrF8StghTgCDvqjVxp7eGbBnrx7RpESsaRMJDTwpud2cHqJM7pzewC
MhKFt8WhKbRUfQBCS8Ar
=SyFO
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
