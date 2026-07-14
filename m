Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548D33260D
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 04:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002419; cv=none; b=f+a3ZesDbg8kI9xkBxP21bUqiKxwVyaht9gj4C6p2z3pUqe9yREqGv4dsCqDvFU3M4gXnd5vRIKbifHinHssXB7HPibX8O7ImBPWT41C10FUgjitbaS5mYXUmFayYjxWum1JoEkMb1BqEpvaI5Xn6FNdngc/DKSAy7nwiv/8mDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002419; c=relaxed/simple;
	bh=GWBY5Lc8k/xgCGwoEJK6+0YavS5hJ59lwX15fZO+Gfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNxBy20D0K3NdIgGn7L2KgWg/sqtu6ify/4/ystoHFnUP3E/DUf4GtPKqpCUj3Jer/9BNskda+yRCqw6KIPl+XFTu+vwPAA8ZhlTeLFiT/oPL7PklJ8KstNjnGgvaR63wRLwGkWDS1nSW9zCLhD/Q1b3ArW5VCkBRjRVnC7hJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVp8vL4y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVp8vL4y"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdb73f0e1so4709285ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 21:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784002418; x=1784607218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZmJBr2Ms4rk2+zplbPjxMjuWScgK319b3jA8/a0Y4Zw=;
        b=HVp8vL4yu0I9THP4qmwWHlWseU+WBUcYJSPfpK3wlJjfNmVmGNvCuE7cBMr6LBOQD2
         pHQkSO5ZZbb1uAGxqY/TKb2ZXwWRuutM5YhRbVy0wm++KpghAYxPTZBdHOgO8jW5BZvI
         l7qV0SuyHD0AgSdqhXXw1UlS7yuxl+hLzyqTt/SKBM7Bo1heXRAuDXsPt/kJkw8S6YHD
         6kLLEDvA0rLjDuTCGYskZr7G1TL31kJAHvlSv/dIL0SyD0yZP0Fpou9TIoB9jNfLaePr
         mLvnliq2xaPaDNg5nA/OxNfhZje/dx/BHcMCYlRBllnrSkXpciQOzPMAtxOZhlCiK00b
         tAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002418; x=1784607218;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZmJBr2Ms4rk2+zplbPjxMjuWScgK319b3jA8/a0Y4Zw=;
        b=k+QrMZURjxdJVIyHAf6c70ju5U/G8d+0Es+9TmzWd+iENFd0kgyp7XTsdhjI4pGOWN
         KsgVkqHLnGiJnHO9yF7/8GYrtCT9X17bl5c+DD9vG5ezKyxA8COZcMYuktFqGIHguIBO
         hfPgIQaATYz2WjxZcwwhU6hwCBtGnjhYaFHOnKgG0qyoLAABVAtDiAd9wXaX38CH/QyC
         9gTekyPmB26IoEzfhtMIIEtiDHOqgjPTkDDwjxSubWs7EHMjcByynRJVfsWfeCs60eTi
         bI5I90M9Ks6rUBnjpkrX0HxdRwavdltCaeOxrOk01fS3Hu8ZQ13GUiGRMM/Pck7MmBsu
         2BFA==
X-Forwarded-Encrypted: i=1; AHgh+RojTyi+jCHA6+ab6c9AUvYeC4Qjvndb4WP1q+eD1Plzrkcu3KPf/GdzVVcRjfqN8OHycvVyKGQ0Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytv+qYKmGajiuIXBStuO+RFQMD6ygCAK2dQguh4nUVjxK8wmDt
	jUkHta3fYIgbF0ykXwtCLuNkrhFNbMx1IPn5RqGebfy0X1OWL5pSppoNde6a5rCMEys=
X-Gm-Gg: AfdE7cmkjKKhfCe/vo1EOoGXGkJc1rQnYcxwkLVLXHEwKgZIAIQ3vL3m19LeeeSdqie
	Gb/cpyc0xnbPI3YK6oW8rlwla0dyo3lnN3LlgREeaPc71ZN6KD2S3pGMkg8Co3xTeoCMEO8P4+Y
	7d5H1qtaLE+hEfDgchDmHspTzJaf4r4oheYaqBq0iJAwyEZ5y43NW0817y9dRicDnEUIEtGdsSV
	1HH35B7LiMoGQ5p2eywyABnlkTVnjrJp5ya9+7hb3gvqRjxvzX0dFZawOpGoYaXrlDsgo1ruZTZ
	IyfjDqUfJUCd3PwT9uG1mGSzuDLA4S0b4PIXkhiwzZiVXYBiEo2VabusShNfbIot1Q6y+nJTXUH
	Sr4a218m6ZpcM9IILSqWqfHG7PX5wAjdeq0aKb6J/aTtivg7xZxu4hGJsXf233/5nIwkAqqoo71
	tS3jI0CHFtZx+z
X-Received: by 2002:a05:6a20:3d02:b0:3bf:e761:626a with SMTP id adf61e73a8af0-3c110a74637mr13325451637.38.1784002417754;
        Mon, 13 Jul 2026 21:13:37 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm80207253eec.27.2026.07.13.21.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:13:36 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:43:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Pan Chuang <panchuang@vivo.com>, Markus Mayer <mmayer@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	"open list:BROADCOM STB AVS CPUFREQ DRIVER" <linux-pm@vger.kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: Remove redundant dev_err()
Message-ID: <ltocyzfol45faegfncfkism4h5ab3qydhi2rirykw5gfe5g43e@ayn3wxii3ikc>
References: <20260713131131.313588-1-panchuang@vivo.com>
 <247557f4-48d8-4cd1-beeb-3317cee58d0f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247557f4-48d8-4cd1-beeb-3317cee58d0f@oss.qualcomm.com>

On 14-07-26, 10:39, Zhongqiu Han wrote:
> On 7/13/2026 9:11 PM, Pan Chuang wrote:
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"), devm_request_irq() automatically logs
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() calls.
> > 
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> 
> Looks good to me overall.
> 
> However the subject is too generic and can be misread as a cpufreq core
> fix. Please scope it to the driver, e.g:
> "cpufreq: brcmstb-avs: Remove redundant dev_err() on IRQ request failure".

Fixed.

> With that:
> 
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied. Thanks.

-- 
viresh
