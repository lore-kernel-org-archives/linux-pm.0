From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] power/reset: zx: Register restart handler
Date: Fri, 24 Jul 2015 17:30:58 +0200
Message-ID: <20150724153058.GJ27569@earth>
References: <1436930758-19140-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Do4IU1xF/9sod/r6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37216 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbbGXPbB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:31:01 -0400
Content-Disposition: inline
In-Reply-To: <1436930758-19140-1-git-send-email-jun.nie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: haojian.zhuang@linaro.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, jason.liu@linaro.org


--Do4IU1xF/9sod/r6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 15, 2015 at 11:25:58AM +0800, Jun Nie wrote:
> Register with kernel restart handler instead of setting arm_pm_restart
> directly.

Thanks, queued.

-- Sebastian

--Do4IU1xF/9sod/r6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsloxAAoJENju1/PIO/qa4tYP/RPPvhmy7/WoSk3wVJE1Zcv5
CDWKSoGD+SyK3EcRy+JKcrVcRvgmiP17SiZ9Wvoj5GWZ83QdPCVHX/Bl9bx+Tec8
8ivrveOzYRIXq+Y9CQd+CM2UxrsXXxn+SILBkfIP9OsATIEklSoCo97jIIteodde
YG3bWGtx0U6Hgz1W0jDzd1Z14PF2cNpyfzaGAa3T12s2rrPdb2BvHJDMAtP1rZpl
scdOHk1liyCpxVuwg0PEkWG8+L3WzQ2ez9w8dEavJevi18f4SY7w9LmMajTSLZst
AUWbdb+auHtL/UEIUhhvlBxNFXy8j46sNCRyeNYkuPEO9C3iioIUNWLV21P5A8Hm
JXeA4JL4h4S/wx2Sm6ZErhR8vCwJ6EhOeszVhb2yOTfiyxnWVRTBVNg/ke5K4qf2
Xsiz2NcFc9Yx73bqk02zP18hTRqdYpevC4phyqXe1GM4U547/y+wWNsW1hleuxVi
p/y6t/Um+7kPcNW7V7/J0LS4rJac4d1BECknEN/UkfCmZ/Fbu1FTDuPRqBUZULf9
tABsagFsu7IAXmy6efFv5pDapif988K3ONgq6BcxDpZxyNDnRr7PcEeDER1T2sey
rnfFMBNh3FQ26MGBQoITIu4/gYZAIVJIaY+Dz6Vsl13/S1cgew+slsMLuYaDlk8O
eNZPAPjKdUM+V87JSwsm
=7ueE
-----END PGP SIGNATURE-----

--Do4IU1xF/9sod/r6--
