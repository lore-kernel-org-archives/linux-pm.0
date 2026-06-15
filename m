Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E330BB8D
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781501083; cv=none; b=Gxm9uyEin0ByrYqUic+SoB9A7HKOQOWraCM19CKbmennX4Zl3EH97/WiBVSXPLvLmU0laCXLkn8E/0uAmXewgYS1s2dpgCiCNB7FZSBqMXLHNa/8FXeL2Q6ByHY81lrqCGrZpP2ehjlZIujIjuZvRLl+4RNz5BxDf/wSjM9yncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781501083; c=relaxed/simple;
	bh=LKyNhJXz1JIaxAgZZafPKVNcBtAvTVXc1u1KD9jTvq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq8+HrlVpdDOtYoWrjECjDa0NZYFCHknt0Oyvxco90JklpF5i/FhkMyma9hH723QHvoNIyayB+666PpGgZZDjF0x7sFinhvTqM0qGvQbxL5Fs4tuKLC+Fi4N2yzJ8QXNDciESs7169TWv8LVlyvFjtXdAzXQ+6pxfqW4o62xLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CqHwrJuI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqHwrJuI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c3543590so19528125ad.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781501082; x=1782105882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpcf5mhYwCy+kQj8P5K4qfITxeMqEuvewMFhwML0GRs=;
        b=CqHwrJuIs9298oyuVjMj7WCCc9jwKBH1akZ9JCvCFRFYujyDaQ6gF1mea/211oh1PU
         +a7pgUiWlokW6Kc8qC4lMpO0AfYxxIJJsD6EHiMMpJ8ydghW0Xnh4vYe4PtbG+jEU7Nq
         Q1qq7z0BVe00nNWYgHxhwiEVSTea7pVOB5My1ohA/ACvUWkbhnWEO0aw1wzF6PamzXz8
         kT7SfKNHCndrcHmejDjSh7G/xDa/LeL89eVO8LXqXjHYQRKrHZ+sVH4uGMB5AvwMbjF5
         eRht+KhWkjhfBCc4SLgJB4Z7rKHKkCvg3Uk7C4nIurgYGfHoeylymZaq02JlbPCrl192
         dEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781501082; x=1782105882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rpcf5mhYwCy+kQj8P5K4qfITxeMqEuvewMFhwML0GRs=;
        b=QfNo/LXTmCSGfzojUt0b6NJY1sPdPsN/9MRUB+FyI2ADFg6EGKVQ/+tKe+2fjcS5eS
         1Pz4CeUDyodBYWB0nD3WeDMtUzmQOYpvaxx81kbxN1Lj/muXXBtwhf5DJWE1KdCIFZzF
         wkCi0MGQbPzhiJIHcLdq/7HNlSmP0rLtvTDNnQzuvLq1+1NfGbW3TT3wB+yRNMn94ZaU
         Ob99cedI98etSoW/d82wbDP5nn7iqrmT5L+hrHwKZbN8w84IR6mMszl2Y0XAsyITsG86
         MKHeQj7f1foZv3yEvwttfJEcxLKnt35Sw5mOC581PlCiYuw0YFfDkY4mNlhyrdfeyoCH
         x51g==
X-Forwarded-Encrypted: i=1; AFNElJ9XRNvvjHeoqDGRYKgZKkFVjxER/9EZwJothi5f5pMzp464c6Y/EmUME/0RbefezyIPly8RFHJ9sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1OaGvFReZ4bG7A9pegSyweb8ofLUJ5Pbr+DVQ7Aj46Z4IbJn
	Iq5ZCvsqxwEniJaE3CXmwqRIBY+Qbl05AM5MoAcvIBpWHkGczc8kiGoxNP5tVB7HZWDtqSCxHN6
	jRYcA
X-Gm-Gg: Acq92OGe/fmYNHYTItAHY1fACAetwkA5m6lRnQc1Me2sTCnQpX7stuvZ0rssJsxGqeq
	qSpvtdhPrBTDIx0S1y3k+aBGJY/dEujzOFy19SpcLuyCQnWxQTVncT+UYs1XZhZEeW1JtxGosie
	vGGLYjbsHtser0b5q9iBG60EcNLblyoKFvNljr49QQ0jXfQDVKoW/MGW91moq501J8nAYPxCs5A
	D07Ycv48RzGYLhWidy/V0YhOGmIa++pvNgYtv0tNSTHOQO9iSgomlU7pAGja3Iz5qHh6GvGAQtR
	b6oIxgobUYSdobDeQ1h0Nh+0ct+mIW7om+b+CFJ/0J8wE6Y2j2p/a4fAmzsL1CPKeKFj629oEfY
	ccwwCPW5eiZlyqDA6JFXx6HM/v35qXMpu/dXBQd3TJkYLuz/V0oZuCnG8QfzOJrKqg1Z4nC4TA1
	NRn1zDcw2KXr7MqRWEcWM++pg=
X-Received: by 2002:a17:902:fc8d:b0:2c0:c0fa:1659 with SMTP id d9443c01a7336-2c413dbe166mr150322135ad.33.1781501081641;
        Sun, 14 Jun 2026 22:24:41 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327aca9dsm87824995ad.50.2026.06.14.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 22:24:40 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:54:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: spacemit: Add K1 cpufreq driver
Message-ID: <bd4s2icqgusnuujvrpoag4cniy3g2e4bumecqxt5yffl77aqpq@kxg4dj4c2wk3>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
 <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>

On 12-06-26, 17:51, Shuwei Wu wrote:
> K1 has two CPU cluster clocks but one shared CPU voltage rail. Use one
> cpufreq policy for all CPUs, let the OPP core handle the shared regulator
> and the cluster0 clock, and update the cluster1 clock explicitly.

If the clusters can do DVFS individually (as they have separate clocks), this
should be represented as two separate policies. Isn't it ?

-- 
viresh
