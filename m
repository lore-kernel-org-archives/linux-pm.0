Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EAF3469E6
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004339; cv=none; b=m8pdzYxi9IuC1TzmYUjVIhbDx2pNTdt8BokSCnV6LlRERG67f+TgKxe7MUdi4j+AXj3tKRiDhbiMqrtzUeuRlC8KoeY8WgvVoQU0UZ5dwSBy4RR8rHl0qL3uoCeRDVklySJBhre7W5z83Fx6TEI9bpQldF2pmQCbCyR32VImNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004339; c=relaxed/simple;
	bh=MBOL1hHz/9tSi4pzotgx+mcrCH/eq6+Y1A9vnjZ24vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frvs5CeD+Giair1nC5NRWtdLaTAvajvZf++vLrNA83qArHZZiCrZgp5LEVFQJDlU3qupXQZNGlGBqDEVj8JtRJwUb05fBdERymdpvFs0YNq+WcTejW0ynih/quNgqFGDZw8YWxCeSm9hE+zW95MqFF42JQfsF2bigcJOAwnhgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cu8k7xpz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cu8k7xpz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35b9d29480aso425487a91.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774004335; x=1774609135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mEDcRJrJPFtk05oEPn9Ld9sZyymCsAmIBFQ51i4z4k=;
        b=cu8k7xpzYDAHvY/h0yonuGAjvg7qFDOoKPKETQNOqdtO6zKzeEzEhLB6Uhu9YuQQR7
         u/rkvHof7qeto6lDERZ3EOp9HIKqiTFZSzYM29udmCBqlfWx16c+VeuLkHbQOVo3OgQe
         PsFIvNZ5w3pJrb9ebaINlXGfNozv9clByXFtjuC2japADboGJQVSdeUrwBDI4ztveFtx
         N/ia6gGqYN3kGn7Nj6bCiqwA2RXMZRa/lQZaM9ezv/iDxEu7Z1VOZq6Hln4JJKWZObCt
         VfxJEyC+GjwV+QaUBKqK4x5kI5N2waZyz1PhWnAtgSv+AxUSyxDghrC9nDlc4FEwDj+G
         Uv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004335; x=1774609135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mEDcRJrJPFtk05oEPn9Ld9sZyymCsAmIBFQ51i4z4k=;
        b=dAJ/m5KIWfI2duQHNjkeKnuNdCb/RS0+QqK/R60KYCA0jiz+8FDqIrlkWXFbwQFNp1
         PtgM6XFZDwA/QTndrqpzMKYubJNXk8o1nASQWD9oUYmxZhMq4+ijVr/y7XV3LgkHG3VD
         o70b7k5lk9mowFi9S050h+rEMtD5vTDdZUqxjDBMy+FePpPwN3081HHQV+fpl33qondP
         ycuQFsDQO/pmq+FSlSxijZMyTUk8bPgJFnowCR4kWLObmS8Nkh8/slD925g5MbMxP7tL
         QRFu+fKWioSDX+7qWpmWWWa2IWbHxgIuLe/zEuV0cwXvkFpgqPM15n9617z5Ul1DwMjg
         nU1A==
X-Forwarded-Encrypted: i=1; AJvYcCWtq0Gzz7JVD1mUv5YJcs0CEg2ZiDzw2IB6qDcNlQvEnCju+yHziRfyakZZLt7iGTBDxBsxCpfKAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd4WrcRoYUaRmyYNAnXe34dRQvFehiTyHY1ZemL5JuSDoi+1jo
	kZdQuUlyMHJT99CNfqegbGiLOtP21OXTZzqQLJT7H7RmlZZvmb74ZHNV6KQnIs/duck=
X-Gm-Gg: ATEYQzwbWadEp/dq/DVlM2O2UP7oU02LkLc/DTwCPJgVMYRoQ8oyq6w/Jt8ZQmD1M7t
	XLdLQ4xpMtKMTwsyDzPCZGgtVAv5vL5+KnIo9TbwbBCli21LJfntR95qjKgr71irCiZ36EC907S
	tfce31ybDuj9pJkV9WauLXVNtZgnS2E8lQM7+AKitrMO2wGDOYLtyV6covmCZb4LSqp1MK82uu+
	nFsJ0egeSRQvhU/DtQ1+xJYD33zHQXK544CRG4sZ04f1DXvdDUGfe27oTrccxkKnnACeHGNhBti
	tZiPrE8Li+kwGFeBiSSaJwa7xkIARfdSxMgvP1KtijAfwYr7j/VmBbcUkFhEPB9HR1HbhhIEMoI
	vtYY+il6qTjUDdkyhR5NfyThvdIePbMzS7HrOblc8E72/NHFzbnvHIpjvjLtED0D7EvLYRGwB/B
	BYWIf+cZczagPvAoPGIBmPcmvpgAUz3W2IUkg=
X-Received: by 2002:a17:90b:530f:b0:35b:9720:98d0 with SMTP id 98e67ed59e1d1-35bd2c20602mr2279833a91.5.1774004334895;
        Fri, 20 Mar 2026 03:58:54 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff7090sm5157376a91.3.2026.03.20.03.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:58:54 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:28:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v6 4/4] cpufreq/freq_table: Allow decreasing
 cpuinfo.max_freq
Message-ID: <dpgedx2facqgjryad5gjcapxaf2nkids5qqagpigxlmxvl3si3@m464uba6vx5i>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
 <20260317101753.2284763-5-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317101753.2284763-5-pierre.gondois@arm.com>

On 17-03-26, 11:17, Pierre Gondois wrote:
> Drivers not using freq. tables update cpuinfo.max_freq in their
> .set_boost() callback. E.g. amd-pstate, cppc_cpufreq.
> Drivers relying on freq. tables and supporting boost frequencies
> rely on cpufreq_frequency_table_cpuinfo(). cpuinfo.max_freq is
> only updated if the new maximal value is higher than the previous
> one.
> 
> Using the scmi-cpufreq driver which relies on freq. tables, enabling
> boost will permanently increases the cpuinfo.max_freq value.
> This patch allows to lower cpuinfo.max_freq.
> 
> Note:
> commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
> if max boost is known")

Rafael needs to decide this part, since it may end up breaking acpi-cpufreq.

I am okay otherwise.

-- 
viresh
