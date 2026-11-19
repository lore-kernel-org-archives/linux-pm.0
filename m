Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129090;
	b=z/Bdll3IOEtGvQEpa+Cau9CYyCABnZ8eIiT8TAPte+9bekkBgiSdasJ4FeIa7UWDG5B4
	 3YeydcBvSnaQ7lDV4iL5fyWCQGh7KSPnskYzFkbbdEAMf1eN1A7PQ8kLjMYOKeqKv/iRa
	 QMa/sjCdSIf5+9r4jC4lUTn0BEihbLykb6dpTaAO9L3BiCY4HDid3HJLL0H3tE4BUsHlK
	 I/c080FjoRXnlaW3e9xtOm/n5QGbQpH19JsvPcwL3MLkL5dRfCYf7A/X3FRHnEJZWPR4P
	 aXvbBzqPNP6q0j9vlqfdwrrzr45rsWOFxiq2rNJ/N7UmvwV4CKVKHBbB2x0OAr0L6Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129090;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oSeZFGzry6vPvKn8kGIQrFQWjWayT6ttinb11x02GGI=;
	b=gwxMHb6XNk6a25B/fTmnvbr6TpGqJ4mNJUMlmcV6GCFOiEZi2dcGSKBlyZcmlEUXN9eS
	 z52ijb5E2egcu2qSsDQ61z4u1i9KJbalDX1qtovEENH8uPDprz6TGYtymMLdrS5d2byZI
	 12RNcEKR7EPd8EvjPtpHPBTdAE12ze6HPKLXWAKjcvNmsODM5KFdmMDhgtphFEn8vexFg
	 CiieYdZ/0fYpldJWFwVwCapL27/kpD1WDP7XEcHbefP4DyW2EoZdFHyjG8KjHH25vKwFy
	 lt8HmpxzeYIO7NtU3WpQvJ+x9VWJ6gPCXNwpwXZwChwTMLKIo1yJ01EttBk/dSjeDiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNyEuC4Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10160A5BD5;
	Thu, 19 Nov 2026 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GNyEuC4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E91F01803;
	Thu, 19 Nov 2026 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129090;
	bh=oSeZFGzry6vPvKn8kGIQrFQWjWayT6ttinb11x02GGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GNyEuC4Z9gOIi+B3qf9wPgacH/47VRYjVcLtCkwMfz7MP+Q3+ujmbI/9pqJt9jJy6
	 L+34uwaQN6RBaUDCkEZmk30kY/OAQir7D0vbR3A/5LevCwN/3qABVvRYDVZsQPR7cY
	 8tULn+VstK6vBIK3k8Xfpcj9I2ADvvFqdBJn7efrRzEbAH72Cs2OaTW3eYt2qvR/Es
	 oxc/9Rj268Fd/E3uJimZBbGQdJLGJd7HyT8dBICrbA+dYHXiGbAlGhSph/ijO4Sgpm
	 dwe0vnRnj1vL+9Yjg7HKPPAV59mkrJjsrZeWnQGo4No+IGlbWM+sn8i1JDB7rUTs/X
	 6Sl+XWEDYsq1w==
Date: Thu, 19 Nov 2026 16:58:08 -0600
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: battery: Add a charging
 temperature range
Message-ID: <20261119225808.GA1121782-robh@kernel.org>
References: <20261109-battery-charge-temp-range-v1-0-a967abd8b80c@flipper.net>
 <20261109-battery-charge-temp-range-v1-1-a967abd8b80c@flipper.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-battery-charge-temp-range-v1-1-a967abd8b80c@flipper.net>

On Mon, Nov 09, 2026 at 01:41:48PM +0400, Alexey Charkov wrote:
> Describe batteries rated for separate charging and discharging
> temperature ranges, such as 0-45C for charging and -20-60C for
> discharging, often with a reduced charge current near the ends of the
> charging range: operating-range-celsius holds a single range, and
> existing users read it both as the limit for any use of the battery and
> as the limit for charging.
> 
> Add charge-temp-range-celsius for the charging range, falling back to
> operating-range-celsius when absent, and state that
> operating-range-celsius covers discharging. Add the charge current and
> voltage to use between alert-celsius and the charging range limits, to
> describe a reduced charge rate near those limits and none beyond them.
> 
> A missing half of an alert charge current and voltage pair falls back to
> the matching constant-charge-* setting. alert-celsius is expected to fully
> fall inside charge-temp-range-celsius, but when it does not,
> charge-temp-range-celsius takes precedence to ensure no charge occurs
> outside the allowed range.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  .../devicetree/bindings/power/supply/battery.yaml  | 45 +++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index 9575ee1491bb..d2f2ed9a01fe 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -111,11 +111,21 @@ properties:
>        for each of the battery capacity lookup table.
>  
>    operating-range-celsius:
> -    description: operating temperature range of a battery
> +    description: operating temperature range of a battery, in which it can be
> +      discharged. Charging may be further restricted by
> +      charge-temp-range-celsius.
>      items:
>        - description: minimum temperature at which battery can operate
>        - description: maximum temperature at which battery can operate
>  
> +  charge-temp-range-celsius:

'temp' is kind of redundant with 'celsius' and a departure from all the 
other temperature properties here.

Rob
