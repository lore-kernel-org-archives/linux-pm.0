Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8265382284
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772511133; cv=none; b=OSB5f7NRWnJ+UWXl2/0iaKHHzB3yCnx1xXYpQls2w/iw+jpnh3reVtlwkjhrbyng0z5Ps5dc9opLuOYopFsfcE6cY5pd+HYX9vbh15B5piCJk6GTHfENmj+ZjhSaeD+OFsDoC4I5qOJv3RAE1De+uyKJm2wQH8wQbiik7qiaMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772511133; c=relaxed/simple;
	bh=SZ9LMYsksoD/RYFcH8ydVOYXiVmwcjNz+SNcyqurUBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5S3UIyib/acw46MH+xP4a785i0MIX6o3rKd3ioWxUoBY9WbBSXrusNv27KWHMg9XcpSydDvcw1cMeEOEjv+qSO4tStqIyHk5Dd6GwS1ZK+dTRXL8F+JplNtGfDuYWtlhu0zjwr05VuFaNFT0/pCypsYG39gUBqEXtMQ++fiYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WTfayHc2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTfayHc2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81df6a302b1so5631876b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 20:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772511132; x=1773115932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gpDS3X0VjlcydTav6/z+gRe3fJ5/AS7J2/90esXI00=;
        b=WTfayHc27eP1a2ciZy1kNjum47NtWU5HcFc+CIiw7NIuVbbSWMxqaj1lhomOJRJvP/
         Tov3jIdUc9CmqysVvt/gqUeKz9bc4sLzM4+XgCf6eTGgRADt3jZlQ3Y4N48cS5nQu1G8
         aSJ4VzSTRRgc1TJb+XerkUNHwb5QQ4XLRxqTQy0ssiyTQBp/Eez8+bhlkNBg5V0K244X
         rFN0KELJhZFYHKQ+MpTYHii2uykguxD0J2Wh+6xfD9BRitGjsi3GFxpxPmnChJ3ohRNA
         9a9QdqcXdk2xs7VzohHwcLPLzwwyJOJfmrY+iHe/9YVSnSmu+OVaedTIyRTBfVHvSkp3
         QmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772511132; x=1773115932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gpDS3X0VjlcydTav6/z+gRe3fJ5/AS7J2/90esXI00=;
        b=exuAWMXQJb4kRRsez4Q4ELkAscBJ7bX2d4PvRgDdxKYX+5b0pG5od9V6QJZEu9Lzwg
         GgnbtCd/r33phBOf8C6PcPk1pQCSVDPsJCXTPcDW5L6KJxvh7yPlG2uMhVUinjE0tjFy
         OSJ96l4SA1tjzhOxFNaHh40zW6vdo0J96gJ6kZ6uYsSXPBssFfxYkU3bTycZILrMR9jm
         N6Os53rK5yBY/X0h+iq4sYioCZwDaVTRI0lhb5RnImahPsEbKOCPTrOhQfMFpfECGvMG
         IslxKPT0UZ/ujObNAwdrjxI+GbOj+XTGrE0DmvcJC5iGWuZsUfSYSkpfS8Z+jFaR/xWq
         yOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MnEb7IEf2R7wdQ7f/n2yZDB3KJFMkOLw8s9YKEUP59qz52ZZoMuuKjvdaDOrqZQ77tz451s7cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFsm0EFtRgvRGl4dw9/L9JzCZ2qp6zRkm14G9v5f991lHjmHQ
	r7ENPMHeLOtypk+p37TMZPerG4oCKlfA1wnxu5FAIF/HjvAfE82rQbk8N1jBrgfbzuE=
X-Gm-Gg: ATEYQzzphcyRUsgoxsUZxbYIkx/pqvzj5eqhZeUz/T19KWh9MfOlxYGMKRIVaYm3O9q
	+kEf2NSHykr/smCcTUvdeBO3Jnc2/+IQe+DoQmrHgqikwiCquyUPPgdSo7s89NfJipNs5iDhs0s
	Uc6cKqx+MbZTJvxazittXy7YLxyX++SFbJZr95Dh66VmlbityOgri1jcuYEJYnSF127nrfkMaIz
	l+IZFI207PHjjDcVekfwWhNN4SFsmgh4D9wFzKqLU/au+VboURrTzxBhj4grcvZDPyW14N/98n7
	YBn1IESYx7tQ5yeCPvmfQstVkYq6Z2Fmn2vmZh0kXSAiECNMSIIPPzaITzw7PI9cHPxLTbnQrpB
	EyEOqq7zigFt6BRIj9i7xwJKvrSTzUi5zYOnH0NwJPT6gYPHXYSdniJdDgi2JjbG4aRwPA8TNnX
	poaPPhY/FpaX7ZtWQYWGXRQhaL
X-Received: by 2002:a05:6a20:c6c1:b0:395:705:fcd8 with SMTP id adf61e73a8af0-395c3ae6ce2mr12710726637.41.1772511131473;
        Mon, 02 Mar 2026 20:12:11 -0800 (PST)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa620faesm12655304a12.10.2026.03.02.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:12:10 -0800 (PST)
Date: Tue, 3 Mar 2026 09:42:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: Use sysfs_emit in sysfs show functions
Message-ID: <zmsi4hmhqk6kirjbhs4mrcrxqpl7ajer6u5poob5s5jcw7gwas@bxbddyoqehlh>
References: <20260223210351.344388-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223210351.344388-2-thorsten.blum@linux.dev>

On 23-02-26, 22:03, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred for formatting sysfs output because it
> provides safer bounds checking.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/cpufreq_governor.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
