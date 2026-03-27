Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7636CE1C
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774583039; cv=none; b=DnIPDlO02wJvLS2qQr3t8dIYCyhkFcVQHniw0O+cWG+7j8/gQ2kS6uw0db6wbA4uBtGAN8fmmPV/JQdqpzazTvCGh4ZxA+5nQEbKfssZPfFS60WeGEI+5IZrZXdMDTRqces/za7RXs5mA6Po1caL7G4ssremCjqiPppXiT39Lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774583039; c=relaxed/simple;
	bh=Ff88YU9olI1AcQtF34nU+dqKfqNS8M+q3UTO5aU7lXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1cqQzaaFUhAElxNyCVWqYy4/EBNPzmAOwU38FAAvaeUTE6CwkDdim11Zyt1tZcDSAHYKetsaRXUqGQVoGKvozSsRUfJ4wuY9BqkmlLeSnYBnIw7cMnREI7IOfSewT57NsvtFHZpJURcEPoC8rOByEF1dG2dza/TjfHo0TdyJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vUaBDIfl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUaBDIfl"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b06c43e6a7so8393265ad.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774583037; x=1775187837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=547eAIb9ehebEHqANvGnVVe3TrWGzT3WuNgHvwzcDsQ=;
        b=vUaBDIflofPFa1RIx9TVnlr8GlB1AacH+w2NDg3/WZZhYSoEsSwM99VN+b0QnU3b6k
         tfdd8yNhEexhpxgPj+PuXv87JKSN5B+43giESLw5rnhPTkzLf8OOBk8NpcASa2NGH6QU
         cONUUxvvb5AZQMYPwaDiIfvvbGtgePsS2BdgIlazh/VIREloJU3B+cmv8+0xpSF5OEfR
         cvzkPxOQBL4l6kz+qry35sulJVIBMMma9B+OKRRVi3D/xK5xp4IofoosMy6r6hPlcO4q
         DGvuUjSX6hwUe/7KlJBqVrYtfFu7CXMCYYsLj18e3/nEREU/dLT/xTY59zmsdBbf8NFu
         rRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774583037; x=1775187837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=547eAIb9ehebEHqANvGnVVe3TrWGzT3WuNgHvwzcDsQ=;
        b=ieKK4l2o6MalM72nskf+ccRKarhnGNa2k9Q90WoU3clyl3x7ram/YfjoseCUOEUs6r
         p3p+ZlR6eLfOf2KLmWgJ2yju91ZPaObRXY9ApNjSx37IJ9QPl2CGMrOSqexnmnwwefpZ
         6D6kZTbz5XNX6uSEIbbcU3leqRS9eZ/mr3T3PGyEA/ZgC1sa9e3zGqdlYEPdCozUciNH
         +aYexe0Z9P+uBOBCEbTtR5lfOQVCFTG+hSoY3A4Jdwo5+5TuXNlgLtpjUJHBFtp/Qp3c
         aYbhZjnNP6slw0T/zSxeIfl+BGqs6Oe8qaSa3KG5nIkmIdRHrh8+kV7qHuXPYcvNoXO0
         XL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgPzxisVUNKaT789dekS+EE2NXc9YoJJV4IxS5SEyse8WTkEtEhyVBP8NjNILXMs1zwLyvO2EKyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1qkfyP4UkV6BsGBuLGn9YilYtWUK9bWlU1pXFtQrGFy06qug
	PYKuEBx7GdwXX/Ydh5Ad9xtdqAjDbUD3qp9Ep2sLkBmz3tS9oFjcZp9S1d/HpEDS480=
X-Gm-Gg: ATEYQzy17QZkLCO72h9H/LiomOQyhoE9ylOeAC3JO8nkx26x6fctcRhuK6D+5yPjH8f
	cCCcqGyxF8F6Iold6/YqT9noaA8SjVSRwJ1gc6gZ4rmeXALcu9v8c9J3axHR2PVe8F4gcMAC7gn
	yU7XvWRMsAbhN8+pFjNF3wxrU26b6SnQ9GWDnt6CEk6WHiLgxx6aRNl156A+uXsjQ0bj28lx1An
	J9GREGPvshfW4zLu9za57S/AOgQTK9KTm4GBzamAByNzAm802zwkUzYp52NPLDRb9viZuqwA+RQ
	gCFynz6FjR1uMqlMw6rUIxuB0ieGE87Ep103ExZyTaAdjj+TwJPx4QoErxgY6btXt5fTiHPFkDt
	sBsBVa3Pr4OftNyzyLCMsWCtsuk0MDowQLpg44rmC7ScVAo5dy9ZRgKgKynpOnc6JhaRUfZ5uXX
	bCSmXenohKQ5SBxJpQJQKg6y06
X-Received: by 2002:a17:902:ccd2:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b0cdc0f454mr11895185ad.9.1774583037448;
        Thu, 26 Mar 2026 20:43:57 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc883c0asm47539305ad.45.2026.03.26.20.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:43:55 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:13:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] cpufreq: Introduce boost frequency QoS
Message-ID: <mv7ham5nlret74v6kvstourb2f7d4zxurbgpqm57w7c3hzdw2c@w2rx5r2t5vyg>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326204404.1401849-1-pierre.gondois@arm.com>

On 26-03-26, 21:43, Pierre Gondois wrote:
> Pierre Gondois (2):
>   cpufreq: Remove max_freq_req update for pre-existing policy
>   cpufreq: Add boost_freq_req QoS request
> 
>  drivers/cpufreq/amd-pstate.c   |  2 --
>  drivers/cpufreq/cppc_cpufreq.c | 10 ++-----
>  drivers/cpufreq/cpufreq.c      | 50 +++++++++++++++++++++-------------
>  include/linux/cpufreq.h        |  1 +
>  4 files changed, 34 insertions(+), 29 deletions(-)

Thanks Pierre for your patience.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
