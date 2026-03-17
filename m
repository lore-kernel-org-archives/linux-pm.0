Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058533F38B
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730050; cv=none; b=e68uSLJhODY6HaYtx76gVMgeNtaR9lSYLj70MUe4tkbrJ9eN1D/Vv6sz3bMuSw6DzGXPmkP4JlW0jZPHQb0BNK7uea7cOoyNOdJUg4ZNSJE7tXMmKU8AfDlnBm80z62wgRbs1pjVzuT21p+g9vYl37WS/+V1fLVftuvDs3H5PhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730050; c=relaxed/simple;
	bh=0rVXzKLhUs1WgMyR+8MBuy/pI02M1rYnZZ0iMF4rYzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGGGlbHCGLy1ONv4ZegVKloOiKU++202iKgt9yBgz7UFIdv9jo19tNZEtqNGXA9+d7T433TMPgIgolzvoydLtdqGFRNT6FXC0EiC4HPDlygnhQMNIwv5JfTBF6nu80AnxW/haf31uBg3OqEy/SYN2BCNTncsE9ypFNlzuORn6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eJc8Enxd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJc8Enxd"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso3200562b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773730048; x=1774334848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1WS97ui2Kdn4mHbB3TiqHCGfv5cmFI6uwr8O4t3TQw=;
        b=eJc8EnxdgVlXqchhC+2Heige/cNfg5zT4Zqz7qReXvz5uuDbOIQUvfwGaqJHUVx4jn
         L8P28di1CaT43KhQFnC+x41/3n6uKxjw04cX0DxyP4FmsRuJgp1y53VMVa+aT3DjrY8m
         Fe+ghGDvGy8xO9IFU5Ita05ZD19NP4nOwT0u0zFZeqKcWU675vxiX5Az3GrHPOrc/QTO
         eRxQcza3/Utu/vQOn+QCUHatOjPYQihk00yRx3eAKfuklhPTxueT0Gyd0S7jSFF4yI0J
         qiTiTnn5ioLq/sgw/aYZbJe86ccfUaeP+b0ovGKJxw66yo2rqlqL92MQCn72iyr0uvIA
         YvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730048; x=1774334848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1WS97ui2Kdn4mHbB3TiqHCGfv5cmFI6uwr8O4t3TQw=;
        b=HNNF/nQjPcudRyY6bdhczUisKXcwxO/4TTzZfPfH26hL7jfHHhow46Oc5wj9ZD0z9i
         3Jr8jcCQuH2gWmGKt/mYNTPtLLtcVsj0+K8YvPhfqEj01C2x2t5Ls81Aeqw++FPFNXUg
         dzY7IpdNRwu8iMfiEBDuXjTdt/pQd3CRpioK5I0UwF8wLX5q2DH/e7wabeVBDq5akoyu
         p+LjvKq2Rn0qsPfy/QJjhbgkHIZgmhgO0T4q24apl4lZydcf9VCC3NAv9TJMsMLhHl6n
         gAoAzXj8Q3d9pilsz0dzsRzIXdfgDk0F74TgQMhLcYe7if8Cd3n6mgv66NpptKdkyfQs
         s1xg==
X-Forwarded-Encrypted: i=1; AJvYcCUe7ESPJRjyxEXFoEDokO2XefQ4awH6u33yDkLCKHYEc1O3G19hCYKfu7Qe3FhQfst0vwcXrhhiLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAp18K+UQ2MQ7TxMcWpezKctO79sNCYWAXqO+SCMyWvqCie9pw
	jo4aHwKBzrZ2om8GLEfck5tHpwqS/McaRcTfkm0qtfAnYn9N+gkh6hESvjRCcyMHCf0=
X-Gm-Gg: ATEYQzxOXIdpfbqEkkYnurUq0MNKmK+Ozb1YAlELMKXHiFYrT2A3sUISitMxSJQYBFv
	H7HhM6jIB902uMDRf3BL/x6x+u0EMoJuQjG+zC2S1j2fLjQnGi2asrzfi8moBhbb7Mk7JZzJP6i
	/kFv6ffOFxCB/j6Rkl+fZh0CeQLO9nBkAzXlus7xUIOdE9ySAvdGyAzUMcWvEaVdWmpHhjXd4hs
	Soxg+EGEK1llShLACDiFrbebUJkOdo0xzNVnNNcc5wjUkQ89jp6dqulRGH+HnL4qLPVp9b76RL2
	rKF6QLpH7AxxWeSsvg+UaYhlqN8m7xkbMoYCeTG2M1hX5q0JTWFFTb31WwG9JF+7bV6PUcZfAb+
	mdOD1wZQk+Ys4YhzYvbArgLgcA7wzYIKOkl4gRqrwWyMhk+imLFmplHNFhcmUXmdhckvnPrl7xD
	u17h7rY9B2ejG7RjdvF+K0cxVICOpQMwQMbR8=
X-Received: by 2002:a05:6a00:2490:b0:82a:18a2:91b9 with SMTP id d2e1a72fcca58-82a198d956bmr11007820b3a.49.1773730048172;
        Mon, 16 Mar 2026 23:47:28 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0727e581sm14535482b3a.27.2026.03.16.23.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:47:27 -0700 (PDT)
Date: Tue, 17 Mar 2026 12:17:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] cpufreq: optimize policy_is_shared()
Message-ID: <mzahqtkpyq7eazninszlipmzdgvxnw5ftp5gwhlaxpdqxbyzlz@kdsl4jafdgdq>
References: <20260314192544.605914-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314192544.605914-1-ynorov@nvidia.com>

On 14-03-26, 15:25, Yury Norov wrote:
> The switch to cpumask_nth() over cpumask_weight(), as it may return
> earlier - as soon as the function counts the required number of CPUs.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  include/linux/cpufreq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..8ca2bcb3d7ae 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -232,7 +232,7 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
>  
>  static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  {
> -	return cpumask_weight(policy->cpus) > 1;
> +	return cpumask_nth(1, policy->cpus) < nr_cpumask_bits;
>  }
>  
>  #ifdef CONFIG_CPU_FREQ

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
