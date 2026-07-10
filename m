Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEA3DCD8F;
	Fri, 10 Jul 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675393; cv=none; b=lnQHFCHskT7H2nSqanY6yCXNp9ftqDYJLVdhep95PUP8mKcTT1ND7J8BvhXEwhMLav/VtnhA7sw6BfvnqjNj2qv/bKEJj2tu1YUlzJdz3GmHx35K6vIEIeLQ+GiD1lqoWwiPxSW53f0AWmPdjUwZw4v0aF+mlna0dBO5XePcVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675393; c=relaxed/simple;
	bh=8HdE+hoG5uHhxQBm/7WF60/Che70+1aWSKVvXkOZu9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFFQQ2fP3XelhVFiYVFB9I5Bzi58hEx7VX3tlu0JGOxdyg97ClVvgYc1KHiTVXhjZnmhhP8RIHlRfT6mVG2s/EFBnZmfI0oce2Qql8K7VHkzjrCD2slxOr6zBjLzBMmVyR96acSUiFqTaABfskMOshgpCAqbT89g2+Ka39vBOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfJP0Bcc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfJP0Bcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338FC1F000E9;
	Fri, 10 Jul 2026 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783675392;
	bh=yWjmzxbTAbsmlMTFDtafndSaGi9K4uvX4/DKB9ctpDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gfJP0BccWBXfDrL/Ii8Z/yiZEgIZyTgeJ9JswEPkJ/IGVxQifEMWKQOIp4pvww5Uc
	 ZsuoGSO5/PqzVfwgmNgeFCQC5C13yH4yVyaYGMSD/07SlC5QF2HVeSsp/wdBjWgtIr
	 IjIPOXiFCppJ/5yDHXq402Qt/y1F9QqKSpkCKTZ/16eDhqdiPTvVlaOfE3RZEubo5k
	 9gWylZyms7YWQXK8vaAG8YscQ4j2rNsEHLavLNJMU4r+/kXgwFKDxeiu6wZz4garAo
	 ZCDfk1rdwOsFfFSd6c6+7rIsZH/GZaLH/kgGqTx/2uBjoFL67MOVrvmwHRbm30JuHS
	 Ci8vhOcZWDcxw==
Date: Fri, 10 Jul 2026 10:23:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
	Girish Mahadevan <girishm@codeaurora.org>,
	Alok Chauhan <alokc@codeaurora.org>,
	bjorn.andersson@oss.qualcomm.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
Message-ID: <5a1dd2b7-6e26-4806-ba71-175b195137d6@sirena.org.uk>
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
 <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
 <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/kbEGMd0PR5gaZ/A"
Content-Disposition: inline
In-Reply-To: <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
X-Cookie: Did I say I was a sardine?  Or a bus???


--/kbEGMd0PR5gaZ/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2026 at 09:41:26AM +0530, Praveen Talari wrote:
> On 09-07-2026 23:59, Mark Brown wrote:

> > >   static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> > The above breaks the build due to removing the closing brace for the
> > function:

> Its my bad. It appears this was inadvertently removed in v3, although there
> were no issues up to v2.

> Please let me know if you can add it while picking up this change, or if you
> would prefer that I send a v4 with the update included.

Please send a version that builds.

--/kbEGMd0PR5gaZ/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpQufgACgkQJNaLcl1U
h9BUMQf9F0BmXBtpH21qlsK4DDWNo2KE+0C7ot7mO0ZgvZFUE+4aB/Mb7Y8F3Az5
JMGClmPhCIb/8MPaT7iCqzrW2cK/B1x5sFKbsdVCPWpcJBOfqIQ1/CeiLxaX7zQ9
GQUXEUx0+QBIu+jOK6BhclShP1l2ZpwbSjYogCs+SbxTWwaf2QXDNuYLuH9J6LA0
Nn60lEZjO/UQnZ85edWh4vHr0NUBsGUs+BlMk2m7ScleXQ6GqZE3Kzqcj9bPpJkB
q8xd/+0RreW8A5TRR4mbnWkjLxkNV/GaYRy3XYTioyX6useOFg6N3lUqE+Pl3RGo
MNGHHCZgT26mpoEASZX60nGNlNyf+g==
=BGEJ
-----END PGP SIGNATURE-----

--/kbEGMd0PR5gaZ/A--
