Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B02877DE
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124292; cv=none; b=g/oZ46AHK9lhemvJQf1rxlVqcLpTgeKPf76tASWCY/ECmXCkchxqAiiG0pCLIDBigfX2E6ixQam414gKkjlfXvmNH3/IOAcCLMeGhFfjCP0zUlit7Ujjzv4qb0yUT2XKybQTXXVtU5VLj2jLfOUVaG7qMtlH44LY13St1hsDIRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124292; c=relaxed/simple;
	bh=nEkgXAD6eX1ksTJ2iy3XW26cA/MEHmgv3SE92Ooie6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMEk3qz9KYWsHuANY/4vk2CqmY55Zef7PIlqc4Cc5Kc0Htp4zc8+Eewc8lWsg1r/Y+D/TxoJcmikvXE6i2mS9T2nPvodCZ9JkvEw/4qxioc+p7vEm3H3IHok2RxnWSLWEgU1OJk201KB8qoAbdO0OH8PrSPq1qb68Zzw8ExWGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ia8Qp3kX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ia8Qp3kX"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36535998b71so182327a91.0
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778124291; x=1778729091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXqN27eudQQFvoICR2kx2MkixOHAEunSRWTV3og+HAQ=;
        b=Ia8Qp3kXcc0BTbdZko+TAGNEQsfwiHmqbxuxAtCE/bJo4ZQ5D82zuZM6fAmJW0UPVr
         TR5WjVLnDTk2opQYMyZVDksQeDuW5FBd7SWMeVP3lG4pUlKE04AUNI3oWlUoFAwF1tiq
         TP6KPksE4ctuUJQqtWGbiY6v/uImdD7PT2WPPnogbt/YYmWPCYc3oaAPbCEMK0DAji7K
         9iPXSfvaZJHIiiSeQZWSibTWEt0fY9RQOolugfUPY8Z4DMWGAvQHp9/kzlN5dUVGtam6
         AgSToyc7vQz5vrifKTWgqVAc24khHMS81QIt4eMs9tA3GhP9iUGE0V18wFp7STqPnc+f
         CBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124291; x=1778729091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXqN27eudQQFvoICR2kx2MkixOHAEunSRWTV3og+HAQ=;
        b=G+EIAqMhteqKnnPfGP2KDH2v0HXvCm4QknydSiQYTserST0KtkiVN7WuF4iYMh04Ff
         ZOb72JILj3YF3KlIkzoBJ6Zxd5jbyjmTvVv+xMf7HkGKizX1SNycYNHSdDi0Z3LZFj2a
         3ji83NCiW6mpW+yow/C9gz8i7FSgKblCzXlXRFnILl2nqMU1bAhbcfYGywwjZPUbo+YK
         Ey4WjxMADSC4K1xbsulMdg29rPJFyPCm7ZNDhgF9m/6uO1Jp5f7dDk6pAf67zaLPUsgc
         8Uxh4bFaOqJMveJ96d5MbSaGRClgJkpq7dw/Q1SHS2z4Dbx4j31au37fJbaOsJvqcZu2
         3xTA==
X-Forwarded-Encrypted: i=1; AFNElJ9LxZMn8p71S8Ol3qwYXn/kv4sPZPk3Vnus4ThDzD9IrdK4S5UnQUpsUy98led65neAd+z62mfeKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCIvwbGrbR9l3nIBB6GdcAnbL9QJdHI39uoeIvtuv7Dimtp/m
	AbIDzov0gMt1NBheZSgiA9tYphlDJ8daTZe8/CoMeQU1EFhXOC8NPfmF+fJlItEg72U=
X-Gm-Gg: AeBDietAXTsTUwDTp1Rtu9w1d+LCUGAhuZi7w01gzMsntCtxEw7EQP2ErIAM1ed3Y3F
	rbqktsG9s1Htq2BVnRt0tmQFMDteQrd2Y+8jwnQwXMe0TNuZzkADvPFLaKIHFTpGKwz+DLDW2Wo
	Jlk1HO6iSPm8jrxBELjIkwYYHfzhPoeJCdZnXinxSUKxASUoKJ0n+jXaU24Od/+xTaVe33YqWlg
	g2KVT4E9M33t1ccxv4MMETsNwaXgcPIdC10bnonEi9kpok4aQxdAPZnpiqPb6evHrVYrh+/vBS4
	Du9PgJa6vWDFhkg8c8S9EhCmlEWXKfypgmEoT4rt6qeOsvT6qYjguHk7Jp+RKi1LiCfjvfIqvTE
	vMhfq7Yx1HAlAdOjKipmBb/ys6wR1F0F1L1GPcBSdsysFQzTDksCBlAWa3Gex4VvfF2ntz2E53G
	dwJjkoQ0Y+GuaDzHsNTf8uHCByXBuGxpyx1w==
X-Received: by 2002:a17:90b:2cc5:b0:35f:b9ba:45b4 with SMTP id 98e67ed59e1d1-366050e8ad3mr1024038a91.0.1778124290490;
        Wed, 06 May 2026 20:24:50 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b10d3e04sm1878330a91.9.2026.05.06.20.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 20:24:49 -0700 (PDT)
Date: Thu, 7 May 2026 08:54:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	di.shen@unisoc.com, ling_ling.xu@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH] pm/opp: fix race between opp_add and opp_get
Message-ID: <lhzkb77zezcwhk6oapioe23sjd7rsea36rp76umqfz2crvdlgc@mvfa6i7asnkg>
References: <20260427120047.10830-1-xuewen.yan@unisoc.com>
 <7k6ttcmptilvxmp36dvtznor2gfd33rzledbqfsigmjbkx2rhy@iv4lyzej6ibc>
 <CAB8ipk8XGBtChKV7ub6UcqYyfmnJSvuTX5DmCQrgf8ci9f9cMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB8ipk8XGBtChKV7ub6UcqYyfmnJSvuTX5DmCQrgf8ci9f9cMQ@mail.gmail.com>

On 07-05-26, 10:09, Xuewen Yan wrote:
> Need we add fix tag？
> Fixes: 7034764a1e4a (PM / OPP: Add 'struct kref' to struct dev_pm_opp)

Done

-- 
viresh
