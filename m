Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3B34B1A5
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219288; cv=none; b=RR8sJGIuNlfvIFgXbWHvZBV9H45c2tH3weWHf+1yEnB7Hqs2SndQtdjFmRFJ5olfxq93oE+ho3F1Hep9uXaIkjIu89C3IGA774rAdiphJOeGIdNN7QPSdolfKLAAwyUFy6N72j81JZWNMhWL9C3rk8jYW31vXeZgR3bM1wMCJPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219288; c=relaxed/simple;
	bh=SUkWlFKmAlp8PM0AWeEekhIMr0lbsTtnjYR248qBtPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRATYrAJPDIkXq9soZIjboFO5ZZ3v4XThzIZ+7iYssn9zWf1vcU7rq2vwR74GMUelFsRQS2XQW9D3XMhIF/dOacGMh+bJR6NaeuEhV+t4p74O3Q9Oj3jJ4B5c2CDbu2z5VedfpZo7A+QseUD8sXIBiCuJvV9BU64r7ELNlFosdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FbilsdWo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbilsdWo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-83d5bbef760so24007b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 22:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778219280; x=1778824080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXHCKiYFz3uC8EghuRIMhzyE/oqlvKBcArJ1LO8Jdmc=;
        b=FbilsdWoiigMLFbehSnYePgT4lS0S7CKZwfIoHiyujfs5EllhtkClq/fc9edftO4qq
         Uce6gJkTNGUtPJwJdyCHwLb1YlhxFL3YIEkOJWa+troFGsB6e1+dlrsMx4vO7n/6LpPi
         S3O6+uV2uMsPliGOUBd/IoUmCIm9qbA8cDQoyrtUBL20tKU8cfhvGHJvYNC9O9fSnlt8
         bwlFvgf0QqnjjB7C1jJOPF3CvZDk9x3xqA3xIuKNn9ro4nrELPDjv0u4Kq3b/ldyp2b5
         KUJyR+XCW+uqi4bt+my2W0dGxCKP0OgxKldKkwf9hYTM+6WfnsdwvU84vQwFuGCFyG5z
         U8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778219280; x=1778824080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXHCKiYFz3uC8EghuRIMhzyE/oqlvKBcArJ1LO8Jdmc=;
        b=RHop+cDQIoLaUT8jod2gRL/ACl4nAJfPGEatB4OfgtK1iFErXzR5TxqA1W7dQMjtsq
         zZxTin4+BB629znBB/qidC04BOnAmQWfbNrGvIREYLOrecuNNVHInwXxhIwU/l6Y/fji
         v5QyKNDAAfQ32Ez1ei/G72+U+/L59UMznvURoppb+0VCbxjRoxrCg3yFv9dAX/t9a7HY
         KarZ2yslkVYDdo44lLPonL8x6hEBKcUQgKtuNOZEFAj+/UmB7pZ7ZRMXfwDN4VWx2uc9
         KoAXujBDNVjP5CHJOOaTU3/qxTljqXfPqmkKKpLBDfNzKgBOrRe2xpBQNOlmgHnZfKnn
         s7/g==
X-Forwarded-Encrypted: i=1; AFNElJ9fq3FMXhy/QoRZ6jXESBuAJRTnVLysUHIWWjm+F61/HSm+bsU8QtZRO/FHT/3wakrjAOvmBSvQxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65kIDzVrkfyqGggsWFNAzOH5OPhm++IKXVDKHYXEyo9KFqIDq
	f3JgOMnO13aEJBY0bShiL6ba0drdC5oUEabV7SAjfhgCg+8HC1pHIzhwSN19dU91Z0I=
X-Gm-Gg: AeBDieusovgUPeLmaHJQGww/HdMp1xRDbDelhwWolCkYiJlB/jHniuOcZMGUKM3Bge5
	GOS5pdSCR5vyJ74UgxTX+KWXTeT0gYBuP8YqMRpSS+sc/3GUVKp6UeZOd/gr3TLw+r6+jUQBVDz
	JVxYnaFAvE6vr9UneEyYAEh+w9hlPSPlDjri4a2C21/r6X4hsy1+fBid101d9H+nhPDZV7E1P4Q
	Qz5DCvP+OpDkAkujQP1hLANoRTp+53hlgqE62/6VYBYTK0jOIjCFJ1ArwXYxBC/DQ+LLRqnBVXd
	rsu0blSQISvkKqLzJhIIwSMNjzkOCL03XgquPXT/zrmh1lwMLxmDfMGZ12GWCC9oDw5W7VxHYbG
	XMCjNaJCB9PML4qjZU0xrBp9zwNG8HawR7Vw+e5huKLrW8qF/44NM+y0rI+gqRXw7s8S1ybxcLV
	Kd21inBpSCtOcUGL6KUHdH5FE=
X-Received: by 2002:a05:6a00:340e:b0:827:32de:d197 with SMTP id d2e1a72fcca58-83a5dc60675mr9849040b3a.40.1778219280244;
        Thu, 07 May 2026 22:48:00 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbdda0sm11196302b3a.44.2026.05.07.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 22:47:59 -0700 (PDT)
Date: Fri, 8 May 2026 11:17:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sean Young <sean@mess.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: elanfreq: Drop support for AMD Elan SC4*
Message-ID: <nms5cy6tgpcteav34jdtjf5mbmidf6rwc2uuxxef456xzegsyv@54rbblkdjybt>
References: <20260507090107.10113-1-sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507090107.10113-1-sean@mess.org>

On 07-05-26, 10:01, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC4* is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
> Changes since v1:
>  - Also removes elanfreq= entry from kernel-parameters.txt
> 
>  .../admin-guide/kernel-parameters.txt         |   4 -
>  drivers/cpufreq/Kconfig.x86                   |  15 --
>  drivers/cpufreq/Makefile                      |   1 -
>  drivers/cpufreq/elanfreq.c                    | 226 ------------------
>  4 files changed, 246 deletions(-)
>  delete mode 100644 drivers/cpufreq/elanfreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
