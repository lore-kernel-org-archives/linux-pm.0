Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54342853E0
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154371; cv=none; b=ZWePEMhbK/0rEDJKDmHukl8+7O/9gvWdRpLF9mxNk362IBErdahghvuxTWMS2PXmGinH6ehMuN6v+NY49aru2h9ZWnIf25ggSAxIPXmfSITGc1OYM8pxRSrXr+THThyDbjNYzsUhbb4PW3WHzDxXQ524dHDvFAA/Ch3mBNungGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154371; c=relaxed/simple;
	bh=DbE10ieYAAPdZ/aMj7Jha3L88yCriiIiyuo63Lm7PCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL+EafFUZ55W1LZxubdmjp25tfIr4r9Vj4xyjGdJYEscKdBfVJV+GpHlUOhgHXLCOe9YcSyXqD5J/vHNZx1e47qyODR16LJHh7ldqNEzHAC+lnT9tPxYrs58/K19dB3p5EJOr3ugmCdiWnE71NgVI8EQqtWadqkbiGUgtFIrqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUOn5QLc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUOn5QLc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso4364897a91.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788154370; x=1788759170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z3oEOL/HCSYn6nVXIxkFld926tCj7R+jnIQrhk3OHvk=;
        b=yUOn5QLcKIShaSFftZdQbmyej5/roTsoUwXl6MliySgXKrmvEh3m0snZd6vqjY42yA
         qaxdf7D3k6ESk59InZzH3Xfa4eMXDGsUO/tZIuhD9a+mxYsmlsg128qoRZHuZVpFYnYv
         gZdQzRjj3anUtg9sugk5TwYjUHACrfq6T2D7OYI/ZYoysueMZuuzusWBqG/TuGxqF+FK
         Kfa/yEeKKIKH/pukEPB70eWmlQar4Gze+r1gj13OLewshMgrlIB1RiqVTOlkcPMuOiUL
         vp9O6TaAo8ND6WosT5+RLiLtkkLZykywg8qnkQEH6/Azm2mJQItT7+EyVg8CIRhffB4q
         P1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154370; x=1788759170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3oEOL/HCSYn6nVXIxkFld926tCj7R+jnIQrhk3OHvk=;
        b=kC4mv2oKWxg9WUelZe2kIiK7Iv/+LaCGVqIxU2KWqKA3HyDDL1QFbm4pAPDvHzfl84
         fMOWebsKr4AgQbKXiZQ5pmriFbSeApF7fo+J3H5vkhu0Aqzer3AAMZqeOeSVz0kOWUuS
         HwPtLimmn3+G8kda4R5irMIa+fvKkQtew/85OvjrTsv89y1L/wyrlKJ04UjAmuh8N2rN
         QAlHs/2bsME5zS5f2HR8bmxylpYoIj+uYWRwAFsaywSWKUYP/Eeyz4tsX8b77Xoyf96F
         Yzmz4o76tmdWAn5Pg7TaKYaFNUQj8Q1cxaF+nwirkmziQx9b2SMggmjRYt0o/gI1lF8d
         NUgg==
X-Forwarded-Encrypted: i=1; AKwUvBworaEUa9iUXRJwu/GTZdGWzy9YEhqrplhJW1LDhWujjptYH9MPDxMsFE62JNm6qUIznUjPVWwRYg==@vger.kernel.org
X-Gm-Message-State: AFuF++k/VyDXipM+HCQ5csioTvXImZMZ7LRByCKTng22FLZ5FkMjopIm
	5UU2T7qNPSTxsZnDM0lf/8aVXdUFdrUmyDWSR3gSW+rCzYr7VbGAgbLf23++7G7FHJM=
X-Gm-Gg: AYBFou2FKVsJAj80u/fFyC1QbU2tlmBYmTa95I/gPMpniZcC/AJeTcfuGVHt6/RhagI
	JFUcUy4+mGhqPcTrWe6a/I6lFtIRUX1tZXYphieEMBm+XAzemGvEAX6pKjbFP4zQYujjxWS2Vav
	hjeZvNbuxprr+U3nPCe2IN6TTaD+qdhvFWd7jA4tLtbftXWFfUIH8KVUyUct8E3BfgYTw2IXtSS
	ikwit2A29UeV5KSQyfSTAPKAgOtlLbfYAC+2NgrzpWDW4yHOa1U99UI4wFk2N5CS+AIljD4Debx
	6KcIxW24W97kic+LW9SWL0TSvFkZBeVqADu1lDB3ykd9QKfZWnWG1XOusCtvdO2rdBFpE0TUJyM
	CedLVrwAbvOKFF7ddFXT4l9ypE+9sZDhvHtQEy7CpjR9LgYO7L2H26OiEdbCDj1T3yge22q2lB5
	wJ5dkZgZ6i5EXsVSytbaXVA/Nqc9vsb9H0MPJQ66Yy4n8f+HgZwAvZyiOfKGe+Vg0=
X-Received: by 2002:a17:90b:388c:b0:396:5f7f:52f5 with SMTP id 98e67ed59e1d1-396d0e2466fmr36959506a91.3.1788154369601;
        Sun, 30 Aug 2026 22:32:49 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm9171326eec.1.2026.08.30.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:32:48 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:02:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: airoha: fix probe failure with correct error
 check
Message-ID: <apUR_vBWRwMfUlsK@vireshk-B250M-D3H>
References: <20260821084541.139703-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821084541.139703-1-ansuelsmth@gmail.com>

On 21-08-26, 10:45, Christian Marangi wrote:
> From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> 
> dev_pm_domain_attach_list() returns the number of attached PM domains
> on success (a positive count), or a negative error code on failure.
> The driver checks "if (ret)" which treats a successful attachment of
> one or more PM domains as an error, causing the probe to fail with
> return code 1.
> 
> Fix by checking "if (ret < 0)" like all other users of this API.
> 
> Cc: stable@vger.kernel.org
> Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
> Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/airoha-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
