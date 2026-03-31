Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022753A7840;
	Tue, 31 Mar 2026 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960306; cv=none; b=MH0P1NkILRjokRl/Zmbk3UYJRkRE6NUmGQObu/UGT1Ml4v7RzViTvm6JvbdlD8UadJCB2Zx5VZ116eYvelKfkjsNc5Klg0XSc5s1sIECyQvvDkwPoA63pltbRNLIUf95Gu4nD3qfmTpbSggCEtirrWl6Zi+Lo+aJtUNtOqg7yN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960306; c=relaxed/simple;
	bh=D5/3xk1fp4FeAb9Blzw/Ddwbf2aw5cJA1gRZc9Dui5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMPsGCwk3+SqqiyTuyj5gZBmnYM7o/IHuYIpbyQnHajCQjM0GCDD1JMNn+a6xvdvaeqlrU3VCsCxnZniUJbrx0n+8zRbsy3ygPv3QHWvZEI6UERUR9+hylUHrZA8/AZRFR0M4Y6ehzszVq8udSlRvXiciTXsuPzudgbrNLsY+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeZmfUXJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeZmfUXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F94C2BC9E;
	Tue, 31 Mar 2026 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774960305;
	bh=D5/3xk1fp4FeAb9Blzw/Ddwbf2aw5cJA1gRZc9Dui5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JeZmfUXJlpPYISkPKqERcAolc05szSMZRt9nhT12TH9URKkMk+w2B+W7BZ17XItfk
	 XcNLFtDwSyNrFBduWXcYJa5380Lf7XUX+midjgd+iyy57I57AcdLtABuxMX2KRc0bP
	 H6d02jmzpTbhA3juTB2XvKiFeZApE487rQevjDHjhiTdcD828tkla1Nnc711b8+2pG
	 XSdFSH/e+zhOwASztRQvEeZ8AhAMkJDE5qaVeYfHs6qlRlZmbGEpTJ+gUA6nu1DULH
	 or0u9EGt0jrXbbr/KClkZG5ojZhOneIzPIuCNPv0y1Xr0WTA03PHlvHkZy2zZVh+dN
	 OvaI8+vB3QwvA==
Date: Tue, 31 Mar 2026 13:31:38 +0100
From: Lee Jones <lee@kernel.org>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v9 3/6] mfd: max77759: add register bitmasks and modify
 irq configs for charger
Message-ID: <20260331123138.GE3795166@google.com>
References: <20260325-max77759-charger-v9-0-4486dd297adc@google.com>
 <20260325-max77759-charger-v9-3-4486dd297adc@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-max77759-charger-v9-3-4486dd297adc@google.com>

On Wed, 25 Mar 2026, Amit Sunil Dhamne via B4 Relay wrote:

> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add register bitmasks for charger function.
> In addition split the charger IRQs further such that each bit represents
> an IRQ downstream of charger regmap irq chip. In addition populate the
> ack_base to offload irq ack to the regmap irq chip framework.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: André Draszik <andre.draszik@linaro.org>
> ---
>  drivers/mfd/max77759.c       |  95 ++++++++++++++++++++++---
>  include/linux/mfd/max77759.h | 166 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 222 insertions(+), 39 deletions(-)
> 

[...]

> +/*
> + * enum max77759_chgr_chgin_dtls_status - Charger Input Status
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE:
> + *     Charger input voltage (Vchgin) < Under Voltage Threshold (Vuvlo)
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE: Vchgin > Vuvlo and
> + *     Vchgin < (Battery Voltage (Vbatt) + system voltage (Vsys))
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE:
> + *     Vchgin > Over Voltage threshold (Vovlo)
> + * @MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID:
> + *     Vchgin > Vuvlo, Vchgin < Vovlo and Vchgin > (Vsys + Vbatt)
> + */

This comment is masquerading as a kernel-doc header, but isn't actually
kernel-doc.  Either change the formatting or adapt the formatting to use
/** and use W=1 to check it.

> +enum max77759_chgr_chgin_dtls_status {
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_UNDERVOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_MARGINAL_VOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_OVERVOLTAGE,
> +	MAX77759_CHGR_CHGIN_DTLS_VBUS_VALID,
> +};

-- 
Lee Jones [李琼斯]
