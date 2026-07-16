Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF26318BA8;
	Thu, 16 Jul 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215468; cv=none; b=keOJDrhkHtrKBaPfZOF2dZzYxg2WGQgH7DouzmdwZXGlAnrdIBdtcEvK+cHuM3xdRz7epeEtEkubka7Pq2Lt6DR/DgDK/qxY43VQz7YkSV6OBKP1ZQGbpzlqvtKA8aP7dSDsFDVa1e/iW5T1R19ThnkffACQtdKbriy5OK8FFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215468; c=relaxed/simple;
	bh=8sSysYFQpM6b/hWycoq8O+W02li5J03XTfJEmvy6JAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akliN/sOBzQp7hIs8MummLW5ZbxuCvRsfVuhiSbJicxAdAcywkfN82P78cih4HN16N8CA9boN4T/xZB5uoId0iQZQjQ7p+F+sb3efzsnchA2lI0ejRbbK5c0lMWo40myfUIWAZlVTi7cyBYpUBCA3PuZmoo/wrUsnjKHdf/XMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFGj1d40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFGj1d40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3141F000E9;
	Thu, 16 Jul 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215467;
	bh=RHZlXDwmnmhNAHsXyKmT3KK/eNJCIlM0UHu2j00CWlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFGj1d40jZB6tW/rv23DOlwJ5g/uU/vVvaS1m2H0Zz2m854PSBpvTzTzUEsCLixjy
	 Gje41ODRwf+hr1UPkAill2j4M1f2GxHE34BrcWCnLgqIbK5ouoWBKRNphFgmZqxc3S
	 4SNTAT4rINmL4L6aBNTmMqJnFpUcQvpo9YLVOd3VqGilSpz83s++aPct0dEuTI9Bwq
	 phwYX+dTTO9tUv44z1SWA1eXsYnUrfh+lgSErFWtMj0fk/BxWpdIV59DRq7YhxR+9t
	 /Gn4CQqFAihfdLlw3ZGoXDUHL7WyhDH3j9bSa3SADRAlEmnF9szPbDxsYen/uQ7c5a
	 HVmKu8lK/qk+Q==
Date: Thu, 16 Jul 2026 16:24:20 +0100
From: Lee Jones <lee@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 0/8] Add VIM4 MCU/FAN support
Message-ID: <20260716152420.GA1424265@google.com>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>

On Thu, 02 Jul 2026, Ronald Claveau via B4 Relay wrote:

> The Khadas VIM4 board features a different MCU variant compared to
> previous VIM boards.
> While it shares the same I2C-based communication model,
> it differs in some ways:
> 
>   - A distinct register map with its own volatile/writeable register set
>   - A fan control with 0–100 levels instead of the 0–3 levels previously
>   - A fan power supply gated through a regulator
> 
> This series adds support for this new variant by:
> 
>   1. Refactoring the khadas-mcu MFD driver to use per-variant data
>      structures (regmap config, cells, fan platform data),
>      and adding the khadas,vim4-mcu compatible string.
> 
>   2. Extending the fan thermal driver to retrieve the fan register
>      and maximum level from platform_data,
>      and to optionally manage a power regulator for the fan supply.
> 
>   3. Adding the corresponding DTS node for the VIM4, wiring the MCU to
>      the I2C AO_A bus and exposing it as a thermal cooling device.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

The MFD parts look okay.

I think the Thermal driver has a dep on us, right?

If so, let me know when you have the Acks and I'll merge it.

-- 
Lee Jones
