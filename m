Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE53AFD1C;
	Wed, 17 Jun 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679540; cv=none; b=sUejdpbWLrQhVw/rsozavJU+GMvW1EMZWENfE2uo7CBC+gKyoIpePZ/Wp7TG02aBuXlxaeH5r2UUnzL/bX3wcRLfgzjfiFxqEWase0N9tJ/HpTclrPdlAg4XbfOF4yrTcy3u+8/gHMmMTWeVkE1ZZXih+N92xd8fmSuX05/9f9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679540; c=relaxed/simple;
	bh=pzBIKbIE+zVd39cDTEVjvmvlb2mFCAq34gwCQipRQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE92Un6ARBooSIbc8sRoKInn1rXtxQXh3ozJoX6LxHXP7dO5RmGdznu7QcqeXM5EkZwqjowKaO0tRLlMUFdqERNoBHSBUDWYy7s8jCR2JnvIyscGiWqFg4LX1qoB8+ryGKUY0lbIyO77ZHMJnYe6uF4em3p9dfyZ9pDUwZba8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1WCIINU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1WCIINU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003931F000E9;
	Wed, 17 Jun 2026 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781679539;
	bh=SA6aTbIzbx0CUfFWUj33VnH2qxSN6XyUdikMLnnmSFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K1WCIINUPWnJ6/SD1mJAIsPM4Api5ogTvG0FxAAa+W+IOEDBnwkKcVre+vXR7S91F
	 f0w+zwPzq0DGCtmoMK8qNa+b0u/XgDEnbZWiKDVK1Xfb2CmKmdN2Nr9ZGKHywjqtKW
	 ZR5tVozHpRYPhSrJJPpXfB6JDr3hLR0y9ZmzVewRknXUDDED7wcqzMIfuFXqwMZyi8
	 yJZ+OyBlPLtkp3ZpM9BCYChFC1P5fHpTwvDCxWHDAr4r2S6H8HDt5Fuo6zzKwO7Pca
	 m66CPIJsZ0jLIbV2DNFptba+8tRxm3DFFbJq+Xh6R0fKaNLNI2EI0Sea8awHC6rjrQ
	 qggTfPTVXEEoA==
Date: Wed, 17 Jun 2026 08:58:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: tsens: add ipq5210 &
 ipq9650 compatible
Message-ID: <20260617-spry-stylish-dragonfly-da0173@quoll>
References: <20260615085218.1421347-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260615085218.1421347-2-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615085218.1421347-2-varadarajan.narayanan@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 02:22:17PM +0530, Varadarajan Narayanan wrote:
> Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
> ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
> standalone v2 TSENS compatible with combined interrupt.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v4: Fix version number

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

