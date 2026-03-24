Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F73D88E7;
	Tue, 24 Mar 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342564; cv=none; b=SnpZuNSCsP1R4ZmAVo44vQNaA/E11wA2s3MG6O4hy2RhVXmfuA8ArVyTlHiFaQnW+u8VbWL2sxLZ5PoGUapuiasFF0Ms50gxLQJYQ7OOYItGZzCM/qlajygqEJ8SyvWVoTTeDb1XM84yPo+FKZjtwykFP94pHhI8mH5a1MxoVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342564; c=relaxed/simple;
	bh=frbr81nCvotvkwEe9EhH7stkWGMQfamV9EZqTIMSnyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Y1DFsDROrl5KQqm6qvkAoVwR0IitdzclXi7YqJFzmyWixaoZsiCiRCub6Q6m7RIO3NIhS9U+uNPlv7o5PYuNe6BwCf+Y83POC3KB4bdzckvGD7c3yA9y78K6UvGMHTBZ5eGxzlskARPG7EMT/vfqxSwbOkEIar6ROSL71lztA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmh6zf2h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmh6zf2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6229BC19424;
	Tue, 24 Mar 2026 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342563;
	bh=frbr81nCvotvkwEe9EhH7stkWGMQfamV9EZqTIMSnyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmh6zf2hUV+lKpObYTmeOIuHlmlVhOEtymZl4LPnFNT1kSfrmyKNZDyqwjR88vQDN
	 jVkwpRY6bLiGDsHTYS8VK/WPH4YfbfUfvauKUJM6Q7cPeN43oc94VmuN9H21cexEfX
	 B74uIgwlitMH6f8/k2pNEjgwtRl5H0YUYo5nnFJkcRguR5NWbeN2IE3F0uYXIUGDwI
	 dLTIcXH1DVJ4X0fQOJ+LFhsxlXLryKVzNG7p7EWm3ELhGmLiudgs6gIsdubhbfvnzq
	 HNnLokL8hWGrnRdkzOgYib/PhZ/RfZZ6xNiv1z96gpn7ExfC+jpNgqErkN+qGMXb6q
	 ohjT+7jR/tk0A==
Date: Tue, 24 Mar 2026 09:56:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v3 0/2] power: supply: gpio-charger: add support for
 fast-charge timer
Message-ID: <20260324-monumental-speedy-echidna-c63d83@quoll>
References: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>

On Mon, Mar 23, 2026 at 05:04:05PM +0100, Dimitri Fedrau wrote:
> On some devices like TIs BQ24081 battery charger it is possible to activate
> or deactivate a fast-charge timer that provides a backup safety for charge
> termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
> for enabling/disabling the fast-charge timer via GPIO.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
> Changes in v3:
> - Add documentation for fast_charge_timer
> - Add a compatible for the BQ24081 (using gpio-charger as fallback) and
>   then only allow 'fast-charge-timer-gpios' for the BQ24081.

Where do you "only allow" it? Please point me to specific code.

Best regards,
Krzysztof

