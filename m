Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE22F1FE4;
	Fri, 12 Jun 2026 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280906; cv=none; b=aHhYZieBukRMSb/tTQVhxlfRJ6vUcQmz7TxipgCOjfeL4YMGVtYrbueWnodco0+dmB2AMXVj0XWG6L7WAqlxPL0NKvJC7HLdxu0+0NyqjVU6aZS4MamxTKjCTQAR9NiKcZOW1Dwb7SRzHvfQ1qT92ovV3EPXgTUs6Z9uZshOgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280906; c=relaxed/simple;
	bh=B1hw69U+g5rviJeY96x6rLS2DqQHSYeOVGBp1a6MQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ1hNboX3NFSu1nzA1+XlZWjkw8mXcBHyMG5XgqDEm6v+yNNkfY8OQQ8PRWCk8eID0VHPEz0tP5sG93SBe5peVz3zn0uZ1JjKb3uO3g24ZSkh5Du2NvKkbe8SNZD19lBfPfEVebf86IKaoZkrW37c+ZJ+Vq3aEokzsbEC8zye08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjX6vt7T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjX6vt7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9833A1F00A3A;
	Fri, 12 Jun 2026 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280905;
	bh=b0+2ayb3INKvxVsaVyMkWyuFBSLC5rKM6WFP3AxiqM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjX6vt7TRaUWXftdg2bolxuh2QwLl7bkQZx1Cnes/F5vxK1FdEPFNtAyY3WLGCfRi
	 jsRrGU7M81mv4c4i2sZg+Wl6E2h1SEUDhtL9dx5ejkBn0atR1/AZ/BSKnEvnPK2jPL
	 Jf50nlsBwjiczLfZdbEgNouMk05+wXl3owDfn85Mfr5C0DsGgiRlVEEokZjkOkv9hy
	 jA+ZLdQETj8euE+pXBQFIYODGISSuKwmWB85/PtnmwbZUB91ogo0oWU6fO2FIhtET/
	 JttaprAAAm/gpfORNDH59SzP4iXdKuMKktQTmiKfl6UhbY6wfT17weg76StIrru1zE
	 E+vCjIu+fZaIA==
Date: Fri, 12 Jun 2026 11:15:04 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Herman van Hazendonk <github.com@herrie.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: maxim,max8903: add DC
 and USB input current-limit controls
Message-ID: <178128090443.1145552.3235840430356467114.robh@kernel.org>
References: <20260605-submit-power-max8903-dc-limit-v2-0-0c5396e98f14@herrie.org>
 <20260605-submit-power-max8903-dc-limit-v2-1-0c5396e98f14@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605-submit-power-max8903-dc-limit-v2-1-0c5396e98f14@herrie.org>


On Fri, 05 Jun 2026 11:18:12 +0200, Herman van Hazendonk wrote:
> Add three optional properties to the MAX8903 charger binding to
> describe board-level GPIO control of the DC and USB input current
> limits:
> 
> DC input (TA / DOK pin):
>   - dc-current-limit-gpios (1..4 GPIOs): mux control lines feeding
>     the MAX8903 IDC resistor mux;
>   - dc-current-limit-mapping (uint32-matrix of {microamps,
>     gpio_bit_pattern} pairs): the available current levels and the
>     GPIO bit pattern that selects each level.
> 
> USB input (USB / UOK pin):
>   - usb-current-limit-gpios: a single GPIO driving the IUSB pin.
>     The IUSB pin is silicon-fixed by the MAX8903 datasheet (Pin
>     Description): low selects 100 mA, high selects 500 mA. Only
>     the GPIO mapping is board-specific; the current values are
>     not exposed in DT.
> 
> A dependentRequired block ties dc-current-limit-gpios and
> dc-current-limit-mapping together so an incomplete DT cannot pass
> validation with only one half of the pair.
> 
> These let userspace clamp the input draw via the standard
> POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT power_supply attribute. The HP
> TouchPad uses both: two TLMM lines select between 0.5 A, 1.0 A,
> 1.5 A and 2.0 A DC input current limits behind the MAX8903B
> charger, and a third TLMM line picks the IUSB 100 mA / 500 mA
> limit.
> 
> These are purely additive; existing platforms remain unaffected.
> 
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> ---
>  .../bindings/power/supply/maxim,max8903.yaml       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

