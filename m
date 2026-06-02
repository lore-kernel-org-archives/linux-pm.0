Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728D366DB9;
	Tue,  2 Jun 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417566; cv=none; b=mX5axlnFP5Nw9EZ0JyJxwQhmQ4raq9Rkm8KH05kSpvZazNZ9GpRtg/35N/dRaKkPoDEF7oyaFsKdhk7g71/jYBqHNUoZecX/QQljVfpjJqNCxZe68lpAchvsvLjL2jyMXC+BkCZOzwI/7FMY8JSaQRw8I8s5rghQgnxZIueh0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417566; c=relaxed/simple;
	bh=3PpZSCOhrX5Fo3r9Inj3yvrlHVLpHLHBcy3c4inz8f8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qja6BdwXhJ9riybS4reIf92QXXjMHrnsdOiHzxZslKdMFjZ8OAXMCHZfwpotabWeTT18Gowev1q13ICIdyhMqMGyFD+PcdN5qReomSpOKNSn/d5Kz9z3lE0gAa289BNvXtERSu0DWxQKY909i645Mkoi3JsBo1jenh+Z1+g9uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=Zt5cuLdl; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="Zt5cuLdl"
Message-ID: <60aa3f88-e8de-4594-9c07-832aa6d97b23@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1780417561;
	bh=3PpZSCOhrX5Fo3r9Inj3yvrlHVLpHLHBcy3c4inz8f8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Zt5cuLdllnhn6/RSFBvGVLVkHSYH0N/2m2xi0TnPS3BHc+i4DxP61s3qzdCh8m/k6
	 OhVN0kVWi9Z9f3m33lO2WNyhgDP/z4LgZQqCcaswTzwyIg1/YgvEQryErkU8gzolfT
	 0MkGNAR/9VNXcRMdVW60B/goXUDqg/EfYe8/3f74=
Date: Tue, 2 Jun 2026 18:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v3] thermal: amlogic: add missing dependency on MESON_SM
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <20260602-fix-missing-meson_sm-symbol-v3-1-6f7f69cd7d6c@aliel.fr>
 <9adbe3cb-d42e-4b89-b6d7-62dd58b98e15@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9adbe3cb-d42e-4b89-b6d7-62dd58b98e15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/26 6:01 PM, Daniel Lezcano wrote:
>> ---
>>   drivers/thermal/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 1c4a5cd5a23ee..810eeccedfbab 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -436,6 +436,7 @@ config AMLOGIC_THERMAL
>>       tristate "Amlogic Thermal Support"
>>       default ARCH_MESON
>>       depends on OF && ARCH_MESON
>> +    depends on MESON_SM
>>       help
>>         If you say yes here you get support for Amlogic Thermal
>>         for G12 SoC Family.
> 
> Did you forget to remove the stubs ?

The commit for the stub as already been removed from the
thermal/bleeding-edge branch, so I think there is nothing to remove
anymore, and I dropped it on my side too.

-- 
Best regards,
Ronald
