Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42053C5DD4;
	Wed,  7 Oct 2026 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408274; cv=none; b=h28X0KVd+b9fP9Wm2i20/SPDG7aqw+IRvimzyHSDXXe/VV6jdyr8gJu0A3hN/YU/rqGBQaUpE/D2F3MAjeDV+L31nnzdjqlhkivmRjVL2zeSGQbtjARZZp6MgFh3OB0elQkZvWWTx9GAk3GUUVzNfCmnL9kO07+Dbk6ArajaVVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408274; c=relaxed/simple;
	bh=8Ifum/l77gqxWntAyfFEIEIe2c2+LzFPjSytMy74VfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1M5zVPFOGHqPBYeFlkbAaFoJi9QoI2VGQPq+kJjlXRpj0vUgcsmjY8xxULHuYdYwpY6LmrPkxnGh+o8CVRorcv6mPDS2RJK1j58EFobQAou/iCBMYGiHx1J9v9cEzT+cA7BaZnJq19vCGpxZo39vcUnq3AsbJouTfkqZx8xhOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7Vi7+id; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7Vi7+id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DC21F000FF;
	Wed,  7 Oct 2026 21:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791408273;
	bh=QW+6iHYt4MuO7s+6o3BNEzcdf0RPXwZAyL0mWD/q/4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O7Vi7+idujoI9ni54RgMBO2jR8mzrquJsOAiw1ci3uatQ+xCwgQBgMtYzA6HTv1FR
	 fyqrWEeAiwGs5I0/+XZXSl6RCfB8Kgxalfzp/hsepwuoJZqCVaMrbRSw6OOhMpVKlP
	 rq4tocQETWXIlbLPAo/cdtZedozjDeeKz4zRfA8okHxKoVyeeKGpE9czmRhmvZwQPQ
	 OAoN1JWZLx5JGvCE/5fVjt7BMdEY3kosSCfpLNE7kI810nSpO89XslD0FcyKiVrKFh
	 Xqx75gyys3gZvxjYO4+ZDRmleFpyEqBI9yk89H2C1qvgk4bqCq80GgLglD12ZZY/8K
	 pD2PBA5llvucg==
Date: Wed, 7 Oct 2026 16:24:32 -0500
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sre@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
Message-ID: <20261007212432.GA381404-robh@kernel.org>
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
 <20261006-b4-rk3576-reboot-mode-v3-2-6edba064693b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-b4-rk3576-reboot-mode-v3-2-6edba064693b@flipper.net>

On Tue, Oct 06, 2026 at 08:02:40PM +0400, Alexey Charkov wrote:
> Whatever program that acts on a reboot mode runs before a full OS, so it
> may lack the capability to enable the regulators it depends on, and a
> reset that preserves the mode register generally leaves the regulators as
> the previously running system left them.
> 
> Allow a reboot mode node to name such supplies, so that they can be
> turned on while the mode is being requested.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> index 79ffc78b23ea..5ed70c87269e 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> @@ -36,6 +36,14 @@ patternProperties:
>    "^mode-.*$":
>      maxItems: 1
>  
> +  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
> +    description:
> +      Supply that has to be powered for whatever program acts on the mode.
> +      That could be a boot ROM with no access to regulators, and a warm reset
> +      leaves them as the previously running system left them and not necessarily
> +      what their expected out-of-reboot state is. Any supply described here is
> +      enabled when a mode is requested, and stays enabled.

Sorry, but no. If we allow this, then what next? clocks? power-domains? 
GPIO lines? The list is endless. Maybe if a not generic binding is used, 
but still pretty much pure configuration.

Rob
