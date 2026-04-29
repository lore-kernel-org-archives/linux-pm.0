Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B163359A6C
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502128; cv=none; b=C0QfvqHvpCDVqUf988lPYvMsCuINIOHxIIh8f324JFqlx7UvRyAX9UOprRH5dt5iUMlHzKs/aUbY398jHYAfRAbuGzO7bO7JPvUjoi+LTPa587YlAQOsdEZoSHmePmivYS8iOCA4GHlMchMKQI4NdRye8qqDC483yq4Wr95link=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502128; c=relaxed/simple;
	bh=2tDPKTjbFdZ4IlqqnQW5DkIp6V2EH8xoXznFU+LYPPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9Pq3cNG4NIDQ0+nQrtuulIlowPCqpkO1xJTEMyNuOPIqH/GNOYTq/0OGtVZLeEODJuITQvjcxNhbqJsUxto7CcEzQMxvHBpxhNqRhYndFoNbzVbsqCx4m9T2Poo9IF0u+8+HSOpIn2W5WQ1+LsalslJyU3bHhtUnP26jbXhx0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnneAe2k; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnneAe2k"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fbca04006so106202a91.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777502126; x=1778106926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QdR822Oh+h/wb6tFT1ZtMo5BW1zB1OWiICj47LJjjk=;
        b=UnneAe2kAXNFX1jkzz+AhOO60s7haEdI/8oYOXzcDJbFPaal0A05Ud0RuxxMns2mAZ
         4ohWhrwbwhsvcdEWuqPj/kmvJd/geh/pqd4DlK5bGGEzMdGGm56CPrU4XMk4nMPkyF+G
         kLcujeWj+jZCilErec7tyD8mGF4GoSgLtTzjLRpWKcio7Q2lblN/CGSpLgZOZlTWjnWs
         U6MkvzWcywn+aySj0+J4mio4gXW6BIrVDKLegWUP7I/F3uTrqO0wPgiRSk+0P98RE+zn
         vOxi6vAOFhRxXZ0Tv5vfiOsCN9dc5urj5Hjga1UXJnZ55Ql1BP6sVkgFvQdHlPLB+wbN
         Obdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777502126; x=1778106926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QdR822Oh+h/wb6tFT1ZtMo5BW1zB1OWiICj47LJjjk=;
        b=rl1/uAHOPjAs1/lH8j5IWrSrBVuPgOe6qwjS1AlDRrOHpj2fPIBYtmZE1bz9gh9G/7
         1vyiHcW0oB7Col8k8EFL0pxa20QTew0UxeBeS+MD0QMe2BLYz3TnmdSUEPAK0+cdRETZ
         85GYMDhJc52+ME1o85FD0Jy3vXNKHSRC08u9bnA1b3JWhpzfwEQYfNXXteSeMD8eQDRv
         O04n0kYBBDJdI8qcR6glamHb8ZP7qPWVefb0eP89RqhC/RJfFtl2oB/8Qjz6D5v5x/67
         PtD4tsboebzIaqb7uZpoqZAl3nGOp8JlmAeLi+DDhf2cVKcTE7TVAOMmlcFPSVRyNcAC
         kg5g==
X-Forwarded-Encrypted: i=1; AFNElJ8+FY6CYhjE/S/cwlKOmaeC6iZiIU4u1tSpsIBDuari03jnyGp/ObsSHvEy+1EBlMw6d9WVbYAnOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXGBz2ExSOVRhQ2Pyt1gt2xl+WgVEE6tFTwNnxc7l7VW0lWYv
	1Iznefg3O4mKLYSoyM+VW6EqA2xoz9SDTpy/tgZepO2FChpZXZ8rUzBM
X-Gm-Gg: AeBDieuzAZ6IArZNUa3WXcW01gNoUdPF6FarQapwWKv94PB5Ww7DUssXFbdz+gHvMC5
	EQGxuhscAzaVIrXKa7BTDdiyfoU/VcnIJU0i5hIKsXPWI/6cSMAMiT2LhdOPF6VHhccPo0pEcT2
	bvUoXj6ytuXyIl3UiZKteL7JbOF32kGfbFKDFfRfBQV57imygnVvqO/g0ocF1ITKlHdkDnTPnJb
	BaC19bm4GMIY9KTFOtut5vZ8PSr6aZaVeWwk3+pGXaMWpoH5FWvDzllqCI2VUghXplvk6m23OsD
	nL0WO2Rx0rRsPnwGDZEGVSqiftvEQNBIdukuAoC/ivXI87lkfNeVkfmLtg4I+X/7R3K/7lIh6EC
	gpg1JRQxuD1ay3royq00DzHH9vE5i+Sxh4UOKlFrUd4MYdY4fyqRlhp4td66NLLnkyck9EMMvZo
	Pbk2Pv43F/irYtQlkSIODAMV5FYZ5UWjQGTuZvcQHFlM/CcWPVAQ==
X-Received: by 2002:a17:90b:3505:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-364c310b735mr183471a91.25.1777502126475;
        Wed, 29 Apr 2026 15:35:26 -0700 (PDT)
Received: from [172.30.1.27] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf69bc2sm649418a91.10.2026.04.29.15.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 15:35:25 -0700 (PDT)
Message-ID: <097b96b4-9a43-404d-b06e-9b087a37dec4@gmail.com>
Date: Thu, 30 Apr 2026 07:35:22 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devfreq: event: rockchip-dfi: fix missing
 clk_disable_unprepare() on error
Content-Language: ko
To: Anas Iqbal <mohd.abd.6602@gmail.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260319163011.18876-1-mohd.abd.6602@gmail.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260319163011.18876-1-mohd.abd.6602@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



2026-03-20 AM 1:30에 Anas Iqbal 이(가) 쓴 글:
> Smatch reports:
> drivers/devfreq/event/rockchip-dfi.c:215 rockchip_dfi_enable() warn:
> 'dfi->clk' from clk_prepare_enable() not released.
> 
> If rockchip_dfi_ddrtype_to_ctrl() fails after clk_prepare_enable(),
> the clock is not disabled, leading to a resource leak.
> 
> Add clk_disable_unprepare() in the error path to properly release
> the clock.
> 
> Fixes: d724f4a4581b ("PM / devfreq: rockchip-dfi: Prepare for multiple users")
> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 5e6e7e900bda..8db0bceeded4 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -185,8 +185,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
>  	}
>  
>  	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
> -	if (ret)
> +	if (ret) {
> +		clk_disable_unprepare(dfi->clk);
>  		goto out;
> +	}
>  
>  	for (i = 0; i < dfi->max_channels; i++) {
>  

Applied it.

Thanks,
Chanwoo Choi
