Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926B3A1695;
	Thu, 21 May 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359245; cv=none; b=q12/BZDsQ559TzxuqKkQ711rx8slobZ98YnpcVZfBKzBNw+Qm6SwLTMA1/qo1orozkW+isRL5hdoSMTQaWsFdBLVuRuRMkzx6za683HqSLOu3f0tXZNTAk9wRlTDJADcGJwNL3qbipTdwLqkBRo4XQKzAR5N53sfA1pn9k+6qNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359245; c=relaxed/simple;
	bh=vpQGoE/t3q+i0Qnd+KlHa7R6iLo0EN/1ZhwDVPbxIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRHB+o5bsycan96QJPO1kdBkK/gb+u7Hj/sOg6vzptQpaNYFitoTGyS1QUYZX4EWy/FCN36VyN6OLcge0+LpmV0beR4/dd9eSSTNO5Rz/nuctAjXMbMdmhjxDTVriRajy6ModBmpXXzIFOXjAQx0idq4vcp7anOAkA/OvhoBcfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP1Gk7yA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP1Gk7yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC01F000E9;
	Thu, 21 May 2026 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779359243;
	bh=6UKm7IohSoMp4xhzCIyfqAWE32QeWV+gE1Gh8Ky41yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DP1Gk7yA0FOkO7mqztPhHiPxWZTQEqXUi7AhDduLReAf3KNxS2MXXttcCsjr6jJED
	 4nei0HydFZP6pQWs+KxLIUitexm+SI0Ke6EAnrp0bYPpSoGfrPuRN0ChqlURDp3OvM
	 v3UdK//H4d34hGb5gI2T/xt71C6nk3rDhVjfipYo/0UKZeKG0zGaimT3y0hyp9r83W
	 dJ0TgXUJlwIeNRLkFVtmJ6iAgYyKwZ5jSfdB+0BA2lkpV6NTXMcxO+jZnSvGT3lQDa
	 mM5V2MVhJwCz0h83LqCoS72DNjwoA0MTGpDXosmcO9C5XuY4j/8Md67n+NmRo4/ieC
	 KlJ28qlZVs1MA==
Date: Thu, 21 May 2026 12:27:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abelvesa@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] interconnect: qcom: x1e80100: Revert ABI break
Message-ID: <20260521-pig-of-undeniable-abundance-91f70c@quoll>
References: <20260520184944.182148-3-krzysztof.kozlowski@oss.qualcomm.com>
 <2b5a516d-f847-4cb6-9ea5-21f56448b00f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b5a516d-f847-4cb6-9ea5-21f56448b00f@oss.qualcomm.com>

On Thu, May 21, 2026 at 10:00:03AM +0200, Konrad Dybcio wrote:
> On 5/20/26 8:49 PM, Krzysztof Kozlowski wrote:
> > Revert commit c70f7dcd0921 ("interconnect: qcom: x1e80100: enable QoS
> > configuration") because it breaks the ABI without justification what was
> > broken and what was not working.  It claims the clocks are needed for
> > QoS, which might be correct, but QoS itself is not a mandatory thing for
> > the device to operate.
> 
> ???
> 
> Would a saner resolution not be to simply adjust the bindings change to
> mimic the other post-factum QoS clock additions, where `required:`
> wasn't altered?

Maybe saner but I am really annoyed with the fact that authors don't
care about dtbs_check rules and impact on users.

Anyway, commits were dropped, so this patchset can be ignored.

Best regards,
Krzysztof

