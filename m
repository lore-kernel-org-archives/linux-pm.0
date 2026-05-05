Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B7A3A1686
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777952187; cv=none; b=EjspasHWZKXmdmh56wH/6x13aXZCsMAzhAIl52jB0EiFnPSpmzSOleTSMfl/7feVdydKpFu/FhA91yL94hC3ctWCpCt3PsTanwbxuagbY1NdajKhcKehtsRnKI2tZz49J5RWBdEDPCVkIeNfyKNUOllP9rTTVzLs6pvFC3fxUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777952187; c=relaxed/simple;
	bh=hDs2H23HmFbI/mqU3orYz5fx03GSck/LtWiJajuL9hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAiQike88x3o3BhEPi9h9YVLX71Lg6otEjIOCeSYVAiV4qqqNChQFvZL5zOQ2AXr++gy7+oO5D7IR/9AwcILbRbhSEU8t/QYn3bsTGb2VcqvKnHNKWs7QM2VsBL9YlSkP5IGJo/WaiJ6He9OGK2tShvpX0uyreJVd0jqc3Q8Ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9BTPfwA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9BTPfwA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8383fb7143aso661250b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 20:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777952184; x=1778556984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FA4gZEhIa99vJb/LHUbt5O9v35tP5Lp3TC5lHmjSZc=;
        b=I9BTPfwAwEXuYf/k4TCDWo4XT4Nviwmjgob63T6+aKuU2CNSkw1sc17O29UWkngoKG
         IB3/9WtvmEv/9xLJTdYmyd2yUWo6pdks6wKD+BmLNJtKqPx/PMPRoaWeUBGZW6XPP6Xn
         kAwWF/CE6diGG1asvycfQApHMZwEbLB4/vXbZDStV+sTzFltL8ciJqxiTonJe9R/I53f
         PhJnd5CTz8bqhmXlATEcW7kvWpNB+gLVeJ8XsZmN6SeIWVqm8TXM+b2mdqnud7PnT8UC
         0mewaJY0x4QBFABaWbmirnU3f7ZQaEa/nOaUkysU5xBarm3wSn/FFpR6wpXvxOVtyGcj
         0UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777952184; x=1778556984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FA4gZEhIa99vJb/LHUbt5O9v35tP5Lp3TC5lHmjSZc=;
        b=a9RqPnbubuY7EZfNENgHh9MC8a9rZTus5lRSO8UylXjZkGomti2MlYrDy/lCtPmo6e
         GLsdD/QmLtvXObGTmp7KmjuzbVtZXrz9gVuVYuPcrXehNX9BlcyNoF6F7EM274WZSwln
         zY2QED8pu76cY4R1RkBJRwVsD3gHokDsEvLkGYmMl7tKrTkHBwOsG+Rk97Cv2m8N+/H4
         0tdQKdH9VeB2fQMg9uvTSu8MWvH9mSrVI+JbATlWNA1YHNH/dog9MbOFZegRGoe9Ys+3
         7BGdIH9k0nPYx6QtO7aj1wKZ4NQ2f78lsBE5gJDcgqGuBlogHykpQpYuvmeD3azIYc6d
         h+Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZrkOOO51J2b8SohDhIDRV/2oKcOn224xYRR/50jLTSbi1+osM3uOYQsTRfICiHLJvYZzLF0B5UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxt/b4iIxh+qpohf2uOUGiyDIEFHMH210Q7lbEVZt42Kuut7JZ
	cUunPOa+vNowo9GIbc22L2ohjYp4vOPyzwy57HXVllNlqimUMPPgqdJRLw3RdQhhNEw=
X-Gm-Gg: AeBDietTIGAWDmtPYraDbaaAevV0OW8EuPcb3MVW75emr88xdO/E3AxO9+Hny6p5oEb
	0mJh4HuRAQgS9rpLhm58oWA/0VW8m789RyPyeoc/jSq7XiSZgPyTtaaYiUbXe8FFukD+hAQ7WaL
	VNqxkBu+oMVTbPgU/fOFEtT6mqDshEK7PyCp1uuGXzJRVlnT0JqOyM2rthh4Ozx9RO1jgmXj6x2
	jZk5+d2uVY2V92s3ld6jPeu42+Yta4sx/04CCT7BhZTBFdSkR07xRfjprWtJyn+W0sCGF995bSW
	VTzmBNGjti0Tpr7DeeLP0gC+1Jl4RoC4AdVUP6vSjm61bTtB9V+AzyLxHkQXAaMjree9yl88Mpn
	m5lOpHINuha88IbTPxUivPQNub8Khw7tQ/eF1FBL5w8VoXKXH1eWOCv1I2iUXmsP9Fmiebe/E+U
	pSaDjikC3rPOeB0NhmvMK3VGl1mHlerh8gXw==
X-Received: by 2002:a05:6a00:1d8d:b0:82f:6841:8733 with SMTP id d2e1a72fcca58-8352d2ff78cmr11366441b3a.48.1777952184146;
        Mon, 04 May 2026 20:36:24 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm466364b3a.50.2026.05.04.20.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:36:23 -0700 (PDT)
Date: Tue, 5 May 2026 09:06:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, di.shen@unisoc.com, 
	ling_ling.xu@unisoc.com, ke.wang@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [PATCH] pm/opp: fix race between opp_add and opp_get
Message-ID: <7k6ttcmptilvxmp36dvtznor2gfd33rzledbqfsigmjbkx2rhy@iv4lyzej6ibc>
References: <20260427120047.10830-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427120047.10830-1-xuewen.yan@unisoc.com>

On 27-04-26, 20:00, Xuewen Yan wrote:
> From: Di Shen <di.shen@unisoc.com>
> 
> There is a race between opp_table_find_key and dev_pm_opp_add_dynamic:
> 
> dev_pm_opp_add_dynamic                dev_pm_opp_find_freq_exact
> _opp_add_v1                           _find_key
> _opp_add                              _opp_table_find_key
> mutex_lock(opp_table->lock)
> list_add(&new_opp->node, head)
> mutex_unlock(opp_table->lock)
>                                      mutex_lock(opp_table->lock)
>                                      dev_pm_opp_get(opp)
>                                      kref_get(&opp->kref)
>                                        refcount_inc(&kref->refcount);
>                                      mutex_unlock(opp_table->lock)
> kref_init(&new_opp->kref)
>   refcount_set(&kref->refcount, 1);
>                                      dev_pm_opp_put()
>                                      kref_put_mutex()
> 
> This would cause the opp be freed.
> 
> So use the mutex to protect opp's ref count.
> 
> Co-developed-by: Ling Xu <ling_ling.xu@unisoc.com>
> Signed-off-by: Ling Xu <ling_ling.xu@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/opp/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Good catch.

Applied. Thanks.

-- 
viresh
