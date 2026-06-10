Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE638E8A3;
	Wed, 10 Jun 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078054; cv=none; b=KYphqMGGkzhizmbDvO67aDobO+2EM8XTnM4DAIiTM9YUbxbM+Xof5ja4K7bKfE0ZduiK7Zk5X9I2IHHvA2y0Ojg1m5GqjyB1eHrEORujRUYJ2v+peLaHlC66V17mK0OmlHpm4QVtl8UQ253f7JpSB/OeuH5wNlcUI89CG6nVnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078054; c=relaxed/simple;
	bh=EZt313V3XBHsMTSdBH4H7gf0ggLn9W/jB/Hnu4Kt9iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVQl95FrjlvgdsD0rxSQJb+nX76S7zSS+/jRqwg+31rJs/iwrkKiisBjpiSUbq5krcfBTfXjRp9P7LouOUrRg03ZqPoQ2IN+gkqS9/1O8Wut+T/4BFCS8n51jlqPCCENPtG8dk2gns3bk7Zs8/Z1+ViMutP7USlihx0hGmyTMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faIkrX2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faIkrX2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475461F00893;
	Wed, 10 Jun 2026 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781078053;
	bh=72J1H07Ckymot13bmg9dt75OSqZpl2qtULP3pI4S52I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=faIkrX2TGiITs/ECUR2TMszYWKzOpl64+36Y5xABGOXpkoCrzGIEPwkFEyT+7iKIc
	 oiSbyqCXWEptm7KoNImLgu5D8aCuhw9TwHPzkCnhhQkp/+V0lli+I6w16MnPEsYUZS
	 zHMGLNkfpUshFPOxcNxP60WhHGnNWkL/cfywnpxot5wUrRUfUyR8eW847EUo7+muUA
	 tJ/3/o7qoogtLd8623V3oUR3dApJj07mS9zyNlS4ajLQi/XLyikQPX9Pgfl+Zzv/xM
	 zqkcM083iA/hAvpbOxsrKnEnGBEJvmK75pwafLlzBLdnRb6k1YL3jUudi3Qwp/QKDO
	 PzDQwfWLpP6SA==
Date: Wed, 10 Jun 2026 09:54:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: tsens: add ipq5210 &
 ipq9650 compatible
Message-ID: <20260610-whispering-porcupine-of-bliss-897557@quoll>
References: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260609065447.4024695-2-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609065447.4024695-2-varadarajan.narayanan@oss.qualcomm.com>

On Tue, Jun 09, 2026 at 12:24:46PM +0530, Varadarajan Narayanan wrote:
> Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
> ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
> standalone v2 TSENS compatible with combined interrupt.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v2: Fix fallback definition
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index 7d34ba00e684..a927650c119b 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -92,6 +92,13 @@ properties:
>            - qcom,ipq5332-tsens
>            - qcom,ipq5424-tsens
>            - qcom,ipq8074-tsens
> +          - qcom,ipq9650-tsens

qcom,ipq9650-tsens need constraints for interrupts.

Best regards,
Krzysztof

