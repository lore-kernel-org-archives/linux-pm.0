Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB6F36403A;
	Sun,  5 Jul 2026 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295629; cv=none; b=WJxKjA2xYjHRrGkxYzHWHmcrbCkpC+8ggjWdichcewdrXW7lRSeYDosvyDDoCYvQpNRSZbRHy/AQXwKWenjDyHjIZsT3s/CaW7N7FpGhkHKYlQO5FHFAnRrrQpnSg5imahBfi7nDzrB8svhZ8xcq1ca/aZivXLp69D4NUNSrNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295629; c=relaxed/simple;
	bh=iwcVaZYgPbsy4ri+5Djb7A1qU1VNczfNzCRqx7FXrKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is3c2FOCttYLR4ZWZcV6izyDVnmwHFBEAnGz+yX/SwoGFiHLTfGGV5jzGSCYyhOXZSk+2v7+k2TMGU8zFbUFP5I74j+wujVC9LqpVZgUCAO0BDwGGG265d6SZ56B2jLKNfK9bFXK1JAU6rg7zcGFHRHdNYd4zQ12nTDPeowqLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6G1p+Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6G1p+Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28B01F000E9;
	Sun,  5 Jul 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783295627;
	bh=qj3yNwY0zendhsywgnw+TYQRDs6QQOxOCI07pz31Ffw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b6G1p+Uuj6VWSod8w5woz8LTtSItUEhhW6a3qAVW9c89hRuA5QnLfLc/dO5Il5Chw
	 R+oa6SZDFd4LLmZRvc1nd6lSE48TyKvcusgIdcZ0aM8Nw2ibrinyk+vE8NLCPeRx9R
	 JasYhPIn7kjo9GWx0mvfQJNRkSSjm1JtP2x3LqWBaAXVNqBmHCC0/RV75tx0WRW3P+
	 jZk3bgdZydR0fcgPcvjUpCOaI4XdA184PZK5Is8R4tiLhoLwuBiwxjPjwOui0N0hnx
	 2URNFvFxZCLizHhOEMeIPCCdp3KBfbNZzAGCikmeZkJKn5Oe1N4yPXr97c53xALH79
	 CtUuatB0kM5dQ==
Date: Mon, 6 Jul 2026 00:53:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, David Collins
 <david.collins@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v3 0/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
Message-ID: <20260706005341.0d67c87c@jic23-huawei>
In-Reply-To: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Jul 2026 22:23:32 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Support for the main PMIC5 Gen3 ADC driver has been merged now.
> 
> In order to complete adding support for the Gen3 ADC_TM auxiliary
> driver, some more changes are needed in the main driver, mainly to
> improve its shared interrupt's handling mechanism.
> 
> Patch 1 simplifies the interrupt handling in the main ADC driver
> by declaring the interrupt as a shared one and dropping the logic
> used to call the ADC_TM notifier for handling ADC_TM interrupts on
> the first SDAM whose interrupt is shared.
> 
> Patch 2 removes an unneeded print in the main ADC driver.
> 
> Patch 3 adds the auxiliary thermal driver which supports the ADC_TM
> functionality of ADC5 Gen3.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
I forget it we have discussed this before, but how do we want to
merge this (once everyone is happy)?

Is there anything stopping it being split so patch 1-2 go via
the IIO tree and 3 via thermal?

This is me being too lazy (or busy ;) to try it.

Jonathan
