Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A191D5CFE;
	Thu, 30 Jul 2026 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450977; cv=none; b=F9g93JkZVfWy3UFzZpVN0zUHuvClyBlW93+MRts9fyX8AiS61bWxWHoukCmAjAwYej3N6Kmua+0vZEPSSPrv47ycZihK9FapWueGH+Egp07+Nmq1gzGx/FoqmaR/r+mAhKW4zl4LeUwQPp7bupn6dH+UgRImvE5KeunC8sKaziY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450977; c=relaxed/simple;
	bh=WOslJGLRgjwyAb3zyQvRKJVopXPbFxz/89CCXnc0miM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MYisWW2HE9B1upewjcI82OOZ9wvQJkUoxDtEVCNxIN1dWk1Wv3AtUBhk3Bz6IWekJrDSRroDDi7Grh+UvTcr8c+VIw4zO75uVZyEsze7uIDGG3+wnMKGufNUAeLjGqEEY7ckhcHCvg8laIsn2efwjDMJh320jKhnMZc9j/gQKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLSy1FuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLSy1FuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098771F000E9;
	Thu, 30 Jul 2026 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785450976;
	bh=odnsOAZzm5u5Wq1NnmtjrdZfMAHJQl58DgIGih+mmws=;
	h=Date:From:To:Cc:Subject;
	b=JLSy1FuZL0ybX4+vQb9egIz7ru7tlaRYOJxhI9Le5KWXM814fBV8ZXBXDhlI3vxK+
	 XnuIe+faZvaCd9NjPThsU1YOCQjjlXj4ROoGzODgx/BthD3DQC04GA+RZieoSsmjim
	 0EyjERpfQe0w4td8/mRa0nVLTPk++OGv4x2a+1LIrl/weRv8CGnacWyud0/C0MQtoN
	 l5PAs/P71ULp1h8tYA7zmf5AuGgE4MzI1PyhMZtkbH2ozQWuo9DBipwVGX+qfsl1br
	 XN4FNUCklVQDBv6LbT7d4TjZJ7WxVdXYYqoo/jseC/AYi9onAdIM0E66W9MCicVoLN
	 s1sTrHp7L1nzg==
Received: by venus (Postfix, from userid 1000)
	id 74FAC1805FF; Fri, 31 Jul 2026 00:36:14 +0200 (CEST)
Date: Fri, 31 Jul 2026 00:36:14 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.2-rc
Message-ID: <amvRQlU7ArDfz5yc@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlqmjsozn4r7nsyk"
Content-Disposition: inline


--zlqmjsozn4r7nsyk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply changes for 7.2-rc
MIME-Version: 1.0

Hi Linus,

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.2-rc

for you to fetch changes up to 160a783aa65b74782bc17cb874af1a6d3f5fba3c:

  power: supply: bq25890: fix the -10 C NTC lookup entry (2026-07-23 17:07:24 +0200)

----------------------------------------------------------------
Power Supply Fixes for 7.2 cycle

* Documentation build fix for bd71828
* max17040: handle missing status supplier
* macsmc: Support macOS 27 SMC firmware
* bq25890: fix the -10 C NTC lookup entry

----------------------------------------------------------------
Jianing Li (1):
      power: supply: max17040: handle missing status supplier

Randy Dunlap (1):
      power: supply: bd71828: add a terminating table border

Sasha Finkelstein (1):
      power: supply: macsmc: Support macOS 27 SMC firmware

Xu Rao (1):
      power: supply: bq25890: fix the -10 C NTC lookup entry

 .../ABI/testing/sysfs-class-power-bd71828          |  1 +
 drivers/power/supply/bq25890_charger.c             |  2 +-
 drivers/power/supply/macsmc-power.c                | 52 +++++++++++++++++++---
 drivers/power/supply/max17040_battery.c            |  6 ++-
 4 files changed, 52 insertions(+), 9 deletions(-)

--zlqmjsozn4r7nsyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpr0d4ACgkQ2O7X88g7
+poaRw//XzoVqGWbE5ZQ1OgO336hAtlV/5W7ZFct0iHMDA+9BN+1Ag4iJW+a5Grg
SA+e2xZkGLyYXXgY4fJ12cgdCFpb8Rj5cVXdYdDLkfIpn2ilmqAQp1IhnEaC3R+m
nRMw2gfo5FVWesSOnNG6FQ2aCnwTHWXELmIJZvhgP7o9xFl5/zPupe+cKmsGWOle
df+K/gbjhjZULkj8D7INniCXWcMvk8sSqRHjBHfiPU/SgR1SHAWvhNiUqK5lW9lV
c5BFrc41oOSOXu4KV5fL8t98CauPDY6A333WI3nBZpeFAJoajHWBCvw4kwzvmwPw
JgUwqT3LiZVeWGS+TOwNtnFEh4TVAPkFB+dYuY3gl/R8WWNeMxOqgLUMTaisCjv2
3lMV2WB97KGpkS5bsLPZNmfpGkLXqYIcbfnf9FVYzeJfcukpFqNN8LR6xFOtZ/oo
TrqFXHMWxb6FZUKOhUtZ6w33nO4GLW9Rb9z1YG7TgW+SLumJI1Sj1CVphs48lrus
bqsoQnJR0UYZITaMSjM8Kz7Yl/mAeBACWC7NOtF3Ll8hiyc+uFj5zMJ9uCDBver9
H1LhgZhaEjyLA6OZDIDrd1R3d+P+rSFtsyW/we5I6zXj6+hWletvzNr7hfIbj6mI
0w4IhskqdKNoB2CnFWN2lFVT7kTi7IsOB60VQvJL5bXNC/eNV/8=
=Oe4K
-----END PGP SIGNATURE-----

--zlqmjsozn4r7nsyk--
