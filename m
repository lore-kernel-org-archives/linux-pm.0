Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DCF3101A2
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162996; cv=none; b=XOrgwQCgPiboz6krkGDyP5ZMnOY3qlpkt3u91851O9bJSgJw9rj4TSYf9i5nmiaUluJvftBszfhp3GcFIYjg2xb3+xsfZdetbhzeT0WHBCGdt5WhU7FV+P/23XUtARHA+suMYkW2IHYZkT9wY7NoCvW9N7UfEEz2i+vIZDlaMm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162996; c=relaxed/simple;
	bh=/5KBAkXNsAoZ0dCdyXwjvLZJnV0sY2YkzB0CpxvtEFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opVw0UD8rTM+bgJyWyYIfI8eyM7Gjo8iSqG+zVSbkY8kLTDKgOti+S8ub575uNsHoPzUTaQ+XKf9Yy2KhvA1vTB5tcViLwbzQrdTvljZsX8DoFaKJqBNK9TLXyIZYqvP+H3sQCk8BztDn45J+KWyqykDnZgTsIaUmwpJRjU2590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FwtU1PxZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwtU1PxZ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so2229807a12.2
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788162994; x=1788767794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kTj871xlqaHMwYraZdh0kFP+rAgpCuDmxV4vm0NFxw4=;
        b=FwtU1PxZ3sv00HIYkScT9jNLH1hDhZ0/bDCpL3wwVw0yXXwIWN7hkW1Qyj4Q6W27mv
         oY88V1kc8gRSgT2DE5Z4Hb+zrwc9h7sDWBYWNdHNH5KRtmRayIbEqF3g/4DjtsdWRtYg
         4yOW5d/ymUa0v0lTxkEULSow1QiKrtlY3Qlzz/ks9pvOl+p34uTzABJ3W+Xxe0hru6by
         lYWDCe0fDEju8pczRp1ONLDSlYy3j4NPAaLfivvnBGA6QFEOKsl3g3c0oRrUIYp4eGUg
         cVW1up/zG28ppOBEgzlNr7VaU1Oel6GHjneX+raCY+aB4T6cS5AXrZr70jtaMbDq4ULX
         57pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788162994; x=1788767794;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kTj871xlqaHMwYraZdh0kFP+rAgpCuDmxV4vm0NFxw4=;
        b=QkWxMJ2lK+bCbiaj5gpFgsI5xYjvj3okwxdZyYBm27XA/Jru7gob4W9t3l5TEAEpsh
         dtS4O0Sgrgpk24HyXKq9J/CbvmqaZY+jVy2N6dcX+v3O07dSrCqE5NQYc58xU9gFyGjQ
         EIE5nZdnoz/3L33VKUIaHs2mCqwIREDRPJS5r14EfumzkxI3jr8K8vKMmxCorS2uDdcn
         7v7/fHKyTJ7GM9/I0q+SrZBKDWDmlMSLKgksllIsirhSsTExHddltvQgWSaPfvcZ7AH8
         N1CS9fd9ku/UsL6PM3EDy6bkevD6Fw3gGHlBsIqeGuf7Ft57n8qzW5lkFtzV9nyZHoWX
         dxjA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3/C53y+60BNREH18iBlhl27Pv74KfddxF8z9O3Z2AunM1izHmhUxdmcphLGV+bhdlxQE4IbE0TA==@vger.kernel.org
X-Gm-Message-State: AFuF++l5fg3rQ3nQC45shJO+YiZ82bj3XmgOGdSbn8RTOHtw6FxGehOc
	/7P2gQtiJLvAkeicvmO9rlRIccbq23EdfWxVOizOBhdJYpnWcGpFjAhZ2GT9YD1l2NM=
X-Gm-Gg: AR+sD13CfaQDF/3TKoycwynfW0zkWamuS//hhAlZVv2BjMtKBSyRdp8ywAKhwh6oWkO
	4vT+GG8cq5yIslq2UUAKIVqZ1ZWGzlGX9yiZm2mkjtkj2LnyWfHoUeu2vk1hMOzAFJmFByeJw7/
	yHWZrVi6bvVZNY9T5R8Lv5svUPFDSIHqZ+DCnTBASkeEYjvju9yumYcE21fjkqELgq1yiV0tT+A
	OfLB3V8K/FeDhxcRshNgeH7/ZnnGpU8o6xa2ZnjljrkRRVw02NgH2e4yWMu+UE+nJCFUbd7UkA4
	LzxQiGx7PdAztl1PN9q9SYKO1psWvseyMpHbvrhJ25DiA0JjFy8K+jm6sK7mzJXATx53UbT5YQp
	KE1k8OaqZ087io7NFAoBVdzcjuuCMrh5LGqYM+YMr0WYGyHkoN0Gn6Ue58Lo4PpIezZxonhmn7C
	7mcik2MzMkcj0/qeLCB5tmOO6erNcrYgBPOCxVnCOsoy30cVdTn29QyucpdCsM194=
X-Received: by 2002:a05:6a20:a11f:b0:3c3:6928:8b25 with SMTP id adf61e73a8af0-3d269a4d3ecmr37174478637.17.1788162993984;
        Mon, 31 Aug 2026 00:56:33 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm26529255eec.23.2026.08.31.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 00:56:33 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:26:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
	sumitg@nvidia.com, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra194: fix double-pointer error in
 get_cpu_ndiv
Message-ID: <apUzriIXGmxf-PLc@vireshk-B250M-D3H>
References: <20260831073009.3772408-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831073009.3772408-1-luoxueqin@kylinos.cn>

On 31-08-26, 15:30, Xueqin Luo wrote:
> ndiv is already a u64 pointer, passing &ndiv to smp_call_function_single()
> results in a u64** being written to instead of the caller's u64 variable,
> so the caller always reads back an uninitialized ndiv.  Drop the spurious
> '&'.
> 
> Fixes: 0839ed1fd7ac ("cpufreq: tegra194: add soc data to support multiple soc")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
