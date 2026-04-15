Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A683246ED;
	Wed, 15 Apr 2026 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289731; cv=none; b=hGgzlEiZw+7wNdgBAnqLCH3dTVIO5gt5z6jfgmhhLRad3l+s3AqRnyMAvLDFXyofmSghiNuvrMgM0e+Tklwhdls5MfgSCZZ1XO+CCu/6g6s+PuWkvLyIfWdFpDm0Dh2/MhWwDA5zKprR2W9tLdJdcHCg1hfPBXo3t8aIFqU1mDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289731; c=relaxed/simple;
	bh=NLKcyyFr09VfsA7f5Fgt//lj0YJ6MLZ+i+19K50/J90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu4LeHK/q1hJGkH25GjMBlV2GMNGH+u8Yw8sUkXuK+/sS0GulDg2XaGUTaUPqfbNULe9KKJ0+bV9VR5omkchykRlx52oFsD9MjnveShjgLS/Ogdw2/50Vo31En27BuU0cqYocyTOXrZfsr7qHzNFkQEh7r8xrJgGdpMFHLJSFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwyBfLlf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwyBfLlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3B8C19424;
	Wed, 15 Apr 2026 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289731;
	bh=NLKcyyFr09VfsA7f5Fgt//lj0YJ6MLZ+i+19K50/J90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YwyBfLlfJ0kL3e9UtxJpUnZP8uF1e529T0PSfMqewkeQ9fOdWP0F9946nle9/BkWA
	 7NraekXB7ieQ+xv9P6Qa7DzHF+BxcS4O64ouUiUU4oCWBqoXe4y51S7uJH6DOJXrQT
	 m7vxx68YhHc7aNyqQrqWk1JN+TJHkhzMrAsa3wGeqEv/Vy8M40aIVO1oKQbyQ7+Auc
	 OoVY4woMWj7Wqd/vci3UMHsj+dJcZCmyexTjE1El+Sst6Wff1fEPhe1cI6vNWn38m1
	 QzCbSjJcEfiKPSvP8RFGfDT3+q/DewAX8gwY9LWz74J01pCjRUNeTYJj9lK53XGGOw
	 gFpRAfdKW2mnw==
Date: Wed, 15 Apr 2026 16:48:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-i2c@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Message-ID: <177628972872.698571.2241475535349345609.robh@kernel.org>
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-2-70536b22439a@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-add-mcu-fan-khadas-vim4-v2-2-70536b22439a@aliel.fr>


On Fri, 03 Apr 2026 18:08:35 +0200, Ronald Claveau wrote:
> Add the T7 SOC compatible which fallback to AXG compatible.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  .../devicetree/bindings/i2c/amlogic,meson6-i2c.yaml         | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

