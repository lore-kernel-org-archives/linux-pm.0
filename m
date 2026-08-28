Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB803FA5F0;
	Fri, 28 Aug 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911101; cv=none; b=lh7cJp8gdfh75GWH6zbZdLIyqxg2zSbfjp1c3Nz4bqn6TxDhWRDjhqjfuesAMAEf63y/FjGG3n6Suhtw0ZyjOO7vqXn1NBsxzmNqKZFdtjatgcNhxUf5LT20WO6Zu6weqc3bHl2jLWlDrCN3aoTRzuRSgI3zf53H4f9NaYcFmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911101; c=relaxed/simple;
	bh=eqisKdwrWRZLN3d+3tqRtdruD2WoPzlMm0RKSolgWss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAvJJIGGRfKz2HMBbFosnn7xpnTowOiEP9RZclucjjXGsIH+ZxEIN6nhvSwf0cpMc2cphj5aNhKwKc2iyl5+vYLLWpciz2qTPNmO6/JS9tI8C6jZVJ/ZnEvgZC6fu6tHizAMoS7eToIAhqUyFlD9PevnTw19iZ049l6EHKFiOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cONpQCAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cONpQCAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B641F000E9;
	Fri, 28 Aug 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911099;
	bh=xedyiSQKgGejxD9iPtP8HFyzzfkSAjkd6iclSXBvTeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cONpQCAnszVJ1+hhUzUC+aQ4+ieZGXQtaqSondNR1FYNt81uaq5LOsG8SwAkSOWe4
	 rJVDd1QGwW6cJR4D7fQ7FDIRiPivBLrWzKvyJpxJNGMFz4CAT/WRr8RDIo8Tc71IUq
	 c649nz8TncdbnVvKfXiZig0MX27eSBgPUhnEJO2Z0N21LHRcpVoPVh+yRmCmBcGcUq
	 NgIO0EFCw7sw9lPXyjx9lFAnWICcK7Yh7dRXMA7dSstbKjSPpaok145tBkVFXbuGrK
	 hqRlXbpzdT33Xvf6iOaPcB46w1BEARL6u2BxByaEhJv584gYtfR+bE2MN+iN0kNLrf
	 EjdZNA3VmNtzw==
Date: Fri, 28 Aug 2026 11:58:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, 
	bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250
 cpufreq hardware
Message-ID: <20260828-able-okapi-of-acumen-7b740f@quoll>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-13-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-13-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:55PM +0000, Sreeshankar K wrote:
> Document the cpufreq hardware on the SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

