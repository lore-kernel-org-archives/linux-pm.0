Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259033DEFE
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374856; cv=none; b=jpB+PrhC6++bZ0qRCs5hlKls+S5PmDX9c6+LDa0Y7dNz3LTdul9a3t+0RIntvRymYgxmp/l+t0oaMEbCHPwyWkl2ipaa2KchwBaL2xmUaDkh8Ytkr9u9kQpFc2tMjrzW/RVlrGyrQCO/2cZcW8CHBHDoMje9H3UTWCbB20ZdX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374856; c=relaxed/simple;
	bh=4qJuo5qU+I+SushrL2UeFNuIuwsBS6UwzTW5/V3pGsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDNvMffrARMB9S48FnfaHue3x7CW7MjOulu6qB3wE4pDyVVD16/IMyS97na49S2zbFbpSAxLp38v7XDuXO1w71cs/H/JHb2XzaeIqSzKusGt/h0YSE+/A9G76HTcSxNou/LtCJhocU0n94FpgxYlEVr+HdF3HaKd3fJeOxW4uZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daMinCnv; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daMinCnv"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so2551042e87.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 01:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782374853; x=1782979653; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMl7TRyc5Ti1eJSQjKVmCxsmv7qZYLjfLBy4mCsAAeg=;
        b=daMinCnv/xjQyCrEFNIAdSR3mgeyNn81DZDWzZosOf1ey3tU+jTMlMp1FUsoYDbtFa
         s4zFs/oAPbrXfGHUTNWlhx3Xc6r8VcuTkUuubxK6/hI093oGSvLHaKjfrGOAPUUYRmCc
         FKYo8wQlRkimEfU0H5YNXgSVncnLu7sXZhEjMe66zkPUmo/A9v2WQlTb1WumHWV7UM8U
         USbIvC1K5vEGgVak1mqYzUFwOhiOUgRAi0cct3A4TkbLrjiW12vnR8GoPe/KuayVFpdZ
         J61pFbDeevQQaF4kQ+VY+pmPLaijHH5km3qRxYMdwM25WVET7JIJz6q/r0ZyXUOd1OgS
         lTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374853; x=1782979653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMl7TRyc5Ti1eJSQjKVmCxsmv7qZYLjfLBy4mCsAAeg=;
        b=PLwcuark9LpQbn1c/CCooYJkz8mGS9jmSFBKXLBNoxaNfNed6TcyEEOTfub3BM29Jq
         d1W7LgWALfRDkVyba8rWicP5mBO76euGVOGv330/MnjD5hwaJ58PDxqrtKg5ZiNOmEdk
         jgYOFuyVIoRiH1qezEMiNPs//Crg23bXqMjUNvS2uujY7zrzMte63xGgRGnjpnzDrw0z
         UMW9oPGK1tj1ZLH8GhjiWZsjNlau6fRlPNTq+TextTnZxZfZ01s8vwB3fBNv9uS3AcSL
         errOCKQbKSydBnwc+y8gVDdqKAgjzRihm3ZU2Dehmtmu3F8TNmmR0TzKZsIyE0s39s+f
         COqw==
X-Forwarded-Encrypted: i=1; AHgh+RpgjPLdKyZwZxcEGCUMCJ7qJWG1T+v00m/DsaQa7YDd8hygwZFX2hbchrMJcaMcqNZ96vXnX+4hmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VpH5EPaIbdPgoh4Ksr4stjLlUVQHi3l6pjB/RXB2woPVxwUn
	OWE57UgCpK+BnBVDSZw1iMzrftfR7h0t+HtXLVxuQ+uE9jpZmfp/qoPp
X-Gm-Gg: AfdE7clA7zBQ2LCC45PZNDr6RCuaNrxFWjPTuOJ3eWgTmwUxIzJ+sv1PWYS9L1qkVI/
	Or1cVNRndgBa/aIsZoHjm4CrYExeCmz4Dm01xYgR4ZPTAJDW95w4g+TStUyeCyJ7v+9l6F3npbi
	Vt6MJKLaDlTKcjRmjsOyXdNEV2wNkPoriG0n/zb05EGI9uam5HMlyIb0T4TTPM/JPt5Ozlet9qF
	Uk30g402Y4OSRpBYKeAGtsAvwKtmQIOgLhm5HsKvz0NPh8F7n9ZHCN1o+ebR6GUOEzbzMtfogs2
	TFcOIVteaB78sVX8BbiMBf3enACKpfctqRkAdXEmM4ZTo+pWMtt2vaqp5K5GowljWfa4/OkzxFr
	H2i1TNLf7gfFfG7jjgAJi/zLiswRm8UAOrON7SNBUYqrShu4o8+AOddaEnu+IQU50BKy0vwxARX
	7ZQFk6p6tvHi1V7JRu5jHLng==
X-Received: by 2002:a05:6512:40d0:10b0:5aa:6b8b:8c9c with SMTP id 2adb3069b0e04-5aea1f53efamr308064e87.42.1782374852743;
        Thu, 25 Jun 2026 01:07:32 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999b1b1a7esm41585921fa.40.2026.06.25.01.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:07:31 -0700 (PDT)
Message-ID: <ef408da3-5d46-43c9-ad71-cd33a9fc6d23@gmail.com>
Date: Thu, 25 Jun 2026 11:07:30 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add a terminating table border
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
References: <20260620011821.3568674-1-rdunlap@infradead.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260620011821.3568674-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/06/2026 04:18, Randy Dunlap wrote:
> Fix a documentation build error by adding a bottom table border:
> 
> Documentation/ABI/testing/sysfs-class-power-bd71828:1: ERROR: Malformed table.
> No bottom table border found.
> ============  ===========================================
> 1             automatic adjustment of input current limit
> 0             no adjustment of input current limit. This
>                helps for more unusual power sources like
>                solar modules. [docutils]
> 
> Fixes: e92786dd86a2 ("power: supply: bd71828: sysfs for auto input current limitation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: linux-pm@vger.kernel.org
> 
>   Documentation/ABI/testing/sysfs-class-power-bd71828 |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20260619.orig/Documentation/ABI/testing/sysfs-class-power-bd71828
> +++ linux-next-20260619/Documentation/ABI/testing/sysfs-class-power-bd71828
> @@ -10,3 +10,4 @@ Description:
>   		0             no adjustment of input current limit. This
>   		              helps for more unusual power sources like
>   			      solar modules.
> +		============  ===========================================

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
