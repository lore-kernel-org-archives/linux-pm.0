Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5036B047;
	Thu, 26 Mar 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515859; cv=none; b=Xl0BbNWctzVMbKiO3QG8cCl1Opq+M+c6DMn+NNE+a8+k1IlVOVo2fEfCtp9isxmNoHdiAhehkfp/y9380BHjE7dps+xD3BtASz4wxRMmRybctF7bTh2wcOjNhYOWNZXgv/o/LfOe4wmZgu1r4ZroXbQIkIV4km7rXSmGxRhAdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515859; c=relaxed/simple;
	bh=wGqJgm5IvJVXJ2k7Usi5D6KpmmXmv7I/g0UZecsci6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdr5Es0PeE/lacAj2wpARusBrQsvTJ8Mk3G6MRwDzFX57w1p5p2GtsP0xYFmKM0mCnxWgYe1BkzXAtXjLG68NZiKC1aLhxrWa6Da7Ac9oXkPKRb1781LXE3ecBRd7ezIteY1eCbCCilyQA0YD24cCWlZA7XWXW08Hi/VpXYwVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL+S44QV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL+S44QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDC8C116C6;
	Thu, 26 Mar 2026 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774515858;
	bh=wGqJgm5IvJVXJ2k7Usi5D6KpmmXmv7I/g0UZecsci6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lL+S44QVWYGqzhDmOZfF4+YetGz1JSXlZmJG5Xr4PtpfLzZqd+Ooot8lIWKvvia9A
	 eyBk135S9Ff/E6CbEaUVmMnEXUzve8GnniY2+YdWRP5B6P15Z5TjtneYBsJSpMLgfi
	 B3fyOmajZ3K2YXyV5TMAoJPmajv6RDczImz5/jVmerusahsrrqsEJp5zWCdIAh/BZe
	 XBBqDJD1+HSFa/9QD74O/aIsD/puMFiMbub98wFsKWZeoqvaTc58TOPoAjFS+ukFAq
	 oQCB2TEOCMrR02U3zwkHChN2dA93EBDNPSnLau8RQTJ22y/uarD8dR1ZwVPnhRWtQA
	 m0cgPSiRTdtlw==
Date: Thu, 26 Mar 2026 10:04:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, lee@kernel.org, 
	conor+dt@kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: reset: st: convert to dtschema
Message-ID: <20260326-towering-hedgehog-of-enterprise-6cdfad@quoll>
References: <20260325130623.36710-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325130623.36710-1-krishnagopi487@gmail.com>

On Wed, Mar 25, 2026 at 06:36:21PM +0530, Gopi Krishna Menon wrote:
> Convert the STiH4xx reset controller bindings to DT schema.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changes since v1:
> - Changed unevaluatedProperties to additionalProperties
> - Removed the Suggested-by tags

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

