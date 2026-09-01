Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92126F2BF;
	Tue,  1 Sep 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249221; cv=none; b=t+eK7PVv5P+o7mOmlTEjUygegQ7hIOuTSKzx2KD6nC6FFul/XXMBmxAvBQDLKysxjsIR4GVcgb92GHPp1qHGVa3Y8KNis4R0eKKNoFM0W9cFqCOh358ekNHkD6FQhFPqElLjpu63WENcgV6kgUkY7s6Eq13sfk/K6/iBbyk8Msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249221; c=relaxed/simple;
	bh=GKQEZIrolFnYoDEPWXCDf6XPezyNCMGHhG0SES0i+w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtE3dZxKXXxCBYfTR2GtDAGHTdYqVym35Ij35Y4Fu+LDLZfqsMAeLbvbaXA0D2PWVsnuLnx6Vmll0JaKsMECMzX0idCMuiL+ivV8XEuewwfEdQH8AfDI+4ulr5itWDtbM7OdYUSsqr1D0Ruu1X0rqid8u2MmAFtQzkEzsYc83Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvCQ+XbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvCQ+XbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065CC1F000E9;
	Tue,  1 Sep 2026 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788249219;
	bh=nYWHO/BYqDIdn8dYvGxMzWWVhK7Sib/Rj+KSMAXGayE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BvCQ+XbC0PM01UKGWp94G/nCvIBwI8I0D3vl5AA7LjToukoDS+uUK7MO1pIVVl/aj
	 I6t/QlHPrecba7qBDUAccRf6gI1ZBQxnlTqwGytgRtDi5zpjC6kbv32j+PaIXlOXFH
	 9AXIAO0IRvO5rzlJrIHKhnMzrR5zxIyXRYX97+rMnZ7qAZe8mklMAoaxlp9453rE8G
	 ZkzxFTPokaj1OxzVGAHUAsjzQ/nLqVW9oo2YeH9ncqdqd+km3mo+YgoppSjz1zNx2r
	 LPR3z/AlTE7HCCxppW52NU78gn29xeWLHpkqkucsgtYIK7sMpxnMfOy+aEAuHbQgFS
	 8Eazk6ZL0ezRQ==
Date: Tue, 1 Sep 2026 09:53:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Message-ID: <20260901-orthodox-hyena-of-abracadabra-fa2b31@quoll>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-6-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827-kuno-soc-support-v5-6-6d47636a8f09@oss.qualcomm.com>

On Thu, Aug 27, 2026 at 11:21:09PM +0530, Hardeep Sharma wrote:
> Document the RPMh-based Network-on-Chip interconnect providers and
> associated node-ID definitions for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 118 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,kuno.h       |  89 ++++++++++++++++
>  2 files changed, 207 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

