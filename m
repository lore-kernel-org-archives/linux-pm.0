Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9538D68F;
	Fri, 10 Apr 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806003; cv=none; b=uIlv7N93Kr0AOmRkYEftiGllKHKKdPOsSyU7H2izqgyeosJ1r13brwlcxKf9cSS1XFyF5hi98+YC3J877w+FL8ceSEn6YWZj6y8hQHawPwswKSrgAFSLGdpf8K6o3u00KsYSakFTRBLbeZaH8/rRS8rAMtEzdgNNn6kozDlLUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806003; c=relaxed/simple;
	bh=a1gduW3M5G7bUw2e0IKIKRKOnodkiPsAGPFERA2yiBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCOzXq0388R7g9s3EhGJZVj9paMbuR29qOUgO4bnKXl4rsRnaIfFw2uK4RfJ2btcNGRvXTPB6x7pvAgXz+E7dxkvUIA/FrgpHJ98s1s53575Dsqw/LP1tVwXP4p7rYkNE14SrSc9XEYF3qJqHicEm7XfnUZilN2m50uQLsKSgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuw2sMvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuw2sMvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E66BC19421;
	Fri, 10 Apr 2026 07:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775806002;
	bh=a1gduW3M5G7bUw2e0IKIKRKOnodkiPsAGPFERA2yiBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuw2sMvGnM3VuokAWhST1C5WljelM/kT65RtZ9eTpAaEhQinIL5JWEx+mPQk49MBU
	 TQDZCSzwdoOgah7IM1HhNAIOA7I2Qz19+cgG0Xh3Qxcr9uHRZMbl3yomZHudZm0Um7
	 Vo7eEoy5aQnA6OVIh2OR3aPjvveGEimxh+pwLQICAEsbeEpFLvdGnDXsw3AVz565mu
	 Izc3WNd59kvwfbMDBhRhZIVgVRBJd0kka094Nw7cVS5ADA0BS3ktss6cnm1YI0qiD7
	 tt+RE11cgIydxHIrBgq6WDkvNkHWaVtzm0is5ijq8lEkychPnvfSOcrnQBWYf/COda
	 DvwTqvm/OCIwQ==
Date: Fri, 10 Apr 2026 09:26:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: document the
 RPMh NoC for Hawi SoC
Message-ID: <20260410-lyrical-labrador-of-experiment-83cd08@quoll>
References: <20260409-icc-hawi-v3-0-851cac12a81d@oss.qualcomm.com>
 <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409-icc-hawi-v3-1-851cac12a81d@oss.qualcomm.com>

On Thu, Apr 09, 2026 at 02:01:37PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip interconnect for the Qualcomm Hawi SoC.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,hawi-rpmh.yaml      | 131 ++++++++++++++++
>  include/dt-bindings/interconnect/qcom,hawi-rpmh.h  | 164 +++++++++++++++++++++
>  2 files changed, 295 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

