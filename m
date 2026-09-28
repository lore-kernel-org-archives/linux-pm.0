Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F634078E8;
	Mon, 28 Sep 2026 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575241; cv=none; b=UbgU1mUYN1JJXnwdqAJiza+d6ezblL9xTIsZzSu0kErQA/miczdEI+pjK/AP99GJBs7KL7DX6JgmTV+bXd56OIQyjptTeI9/+JUMWdvsqPVs3LwS1n3C7+vBKXW9Lq4DJzjkUKtz7tquMNCPpDFywTWIxJJKT2/xT1che9/5iYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575241; c=relaxed/simple;
	bh=K3uMva7d9WnPdrm/iqWhJRl1LnOJxT1/2FNjqgcYsPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWFr+e/vBcG/KcGY/rwRG56hN+b6UTiuTp+rSeDTBYxU+/X7iurFa7z7fzhZGogjI3r1Ih0G0e7UmQhS2sYz+TrRN+RL+u3pX2HuWleais9HFqkxlDq63H1iPfhcUGUMft2Aes44Rj5+PkvRH0dr+0a0AvZ5WnxaIoIJTMcDvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0bXdv4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0bXdv4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766291F000FF;
	Mon, 28 Sep 2026 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575239;
	bh=t9pKM+MlAPbDUZEiqQ8pO6ftc9z7NmBVCj5vCnlWtoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I0bXdv4jZuTShWJfhlPoE6ZNnJlgvc35a0SdLsa6fcWtGur+jMv0fdFwyfSfjQg0M
	 BjNAevSKzXVtGWDBU6/8YsrBENob6/2j7BdtwwfFD/Qa5xEVpToDvLcWX2+cdsvfma
	 fc51ZzpD5KmgDYzX4DqTufQ1IRUnwFZdqL5TaBMaOJXW33opQgRlDIdtCN0HuEB83F
	 Vu9EkRj5D3aSriVZsnIIorEpqDR1tYLwU7KcJA0MMmkG1yiDZhNrIMYKDedUYmP379
	 qFpCTFUSZ1fOkFzD3XV9tyNdTwrN3CeRES1stX8JOL6Nor5BwIFPOeLwQrRjggLXZ4
	 8hAHwcDlfsnJw==
Date: Mon, 28 Sep 2026 08:00:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom,ids: add few more SOC IDs
 for IPQ5210 family
Message-ID: <20260928-accurate-cobra-of-security-efbbd6@quoll>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
 <20260922-ipq52xx_new_ids-v2-1-4b1a0f3d04b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922-ipq52xx_new_ids-v2-1-4b1a0f3d04b2@oss.qualcomm.com>

On Tue, Sep 22, 2026 at 10:03:14AM +0530, Kathiravan Thirumoorthy wrote:
> QCF3211 and IPQ5211 are the new SoCs based on the IPQ5210 family. Add
> the SoC IDs for the same.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

