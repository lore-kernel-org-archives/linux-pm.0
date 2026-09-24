Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E639934B;
	Thu, 24 Sep 2026 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263082; cv=none; b=Fcu5jwuf3y3D559YC/KmAZuEK4MDBxF24ZVHAmWHX3a9OXIsYeZierSo96PFtJlgh12b3uZuwS1lh4i4UCPZVfrjRuU8tM5y6ZRarHAGc0dHD45lfTpFdVjQGDVN1xi6rgFn/ej239mz1Syu8g6XLDJFj76iwdiw6T+3CnncxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263082; c=relaxed/simple;
	bh=3fKhp0CPyI1Uop7bsEthktETQG+tMkwp1WISOWBRlPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTej5h9zvFChZ8XPDS35XzcMKfg/V+YzmkdkV9SabGH9ojwcV30u3Lu1FzpbkMxX8fnJTwJmW0TO7ls6vZ3DcvZOFAMztno6+d7FZMT82SSL72L6s+TN+18eslil6HPLhQMeE0HTGnZtv3kHkSIKMfT1vHi2PjHq5dMId/Cm8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdulPwzd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdulPwzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8046A1F000FF;
	Thu, 24 Sep 2026 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263080;
	bh=jmAptIvHqywkparkAJXS/X7IeXr9c/AeAy6RqWrrvUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdulPwzd7jLXujpWA6xkurhmXp530xNSTW0b4ozNRsvbS8lc9Hg6AJYZ3CLrnCpoA
	 AgYI8zKTjeh0XbekQ8PpGahLG/qAdbFprLenvsPzEcE3b+RRQqFbLl4L3+/SZWpBNd
	 RsQsJWq5MOr1pVU7Ur9PGdeZt46y+vFXt6nAwpLry2CzXbQ9V59d+OEKKh0qSXm/Lc
	 AQenRp72jTYJCjjG8ACdf4vrUNVT3glLQasLf+oJnKxRLWqYxc3qKCLoN8geFjBwwg
	 GR1NQeaaRTfEXuFNQDA83AGAFjMBZkqoO9Yk4YLmmKrJdyeJAHW1BMA7GSP8boL9bO
	 8IWUvM7CEjmBw==
Date: Thu, 24 Sep 2026 10:17:58 -0500
From: Rob Herring <robh@kernel.org>
To: Mikhail Kalashnikov <iuncuim@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Juan Manuel =?iso-8859-1?Q?L=F3pez?= Carrillo <juanmanuellopezcarrillo@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: sun8i: Add A523 THS0/1
 controllers
Message-ID: <20260924151758.GA75925-robh@kernel.org>
References: <20260913145527.18148-1-iuncuim@gmail.com>
 <20260913145527.18148-2-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913145527.18148-2-iuncuim@gmail.com>

On Sun, Sep 13, 2026 at 10:55:23PM +0800, Mikhail Kalashnikov wrote:
> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> Add dt-bindings description of the thermal sensors in the A523 processor.
> 
> The calibration data for both thermal controllers (THS0, THS1) is split
> across two nvmem cells at different offsets, requiring the two cells
> to be read and merged. To maintain backward compatibility, the name of
> the old cell remains "calibration" and the new cell is named
> "calibration-second-part".
> 
> Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
> ---
>  .../thermal/allwinner,sun8i-a83t-ths.yaml     | 34 +++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> index 3e61689f6..792081af5 100644
> --- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> +++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
> @@ -24,6 +24,8 @@ properties:
>        - allwinner,sun50i-h5-ths
>        - allwinner,sun50i-h6-ths
>        - allwinner,sun50i-h616-ths
> +      - allwinner,sun55i-a523-ths0
> +      - allwinner,sun55i-a523-ths1

Why the 2 compatibles? What's the difference between them?

Surely this has been asked already, but nothing *in this patch* answers 
it.

Rob

