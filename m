Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D94AC148;
	Mon, 28 Sep 2026 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595484; cv=none; b=PyMccIJ+rdr5bQ+KibNvAiR/CNdDiQpcWXkjMITFGBRfECpXzf7Ck2X+2fJW8xpPYV2ylT/ZQz5KcqIlVWDClleG4bZvoVclB7kL6wa2DFuxhchB3pZS35rtrvd5jdOAbm/1iFd61jMpfWh7WnCnIg4XgQItRJDddabjJLVHzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595484; c=relaxed/simple;
	bh=kDnnlNBo405fAOSZLWH3+dQVJ15NauQramngbj35ue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im2ys5pellsMWJNu2NvN1K4OU5QH22HvTVUMH2DQ1CzzYems0iVje2+rYr677K6kaV76s6ylaAR3fb8Rc8h+UIpwqVZHbhKfpP5se1QWcUBK7lc+o4u7+KrgNfROW+uahUp9c+yC/mK4PxgO6/b5FmmhVP5skTXmjQZDF7WPCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI8o955V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI8o955V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3401F00893;
	Mon, 28 Sep 2026 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790595482;
	bh=+fRE7u7p7mgyA70gWyXTxX6WuH7haPMllhu9ppFM8hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BI8o955VGnKz57CAbn6tjOPweK5fhFvKW1c6CUE6J7BA1E1/zG3szqr7C6j9w+MZ9
	 IpiiZplkzI0dcBHLXrcOYxRHSnSkMKSw7Ryedx9FyxlV4NK22xZHJtvKteTwhs54Pc
	 N7RHb5miS1Osvbw0p/FK/wKTKnpbG/S+FxvC6p++LjQQXsGl1cu/IEUQ6eCUqiEQar
	 L15hOYdV7UycKff0YHY73LsVc4/2TmWcecrx5oyKrPZaOOtk9NtLfloSK6nPv3LWCj
	 Z7WBeuyudJAaVTUxgDA5srESVu8rCauCSljUXoFQUeJkNTsG/YD4xhpbRlHP2FifHE
	 SoyMHEqKm8+cQ==
Date: Mon, 28 Sep 2026 12:37:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH 0/6] Assorted fixes for icc-rpm
Message-ID: <d8f3da24-4ec8-4a88-bb7b-9df359b00ca2@sirena.org.uk>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <a4439f1d-6c2c-43ee-966c-239eaee148df@sirena.org.uk>
 <11500e01-a854-4d43-8964-a2456e319be7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iKrgofF5lHYfF49A"
Content-Disposition: inline
In-Reply-To: <11500e01-a854-4d43-8964-a2456e319be7@oss.qualcomm.com>
X-Cookie: All is fear in love and war.


--iKrgofF5lHYfF49A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 12:49:09PM +0200, Konrad Dybcio wrote:
> On 9/25/26 1:19 AM, Mark Brown wrote:

> > <4>[    3.147172] qcom-pcie 1c08000.pcie: supply vdda not found, using =
dummy regulator
> > <4>[    3.147292] qcom-pcie 1c08000.pcie: supply vddpe-3v3 not found, u=
sing dummy regulator
> > Format: Log Type - Time(microsec) - Message - Optional Info
> > Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic

> Strange, next-20260923 boots for me :/

The issue appears to have gone away today. =20

--iKrgofF5lHYfF49A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq6UZUACgkQJNaLcl1U
h9AXPwf/SUdTeoI4Zzm9kPwoGI7qUtQj1z1wGAkMG7EPue5dBSCMo6Vk2SSJwvc6
NOi0C8h86+XrFgdyJzFMiMj/YTD1Aac/AA9Lm/jkP54/ncW0/BZssOQjmkfXeQuW
1pJOrgxx7oWpxtqzjyuTktAn39+U7KBXUycYp0NiNhBk07iuLy0h28I7Wzm3/Wcc
FPbsaR6/q9ASsUOBL1YYnyQ5FIkEV6e7i/Qg+yABTiBPEA2fTTRwgzx6DaFIlDKg
6RCcWOOvBDM8/IU1w7ywQKB7MCyDmgNS+YtDOQlOnD2Bg7zoefZxFAugUvgj25TL
73lmxzVfWO0mtjk0vTJClokBN0sKuA==
=bny/
-----END PGP SIGNATURE-----

--iKrgofF5lHYfF49A--
