Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D533CEA5;
	Sun, 14 Jun 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475892; cv=none; b=Go1aZX3mGtZGI5QvzI0wwVbFgPqC0DxwGD8WCL9+PfPjj7UuGm/OCRYv0dwHzMB+l3+ijmy/Xe2agq4vXuC5Xl0DqhSEO/sq9yD7VbwQylxrbBsqubghkrGjOU/OfflRGwirPhlUYVdhcBCHoVXX/gQeZEqpDGft1w+K9SXaL84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475892; c=relaxed/simple;
	bh=wI2DlS774IqpVsg9j1PM1C1Is9UCIQcmLP8ixxv8XPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udN3VVisNGo525UNlwrMrZWaXqmsbgQ/+FNMVY/yoSLQUJbxHDgxrEOw8f6b5m1pm07AfQsYGz6y4v7WBk98ugeVVQK3mYVrzXPEwYdB1vkBqY1uMpVRELjId1/xDqzgTnQe/0kygpin7qMZdiPm3hfpOEdIUbl8vuOhp145LOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtEtALnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtEtALnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1201F000E9;
	Sun, 14 Jun 2026 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781475890;
	bh=4JM9nQpWmXqoX/eAkM6+OEne4H6FBJgDy7rxA2wS4HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CtEtALnfbZB8tN1Te+X2hEQnPLousvOYpOZBX4AjGSYcYcjWVGeeS82pomOC4+dQT
	 2qv3QHRkPkYxU+Wh7T0kMIL0AKTiCYlutlmONQi7kH0oQ7LDp+jyWEf/BFWjp41Tk8
	 Eqvn13Q8w8j6C49OjbDcjG7KhNDa2SED6O7+JAopyX+b6UpiIPa21GKT7DRg6bYHcP
	 hiEWADS8aM2wR6j7/A+56eJLXuPsegheCZcZH3GRs8Fyc0ivRd9rOk+WZI0GPqcPxF
	 icROupolpxboqBAL8XVZpM/AJ2zduVBzMf3cAX3WiyFN3hOSIQaQKjXtF67PwVo4bk
	 RnJDUjc973C8w==
Date: Mon, 15 Jun 2026 00:24:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Beniamino Galvani <b.galvani@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Message-ID: <ai8qCJ89VzH7YaNL@zenone.zhora.eu>
References: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
 <20260603-add-mcu-fan-khadas-vim4-v7-2-594ba8a965d8@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-add-mcu-fan-khadas-vim4-v7-2-594ba8a965d8@aliel.fr>

Hi Ronald,

On Wed, Jun 03, 2026 at 08:05:24PM +0200, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add the T7 SOC compatible which fallback to AXG compatible.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
