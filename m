Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD211DF980
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382074; cv=none; b=k9msBUoylc0DXRk9BKxVFvjX2OMGckEtvwoX1QidY1YAyq5vUx19wZof8x8d7YW2kyHLtvxrxWhEWpYjxN0S91weBlwiqEUfhLY2SN1UQrnuiVQoy7dfDlgZozSPqwvuYZpgHzoEIG5wMKqIs06jPItaEkrkni1J/TtaPJ9psE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382074; c=relaxed/simple;
	bh=c6VYYooBuklbrFIdu6kM24pC5jve/wT/sSRJEvmlKTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REsijDHQmUzKpv3sVGxxb4qSc/PU2eq2v5niLsBofcDeT3NXgMUIj1qfdY5Wj1TC5U0SwWEN82b4xwBI+RX+l3z1zv3k6/6UXlv0g9tSZwkYlXEquJSsHOjpR0Im6/ihPej0q4z/nXjWX934WyE3VdBrW9I1g9HBdGl1/O5TEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdBV16/0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdBV16/0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad9a9be502so11706985ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773382073; x=1773986873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwCbFjCjgsNsO4YhMYDCjGLZ2umsTE3gLTKcHITMbH0=;
        b=qdBV16/0jhm2xFD8b/ly97jVH9XtwRaFOsqq410Y6WnpItqnFRRIhMD6QigxFIH/vd
         zfpNgCuJpyf9kDLLtQ0uDb5bf3MnJBB9CxrKqilk7UofkiUnGjCWpCtQZTDwUaa553ZD
         tNtVz4ryRR9PAtinSFY6KomdLemE8BPCe+0Q7rjSF3Tb+kgzrYl4PUK+DRpyG6JuzJ8U
         EOWHnuPY7Y3yKg40h725GpvqVarfry8OU3xDZ3VHC9xmxoJ6u2OD1hyaqtdSdZD5Lj/G
         TG5zO0R22FTqSwVB1tSBlUtn825BZ1k1GUU0hh/7lmRbd2McMKfodNqII9EpL5G/K2sR
         qXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382073; x=1773986873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwCbFjCjgsNsO4YhMYDCjGLZ2umsTE3gLTKcHITMbH0=;
        b=AhxjkjXgvYhiGTXCwcoUQdtg1T4GCYRvTdY5PficLGmvP/Nyahy3u4dfARQe7yKAqj
         yFbT8mhQeZf4JA5OEc02EIZbzTzesM3y2E6rm1D82IEPCN6WYHjDlyFZ4WOZbAcOR/se
         QXVeKtjHH4T+uCL+oz3YNwIXp4abRxKwwtnO5wS25yaNO6HmERQG5lLIaZ65wClRn4AG
         WGICFgQrEN1P63naytE98x9sQmoQsG1hzqa2dmC07kH/7V82pDk/47/sXlcPIn8UPQy7
         ZsTGze7B0aIdw0agjI+RJEOqLWYWO3kBV26FwjVZB8WLsoJM5RDeXB0ZZ2B5OruHidbZ
         4gsA==
X-Forwarded-Encrypted: i=1; AJvYcCW5lnSDkqRPbYDk7yJdZyaT1X51rSyDfzOOMtJ90hKGEdO7V2jyG5q6jkR01qa3TlRpMrM1b6GpWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYm7wy6AZNZB9h1FLNKc05UQYejuzTv9DiQHSgvXmcO1f44D8
	4u71kHC7aekfy7FQaPk4X+ODPSTxz9GmCYqzgbTQhuERfckweLVmY0eHKeUpdIwUadU=
X-Gm-Gg: ATEYQzzPq0LE5VvnFda1/q5aDSvZVOk1P6sshS4zPUB4Ab2r6lkALaomIT3OxAJkqcV
	1r3Wm7adJ4XV9BOBXWUdhwlbNacKdFiucP729eZGBXJeyeGy4n0N8SjjLweJ1yIClTHJHKjgqJG
	9+4oGt6ubhZG+FfQCMBb++2l+Zui9OF99ooeyC3doN0OgzmCmGuw68AwQ8VcT7ZZIzcX8obviAa
	DTLV4NB7ZO0va9NqkdjIe6+pfeYBMAIZ8mU64i5qMUdI6J2oY193VXtoO+ZKxBsPZsT7aFNO8JP
	K/LiR573FM9ub/9B0SrQW6oFIqYEa9h+BPbHqUonrnTmOUAam5Yu0icZpm+3spgktHCgC8aSqvK
	OD6fJKIbA6DJA5xxXD/Ft2NyLHNfuhrAEPHm59ZU8Q3kaRCLSsCu8K0rmtKdTphJ6T6ojlBItbx
	fYKA330dlFD8X7srPJeSJG4Rkj
X-Received: by 2002:a17:902:ce11:b0:2ae:3dd5:c69c with SMTP id d9443c01a7336-2aecab1ed6bmr19020575ad.33.1773382072584;
        Thu, 12 Mar 2026 23:07:52 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ed753sm12352835ad.45.2026.03.12.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:07:51 -0700 (PDT)
Date: Fri, 13 Mar 2026 11:37:49 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] cpufreq: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <upto66dotvjmkd5zsdbmtumxccm53qgwmf3qlpfd36q56jqfcj@7ed5kdoq4q76>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-7-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312150523.2054552-7-vineeth@bitbyteword.org>

On 12-03-26, 11:05, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6
> ---
>  drivers/cpufreq/amd-pstate.c   | 10 +++++-----
>  drivers/cpufreq/cpufreq.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
