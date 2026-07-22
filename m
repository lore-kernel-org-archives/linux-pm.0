Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384C37DE89;
	Wed, 22 Jul 2026 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733624; cv=none; b=BMjTU9hy9ZUomTEmcsLoxunHb9BMOvgD0EYb3Dj2JA8cBGi8itWg7UKxaUmFheFZElKyrdF/eCZn4wAGYdqneRrdHJb5wwXHs71lb/4fOfCRiDGRETq9OEtRGjT15bziC2ySG6QGEOmDOHMP2AGySt9ebAL8XSJ1ZFTGGfR8ub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733624; c=relaxed/simple;
	bh=4Y6payjzw4H+9nIeEhagxhPs2sVXNApGYce2Vry765k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwWNK1XHmMJaLCYKIf8bDnfNg+TgtXPwG/vdMT6yY7ufcmvpvZs9MNxxRwHS1CKufB6kWeiu8hPy/AcwlPnXKurN+xVkBl+8ns8CHeM2UmPVFVUEDDKh3bl5jBeVoSmSVQj3YhPMAK376191NAb+2f22oGbJSptNqJ5BmvhJsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHxNWoLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHxNWoLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152451F000E9;
	Wed, 22 Jul 2026 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733622;
	bh=Ni9QvwpOBI9XGbAW5jEnvLz17SQhbLZTmB0sDYQ3bfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MHxNWoLipdYtdcxH5ZuffW1EziIb/qde+X319AUL1yhw/yF3qyEJ6UZQLp7XZYO8P
	 AoCZAtXVRwp4p/QDqVSNz7zn9Mhr+Co6eIVTXEz1lx3Se6Neahl4s+1cGRzo5CaimB
	 ih4VrieaBPffALnRLeVIYcbMnJK8A3jnxgmcqJr+bDvy6MOf868pkYzrm0nF+O9xEb
	 LRyJdp9PE/focqh37rS4ukFWq5uBchAusVqVE90aPvafTmyjivXSdVPmMJtT8dcjnm
	 6kZnbvnTWa9ygwRThUSPMYUDzC1vas3CrADVQWWnqJkQaMbw0xFQjnlu5QPnsz5J4Q
	 0gScho7E0CJhQ==
Date: Wed, 22 Jul 2026 10:20:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: devicetree@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Mateusz Majewski <m.majewski2@samsung.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Zhang Rui <rui.zhang@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: thermal: gs101-tmu: add Exynos850
 compatible
Message-ID: <178473361756.946166.4949700030015164786.robh@kernel.org>
References: <20260709-acpm-tmu-e850-support-v1-0-9fdd58b634af@linaro.org>
 <20260709-acpm-tmu-e850-support-v1-1-9fdd58b634af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-acpm-tmu-e850-support-v1-1-9fdd58b634af@linaro.org>


On Thu, 09 Jul 2026 02:10:27 +0100, Alexey Klimov wrote:
> Document the `samsung,exynos850-tmu-top` compatible string for the
> Exynos850 SoC.
> 
> Unlike the GS101, where the ACPM firmware handles most of the TMU
> initialization and threshold configuration, the Exynos850 firmware
> implements a significantly smaller subset of TMU IPC commands.
> Consequently, the Application Processor requires broader direct
> MMIO access to initialize the thermal unit, configure thresholds,
> clear interrupts and collect calibration data.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 26 +++++++++++++++-------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

