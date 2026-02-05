Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E430499A;
	Thu,  5 Feb 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291179; cv=none; b=L1UqZJU8x3RGFV4Rm9szShGPyCYZQIuAZtRk/kYKp3NQ3WOYwHPGw3Kgi0gYjrqkZrsA7wgbCaTf7DguAAbj99UyxxzXHGIEchvVryGqWM0OwwBsFWUiKGRowrXCp+gzL3h20FOc7l+EqsVwCrd3YLBvQJM0cQHKsLzQ15BXE7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291179; c=relaxed/simple;
	bh=P4ZwgmEFwWuk9hjrWBwpZjmoLLL/Y/YJAN5ooNOu0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZiXsXHGky4efiFJdDw7+nCY1WeoFS6g89cbQjpCaziyj1xE6GQuLKn4Z4Fpt+rAgWV1btaG4J09o4tRE7alcOXaaOiVgWI1oIQv7p9E7YsKEHIDXrJfi180tKdGlctqAg5ZdMyGgTsaF59xf94LqI8woFfRjp67QDpli1r1EYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEYMDdlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEYMDdlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41E7C4CEF7;
	Thu,  5 Feb 2026 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291179;
	bh=P4ZwgmEFwWuk9hjrWBwpZjmoLLL/Y/YJAN5ooNOu0uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IEYMDdlKA9PbPNi0vo3ba+Y/Zhy/k8KxDytnoOYJpm7Ftn/gWcD+0RnUhERCw/AWE
	 C6NXUVB4LegYFVH/l0vPNVkPCyGy0GOnvR8q8p9qzqw/ieouROH6/NwKUyIBQESC1p
	 q2+wDjfP/ZLs0HD9+URPzrFUzXHmozauTNvw+hmmiXCeLdSeofmAOid1EDBvZ4+ceU
	 dogT/Xqd8RyT0plrS/bva+gZACVvx9XyIuKG7U13WPGw/z8FADDwULJ6/DRiLQPHu3
	 5Tnxdi4LVlKAkRH7tUZ9xxyW6WK1shCDs628G3VNMkxpJ0nco0ObA6x0F7PeF/rhPA
	 +9UM4UwaO3O7w==
Date: Thu, 5 Feb 2026 12:32:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bryan O'Donoghue <bod@kernel.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Dikshita Agarwal <dikshita@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/7] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Message-ID: <20260205-vermilion-chupacabra-of-teaching-f964eb@quoll>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-2-70fa68e57f96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-2-70fa68e57f96@oss.qualcomm.com>

On Wed, Feb 04, 2026 at 02:59:50AM +0200, Dmitry Baryshkov wrote:
> First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
> are powered by the MMCX domain. Add MMCX domain to the list of the power
> domain to be used on this platform.
> 
> While we are at it, drop minItems from both power-domains and
> power-domains-names, it doesn't make sense from the hardware point of
> view. There are always 2 GDSCs and two power rails wired to the video
> clock controller and Venus. Disallow passing just two.


the min-items were also serving to preserve ABI which you now broke.
Same comments as previous patch apply.

Best regards,
Krzysztof

