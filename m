Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A032B47AF6E;
	Fri,  2 Oct 2026 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935050; cv=none; b=H6PAplQMkMXEKzMLW95WCdzO/WICkgsq0nzVcLowqXKLBAdJrcxvNXnvyhF0ZzXnfZD0ogpe384Ab67VmMoMK4LTMyNYEXUAFcdoC/MZyqCxipUCe4YevBmcEvhOMVzCnNbFcb2tdU1/BlZaLrgtSM/F0dps+5V8EQ4bD5DeL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935050; c=relaxed/simple;
	bh=qY9Qy/zjj5otB983nZyGB0RLI2KGL0XWmvAirNnx1iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARZiy06QZ6p1uo0zTRx4PRQN/jJ+w8lI4PObid+MBd5KZWTgZ1qKwChd+Iaz2UCQ3bbb1sKnKaSVNKXXdrGikEHU+n4IQkoVTnJX6LrHsYKuGnVhbUpIUU5lmPq5xjHbnrjHm2qOrIuXLd3N0Xc95nHaJLyDsUTJZW2e2MkFPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOnmRr5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOnmRr5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3461F000FF;
	Fri,  2 Oct 2026 09:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790935049;
	bh=PLeFu54Nd5rSMQsgmk8z/TW66IdcUrnWu2a8cKeXez0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NOnmRr5GZfqw+1btVcKPXx/ECYIxnDHl/RVP+c+SgzGdRqr9uXCheHqsscC2Zu2TN
	 Zd5/EUIIesNAf66IZwaN6yQauHNLh2v0yyx0XWGLCoUDCI2UdIjJb9yAE7nmb5/Z/F
	 B2wkj2OsN4Ek+Ut1w82WQ62aZYM6ERP1kBWxrWbmKU6FMIzpjh4Fp3gmMPLimSeCB3
	 ap2Y6hekZMupJZV8yOOpFcc1paW4sHNie2ROcF9zhFXSbpL8gh1IXLSPOmdbtFbLuu
	 z2N9z2ck7HCWUKUQPqogK+anFEiLuR3s3yWc2uf0b2RypMnqseV4An7MGAANYXVWLK
	 Ai3NsRny3nAQg==
Date: Fri, 2 Oct 2026 11:57:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Ulf Hansson <ulfh@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: power: qcom-rpmpd: define RPMPD_VDDMD
Message-ID: <20261002-devious-mauve-wrasse-66bbeb@quoll>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-1-95c47d0f26cf@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261002-sdm632-rpmpd-v3-1-95c47d0f26cf@mainlining.org>

On Fri, Oct 02, 2026 at 12:38:29AM +0200, Barnab=C3=A1s Cz=C3=A9m=C3=A1n wr=
ote:
> Define RPMPD_VDDMD can be used for SDM439 and SDM632 MSS.

There is no sdm439 RPMPD... The SDM632 is added later and bindings
header come with the compatible patch. Squash these.

>=20
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
=2Eorg>
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings=
/power/qcom-rpmpd.h
> index 4371ac941f29..beb066b3aa8c 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -15,6 +15,7 @@
>  #define RPMPD_VDDMX		3
>  #define RPMPD_VDDMX_AO		4
>  #define RPMPD_VDDMX_VFL		5
> +#define RPMPD_VDDMD		5

Problem is that it is platform specific and comment in that file says
"don't do it" yet you do it.

So the device has nbo MX? Why commit msg is silent on this? Explains
not much except repeating the diff and referencing users which are
almost obvious if this is properly squashed.

Best regards,
Krzysztof

