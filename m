Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A319C542
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357479; cv=none; b=tXoELPpp+e0B3zd84tS5+NhSqyCeOIVi+HIOiZcf69VhjBEM18zVBrBWH/NgwJoXdlFfS03jMCePh8q+AiDJh5/wfzlb1Rz0XRH0gAcLz+2pX1rAa7OjrOVStg2YvXUiBPH8YaxCdGNNUnanF/Js5NjA4r6OFTN11pSr4/kSq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357479; c=relaxed/simple;
	bh=Y1N7wF44jXkKcQ9zsr1lgSXem7oNUSaQboj9pTd4Lgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+FXG1xrSxZEnA9kPRMCWV1726Bt9jaACt/jxhXTLHdtxuHhN3RScLuAqVqK6fMDO5C9kNw2Vdo9XaDGjNRJBqZZpS0rqoOrLeP3wGZqz/opsYePrr7tyckjeY/TWoZ88qj8Gm7YnAtQgxgEAzHEkVfJYyCsAuTLM+7lcznEk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgL8DHcf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgL8DHcf"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4974248a91.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357477; x=1776962277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yA9YSNeAfuMMoPnACG23ugvDbAINZvrlXtBMrRI+L8=;
        b=sgL8DHcfOgAwNkpDkSu5I2HduBKJpCKkkjxWBHIyBWPhin1OuC/VTqyIIiKUtCBbJu
         Xo15+HzvdzV8/CsRcjXo/kyAjizUHPSH6Wsyj+lbvPHQ5mTsPw5wy+jsj5/a4sOJ5F79
         ftX7nIrIsum8vUC+vd/w1Y6oKGWt66HHI+tmgu4QVQebzxJeVuaNoitKrSmWt5SYp/Lb
         rdw5SBxuGJca8bAXiQtiIBEv9u5x5zG4X46WSyjIm3ZfEhpqtiBgwTMczqdlOtnVq08k
         r0N1q4z1EazAyMEF/DIZOW5ZuANWEFF//EAvyLHZiAHOaoHz9N8UWLMbMk6slwAeL4FV
         5XBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357477; x=1776962277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yA9YSNeAfuMMoPnACG23ugvDbAINZvrlXtBMrRI+L8=;
        b=j2UHtv9jQlikphmqFSErHWMDZOuJIpZpvScs8PLsBEeCs3qUG9vTIAgV6+5GwUqEFY
         a9bN+KmnFMX+5j36HaM9VrshBTWAE8ipFu4UZvlKZ1MKhQjvzyQrcbmorqr+kCCP5OjF
         lgg1ZmEjdWZV1VBDdcmfJfrI3BQB+uSUoggImwVk+IKUzQN++vac8A81pfEx0av5ORtG
         ZJuAZhkmQwTnzZav2CPetpa1rDcWuEbtZITMeaffxxcaT3l/I28Pr6b/fhWXvnNJotns
         r5gW2EWgOq2S6kNi/rJG+r/w90Z2G6cBoLugZSwC2CB+PB1wuRJkFsji2JRnsUUHYzjT
         KxTg==
X-Forwarded-Encrypted: i=1; AFNElJ/PpFuGCYCYjhpsgXe4yDgpzGrRQ+TJQ19WLbJeEjM/A+Zu7W9pJq0fou1HUdaWCdrCrgqJJn+WHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMf8exFwnDihzpz4CC9KD6+02TQvWMEUYWMW5o3DTVWwkZTCNv
	Ln5F6ZpAsrVhzW/FBanZPzyO51UjSmx+3vTpvtzmGLiVDWm3CuB8dNHA
X-Gm-Gg: AeBDies8PdguydeBBktAXfacm1TJc7sq+aHqEWrBmTOOo6w6l1ZRcPFxIEhbjDITUwm
	t+w3CzCg4Prm2iVvxZc8I8o/JvSUttV4wXN95Nk1P3ioCQvKwoodqgHxwhR3+kq3RoyERTkAeCn
	sEN2TSiuot1cHXqrpm6USQosCRWRD+ykGuuypk8Xo7T6EYxMUkp8HTcwL2NoC73lrw/GZXvZUsH
	iG0g3SYL1TP8J+31+h+Fajd3bR52OOIKecJL5zseLbbwQUFd9MFyjz4lJyexoL1Eirdcvtn4M9w
	ijk0x2C9z3QTBQCJdv1VCu3c7jJBaW4UmZ8KnYQPylKZs6DVMvZlN06i7Z0WPzSzsQFgoskyfaF
	tzNg/hdC1Mt2BdBOrYWHqiWYLhwljVFRTIcqdlNes+11m6VywwKGnKhZALwzaEcP75LiohXcZSx
	Ik1RwkMT9x3fUSolZbw7IPqQ1IpMcufN4PgET4SGEBi2Zp
X-Received: by 2002:a17:90b:4a45:b0:35d:a62c:19de with SMTP id 98e67ed59e1d1-3613df17f94mr105102a91.1.1776357477448;
        Thu, 16 Apr 2026 09:37:57 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36132cb3804sm3061025a91.6.2026.04.16.09.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:37:57 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:37:54 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Do not create empty devres on missing
 interconnects
Message-ID: <aeEQYg3fTj-n0JDR@google.com>
References: <20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com>

On Thu, Apr 16, 2026 at 03:09:13PM +0200, Krzysztof Kozlowski wrote:
> of_icc_get() returns NULL on valid case - no interconnects - but no
> need to create devres for that, because it just wastes memory without
> any use/benefits.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Regards,
Kuan-Wei

> ---
>  drivers/interconnect/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8569b78a1851..ce572c62f58f 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -432,7 +432,7 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
>  		return ERR_PTR(-ENOMEM);
>  
>  	path = of_icc_get(dev, name);
> -	if (!IS_ERR(path)) {
> +	if (!IS_ERR_OR_NULL(path)) {
>  		*ptr = path;
>  		devres_add(dev, ptr);
>  	} else {
> -- 
> 2.51.0
> 
> 
