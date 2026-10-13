Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643227E792;
	Tue, 13 Oct 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872680; cv=none; b=PPtG02onOwTp61wYsH6SOufrC3aKzbVpze3kiTWYVoRlkjN57f7pXjiBqfaBIXK6qgd1/Qwj2+9By5m6+Zxqk+WL1MBoKiMc2ib5YA1pT63HrH6p3sQl9wNMVJPcXi/3E2L61waWNBfGpzIBvOx4ujONsaPgljcXvZ32ZUMk/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872680; c=relaxed/simple;
	bh=QojYWdLEDLPb/17elYAw4JCexvhyxM5gu1w0BtA7PSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3WoYNo9I8MI1fF1IHqU1J6tcNpbBxINtJNpBg6KgW/v2cDHkAEJISHcC4eJ9BDGdRwQ2B8LVZMv/FkxJ1vQgMLwzXfw4LnCR4CKgzyhbNXAEDFp8UPi4Ml9EfeBvCe2q/5fSUXl+lw57j0j8FsTAO8e2AeckoFAM+IIfm3eETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax4eisFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax4eisFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F91F000FF;
	Tue, 13 Oct 2026 06:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791872679;
	bh=j/L7A3Rfpyj3M+jKYuxrkHjlngaKIfVbDpPiwUAGjik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ax4eisFP4lNC6uGMenPGerBbSEDUwCMRezB9RLt32p2PvskQxB8kwSkNsDR00J3mw
	 AyYc2gYvsPnj7/LQdY9A9xa3ZOmUuF7Wk9q0xFMUSvsXqJn4T7tPPdp5HBkofZCMCr
	 tKyjnsGwM6pBkMiS4ubTaeEnt0EDoBDcPJlNheN8+HBrZa1czy9XLUwbLTeeXiIZ9t
	 iRlBA5QdCpr4OEuPaBgqe9PL/dt4lZgF+TRO/6AcXpUTlNDJsEfyDr6ql8lJU+yAWu
	 ZppYUluPZ3DaE/4jxiJgHX+OO1wLvCCbb7wIj809qKASKRfZmwPCkOk8VQEYHmFT+w
	 6grYfs48HBoCg==
Date: Tue, 13 Oct 2026 08:24:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Subject: Re: [PATCH 1/6] dt-bindings: thermal: thermal-zones: add
 hardware-binning trip properties
Message-ID: <20261013-jolly-abiding-wolf-bab43e@quoll>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
 <20261002-thermal_bin-v1-1-5a29be7e8ec5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-thermal_bin-v1-1-5a29be7e8ec5@oss.qualcomm.com>

On Fri, Oct 02, 2026 at 04:16:56PM +0530, Gaurav Kohli wrote:
> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> 
> Differences in SoC packaging can be used to provide multiple SoC SKUs at
> different thermal and performance characteristics. The underlying SoC
> remains the same except for how much heat the packaging can dissipate,
> thereby influencing the critical trip point at which an SoC SKU needs to
> be throttled. This SKU-specific data is typically burned into fuses
> during manufacturing and can be read back at runtime.
> 
> Add two optional trip-point properties to describe this:
> 
>   - 'temperature-bin': an array of per-bin trip temperatures, used
>     instead of 'temperature' when the trip depends on the hardware
>     revision encoded in fuses.
> 
>   - 'thermal-hw-bin': one or more bitmask groups describing the hardware
>     revisions for which a trip point is valid, modeled on the
>     'opp-supported-hw' property of the OPP framework.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml | 53 +++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)

10 days was enough for replies to feedback, so dropping from patchwork.

Best regards,
Krzysztof

