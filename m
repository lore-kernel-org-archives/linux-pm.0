Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2F3B05AF;
	Wed, 23 Sep 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152600; cv=none; b=oSNqoA87iILA4uKANHlaatu4KTY08dKIGKURl235x7KKoZ0fb77USSf+dDXP/LyQzrQYeurcUOHwtuL46LncjcmAFT2kLqOxUQtENHlkBo1q753SHDAqpzxGtGKlSPEnBzwaNQM6dmcaonmBUd2q3ajBTqQBj6nojzWgj/ofDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152600; c=relaxed/simple;
	bh=pIKL25u+pkh8Tw9brVYeuAUUS8Ix8atvIczZ+79EDqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sckG446XizAiXTL/cZKieUvAnZz/dQd/CPyqeCnq1VZcv/vdm/os76MtW2q1p9vmgHSwMx7SLFGCGm1MgMjObQ6m/35cfoeFOnwJ2WT6Pd/ysQZaGT7a5y4FRIb0H33Qv3+25sT8tNEyvUf01eWQAWKori10Tppx3vW2E1ORnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e5aypmkN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e5aypmkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790152587;
	bh=pIKL25u+pkh8Tw9brVYeuAUUS8Ix8atvIczZ+79EDqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e5aypmkNDlu87q3PuvIE9WjhpjIu9trcaPkaFRfgh/gBzMqUOEUikd1YfLNohz/M5
	 B5I44SlSL11n710pEQMXJ4Sj8t1tLD2DDqQeNKKh6rxqHvjL6sk65Jbx6mjoNZi9YV
	 ovXbioqaw36JaLI1bFfxy6ZUNyTmB7cfLxe3VMjftEpAhI1gmpPICHpE/hSeGgjSF/
	 1zrRpeoTSBcsCltuk6M6C3mxysvGAC6C6G6rH6O9lcldOmZkH9qW2/WefMHk+sQQRT
	 YdWfWdo8WHOALWOYtI1HKnvM8HarZrFe9+NEH2Hhbo8KICXaOnprTtIsmERAYt0iRG
	 DWMTeqrqLJ0ww==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1187B17E0104;
	Wed, 23 Sep 2026 10:36:27 +0200 (CEST)
Message-ID: <b98716ab-1c7b-4da2-85c8-e425be39b4d7@collabora.com>
Date: Wed, 23 Sep 2026 10:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cpufreq: mediatek: add mt6572 support
To: rva333@protonmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
 <20260923-6572-cpufreq-v1-2-41f7af6d6d1a@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260923-6572-cpufreq-v1-2-41f7af6d6d1a@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/26 09:23, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add mt6572 SoC platform data for CPU frequency scaling.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index f15135b2898b..615bccc77c98 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -737,6 +737,14 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
>   	.ccifreq_supported = false,
>   };
>   
> +static const struct mtk_cpufreq_platform_data mt6572_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1250000,
> +	.sram_min_volt = 0,

Are you sure that there's no SRAM regulator on MT6572?

If there's none, there's no need to set sram_min_volt here, but if there is, you
also need to set sram_max_volt.

The ccifreq_supported explicitly set to false is ok for human readability of the
SoC features - that's also unneeded but keep it for the same of understanding
what's going on with this SoC.

Cheers,
Angelo

> +	.ccifreq_supported = false,
> +};
> +
