Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4742C15AC;
	Tue, 28 Apr 2026 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362497; cv=none; b=EYHAC74K06jQr6uM//bKtlkas6c8vvWnKN4nIw+WWfyuJnI31hS//An56HaZyWyQU/g8X3U6HPORnTwrvW2wPABFJuzgi/KJnMoZIZ/pGfd2aDxF+D9rYI0Ru/ZfSZUjz5rI7diSprUo33PpzqW4qRBeEKJpcPvpyK7j3CSlJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362497; c=relaxed/simple;
	bh=ft9oi09v7e6MaGktTxeycnqTmmPuYqwjGTgoOgQE+Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUFjfvMickDmAfg5AoUzmTEBwiQH2n8AFL3svOQwzZzxUXW7Z/QkxLvEtCnMrrlTq1UheIvGucDYojVhq9ZXJR3I90VwtoI74U5YKsDA0dIfIFk2jgKWPpFER1Qowb1BCJ1xvUwjd2+beSJzcK1c1w6BF4LlyPpmSYzPrh9cB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6UkoYPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6UkoYPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417F1C2BCAF;
	Tue, 28 Apr 2026 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362496;
	bh=ft9oi09v7e6MaGktTxeycnqTmmPuYqwjGTgoOgQE+Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6UkoYPrXiTQxDUl4bAQiXStQr+Bh9R0gc3d4IMmW8E102PEGQWk6t84EZ/S9R4YD
	 jZoKh7msf0blhF2IEbox08mZKBwat/WQyHJdW34XjqPWmVDwMR5pbiTwzoSGUwj6vy
	 r6GZKn1YqdNrhkTZXmDhzOt29qh9WL17jyQ/SxPlknnGH0AouF0TmNYEibvTEs4mOa
	 Vrw6bkNwXohgH1hcK2Sdb4fDCpXjrRTuwLedtrWvopNz/2W9MncfUna+8AyRriFDHH
	 /GtTIEk5GxSrntSDuXmxYcI7bjFlbH7LgARBt/KwQ89lBam12gUx6OrQsl3AFqlmM4
	 CUb9hBkz3HrUA==
Date: Tue, 28 Apr 2026 09:48:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org, 
	simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com, neil.armstrong@linaro.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
Message-ID: <20260428-vigilant-grebe-of-tempering-0b5e14@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-6-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427170914.5062-6-macroalpha82@gmail.com>

On Mon, Apr 27, 2026 at 12:09:13PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add compatible string for the Anbernic RG Vita-Pro.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

You combined three completely independent subsystems into one patchset.
Usually that's unnecessary burden on our mailboxes and instead of simple
shazam of entire patchset maintainers need to pick up individual bits.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

