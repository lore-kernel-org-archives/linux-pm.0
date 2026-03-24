Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33F38CFF9;
	Tue, 24 Mar 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344638; cv=none; b=keFZhLWt4pEE5+KOHrOZnrrGT0Dw3y2Bi/IjJAHvkmqAbIBsB0ouRueH60aDXYuWZIwd0CMel8cw36AUsuftLoaK0GV+kDZ4+hyJAn312HWdsnuemCYyppCYw0jbm6lC6Avl7sfmh60MrDB9CUHWigw/c2BwY8uJe0kbRZS305c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344638; c=relaxed/simple;
	bh=fPiho2SdSuE/+OCezMKP8RHMpCHb8CgGLDiyPgHRfNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrnUy5mqMePEERZ/A5jxgq+x3+7lBlSRESPQQU5bbvAL8lPhPAD8flj79rlf8Ww4mLlUz7AtALVQ8/SMwLsFQ+lYOJ9CzJJYVWueYu/gIpxph33GvE/KJXdlldl8r2RTOSkWfuNJdCnU6FRANpQb6pr/FdUSiLZPjyMCFiuqs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPkIlw6o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPkIlw6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06239C19424;
	Tue, 24 Mar 2026 09:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774344637;
	bh=fPiho2SdSuE/+OCezMKP8RHMpCHb8CgGLDiyPgHRfNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPkIlw6oyD+FT6WM0fRQAAw6jDC6dFWSn2j75XjcvJqGWDOjUfb4auQ0EP3YPuk2y
	 bGsghTnu+XLy4Od2LjTE+0Esst8/F0JtP7eixy15SixJwjXKZXK7uOJx6NQ3Hu0Kj+
	 H6h9iJelLDbMq4WJGHfbIB3v8KGrXWL0C0lhtHOKuKV730d112qqfMhMIWiQCKoMn5
	 2i5+qF05mNCc2reebV6xChxKyKBKdPczKlPGBLd5zkHXaR4BSlmG0L6oZHSEsCdZLC
	 Y3JJkSzVS9+Eso7RS0Bp30oZtFV3HabSwLtQUzl1flB0RZHro6UOmH0HRLdYjYwoAu
	 t4CAceiZufW8w==
Date: Tue, 24 Mar 2026 10:30:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, vireshk@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH 1/2] dt-bindings: thermal: st,thermal-spear1340: convert
 to dtschema
Message-ID: <20260324-belligerent-armadillo-of-camouflage-e52f7b@quoll>
References: <20260323133814.14152-1-krishnagopi487@gmail.com>
 <20260323133814.14152-2-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323133814.14152-2-krishnagopi487@gmail.com>

On Mon, Mar 23, 2026 at 07:08:08PM +0530, Gopi Krishna Menon wrote:
> +properties:
> +  compatible:
> +    const: st,thermal-spear1340
> +
> +  reg:
> +    maxItems: 1
> +
> +  st,thermal-flags:
> +    description: flags used to enable thermal sensor
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - reg
> +  - st,thermal-flags
> +
> +unevaluatedProperties: false

additionalProperties: true


Best regards,
Krzysztof

