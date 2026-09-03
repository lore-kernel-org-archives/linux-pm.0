Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783764F472D;
	Thu,  3 Sep 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456181; cv=none; b=scsuXgpmNq8H6vzXkY2+M/Sp+m7tj0PaHcF9z+YuDwEoTb2kgH31FkcSj1bkWBnVqjLLRAuALjejKSPVPsLj2w4fgoB+1SPZrG2Naa+6v/6OhohiIwv4SC+TSwi+CJ0W2W561kxkHK9ZAWnTUJRr4L8y4syXRoGqBax/s03rf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456181; c=relaxed/simple;
	bh=wnMnI6ci0pPe6PHijipJ6bGyR2qKWN512dTM9ouIjPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcDg/TmLOFDpvI3SqABSQxgMMIYDOFMzm5Uj7d5Zz0XHPs0FPXjuGN2xTgxISSWagyi3PBIfhtmWs6ElgchNPO3DLxIFddT+uCfg19r5c3CHIySNHsGJuNy92u9ip7Savb0N765AJRAuqY5nmUEb0PF2YDOn7xIBuii6KdCdT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dIE8eHlo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIE8eHlo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=RyPxf/tSnn2i/XHJ82iz3tN29iMK2WGJcQObym/K8ro=; b=dIE8eHloCTWBu71LdA+KCXWz7o
	71aiFAjME/e1i+oOwGouQU1f7k6Zmflz/VNtv4ZA+dIPLE09gDpH2c/YQerm1xALopwakl0nFc8BI
	0HTVqwz3fYpyjmSqERqRi+21xnoj+Yms9BGgjvCuZ+MPbCsEEg1F3difqQVNFG+Jji2x0neoSobiH
	30RcydH/2fYaiYTtaqFWB8Marr0Sdk+0QgJFVcerhf112qYPlUSFmIu6knkI5k3izPauCZikz4Neu
	zRmY/qo9COSDNAaZkYQ5OFjFYY8UsK6ChD7bUd/KiyPssrMpfa3+cIIqNRDwA6w5UDDxfON+2y/Wt
	a3m+rOFg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2B9L-00000000Gj5-3Bft;
	Thu, 03 Sep 2026 17:22:55 +0000
Message-ID: <3d656f96-c2c6-4783-847c-4a6c0f6398a0@infradead.org>
Date: Thu, 3 Sep 2026 10:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: thermal: cpu-idle-cooling.rst: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903160751.734704-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260903160751.734704-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 9:07 AM, Manuel Ebner wrote:
> Remove needless '(' from equation.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/driver-api/thermal/cpu-idle-cooling.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> index c2a7ca676..b9d4c91a7 100644
> --- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> +++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
> @@ -161,7 +161,7 @@ tree. So with the idle injection mechanism, we want an average power
>  specific OPP and idle another amount of time. That could be put in a
>  equation::
>  
> - P(opp)target = ((Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
> + P(opp)target = (Trunning x (P(opp)running) + (Tidle x P(opp)idle)) /
>  			(Trunning + Tidle)
>  
>    ...

-- 
~Randy
