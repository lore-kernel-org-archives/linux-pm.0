Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187863C943B;
	Thu, 12 Mar 2026 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329492; cv=none; b=jjx+lImzs0/myf1HCiSJmoBg9PM/GPOhb6BxlCcPcMol+5k+SQNMUct0BF6TJy0oXrYoF28DpTk2l9PpsyINnwT/i7oi/0kWuB45krGlxgXuYzkm1VDy0ieO6FTXtnvW3NkjIenUsZLJMs6A0op7K2P0NZ5srgaB2iO6DF55Xho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329492; c=relaxed/simple;
	bh=nM7mxcedWBXClU4VvgLd8VHnKMBqGYEjylyr8nYUbzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiyfRyyOqfPgUtsQkGpqGTe/0ZR6veJeIpcF//cWh04KAxFgsecvhoZYw/k0XK+CRCNSlVzVdu+Ycui3teuU8/rBo1//buSzF3udQpmKMDcOEyVXOw0POFp+ESm+7eWDp8LbJBbJZlnt4jwwahgwWCCQ9VgzBx61zXCEj16zxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwgXGj8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwgXGj8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854A3C4CEF7;
	Thu, 12 Mar 2026 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773329491;
	bh=nM7mxcedWBXClU4VvgLd8VHnKMBqGYEjylyr8nYUbzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwgXGj8y0+ZGnWJ38GM07ZNAKNcH1E+6Oem2eE/mtbsTl3xxIN76fqa8ewR6somKy
	 C9msQXXW/aFE2Hvp51SOOug9ZOOZ1ZcT3iBLjh7OzBM1M/C0yu5mVgfKpoDIETn7QW
	 Mw0YfB+pYyvxGOKI6rTSD5cXbP259qZ8JIbWFc4QlTcA428eziLygBI123tb7MuXBj
	 ipk4OAohSLhuu11DO8rcp8ivodae5bzQPlfNNmx+TaW7taXVn87ENW8WnSFUhd3G6E
	 jSI+aEcnzVjhf865PS/I3GnPgT+/mq3hphTXB+MarvCw/OfFTbm7DPTWLU1bNUSeQg
	 OKZD+1VJzIJcA==
Date: Thu, 12 Mar 2026 10:31:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: mfd: max77620: document optional RTC
 address for MAX77663
Message-ID: <177332949012.3263886.11722832171482472961.robh@kernel.org>
References: <20260312085258.11431-1-clamor95@gmail.com>
 <20260312085258.11431-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312085258.11431-5-clamor95@gmail.com>


On Thu, 12 Mar 2026 10:52:57 +0200, Svyatoslav Ryhel wrote:
> Document an optional second I2C address for the MAX77663 PMIC's RTC
> device, to be used if the MAX77663 RTC is located at a non-default I2C
> address.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/mfd/maxim,max77620.yaml          | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

