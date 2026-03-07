Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB0254B03;
	Sat,  7 Mar 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887379; cv=none; b=Ixq7zrPL6sRdJxhzjIoQ6YgCT4Bts55ZBq7VpXGy9bsGzbVbGBcw/XVraiJ8Z8EbsYP1bQX9fXGUJ/XM3SUhYgO2DK5I7h3Io1dMLtBRiRUy/CoV7hyJilsyUKiVcOEx7wnlImjbD+rWWSJC4Blv6yKp4brgs9ko3eqWG4UmTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887379; c=relaxed/simple;
	bh=Zbp/1tKW7RdZIEVwOqkjlXeDgopQQuK16aXFYV3scKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJyvWaS6E/J9VzZuvNv2jGK28KqxzTcOnYuoR6Kqwuoltojo0HgxGhmERjdP3ihKtD6bY1KGqL0GWzmVk2qn4qwy9EM4a8WXI4Zv/wquCzTf/zpN7CbQ/HJ7+DQ4kFJxUElFB8dlzb2GQdX95rQDPuBWQ5uDr8QFYguZcKWwUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPfy6gCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPfy6gCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73C4C19422;
	Sat,  7 Mar 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887379;
	bh=Zbp/1tKW7RdZIEVwOqkjlXeDgopQQuK16aXFYV3scKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPfy6gCJyWZndvwqzULnhpVg+BqOWDvzhyYaNGMuCfCYvRRhvofF2KZ3vxxasqTYj
	 FemoMMm2rX40+Mm/3vRYF2Iw4CRTUkLLEB9rYpfqoeiHEz6Cm3On4+9hZMqVV+rw9S
	 0P+UZbRofU1M54rPrwpEzEH7k/bLqwm65cdqrBQtCowBmem6LKvENMTE/TFzoCfHrZ
	 TQAsSLRtzEOGa/isnjnknC27LVIm/G+2ZF1u5G5PU2Kd/o381NRZnlDaYrP0zmvuRu
	 8WJMD8sKU4wfrwyuZdKpYvRM8xTga3ARR/c0amojQQ8dSMSd5lDAtQIg4zZklcTIX8
	 tVYTgl2x18epQ==
Date: Sat, 7 Mar 2026 13:42:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: gpio: trivial-gpio: remove max77620
 compatible
Message-ID: <20260307-azure-quokka-of-abracadabra-cebde4@quoll>
References: <20260306133351.31589-1-clamor95@gmail.com>
 <20260306133351.31589-4-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306133351.31589-4-clamor95@gmail.com>

On Fri, Mar 06, 2026 at 03:33:48PM +0200, Svyatoslav Ryhel wrote:
> Binding for MAX77620 GPIO function is covered by the MAX77620 schema. GPIO
> controller function in MAX77620 has no dedicated node and is folded into
> the parent node itself.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/gpio/trivial-gpio.yaml | 2 --
>  1 file changed, 2 deletions(-)

This should be squashed with the converting patch for this compatible.

Best regards,
Krzysztof

