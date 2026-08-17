Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6F265623;
	Mon, 17 Aug 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951856; cv=none; b=ZgNRQ1Vh/jIgoHVN+z4lHpCC2liwaK6Tc5pHJw/DFSGzPKOLnXpu57tkL6Mvslo0LcBKZ+DSjMDbh+EKtGhirB7DHdHVkxdU3TN2/l4/ABmycFaiCPa/9MvycxAh9vEtPy4MB8awrl0QwS3EqLBELkirWyy3f2pme6ZEqmBXZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951856; c=relaxed/simple;
	bh=7rGtYi2sCC1wDsHltJRghkC31G+9YlD0aaK5J/vcnBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uANVQmteAAB5XJjxi7uHC8NzHP9B2YkGLt195ZwnOw61EL3nKl9gtVSbJeWwMAIPkJnbSRBwxb0lOMO+2VuoyYf3j+fu5QGpFQchMMs8m1uNxDr2CYIMzo8IuZMBr5hlx+kAxnWOG1EiQynOPWYGCcRTl4jwjW1PTaCkkay67z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXsYiIHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXsYiIHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62E11F000E9;
	Mon, 17 Aug 2026 07:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786951855;
	bh=+Fd7pzNoHyUBnTjJJpnWRPeGYZJV4vIlYLFWplUVzYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dXsYiIHpunmj7OQ6/Efrvkr4t8pr7EibUF2BO9xuUthST1xV8rGn3eEZGIVWONquD
	 u4LKNQI+cRdbwZ8dYZA0i1SH56FNvgMvrUHnBgwLMM+ntgEEVb6sUHYoCttdQN0w8I
	 U2flXA7Hvzrsb4IwUBdz5RS2sa9tYKSW/f2c2SIvnycq8NJTYY6W6h9TyF33c+2qSh
	 Qbt3HW/6MZWvIwCdiVul2yiaUrgoUwBWOXaIBLg1DtA/U1hVPsPEcGm0xeogI6uEiE
	 Um5x5p0/DV9qFbsvo6QTCB1pr3HigufgLu5CHVAH2HJ766L/OQLPTZjBgPZThNonjF
	 Zevt9Y83nwAwQ==
Date: Mon, 17 Aug 2026 09:30:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Message-ID: <20260817-speedy-nimble-heron-a4aeeb@quoll>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-10-3079794f0f73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814-kuno-soc-support-v2-10-3079794f0f73@oss.qualcomm.com>

On Fri, Aug 14, 2026 at 01:01:41PM +0530, Hardeep Sharma wrote:
> Document the Global Clock Controller (GCC) binding and associated
> clock/reset IDs for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

I do not see how you addressed my comments. I should not be needing to
verify if each one is implemented and then say again the same.

Best regards,
Krzysztof

