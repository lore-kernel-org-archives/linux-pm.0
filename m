Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05D3D6CA5;
	Fri,  4 Sep 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509644; cv=none; b=UWiH8U3nd+aIQW6ipR0eAP4ntd/6T1+3ArG7WoChYk/Tg9T+79+BHWcAW/pQJ3hsPtdJ0YxP/yHvIxpLwYCFCx+ZcWunCA10w33m2gd9xAxie+H4BdvfKJZaEhqR5BXKEhWdRup2tevf6LnOn2EmKq7GFWeuYLmHhz3VqqKORL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509644; c=relaxed/simple;
	bh=e/2Zgoy8BfvbUfTRtX2XvZNXp5wxQdtS8OcL1cqVA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPy3BxQsiFUS7+nMIkKZQCZXdT4h//F8b/KuZu/wdZS/4ZFrmMn1Ps1JAxjeSGlBLRcxCjHc+xFzxmKF9wRDmdoPok7iSxpCqFN1nhBBgpoSl0MBc+Wmry0CbqZfRmUDuS8GxjE2hsHj1SSUAXlzZmq43F7J07NBPoF3ekx6qS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZnVDL3lx; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZnVDL3lx"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72A16153B;
	Fri,  4 Sep 2026 01:13:58 -0700 (PDT)
Received: from [10.57.5.232] (unknown [10.57.5.232])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18A83F673;
	Fri,  4 Sep 2026 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788509642; bh=e/2Zgoy8BfvbUfTRtX2XvZNXp5wxQdtS8OcL1cqVA2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnVDL3lxB4KG0sAC/ySibkg6SA6GeGr++WJKM4KH+X3PQbetFI2zGxmmxvVx6HDte
	 Dong/aBR7nVJhIRALQ5YbEtqwhI+bc/6pBNXtYftnwk/PvY8ldJRAlSIqL+NjXtYt8
	 78BceKMBMgGrknc8J/q2NKn+ckGcxGMKUQaIsFyc=
Message-ID: <92153d54-e7aa-4fe3-8317-0060b4078d6c@arm.com>
Date: Fri, 4 Sep 2026 09:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: exynos5422-dmc: handle clock enable failures
To: Jiawen Liu <1298662399@qq.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, linux-pm@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <tencent_405FF24AB67AAAA26BC85ADD092710C0BB07@qq.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <tencent_405FF24AB67AAAA26BC85ADD092710C0BB07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 14:19, Jiawen Liu wrote:
> Check clock-enable failures during probe.
> 
> If a later clock cannot be enabled, unwind clocks already enabled on
> that path before returning the error.
> 
> Signed-off-by: jiawen <1298662399@qq.com>
> ---
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> --- a/drivers/memory/samsung/exynos5422-dmc.c
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -1297,8 +1297,15 @@
>   	if (ret)
>   		return ret;
>   
> -	clk_prepare_enable(dmc->fout_bpll);
> -	clk_prepare_enable(dmc->mout_bpll);
> +	ret = clk_prepare_enable(dmc->fout_bpll);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(dmc->mout_bpll);
> +	if (ret) {
> +		clk_disable_unprepare(dmc->fout_bpll);
> +		return ret;
> +	}
>   
>   	/*
>   	 * Some bootloaders do not set clock routes correctly.
> 

As other folks mentioned, please align to the procedures for
sending the patches.

The change itself looks good, so looking forward for the proper
v2.

Regards,
Lukasz
