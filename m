Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028F32E72F
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135723; cv=none; b=bpMBqatI76LLxQBpWwjt73LBpEDSTHMT06gv6jiSMJUkCrKKuBfuNe+2bnf/9MzLEQjPNrLA7li2NpMFn+eTnCS1EeTYujXgC4izT7+5hxOJoS/gyPXqZhqr9eUs6xpetmJ4sds9iEFlc8QA/jy6LpC3TOMshyW1xr8fHPLHwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135723; c=relaxed/simple;
	bh=G2WMwP+4ZHgPILFUcOHdi2ddx073pEqlCcI35ILv3OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prFJ12B4Tcp2CzbpZdahQWUtngrhHDQLWd8IQ3Er6VGS2OBrPS/HUcf4FpKyrU3YOx2pesbjo/6ueSJDSCnX9ZT2W5wwNtZNPpOvDLkWEE+Q4zZdC8qORzI7jdfg68MuwHf8T+vDZgaKtic/ejfaMCS2TYqdDsn6oEFCLSoQ3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yy0SQ+xz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy0SQ+xz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba928852a5so3060355ad.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778135720; x=1778740520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+9Mr8wRMuo9k5SjJMJMwmA/7bJgsIptgFWAxsVAj6I=;
        b=Yy0SQ+xzUOHgyGWfGP400fapxLSlae/1Hn75VwUiUbe2z8hseJsqTffKGrIBvKmJ+u
         LCcUth0jUUeX8g3MtGsLI+YTpmmJVrhQdfnrmznvUCjIZwJG+VrcERuMiqlEmb3LeqS5
         yHTDR7Ex7QbAqftltGTWGcLp2RKSGzptGavG+1yl65qPS+vK81gobmQwW3LaNGtIa9w1
         AwXypTquQE368rJTrwUDADMHQE0t6SgrdHjb2xUjG8gt3iq9FEcx3oYX5wXwVmrn10ga
         Hj9XRNcVzl50/e+zA4pIpoSyFVsN4XOy6j7NDVKVLHJOHIY2ihpyD8jIsIDv2C9FgCyT
         I7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135720; x=1778740520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+9Mr8wRMuo9k5SjJMJMwmA/7bJgsIptgFWAxsVAj6I=;
        b=SPvf6ajseXmDS0h6MxsthBH+2blFHk4QbeP1IWNguTWGQJ08hqG5lQzw2DEy3TuUjP
         ixUUboCIkwuolQ7Qt9HJ/tqLKrwMKFJcOTN074Y3CCkFCCaOT4h3Q0hKHlieMCrj2wnT
         Q6XqmVgenckJUEO/DvE7gA14Zmj1XDCVHBWv79fxkxda5RVyigpd3AkF1ceLZ6X5wjnZ
         eGWk4Vp6Ly8zJ1TthL35SuYtcq8bvw1ZwHJ9iAzgKgjePxYLH4p/0WHU552VQyw5NoP6
         XWlSMLU/DdsXsh9KkjFoP8YKNKDXeBKMjU7Qfb9/dozUgk5fFUPbtKZQg8s8yl6lQJA7
         NzBg==
X-Forwarded-Encrypted: i=1; AFNElJ9wiUmKZWGOWDSUhAystK10EHyiHGchvdB0KiaYdr7w/BMtZQKXMVRp44e/nGBLMdswpbFWkuhF6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMYPh3GM/3upEXBiUbkZwr3k2IS8QUmbyuFdUb9fLWxX0xxaFi
	uCyfqXltfMXrJhSq/HoHgx5GYovCvyWYJBQLMBEUl2xQLtQxGJYFT3pP0DAuCJ7WFsg=
X-Gm-Gg: AeBDiev5w+NAf9t84IhrdG808h2w260KSQxVEpSe2wp1GtmBGv1YKyAULFy3YcWzQtP
	mKJh8nO9tGySmD49bDbYPIhcsu6pwuHMF69S10R4Sa/iO69gdDzQ02aOD6E+7975v8tWCEv6FzR
	vMd3Jm8uSu9hChwszAcBN/MxXxc6YPX4BkXCdFMcf/SFwFyUzLZA7NKMgsZViOGU1WA6RNMdsL3
	bFcrI1yo3NC1Ryo7XlxEzXN74IuZHHSSZ7A0ZCAKe1bmUCsYIbiQncOnzTEJIkRut/x9NT46mn2
	0Sns43sL9RN3LmDoVl1QSpl1SbNxlb5dqeQLA2QM2vBMY21B0pV0ItV4tDRhVmAuxUQA5K61ObW
	A/nP63Shdqma9aJqMX5rzKAgCRYgfYeXZORHJDZ17rIXFSL6xGHaEAEEfHbDjSjdp3ekpqLbihQ
	hxQ6CscxL71Zgg6nJ1qytS6Un5A0EbzX3lC2CfacszBDXzQOdmQ5cip80=
X-Received: by 2002:a17:902:bcc2:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2ba78b43e9emr47792095ad.4.1778135720218;
        Wed, 06 May 2026 23:35:20 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaac340dsm13818375ad.1.2026.05.06.23.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:35:19 -0700 (PDT)
Date: Thu, 7 May 2026 12:05:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sean Young <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 7/8] cpufreq: sc520_freq: Drop support for AMD Elan SC520
Message-ID: <o2zsw3qo2btrfptggwkskjwuqdb3l3xpkd5in2abbclgisg2xt@zi4sedmhhcxu>
References: <cover.1778071745.git.sean@mess.org>
 <12a3abd097fda750ae905290c86ddb8d2b0a716c.1778071745.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a3abd097fda750ae905290c86ddb8d2b0a716c.1778071745.git.sean@mess.org>

On 06-05-26, 15:42, Sean Young wrote:
> Since commit 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"),
> the AMD Elan SC520 is no longer supported, so the cpu frequency
> driver is no longer needed.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/cpufreq/Kconfig.x86  |  11 ---
>  drivers/cpufreq/Makefile     |   1 -
>  drivers/cpufreq/sc520_freq.c | 136 -----------------------------------
>  3 files changed, 148 deletions(-)
>  delete mode 100644 drivers/cpufreq/sc520_freq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
