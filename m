Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80E1DF98F;
	Fri,  2 Oct 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935300; cv=none; b=ShsDlyZS4802h0OV9HN8lenG/XZnZQawdmHQ8zFGYUq30706MrzF/pvD0kb+bvre5WIJjWi1L4cwjeedG/GGRtQRltdxvvvNGRdKxHazMdXb0pW7nUa96YOyVfOtipSsOnF65BXN8Tj4zruDCvvIMU7mEfcC4T5+2f5q7qOuF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935300; c=relaxed/simple;
	bh=JtirlsdrOZiqMDeKC2KiUPHHDFVpd5a5iD2HBdqzsvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozjy69EWkmwttks2SOR7ETeuR2eNXLwzyrrIGR8mlqDtBxiZLcLJ4L1rxoBBqsKsboMX82OLwdpUqg1S9f1gaFwucphmiJGRg4X8so/MT1LAkfs0CU5B+Jml4clIfEL2P7FzatqX6eNt6ZUvMb99HTSAajR7X3OR+LH5UQmTPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtXv1Qn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtXv1Qn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB21F000FF;
	Fri,  2 Oct 2026 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935299;
	bh=SlPUmO0vovZ3zvIct67VC3UGZLnJIwfTCorxIZIMUVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtXv1Qn4iQdOPxJMnnV1eouSWX1NQiC1wr83AAp+oNtOXyRiGltWnrat/C5nvoQUb
	 pV+oAr7Qq428kQURT6rosfoaf/H2tZOC1v6cV2cfntOf8Evjitfza7O7qUm2WO67FB
	 Hcw3BRCp1mkwplcfZok/NCn56XTz2ssCYxF8eS/WqmSo0DdlDpBxGtFp9aVydgUv67
	 T+A4IWyw8QwICIXLzOdzQTzd9xC6PAJ/9vyOCJ0IHHPEm7M8+1q/O9dWTYGUjEd802
	 AaLR+Lv2BUdkUKDjU2sIgKBW4hFA83AGoooNo3uoBaLH25I8g+nS8uqXBqlTKS33ub
	 eQQQnepv90fTA==
Date: Fri, 2 Oct 2026 12:01:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: remoteproc: qcom,msm8916-mss-pil:
 Add SDM632
Message-ID: <20261002-speedy-alligator-of-courtesy-5da662@quoll>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-5-95c47d0f26cf@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261002-sdm632-rpmpd-v3-5-95c47d0f26cf@mainlining.org>

On Fri, Oct 02, 2026 at 12:38:33AM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> SDM632 MSS is very similar for MSM8953 mss the difference is
> mss-supply is a pm domain on SDM632, previously SDM632 MSS
> was represented by MSM8953 MSS. Correct the bindings to
> described it correctly.
>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  .../devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.yaml     | 9 +++=
+++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-ms=
s-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-=
pil.yaml
> index 4049157dd83d..049191cad5f8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.y=
aml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8916-mss-pil.y=
aml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,msm8940-mss-pil
>            - qcom,msm8953-mss-pil
>            - qcom,msm8974-mss-pil
> +          - qcom,sdm632-mss-pil
> =20
>        - const: qcom,q6v5-pil
>          description: Deprecated, prefer using qcom,msm8916-mss-pil
> @@ -79,14 +80,14 @@ properties:
>                       (not valid for qcom,msm8226-mss-pil, qcom,msm8926-m=
ss-pil
>                       and qcom,msm8974-mss-pil)
>        - description: MSS proxy power domain (control handed over after s=
tartup)
> -                     (only valid for qcom,msm8953-mss-pil)
> +                     (only valid for qcom,sdm632-mss-pil)
>      minItems: 1
> =20
>    power-domain-names:
>      items:
>        - const: cx
>        - const: mx # not valid for qcom,msm8226-mss-pil, qcom-msm8926-mss=
-pil and qcom,msm8974-mss-pil
> -      - const: mss # only valid for qcom,msm8953-mss-pil
> +      - const: mss # only valid for qcom,sdm632-mss-pil

So not valid for msm8953, but msm8953 has it, so you just introduced new
warnings, no?

Anyway, changing existing device needs its own rationale and usually own
commit.

Best regards,
Krzysztof

