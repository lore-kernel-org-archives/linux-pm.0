Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225212D21B;
	Sun, 21 Jun 2026 03:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013948; cv=none; b=eaoOVZchxagpHdd9+kVELc6pPreAYYqHBHyhrQdWtZ5KJNZ7NxknH924cznul6622lOlGTaiATdP4p47b4ZqBTzN/a/0uW17rVxglXDWIveCWsFZRwSgAaojo3DmFTiSLoovUit57xezscFj2325Ug4NPwoeHtvT92Vx1hkZiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013948; c=relaxed/simple;
	bh=Lv1qxwlPANBQ+blC3yKpPup1mEGf0OeimVB9Q2AdACI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obgTjBOUeyRCMLpT7KhhNfklreJyuSkmNMLLtcoxn2WQsYehAx4sg+BHaUCFg1RnK4f+w+GMMRacm/WOkeCxCjKL3F9Z5wgAzG4W3T+stx1rJ4NpFTaJLVztQwJR0o6OQk4WSWd+uGAi8TQxrBfS3dA9F8Qyd1o6cE2x5N5eSqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y8dXIbI6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8dXIbI6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rmXkENlna0vQVeV/xtVeGZvVRwkXtaqytZ8wM4p6YnE=; b=Y8dXIbI6SYdIq0yMbR3TogdxS1
	oVEt6k9nzqPL/H0zHwUb18PNbUYZiyT5u57ZME1YWd1lBEf3XbL20zGZm92Z/9xd48qARVo7GgNcd
	I6pAh1y8iWmEhMQrWvR9Sf/Y+SrReMANCe3lmGV5pPZpfCYDgjzU80r5kPXeEmHk+WqVXh+Cevlvy
	LWxWmn5XeYWECnSBVhXL+mbb97EUcQXsQosHLLUthI5a9GWsFCSZ8iiR+9S/HlE9oVktbpP7RimLF
	aak2jDOqeJyPPqGm3YUUpmER2N+PTkVLRyTQGSNrXoAQwGncAeF//QSgfWbsZDk+1IgOXI9Bn1bd7
	ABSYWlOg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wb9EN-00000003jHd-2bcV;
	Sun, 21 Jun 2026 03:52:23 +0000
Message-ID: <10a04e7d-31b4-4c51-bf68-298f517fbab6@infradead.org>
Date: Sat, 20 Jun 2026 20:52:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: admin-guide: pm: cpufreq: fix
 sampling_rate example command
To: wangxiaodong <wangxiaodong827546786@gmail.com>, rafael@kernel.org,
 viresh.kumar@linaro.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260621022515.10137-1-wangxiaodong827546786@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260621022515.10137-1-wangxiaodong827546786@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/26 7:25 PM, wangxiaodong wrote:
> The example shell command for setting ondemand's sampling_rate wraps an
> arithmetic expansion $((...)) in command-substitution backticks. The
> arithmetic result is then executed as a command, which fails and writes
> an empty value. Drop the surrounding backticks so the computed value is
> passed to echo as intended.
> 
> Signed-off-by: wangxiaodong <wangxiaodong827546786@gmail.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 8831cface585..34baf20cc202 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -497,7 +497,7 @@ This governor exposes the following tunables:
>  	represented by it to be 1.5 times as high as the transition latency
>  	(the default)::
>  
> -	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2))` > ondemand/sampling_rate
> +	# echo $(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/sampling_rate

Ugh. Thanks.
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

and possibly:
Fixes: e54ac586674d ("cpufreq: editing corrections to cpufreq.rst")

>  
>  ``up_threshold``
>  	If the estimated CPU load is above this value (in percent), the governor

-- 
~Randy
