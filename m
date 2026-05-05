Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD7392C28
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777953581; cv=none; b=sDKkdkWuCm0W80qekK5wlkvLEmd/d7KXr80ppZaM3D6R91gnCuLwPIdCXU8+rIQ9QYbVuI7RzP772TPZsdYwp5mEMnL1HGEWB//AP0WwyDWsuAZYSQEanfW/DOyYfOy6zBM/Z1qJKfzSe+KW5cUTot/bVJxMqwsnJrNxL/ov4Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777953581; c=relaxed/simple;
	bh=a+YUDaVvYwmqejKggDNsG92A1d16l1vbsSGStD94968=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKKGmgXNVr/nKERNVwbjrEwJdbC/SB/VAmSTIyjJGBiMsOxTNhAoU7vbupgTiOpfWcXs08X99PgFOqD34g64NAI3zlHeTQyfa4dzcKcYeHV2x8cF5PGbnU3U6FO2m3CKsAwQBZx01kaJnjWDtbslgR7skADVTcW+p2KcW1z0lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V2tf1Oa5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2tf1Oa5"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso945748b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 20:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777953580; x=1778558380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDkBs+2XbGaX1zTF0vQnJxBMgO6n5hP8tSgf7oIzT00=;
        b=V2tf1Oa5lV3q6gaX2VOxUKnAWbTnSCfCp+NOmknxQEOWXFJNfAFeSdIyLW/B9uUlSq
         5t2TRAc/kpUIR3R1Cc2nDK1VGl+Mc4/jbnUYSz/SCYfh3TJLWTR8SAhlxio5wZC2RkS2
         xwGxwMFXJuctMfVhbp3aHGfQulJXzTJwvtRy9T+3lHPMD1avJMErBERpktmPYX00s/PU
         BGTkcBgrg+nMax8eDLX9SGhA3vg0oxQJi9rKHk1zN0CwuEI2xzFSE/1/RQ6SidkPi/sC
         Sz0uFuM7SxxJQDnyrfuHYBEADtvY97iv5xNFn9EW3fHQa8LI2Cz+5qM+XK9vXZjyI5UG
         8diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777953580; x=1778558380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDkBs+2XbGaX1zTF0vQnJxBMgO6n5hP8tSgf7oIzT00=;
        b=bdOcRr/kPVb3NUzw6tmzv5v2KCRsv9rbqM9AVTn47bkHYB135R5hzcV3+72MOnCk3a
         74VpLB7m9qSlb8AKYQ1VBej28tkhqLZWPZJPtbm5IpYUmit8WevL//ZnrpHx9X2mkhxm
         knVG/F9wqSaXJTpPMCZdwPasbNmg24fi1UPUJIjgtJSky0b82+RhfPe1t7nrJxww7wvX
         CmSJZnBGCJwJE7MVoEMsur/jWdli7yvKnYjEEKfpC8t+OwI85292lWu1ZDJrF2Pnm1ov
         Hk3FlVyxYx++x9sI456mQzGUMiHGytKbwvJyLtEP7lUWxc5vQoa5AHCsVi0TXmYI/9fE
         HIIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t6ytQmXJuzNTu9IQsMgTVSfZTqi6O3SVVQqsNoZAnwkPo+ak3WFOUTzfudTlFXKHP0oo2Shu6TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRIGMKuxaSy58eHYkXufm/bTCw1ryxUudltj2NkSRdighmOU+
	9TPdcvVznBj/n/NBvqVt0TCtUSGizZJWU71GeSogaJARQnVt3NSUgMiHpnTkJiFB3Og=
X-Gm-Gg: AeBDiesD1BRNlDRHv9P8UGX27J1xkrwvP6vD/hHgIKp/ol3cClg6pGCXltU7BH+/ElG
	7VpeGgh0e5UxqNBe7rOCmHFDUHo2+QPKpUioTAPJKV2mki5lCU05I4lFWJVBnVSQ8tWcSu6DZeU
	/pfpgM+mH3vV2YRJjEyUpTD+etXG4M8MMZEwFpk7eWVPHnIJF2YdP85ZH0Ubrf/2/UfoYIyn8X3
	rtQzBaXQYkJFM7Ozd0vXOPWRlKXpSYM8USFlRZZU2jLlvYdLyCp96I4dYCL2S8e0OTflO2UQYLh
	AWh8P4t7PPaJRZNMg62xNTmFLpmAPdq4/d1JJM7MSo9SyjomLlqHyahGPaJfFE1xW3P+xNtQdPR
	PpcREulRHS2j0kyiMqISIfQ2v80oGHIbEXFCJHaS6Op0E0bKNQPvkUziJ+ntgGmQH/BwSYUSimD
	bjZ0191S/nYJAXtZ4yGu/+5QZQppK3TmV6HA==
X-Received: by 2002:a05:6a00:2346:b0:82c:9c90:6ea0 with SMTP id d2e1a72fcca58-838fc20cda8mr1565125b3a.3.1777953579622;
        Mon, 04 May 2026 20:59:39 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbee14sm573002b3a.48.2026.05.04.20.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 20:59:38 -0700 (PDT)
Date: Tue, 5 May 2026 09:29:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: ray.huang@amd.com, mario.limonciello@amd.com, rafael@kernel.org, 
	sven@kernel.org, j@jannau.net, perry.yuan@amd.com, kprateek.nayak@amd.com, 
	neal@gompa.dev, linux-pm@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] *cpufreq: Use FIELD_MODIFY() for bitfield operations
Message-ID: <xguly4zwdl4bloaq4wbb445vl7otmjlnitzr2xhvfosncnjgvi@e2sbpnk6e2ff>
References: <20260430163213.44695-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430163213.44695-1-18255117159@163.com>

On 01-05-26, 00:32, Hans Zhang wrote:
> Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
> macro. This improves code readability and safety without functional
> changes.
> 
> FIELD_MODIFY() internally performs the same mask-clear + set operation but
> adds type checking and compile-time field boundary verification.
> 
> Hans Zhang (2):
>   cpufreq/amd-pstate: Use FIELD_MODIFY()
>   cpufreq: apple-soc: Use FIELD_MODIFY()
> 
>  drivers/cpufreq/amd-pstate.c        | 26 ++++++++++----------------
>  drivers/cpufreq/apple-soc-cpufreq.c |  6 ++----
>  2 files changed, 12 insertions(+), 20 deletions(-)

Applied. Thanks.

-- 
viresh
