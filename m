Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB88337699;
	Thu, 21 May 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349715; cv=none; b=uAvsZfcpgKOE9j1Da408JodCs7MgKg1byswJ5S9WDQrASjL2z+i4Jy/uDuc3NlmQ9b7MPWhHHc5hOOJ0WCbmstCfS+X8PMKB2ahwezw0H5A37dppeyoAOT/thsWMuPim4G3t+wqx1y43dRAhaUMNEFx8zDzqzLf5rHu8Ils52UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349715; c=relaxed/simple;
	bh=6ysasMQzBiu77inUKH4jG0nogxmZ5jy6i8s1FGbrXZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKGc2VP1xov1faaqxARIJmtcZj7zEsg+VgFwNBXuhfvTiZe40/KYuBXDyXQ51HSfXHLH3TBQAnPjxzx7mvMuSgWa+8G6g3pbx5LvqkWZDFwdbMb/ODJLH2QZoPFT9ZrXl5qePtvE6gArMVET1pQMxVjKkOCeL/Jge6PFb7odXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TArWVdTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TArWVdTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977A51F000E9;
	Thu, 21 May 2026 07:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779349714;
	bh=msG1w+/0XlPu4UUp37IJw+dexMEoxGf3sGxbBxw/2Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TArWVdTB2tjhHGR3gLg5gWePqKKRzouC20AUk7k38dCQ417tGjdCOdeF00JVq3D6D
	 ckL3aTzoiq7f0b+HeH7BpNiOhH1JtoRbavMls8RfyxX4AG80s2dTdudBJ2vkEb0tti
	 toLcRZ56MdYEyWZE8VZf+r0fXOGxbxBRpO9hCA33zLv2sDB4p2Vqv2PDCtPppQQ16d
	 4tog9ODkKZcLjeBOYVdpT/kykLnc7I5uv2cJywZXhQv1Cgj7IfFBhM2tdUlKQrWpHL
	 MVWe8+TU2zE8KpGwqfQZLKDDq8ceb3DAqfuSH9iHnVLUzP+G8p5EinXcwAxK+L4xI/
	 QDNoTUmU2kAew==
Date: Thu, 21 May 2026 09:48:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 6/7] dt-bindings: arm: airoha: Add the chip-scu node
 for AN7583 SoC
Message-ID: <20260521-terrestrial-cream-lizard-fbe6ba@quoll>
References: <20260520155525.22239-1-ansuelsmth@gmail.com>
 <20260520155525.22239-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520155525.22239-7-ansuelsmth@gmail.com>

On Wed, May 20, 2026 at 05:55:19PM +0200, Christian Marangi wrote:
> Document support for Airoha AN7583 chip-scu node.
> 
> This is similar to Airoha EN7581 with the addition of the presence of
> thermal sensor in addition to controlling HW PIN and other miscellaneous
> pheriperals.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

