Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21C41E6C5;
	Thu, 24 Sep 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790291973; cv=none; b=pDTHu6CVd5mrRVLrC0uEAIq5cLzsANFc5/5WIED/AxveJzAxsa6rHC5i+P1d07BYXSSno8LAQESJm0i6swtbk49uDSswgzguIVllSK40dDhxuGbXIfVYLjCESCDXptHCs3ANyfgQHoV4gFiGbDLMIFYP8nelDIRmyUavOixkW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790291973; c=relaxed/simple;
	bh=VUYEEE3HevbpBaBEh98rRlQ6afkhGNAfaMMbUMmhrRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH8Jcq44S98dbzhcBMJNCmYN0/xmMdE93XJe4VfYmiOq4MYgNed1JS4cTFNkECX0o5NKSHZLYaDKb9gP2WaUQRDfu0XNPCrXjVTYwIZYcov2QSYLecSf2luvlzlZcgaEWUKwMNCs62ZBFOUPrt2qucdWKBKOuCqNO/PX7XBIWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx/LMMZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx/LMMZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB38A1F00893;
	Thu, 24 Sep 2026 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790291971;
	bh=58txGiUYq2o3vDEpNYOXBhgESMZOWm8Yh5OzD7flxWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hx/LMMZpDqXxSUq4Ps9iyk/DvO84jO7vrOHI7QGUK0/3u+qPYj1fbPk9HjocHzPHa
	 GCQC6ftH+HYwS0E14C4lXK/gFIJ0IOrqW/rXyaU/R82RSjd7GeMYDIDC2/0hVPr7y3
	 Iqoef6j89dA8muGvk1Uxzy/QDWLV03WptSO0Osu0LIcepbOHLuXvEYsT7vGrX7vwZL
	 gg/L8HvHjoQHYvISgobMg/RwBVEYfFsRFDyn8CAjzpWdKxq2TpbkhgMzPtLEGtODf/
	 WpdA+ESbaem7uXhuKp+jX1oFk09qjjE6Zj1u8x8A+ujPSJ9xzrP0Z5kqf6F7J9rn1B
	 coSq3UH3GMp2w==
Date: Fri, 25 Sep 2026 00:19:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH 0/6] Assorted fixes for icc-rpm
Message-ID: <a4439f1d-6c2c-43ee-966c-239eaee148df@sirena.org.uk>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="viEvHksDB/4cQVa2"
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
X-Cookie: A grammarian's life is always in tense.


--viEvHksDB/4cQVa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2026 at 06:41:53PM +0200, Konrad Dybcio wrote:
> This series brings multi-port QoS programming and squashes some
> minor existing issues. No dependencies.

Something about this series seems to break network boot on db845c, the
system comes up but the USB and network never appears and eventually the
board reboots (I guess a watchdog?):

<6>[    3.127987] Trying to probe devices needed for running init ...
<4>[    3.131178] qcom-pcie 1c00000.pcie: supply vdda not found, using dummy regulator
<4>[    3.133600] qcom-pcie 1c08000.pcie: supply vdda not found, using dummy regulator
<4>[    3.133765] qcom-pcie 1c08000.pcie: supply vddpe-3v3 not found, using dummy regulator
<4>[    3.145996] qcom-pcie 1c00000.pcie: supply vdda not found, using dummy regulator
<4>[    3.147172] qcom-pcie 1c08000.pcie: supply vdda not found, using dummy regulator
<4>[    3.147292] qcom-pcie 1c08000.pcie: supply vddpe-3v3 not found, using dummy regulator
Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic

bisect log seems to coverge fairly nicely, but only on the merge commit
unfortunately:

git bisect start
# status: waiting for both good and bad commits
# good: [93f51579e7df248780214094418f205253383cc5] Linux 7.3-rc4
git bisect good 93f51579e7df248780214094418f205253383cc5
# status: waiting for bad commit, 1 good commit known
# bad: [3d7783543c2646af69ad65825e810060494bea21] Add linux-next specific files for 20260923
git bisect bad 3d7783543c2646af69ad65825e810060494bea21
# skip: [f5c66cf1cc3d0412aae3a79defe24f2558fd3796] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect skip f5c66cf1cc3d0412aae3a79defe24f2558fd3796
# good: [f5c66cf1cc3d0412aae3a79defe24f2558fd3796] Merge branch 'main' of https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good f5c66cf1cc3d0412aae3a79defe24f2558fd3796
# good: [25bd2398be78da6f80b39de910027470b29617ae] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git bisect good 25bd2398be78da6f80b39de910027470b29617ae
# good: [294dea4858e9113fd11d22a1b8cbf1e8c0aa7876] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect good 294dea4858e9113fd11d22a1b8cbf1e8c0aa7876
# bad: [23c47f595e5eb361f426eb541d56fd2cdb96b30f] Merge branch 'staging-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect bad 23c47f595e5eb361f426eb541d56fd2cdb96b30f
# bad: [ffa9e57e6ed0b967209bf65aad8d834fe2103e1d] Merge branch 'icc-next' of https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
git bisect bad ffa9e57e6ed0b967209bf65aad8d834fe2103e1d
# good: [ade03fa0fb64ac61c6eb1b409baa2c2f710c27d8] Merge branch 'driver-core-next' of https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
git bisect good ade03fa0fb64ac61c6eb1b409baa2c2f710c27d8
# good: [bbed88f72dbbb960080282de3b90ca0933fa6226] usb: dwc2: fix typos in comments
git bisect good bbed88f72dbbb960080282de3b90ca0933fa6226
# good: [f9b0809c23123401290e3a144d231aa40fff692e] Merge branch 'char-misc-next' of https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
git bisect good f9b0809c23123401290e3a144d231aa40fff692e
# bad: [07bf225c62c00b9b934b9125e78e2208b961d9c3] Merge branch 'icc-rpm' into icc-next
git bisect bad 07bf225c62c00b9b934b9125e78e2208b961d9c3
# good: [041e725a102fbf3a4e484e28abe66575bc515888] Merge branch 'icc-milos' into icc-next
git bisect good 041e725a102fbf3a4e484e28abe66575bc515888
# good: [ddbacca26d1db5bd9c477253b0af83b028136a24] interconnect: qcom: icc-rpm: Program SMD RPM auxiliary QoS ports
git bisect good ddbacca26d1db5bd9c477253b0af83b028136a24
# good: [cc91c1b99101f2dcd2f624a27bec6f6f557e5421] interconnect: qcom: msm8976: Configure auxiliary GPU QoS port
git bisect good cc91c1b99101f2dcd2f624a27bec6f6f557e5421
# good: [24e7422ce31189502d07279c083646aaca513311] interconnect: qcom: use 64-bit SMD RPM bus votes
git bisect good 24e7422ce31189502d07279c083646aaca513311
# first bad commit: [07bf225c62c00b9b934b9125e78e2208b961d9c3] Merge branch 'icc-rpm' into icc-next

--viEvHksDB/4cQVa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1r/4ACgkQJNaLcl1U
h9Dh9gf/eGI/sxImujr0Sy/J0ViycI4sDeeZsyoN/+XpufUAbGSqYfgGWcEzcw8N
Fy4s0lr6rGF5wusBlBbSubkJt/AJL4wbA4WnMMrYJzkt0SPby3CBp+5yYV+dk8NP
shNeo4vgPVdESbC/vbYab91uhni3HPNWQq5HE7xsXQEUfHXc2m0DuzNUwffJCJ0X
Ym+jsciOCK9VvC1T0AY+kaHlcPf34PMovWi0+8uweLZFn2u/6jrPUMfuFDsR/Pll
Anr09x/LsxBjteZ9lpUMyvyFD/uwlZviNDO8EcIviqHf4oiFpnteLleyq/Fsnals
vdtIk/VJB+lpGOd8yaGqSQs2Whw93w==
=2+KG
-----END PGP SIGNATURE-----

--viEvHksDB/4cQVa2--
