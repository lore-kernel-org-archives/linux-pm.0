Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00E381B0B;
	Thu, 12 Mar 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328946; cv=none; b=rHZmKojQTcHsJYkgSFcAuKYc9fBH8akpi24Zr+AvxQSoKbQDuxUE6OM8ujhBd/puJ9GtWA2+Mcs/ac6doYdWi0jTKH/0STu3bPurUpYOQ3qcNnKIkv+rJKfEWeIP8Kyl3Z+mMb7oYHOc2On2k+stiqYHkXHJ3oIiSIaWchtEYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328946; c=relaxed/simple;
	bh=bRXCBQfoBwJAorQMMDgW9XwSg07QH/r98NxXMLNj/2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdGj25HDALWk1jiFvDyvNQiYOtO+1kS/k/hDDFv0jrOZE8ugWE78B9DylwJfctH6awrYDc7z1IA32Hdbxdw7etVEc/rc3zGyf48JSNyy9TPzGRa9FOTKHdkP7v6INPl6nEJXDf2XnFTI7zrIz01lzu9MK7C0meUrQgP3ZPYeH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUvVh8bx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUvVh8bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D92C19424;
	Thu, 12 Mar 2026 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773328945;
	bh=bRXCBQfoBwJAorQMMDgW9XwSg07QH/r98NxXMLNj/2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUvVh8bxRoTm2OO28FXvq+JlwkDRZgzmjwzOATnsQFbhlKsGyRBcPP9A3sHZNzqvc
	 5U+RADs85917PvHuR4N6dkr9XP1oQswUnyNi3s+5fZ95Y9usFCY3nDLlULkL03so2H
	 wSpJxLCJBoixfG9z/PJTH9O6hmIrpPW33XpHWmTkpG01l84gfdbNed5KQro43BnkeD
	 aq+pB9UQePH000vy4nukOjC5wGdrDPrStHfHSF7/IaS0uk1KVU/XzO4Xge8MQtm30c
	 V29aEzB9hCB7hLLnedAa+ycmPCSfqNa5vpZvXWnfAMVeGVW8NOxm8TZ9ffQR+2sGt1
	 d3YL+KQuqxuLA==
Date: Thu, 12 Mar 2026 10:22:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-rtc@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: mfd: max77620: convert to DT schema
Message-ID: <177332894382.3161030.7760088067614106016.robh@kernel.org>
References: <20260312085258.11431-1-clamor95@gmail.com>
 <20260312085258.11431-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312085258.11431-4-clamor95@gmail.com>


On Thu, 12 Mar 2026 10:52:56 +0200, Svyatoslav Ryhel wrote:
> Convert max77620 devicetree bindings from TXT to YAML format. This patch
> does not change any functionality; the bindings remain the same. The
> thermal bindings are incorporated into the binding. GPIO controller
> function in MAX77620 has no dedicated node and is folded into the parent
> node itself.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/gpio/trivial-gpio.yaml           |   2 -
>  .../devicetree/bindings/mfd/max77620.txt      | 162 -------
>  .../bindings/mfd/maxim,max77620.yaml          | 424 ++++++++++++++++++
>  .../bindings/thermal/max77620_thermal.txt     |  70 ---
>  4 files changed, 424 insertions(+), 234 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77620.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

