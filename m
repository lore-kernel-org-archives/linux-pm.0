Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10EC76026;
	Sat, 31 Jan 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769872028; cv=none; b=ZKzUTSGSWZ+Hvgi+tgBJb/iNCk/Bfi/TGf146p9Zqh209RJbn16tIW4n5v06syrMmNKTwn9ZJj4FCAKXubV1xDX6gsx8LZ4hgKTpiH35LU0ldnFuxP92APCxS/n8dOHNyWZInZ75PBLGfX3X0QhN8X28zLaDbSlTLBVEqKK3CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769872028; c=relaxed/simple;
	bh=m4ZHaiDKsZInmlYkHLTCkez4gr8tSzASeFxCTaESUC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOl1LIeAjX8EvlS5ZHxYX9Cmwd7uJbMsN8tjMlQJ75OjfQIxubogiZs/2SqYxnrrxu4Pr1ldR+j2UhmGljCI+f6MTcaueLltf90KlKSQwnFg7B1FQScTQQKGnVZq1E+p7b4R/C0nKDpcJxQdJJpAIRWk+kzcofDwFoSeyqqG79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adpZlQ21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adpZlQ21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077DFC4CEF1;
	Sat, 31 Jan 2026 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769872028;
	bh=m4ZHaiDKsZInmlYkHLTCkez4gr8tSzASeFxCTaESUC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adpZlQ21t7enHkdpnYyR5rIJ/nh5hhuxRB1S/aC9RmQ5s0GbQp/+gnqgCZbUVtXar
	 zNY1W7vivRjC+lePrzZweY10g6p5NUnFGT5z2cMCeNYy84SV6kPHv/iRGV3SXIuSPr
	 2wJ/mlMD6tbyTu468msMnZ9MzYZBOyexh4lh4GvsTJQ0kICUc7sVeIcEG8g6HXuhyg
	 fSdzP81wgQQht0mq7Uro8RTLukmDT77coCiXLv+svDWwAIlJFMnQUGqlk/w9gPSr2F
	 nF5mnJU5IauIXTGgXVNrAspZqTileedUb3hgm/Si1Ag25xgWbKr6RDl8wDiQ5pmLrh
	 Z3jjckuCQucvQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 61B4E1AC52C4; Sat, 31 Jan 2026 15:07:04 +0000 (GMT)
Date: Sat, 31 Jan 2026 15:07:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aishwarya TCV <Aiswarya.TCV@arm.com>
Subject: Re: [PATCH] thermal/drivers/qcom/lmh: Remove spurious IRQF_ONESHOT
Message-ID: <aX4amIuUFUtv7M2J@sirena.co.uk>
References: <20260130-thermal-lmh-oneshot-v1-1-9b132204ef1b@kernel.org>
 <md3ohsrso7hldhhlqwsky4rc7yf4uvpugyctvpge3emfc5xgsl@flei5hr3fxw5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iB8/nrYcm2WVfPQD"
Content-Disposition: inline
In-Reply-To: <md3ohsrso7hldhhlqwsky4rc7yf4uvpugyctvpge3emfc5xgsl@flei5hr3fxw5>
X-Cookie: Think big.  Pollute the Mississippi.


--iB8/nrYcm2WVfPQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 31, 2026 at 08:59:03AM +0200, Dmitry Baryshkov wrote:
> On Fri, Jan 30, 2026 at 04:54:45PM +0000, Mark Brown wrote:

> > This warning is there because IRQF_ONESHOT is only meaningful when there is
> > a threaded interrupt handler and this driver does not register one. Just
> > remove IRQF_ONESHOT, it wasn't doing anything.

> I think it might be not that easy. The IRQ is level-triggered, with the
> IRQ source (if I'm not mistaken) cointinuing to be high level while CPU
> is overheated. By removing this IRQF_ONESHOT we might get an IRQ storm.

See the commit log for aef30c8d569c ("genirq: Warn about using
IRQF_ONESHOT without a threaded handler"), and note that a oneshot
interrupt will be unmasked if the main handler directly handles it and
returns IRQ_HANDLED instead of waking the thread with IRQ_WAKE_THREAD.
The handler in this driver unconditionally returns IRQ_HANDLED.

The above sounds like the interrupt needs to be edge triggered?

--iB8/nrYcm2WVfPQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAml+GpcACgkQJNaLcl1U
h9AA3Af+NZCzcDh2uprkeaQp7NNnLIY3Lug6c1HJIbDwVvucgAwODX+D5h2wmqFn
HlYRG5Jbizvk2rcc4T3azXHT9cMwEZysAm2bqh9T9DiwuFgr6UGLi9yb1HfLS4JF
/+ewKB9Iba+I7E+SQo+d+U2JtvdpPk0FMe1pnYxAD4JSQmh/jfqBjW/+f6XFOvc+
Hy+sEEDglZHla7oQIg2Y1ytiRuFLy6eqyIxHwkIVaOz/wPNVCD866VpMJHjtT4NP
fhfr+2mKdKheFh0GKrRzGQxusdEXpq8hF6vZFU1RsjBZcYCVLIB907xPZiyKowP4
pNtNIAvJizIigg5vqq8mHNwQZWRVlQ==
=jtup
-----END PGP SIGNATURE-----

--iB8/nrYcm2WVfPQD--
