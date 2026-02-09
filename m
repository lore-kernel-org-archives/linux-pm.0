Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B6C125A0;
	Mon,  9 Feb 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645675; cv=none; b=AutFzAa1x0rO8hm+bmTvlIt0YZY/AcVBE76eSaDmBNdH9aXy1Kx6h4utjmWnn9gMtrmet1tueqQXUJiTgebDupgeUUkp4A41Xmot4YrQC+Rno3Bmco/pcj95IZAM4fmFSif/mQPBBonWbwshMddFDINwSY6gBge+nNZuyMHauTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645675; c=relaxed/simple;
	bh=fYPBR01alZpEYRpDujYTEsPzZb1nOME5FDGaHE4a5BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+UaIJsio44E4z2meYmNJuRYNqD2GTDDyMsouDzeqvN0uRYxY6UcLpzRZBqYxFniuUYdtZCpaGGH7EKqnABFL8cYp7bLOGT2kIowXQ03m8pL8sDtO3Xbfoq5fneEsWg/8Bd+ceUvta5Rl0BKi5S7jD7Q4DCyswA/7mhularBKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6G5ti1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6G5ti1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261B0C116C6;
	Mon,  9 Feb 2026 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770645674;
	bh=fYPBR01alZpEYRpDujYTEsPzZb1nOME5FDGaHE4a5BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6G5ti1ZqRs5CWS9JhQXr8p5lqFEB6XLntBSZIavi229v1MMeDMcYKyXt/CtPMcNL
	 jRO3FtS3lSEIOSOUYkpdpt8pF5lCwuLSHNijIsAD9BjrYDbTD1bD/l4dxEAZq6ntN0
	 jblyMWO5IywmZ32ZU1UxiKm75z+ZDEfZYyJ82vny/ot7RxytYprawwbUo2hbpjgM0x
	 rTYc8N35C+AQ8cd4K5xiVnR38LSalP6zItq/uMXD0YHTMe0OAE3c99GDvlCgB75JeP
	 99qqpEa97gF9lpR7XP8VYWYVhhsptzSjXr/iKB8z2HACvXdoYDR7IUhfGg5MTqASuH
	 euGVLyF11GrIQ==
Date: Mon, 9 Feb 2026 15:01:12 +0100
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
Subject: Re: [PATCH v5 1/5] media: dt-bindings: qcom,sm8250-venus: sort out
 power domains
Message-ID: <20260209-impetuous-functional-caribou-14c8ec@quoll>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-1-0a22365d3585@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-iris-venus-fix-sm8250-v5-1-0a22365d3585@oss.qualcomm.com>

On Mon, Feb 09, 2026 at 03:32:16AM +0200, Dmitry Baryshkov wrote:
> First of all, on SM8250 Iris (ex-Venus) core needs to scale clocks which
> are powered by the MMCX domain. Add MMCX domain to the list of the power
> domain to be used on this platform.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/media/qcom,sm8250-venus.yaml          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

