Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85983E275F;
	Mon,  8 Jun 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931407; cv=none; b=VsLxffaXlq7yrSnoZj+xRJP4tjw6GJdc2LsDhTVyMc+htEk5TyYGWwSVN1zdvPR2caoemdrrekn1PT+zxuqQWEibOJ70MWok5L7ERyew8bCL6c8SI+eHik5C7+VbAQRLdnTNNWUSo5J1lF5Gnmbw5eVyOV3O/rXucPqfWC4N714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931407; c=relaxed/simple;
	bh=bPhomuasu6Q+0DBnKHEAjJ7IHxLg/GC0AK6dL5klywQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpz3THltNFQABDo1RYd5IqpB39dnf0a5nGw9yBElZsZEjQrYHch5C56zPEiYnKJSJEzboFfiTkRI+KNiRwvC1VlMvOb4gAm0SYKd+3L6upIs8cW5iP+EkZpEnolo715W5py+KXy0Nk3pMtYfZeRXJ6Y8G9Ko5qPGQ3DeqZly510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANXHFp33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANXHFp33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4CC1F00893;
	Mon,  8 Jun 2026 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931406;
	bh=hkndTbrT1r7tieuraToUJXt3JGqX5yY3VwdAGotOMmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANXHFp3311twQZ1kOJUEk3jIkKtgPgnaotlgZ6A4xPqR53TZmdGnxmLtWtXdIERnO
	 2Rk1KzTliOeX9hyILHLzIt6fMmpthETBItXjkJhbCm+i8MLMMGZSnCdaQKpillah2y
	 1MbBV7Xf837dn8vJm7AYFB7wmHux9jOvCur6opJwyRPOCTmoaDYbU+d3Y4lG+P8pg3
	 NOA3ALHcgRK67OsZpYfFEJVJVcXudOCD/2TxoJ1Vr8Tv3FuY9j2WQDIMbKG0E7t8+q
	 cE7yTtH7PRbMrrpef6bgw403HerOj6iOpXefgpAYaAiSiobF7AdcX0Wfvb4y+K5khF
	 KwLSrXjtKUMXw==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/5] Support enabling interconnect path for GDSC for fixing Milos camcc
Date: Mon,  8 Jun 2026 10:09:56 -0500
Message-ID: <178093139444.244194.10957734005800853010.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 May 2026 11:18:28 +0200, Luca Weiss wrote:
> Some power domains like CAMSS_TOP_GDSC requires the enablement of the
> multimedia NoC on newer SoCs like Milos.
> 
> Add support for getting an interconnect path as specified in the SoC
> clock driver, and enabling/disabling that interconnect path when the
> GDSC is being enabled/disabled.
> 
> [...]

Applied, thanks!

[1/5] interconnect: Add devm_of_icc_get_by_index() as exported API for users
      commit: 771ed1b12942dbf592c34554c81f25a627fd254e
[2/5] dt-bindings: clock: qcom,milos-camcc: Document interconnect path
      commit: 7e622e74d2700da4d6ed3aa2a4d7e1b7d7293768
[3/5] clk: qcom: gdsc: Support enabling interconnect path for power domain
      commit: bd09d87c55d6e7783ee2394c30061d66cc9df299
[4/5] clk: qcom: camcc-milos: Declare icc path dependency for CAMSS_TOP_GDSC
      commit: 205aefa0db8bff56f08d0e06a0ca628555758805

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
