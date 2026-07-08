Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CD480974;
	Wed,  8 Jul 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529566; cv=none; b=OdKErR7yHBQGV2o9f2uZGPO3u5R0zIWYVhBJAl6p1fjU8cBbHsRNCswUk+MejdAB6nxDv0jXWcD/BjqgjqA1FZ40mhze7r6fSPfnfIYdU4C95hZjVT9wvFV9EnWpR7buQEJ1Rs3S6C5M9RDyV3RIi/iE4mNwicEWv6lv5nFtkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529566; c=relaxed/simple;
	bh=E+a/Nl4KRlXUbSBIV1vhfrYD79/OxswYaqm7Cdwqxyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpHfeR1uIDhCyMpmWCEwUuAjdU+LPfE85/RHK2sIwG80aMAqNUF+PZpCao6L2zr0FUirX4baKTP0ya6pNZDN8DwfDHuL77XAwAE+AagRgpiJm2vvajBqxRDPwduUa8eKxR+Xrk/LCLCEgh4aiYojWRtvV5UwwsKWCuwCUByz6tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSxeMkAw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSxeMkAw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VTZZc5hm7q7+Hrky3l8s8+PHOQxPKBAOs7wnzzVfQwQ=; b=lSxeMkAwQxu02LM23af1QtPwwX
	Hu7hYLm5XjqUHoPO2ikXNgZvoUnAK1v9rT6ogCzQ4OuvpJWWR/UrYGGvwIwZepZ0HmaLMakcILOK0
	Li6Raa3RAuZFlZDTC7DEEBo1dRmQJl6NZjYAVaZeGI0zbdplZEWFpzwrEuT3mYnpyMHR8uzPzsxyV
	BB8RKUrVMLeWU7xpXte6zgN9GAGRTiQpeuAPXjCvORi8IZlhdAHpX97TLI5OXKLprbnMejHaS9gf0
	2n/EYmmEx6RKZ84oNZ5yAqlfKj2UjeOQ/q4CI32v5eRdgLGXwImBXHMvIQkEHfZj4zWM7FDZoM8tx
	Buab4nYA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whVVi-0000000021n-39Xw;
	Wed, 08 Jul 2026 16:52:34 +0000
Message-ID: <deca50e8-8f51-442d-b97b-3e2bc1ab4148@infradead.org>
Date: Wed, 8 Jul 2026 09:52:33 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add a terminating table border
To: linux-doc@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org
References: <20260620011821.3568674-1-rdunlap@infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260620011821.3568674-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

ping. Build error is now in mainline.


On 6/19/26 6:18 PM, Randy Dunlap wrote:
> Fix a documentation build error by adding a bottom table border:
> 
> Documentation/ABI/testing/sysfs-class-power-bd71828:1: ERROR: Malformed table.
> No bottom table border found.
> ============  ===========================================
> 1             automatic adjustment of input current limit
> 0             no adjustment of input current limit. This
>               helps for more unusual power sources like
>               solar modules. [docutils]
> 
> Fixes: e92786dd86a2 ("power: supply: bd71828: sysfs for auto input current limitation")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: linux-pm@vger.kernel.org
> 
>  Documentation/ABI/testing/sysfs-class-power-bd71828 |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20260619.orig/Documentation/ABI/testing/sysfs-class-power-bd71828
> +++ linux-next-20260619/Documentation/ABI/testing/sysfs-class-power-bd71828
> @@ -10,3 +10,4 @@ Description:
>  		0             no adjustment of input current limit. This
>  		              helps for more unusual power sources like
>  			      solar modules.
> +		============  ===========================================
> 

-- 
~Randy

