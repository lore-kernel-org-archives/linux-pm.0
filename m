Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E602EEE76;
	Mon, 31 Aug 2026 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160550; cv=none; b=B4ft3SibE8Cijv4HNyf5X9UlMx0K2WP4wY/sQSUWLKRAF5rsEjnj2FEROHlvokd97nZeYhSEtoaybAyl3jnvPxnnTUVt2efxOLJj6Pv8rJkUjEJYHiSMx9n2UK48Ey1Wt9+xVr8vFJkNZHY/jF/+piB3hWFeDRr8bUNKo9T0bs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160550; c=relaxed/simple;
	bh=Jhv9dnfb4r9lVTlNH0pbT/GU99DJo5QcB1THQ+5AkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoBJH0EhQDvUyWhNRdjzwuzixyxLOTVUDm8TqCpYCLURjoxsm5jb29J/a8lrLvPLqdeoEnhZ/+YXZPm+fqpp0XdmbvpyqMN6zB8tUfKtqd/51SNg9qDywgD9OM2BQsotJFvYs0OvdhA0Al0Cr5au6apQY6/86/f4/dX7L9NTF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyBUr4Zx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyBUr4Zx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF541F000E9;
	Mon, 31 Aug 2026 07:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160549;
	bh=YMmTrDcw7M/LAr4YU/0uekZXL2PNRhokJqa94waiuNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jyBUr4Zx8s3NKnQn0Cjk6zRAD1ZU7m1utUzQOaIAJHfsByjmAvA9jIjupWYn5OwUc
	 rFiel7zS7wwdZ0lilc4uYI7tYROWwnIhKZk39hmaT+mWbx2hGXVgkuaFZvXwrdK5F6
	 OPTfCIUqsDWXEpqCORb/9guMHcj0vM1/tPMi+LF7cCaFxt1zUbX4+StXMe8DN59AXB
	 qvPBtSfaifj/g4kjC1PzmPU1y+IC8GUzlHajuhvCtRlkO4pZeyCTAaEX1MybM4KJUg
	 dM6RZw5rxnbPWT8s6fGwIVPJIjMh693njZFo7gXI1xJnQ5R/oiuGE1YfWdPVtY+oBa
	 IqDcUQx5LFx2Q==
Date: Mon, 31 Aug 2026 09:15:46 +0200
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
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
Message-ID: <20260831-amiable-awesome-ibex-cc7e35@quoll>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>

On Thu, Aug 27, 2026 at 11:21:03PM +0530, Hardeep Sharma wrote:
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
> 
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
> 
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
> 
> The soc: qcom: geni-se patch allows the GENI serial engine driver to be
> selected on 32-bit ARM Qualcomm SoCs, which the debug UART console
> depends on.

You need to slow down. v4, 15 patches, was posted on Aug 27th. This as
well.

Best regards,
Krzysztof

