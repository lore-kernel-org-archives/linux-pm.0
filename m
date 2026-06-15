Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023422DFA3A
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781500043; cv=none; b=PqUNNImLhd3KWav8Wg6iRMgoqTcpmqqBSz3Hc0/vqeTX/ijHeZLJYSzCHB3J1aMwPAAFqR4x/rVTiiMtyGF8e1a7RwMBOV6KBdfy4GPXU3xEqncDPu0qWQaR1rd0XZrW8pM7uHOH6NlKaF43LhyLx9MdMvnNKEF43izCII3VfqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781500043; c=relaxed/simple;
	bh=iNVf5YMgw7v/1a27+G4oX6+gXGKseRTy3IsG+KE4wnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5bCW/J6FaIsXphe3Xi9Xsq/N8i6PC+/LnB2Zq4Jd8SJVg0Ql7f5XckgCXI/QMOfirwE1aYSVUG+d2Vf3q2hUC3VQdgSe8xLI6Gy8/hmjJUsqLExQ2dYFmmBVU4h88CKHC2r6D4DfyCoFxHJNM/S/pbCFQ9BpT3LvfOw3K1goJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROwbjCRS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROwbjCRS"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso19515595ad.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 22:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781500041; x=1782104841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/Oj6obfAcAELe8NNKZFmVNeON2ZbUEPKWSKWZaFYsM=;
        b=ROwbjCRSdrLcW/+1H75OoElt/IuJy73o6Avqea6TlWTWexD0sRe0XIt7/I6mD4Tr9M
         UysNsuDNrhSv2aUM6laIQEkc5wNH+edqK8s9IeFIeJyP6xQ6QEWnLr13+7uiaGl9eLzD
         TsNp5Buwm2dRJ0vckLAtM9QJZep09MeflKdKPTloDA5QprFB5lI3AGvddX1t1GbeeEx0
         wkBffgiGSuD1S5db9TrCRcZlPdSXiEAINGPOdFpX4BRAgIUw5ryyod9eKjNP78mrExaw
         PlAKjKwSxABaLi6Bv0ITRd5hF0MVY64tSfA2mTn+tQURa5AGjSxHV4357DrrhtSi2q6a
         bT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781500041; x=1782104841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/Oj6obfAcAELe8NNKZFmVNeON2ZbUEPKWSKWZaFYsM=;
        b=Bz4D3hPDacEQ5Dr1tYasNrOQoiobGSkMxL0oIsmIrdy4ylNRUKZLz9GhJMLuSRFCBH
         /oF8elpvrxspGXeDfrp+KTvLVClBUCAfcdih6JopEd4z101oJu+kGEwFZDy9Al9D5/cJ
         aoiSkMqQTKmPuwiVTj7Gl0HQE5OOO1kjkn9c4aENNDC+Rw+AAfr/lXT8+Y8iYi70gAB0
         JjTjDuKT31vD5Vm4PjED/L7tX3b20aRilMHrdnXKwcZ3oybs520wGlv7rVyR1BEs/Ci3
         yx7n1TCztCO9w6wrDaCqPkXPd9qScGKywjH3JPqQ1SDRTZ0dVsAe4OB+sdfvJn4KOdFw
         fpuA==
X-Forwarded-Encrypted: i=1; AFNElJ+3nIZMJOQHnYF2vUk+2wqR0cffw0dnMaIIkKPQ7MUCHRsocUUtl/uHCGcemy8jrPORcVcHiRz1Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YznMU8bu3HIoE7B4lkysDFCkSsLXCCZVvnlYSkIVkpHavnpZ7Ye
	LKNerN63SgeyzJQCCr5GJjm3Q1RShFUQ60q9iaEuo+G609R+yFNoaylgyLiK0A+nEZw=
X-Gm-Gg: Acq92OErfu9+lhTMapRJBYLevsRk5PZVQizGkkuKwwy6Nk74hOYdO1dsvOSs6ekbyE8
	dYsjxVywn5qAu7xZ7ncuoqqgEJxu701NhVj8/rcp4BHlDJATADggZ7rn55XUYQWMDbp5g7I+Yv8
	tuaNvLC2RPh3XwJ5MqXZrHt+sqoDLCyhnJVK7bzM4ECp1irV/lLisQY3/jpfYcRFqPDEIdFkvN4
	t6CpYmscRcrHVIee+42h36JMI1v1HmUQvpid9CcY+d0FgASEw4wMrHjFxRNfDaECGuTwKmCMabT
	Q2KOe/TEnafisM7nu54FhqdUaYUvCjvuZgsG8digGNcXH6BuiUOjR3K14PKa3E/Xh6UFx3aQAsN
	jAHHPaqvEHVaoWnZsm2q5yb2Wv+UmHcgjgA5PgCHDGhqDigQuNiuGQs1AvU7fgWVsdSPhfCYNvD
	ERO/ZmTjnAtuMjPPk3PRhtvLA=
X-Received: by 2002:a17:903:2c0c:b0:2bd:ba44:6c07 with SMTP id d9443c01a7336-2c66417d194mr100735495ad.16.1781500041150;
        Sun, 14 Jun 2026 22:07:21 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433558449sm89984355ad.78.2026.06.14.22.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 22:07:19 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:37:17 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cpufreq: spacemit: Add cpufreq support for K1 SoC
Message-ID: <lt7l6hvia6hahvizr6qwirgnhzjqdfn4edzt7fakqxbhkcmaxr@x6d5h4i55edw>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>

On 12-06-26, 17:51, Shuwei Wu wrote:
> Changes in v3:
> - Add a K1-specific cpufreq driver for the shared-rail, dual-clock topology

Why ?

> - Use one shared CPU OPP table and one cpufreq policy for all CPUs
> - Link to v2: https://lore.kernel.org/r/20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org

-- 
viresh
