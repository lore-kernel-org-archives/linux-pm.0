Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D937FF7F
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 05:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783401044; cv=none; b=NVk8lTW+wqUOxy6yBuchP0F5g3WUQVCZ8CNNl7ydVleWxEyxCBSFhLzzic7opI95C/zHVht2f2V9bl4I0qHoYB8dQbgUQ80AEs4c1AXRLpo/8iIgjzReTG3vaQoDbhfdALmnJaPCpW3wHjLZax/bJYRUgZENePKrDwbnGZSerfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783401044; c=relaxed/simple;
	bh=09pBjauv0838HDn3fbf/w3Lov5kSiWIMIHEO6sJqUyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlgiCgbom5uOSKBhfh9AYCfq4g06rcH+IvIwo8UVu9/yLCLkXmlGrm0+TgShWiybzUChpH4c2tldaeEyUOT9OmEtmBsKARMga8bQtwHzSie87OUOIOBjbrIPlIUawEim7tPDyggq4uoqMlxwgBTzVsvy5zuzrgcNd+ckhOx0H/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxz9G32z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxz9G32z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3660746a91.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 22:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783401042; x=1784005842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rCviGYAxqKCjjniGYaw42oP7QrFMhf2K89fW3sESE4=;
        b=gxz9G32z6Fuha7706aYmJCCdJ9F+c/0ekkZdL9PRSKbR1dKMC9ADBnlTVqQ60bJIKh
         LSazmAKQfglXZ3irnCQoKizVXbNzYNAsxbqN1wAw976mHdyjzwsOLE/CMcGycNc7zc/B
         4VKGr4cEIT6WEN7zLXgj2YfRwqhiltxP8BevM+s+glFXkQ84uD4u0Qd9XQP7OGBPgFyX
         R1DcW0/Mg1itjUh0rkJSYL3NiEt82Cgzevhmwp5LI3VjJ7tDjSqeYOblfBMC/uWw7h9N
         Ns7Ge25zso7RHDnTXRCZ7Kf3wVmPl2Z+3JKWLJqshhXAi8Rk6qflg1uQ5CWrF4UD72bH
         1SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783401042; x=1784005842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rCviGYAxqKCjjniGYaw42oP7QrFMhf2K89fW3sESE4=;
        b=PvTCWwsNVpTh/7IbrFmA7RtnL+9YP5+NgemhW0drzUqYVtG7zvbiUWfV3xuX4SP5sf
         mnlbLjPveMVY5CyIhmg6ibs03G9F9xzrHy5BL2I+jI+hm0uq/clVD2D2mTtSAz0Sjco7
         z17E0o2Cx/APSuxJP8rvc/IkAEvAwKXRpbHTVmz72ey35ZTAkKzg6GgBuOp/nS3pbA8L
         9SMvJyURFHQ1ChCXPIbMfwho67k33A7hITVGZ3ealhyjjUJxTtxsu+o4wdiOgSnw88wF
         vECKMWPRdWQKxNrvTocKogQzkAbdNieRefXH0UBbnWdw6d0cMCnHsbkjXjgb/p85ySbP
         E/uQ==
X-Forwarded-Encrypted: i=1; AHgh+RqhP6ho6UqEgMXphkWGp+Erp5LjJ11KjTirBL1rIo4SGoPztfiJ5X5Ir9lQWyYiKDyuqUtzNwxASw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJXuTZmZmVWu6VKZknxdCOKwvI4WTVTewD/OxOVew5cjSoUPt
	raSVm1fAR6mVFU/1j9L8K0EcGsjA22Jrhd07X6YJb8V0OnHAstw+B7FOLeRTrqJhDhY=
X-Gm-Gg: AfdE7cnj5dv/onUcrK0ip/iP+z1EkOuIzn1M3orcYsJcVEBE6chBNRTLp33ZGqiUjOc
	zEAyp6E/Pfy6AALQl2QPvx9NKA7ZMNlVN71831StxpF2uaLoJ5/5U/DrGawChFkblKyoHi4mL6r
	a0PCQ56LQASBbuUZpuuNw2vEZSing/VrFD/U2B/xh2GPxqC6mhdJRn/vJl0+HO04Rt76CMQ+Glh
	RLFeZsWEbuQsmMCkZ04IHEQ/NRiAUrRUYnsJZH1K1BYaMCBiYsKHYvis94oC0GOrCXuYGDW1x1Q
	BebPAnc9ohOCq08mZcPLHcqDK5OzGAjkQhbfi/Ka0oHqvVDf5LviBqHgj8WTnyMNqmAgP8rrkuq
	WuNRZVCY1YeRLI/vZbLlOU8IFQMrgLd3TDV00EqHXgwMGvaBvFA4jIAePcouC6peM1+EAPxeaoy
	C4OmVduUEMzfIa
X-Received: by 2002:a17:90b:5403:b0:380:9504:9780 with SMTP id 98e67ed59e1d1-38758062363mr3539509a91.29.1783401041657;
        Mon, 06 Jul 2026 22:10:41 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f7293sm3810292eec.3.2026.07.06.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 22:10:40 -0700 (PDT)
Date: Tue, 7 Jul 2026 10:40:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinseok Kim <always.starving0@gmail.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/cpufreq: Remove unused local variables
 from switch_show_governor()
Message-ID: <oz7lhcfan7rpy5ixlqlaea7rqjhagepqqzpssueai4qcwe357y@ilky5ez6eyd4>
References: <20260706143857.3306-1-always.starving0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706143857.3306-1-always.starving0@gmail.com>

On 06-07-26, 23:38, Jinseok Kim wrote:
> switch_show_governor() assigns the current governor and frequency
> to local variables before switching governors.
> 
> However, these variables are never referenced afterwards. The function
> does not restore the previous governor or use the saved frequency, as
> backup_governor() and restore_governor() already handle state preservation
> elsewhere.
> 
> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  tools/testing/selftests/cpufreq/governor.sh | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
