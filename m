Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4693A34403F
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059496; cv=none; b=MRWg9bHREKYS4OSrBOj1AGOr+AMfQ572CeSAd5TqJSpAUH/QyJqfP8qLqoV0LrUF638ILHvyuA4pbGz/bfB7R5igNJgEiYlBJqLU3gmUbAGiZcTMm9YYPg3/LFISyroDSGNfSqKEw7ESq//EDRjnDPXGWsJSnIUP2aFnOnjMRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059496; c=relaxed/simple;
	bh=eAlm22D/FTYm2yDyKa3B/r3DUVpjjOkJvimiyG+ILkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIZtML+buiP82uyrGGUPuFMlZfIwXvtSoL8hxKGTZTD0ii5ambWxjRo1z39rQeg1sVLXsnggGnMZ681ALLOxXdjCx+fDC6YPfbLrMOD4rn7uLibktA/CTUb0Vrz4tcqH+5BkuDVpQ+jbjiUpR6DnLXIkQVXr293LaOkf2Z//V0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUyhGEPT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUyhGEPT"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76b95e652bso1675038a12.3
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776059494; x=1776664294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AeQDQeBvQZOlrZs1SM9OmJqEmhvxKZeUuqXZlJxsEYw=;
        b=xUyhGEPT7y0qLZrcpWWnS73NON0qitxsYLvEI7JuRD64mXkOgz5HdC0125Mh43jSh/
         L31q9RrZFgiHNki9vR7H3feOjY71kTiLylZ6qW0DNj+/E6Zb3zVQ6BsnBil+XWtQqOvn
         um68yupybLfptFIqojY7DFz5Y8OowEMvu7LvcGfemClkPLzfKWXl4DZ3jNrnmEz/WzsR
         nwFgk0/ST49yqFGyOgjWeNVY3+WAu1/DfDZ7L0QBNXpgqPNQKoVlQtyCYR1lz5T+sgcl
         VrZdlpoUmVXuDG/STx/KbOE1nWPv9iYqcLw1lJ2zlaEOa2Jc/eC83OxW93ZS13FMpDgf
         5qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059494; x=1776664294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeQDQeBvQZOlrZs1SM9OmJqEmhvxKZeUuqXZlJxsEYw=;
        b=WOoGUrWej0JdyYDyGNvFULF9ADxAZJa9nYJfm7s6Azzimvn/T85mLSYrAuDECNdGDE
         DYS8yugMKdAu6LhIYZw25Dt2lr75l2SZmT6CM4lEAaw4Lu8MBCbaruzymlFQXvdz51t1
         +9IWjf4Y/yb9BjosWuISRuImUAUAtkd2xIXZ/cShNYVVqReX7Nz1EDOO/aF2CRkwBRES
         wVf0suoL+zy5HTD3wijiML4qHSr2zgRz7oM5PtgqXIaxr9d9magTLcK9L3z9/m8x6j7S
         n3sfawspDoc7mQ1RBruTgtisSyMChqRAxxQLCdC/kC1xTRFj8xH81M3Kdfwa6nYpqwqC
         VdJw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xj/e4LHIown/ROSIYpCrXmncs7mvB78i0w39NZ2qGU0qb5sb45iz4lLPVD+2YVAFpVtvxWY/+4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrpvGgNpyo/oOMB9J6kqqj8lT0zBNj0BQOpmIjBuEjSz7NZYq
	L/+GLJFmNCGowOnWkp8rE6bGjH1vWIX/UXqm/D7XV6ugRo97pXLkCprH2lzpuUleylQ=
X-Gm-Gg: AeBDieunLglPoA4fL8f8UfZcSVE026O+vP/KXubxz+h15aMpnVSL7pXE/CotYOGmAKd
	rnV1+HBCvg6EkIumuUvO5Ay7r12e3+R9GpppI/Ew2tZfIeAhhqrfjOL1GWwhEvKw4SPhjY1PFGZ
	UyDzJWr0ktGCY1J1dg2qpwzLT5cFu+ONHkrjHNklRB1Wh3O2PR/wmDAwjKBulz5BKgghOoWDK82
	jmwnXVQkiNU+22yO3J2KLcxsUOLSzNGyyfzBR9hQ/6oc2nosYeAf214GKa0YVo8QE4ee7Cmmk5q
	/Q9+C0cmT80V8Yk2apgP7FdqRH1UucCZgtJDScn+Y4NGaMaA6x7vEUlAcVQ0WxD8XWB7398E7om
	qSHbx7FHx358Tn7OYzO7TSbpzWUxH9BefAQuj9DLfdFzTdzWRLETblEY75Kf9VjRPHpEZCyDBeR
	NGsL99GzipBoz2MMJZpgDw0DYh
X-Received: by 2002:a17:902:cf4b:b0:2b4:5b82:a8e3 with SMTP id d9443c01a7336-2b45b82b920mr33230225ad.24.1776059494437;
        Sun, 12 Apr 2026 22:51:34 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f2ec20sm108579865ad.66.2026.04.12.22.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 22:51:33 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:21:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, zhenglifeng1@huawei.com, 
	treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com, ionela.voinescu@arm.com, 
	ksitaraman@nvidia.com, sanjayc@nvidia.com, zhanjie9@hisilicon.com, corbet@lwn.net, 
	mochs@nvidia.com, skhan@linuxfoundation.org, bbasu@nvidia.com, 
	rdunlap@infradead.org, linux-pm@vger.kernel.org, mario.limonciello@amd.com, 
	rafael@kernel.org
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
Message-ID: <zfoorh6tza4taswyr5zhxqn4rhcqzq4rtvz46eigoy25muxfls@tlbuypuwocvm>
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
 <208360b1-36a5-419d-80f4-431914407f61@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208360b1-36a5-419d-80f4-431914407f61@arm.com>

On 10-04-26, 15:47, Pierre Gondois wrote:
> I need to ping Viresh to check if this is still relevant.

I think its okay to clear the min/max state in the kernel once and for all if
you think it is not done nicely. As discussed earlier, try that in a fresh
series which only does that part.

-- 
viresh
