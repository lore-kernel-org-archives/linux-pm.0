Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922943101D2
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389630; cv=none; b=dQlKijQ3S8etKdfZsLiXLwpYVoM4+X0tDf8oS4nRa+K8xOl6y2o1qtTaNkGz4s63bqv8EcCU9JBZyfe5Ef8OmnuShuZhHCxYmwUm/dAaa5sy0D+4KvLLAZCyKS62140BYYpoB2zs0xkG5qj9TopomLYOGnOOb2l0mzjT8wrP3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389630; c=relaxed/simple;
	bh=QzA++DFGuQDwhpiAM8PytSjFgOTUB2ni2zVVaKO+UfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvpiGKJ+7boGoAJsY6sKTRWEr1N80Fayhbh/hz9szf5mC4GZaVA399xrhiwXrNapu70Hq+439mVOvNVZFMRjK6ls9O6n1rj5yOvVTkIG0wtgQ5Ps2BmcJNTPKswXuFLtOI3VOQuaGu6tfa7qrI2TIoXgb8ZdJ6Q5ZIqnmM/ApeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gu+VNv6E; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gu+VNv6E"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c6e2355739dso685364a12.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773389624; x=1773994424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPiU/UbM9hvgFbZ0gliQuFy9IbMgEFKd7U7wfZ1TREU=;
        b=gu+VNv6EmF0Si7YLIP0eDucMklI/lXIGrnI33w8vXYrS3lb8ukXxhswai2zwFxazCw
         MqA8cxYJXqV9c/nJjV1UPN3I01cyxUztRsJc2zzyTveeOnGJe6AgDb53cg8FKL1MY6Bf
         NJ2LrYRkLr4M3jh41JlxK5H6tQkKiNx9lymTanqCHt5tpydroZcL80JyUqoBwOLx/rbd
         kPyG5Lbdt8vrKk7/mm2wauAn4BWO5eQN9jnDw5/UO8NXeRD1cJtgq2TOHae8Ltd5VJen
         j6MHrjPBktMPHoTkqL4kkMoiSBnBsRy7DKk89CevAnW8bHSIh4HzZGchNMYfr/3uwh6K
         YIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773389624; x=1773994424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPiU/UbM9hvgFbZ0gliQuFy9IbMgEFKd7U7wfZ1TREU=;
        b=gNeIkLDNI3yHqdcFoAzVUzuv7qvXl9a0kx8To9bV0B/S6owy91SmrrQaF0kd84mMgS
         tzu85sNZEtL+xY/COqLV7GD3tzpYLSBJKc3U14xI5eufzMCtVk7EHNJz6t35g4PlHOMT
         CgeZ1wWzMFQwEF9jlsaHIVGhWdy36EkgVz8D5KyFh3y/mRlYsZQv0GrxpojTQ0cLCcAl
         qmp+7jmSZzaxEhQjHONe4j86xizj/sFmxCet2/dkS8MXEA13ymbq8ZY/yOQF1oaQu+p+
         NzBJwWgTz0KZ0q3uZzN8Sm3UP7fUD6t20POaLljb+wT4ibyTOOhQldbXwxBapkSTimEX
         EMHA==
X-Forwarded-Encrypted: i=1; AJvYcCXYTs43gzN12bvspghoWfEpNL18cQilkl5ojvz2Ge8pyUYfjH+2sfvaLUId44Y3DS5RSSZYMW9Olw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnz2a2OQLRbH7h4FsycLdZLh9dzjEiEyvn5VSmpJEb3aKIqou1
	MT2GlMlukwAww1l9O248d0xwGcKOe1Q5+x2T2dH5eaqZyhO37EHJt2HWaoIWsVrQcDpqd3Q54ks
	15Wia
X-Gm-Gg: ATEYQzwUrzjqcrBAgvZ4IFy7a0+PUcx/JCxNNzqZLMeJNrpbrI1N8MpjLFgfjKrxLc2
	swfZKnOqG1EZcFdy/GX0T8jrozZQYtFw/8ByRABnKEM2rrdidsU70EoNrwpVKd1Ik9FYNwBETWr
	pWhuJRdt7KFyj51JS7ThAF9qHtNn0TYA4N65tSbPotkSffbbvZpG5EnQzEjjEQjDRpCG9+DY6NL
	gTkbBxTHOwCgvW+widCW86Gs1zTLSRa45m5ARRuMvqzi8mocPujtyQNHzsUKenP4h7R3h+s3mE4
	DlR0qclBbhIYC2TWmuZz5WzX+eBYXcY1BGW7A2uujyy8Ks52B3/2gH8sd7C13+bnsCpRf+mixE9
	CvGB9UI4HcWpi7HeNfeRJj4CcB0dURoj/x+V3oMS/VSW+BJ2p/ihyZ5CdwLFDZzuWZCJ7PlxsEC
	S3lcY9fmbggooCkiDBQBrHr9pX
X-Received: by 2002:a17:902:f601:b0:2ae:6364:e6f1 with SMTP id d9443c01a7336-2aeca940e7dmr24944375ad.1.1773389624264;
        Fri, 13 Mar 2026 01:13:44 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd14sm19452075ad.50.2026.03.13.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 01:13:43 -0700 (PDT)
Date: Fri, 13 Mar 2026 13:43:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/6] cpufreq: Introduce boost frequency QoS
Message-ID: <qjn3bgedmtbvrdjlhjmns2h4hcpx25vfzxpbfcbyemxr435lhl@ctbmdiye3cj3>
References: <20260225084930.1692228-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225084930.1692228-1-pierre.gondois@arm.com>

On 25-02-26, 09:49, Pierre Gondois wrote:
> E.g.:
> On a Juno with available frequencies: 600.000, 1.000.000
> Boost frequencies: 1.200.000
> Using the cppc-cpufreq driver.

I think I suggested adding this example in one of the commits (it is useful),
not sure if it done yet ?

> Without the patches:
> # ## Init state
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> # echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> # echo 1 > ../boost
> scaling_max_freq:1200000
> cpuinfo_max_freq:1200000
> 
> # echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> # echo 0 > ../boost
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> ---
> With the patches:
> # ## Init
> scaling_max_freq:1000000
> cpuinfo_max_freq:1000000
> 
> # echo 700000 > scaling_max_freq
> scaling_max_freq:700000
> cpuinfo_max_freq:1000000
> 
> # echo 1 > ../boost
> scaling_max_freq:700000
> cpuinfo_max_freq:1200000
> 
> # echo 800000 > scaling_max_freq
> scaling_max_freq:800000
> cpuinfo_max_freq:1200000
> 
> # echo 0 > ../boost
> scaling_max_freq:800000
> cpuinfo_max_freq:1000000

-- 
viresh
