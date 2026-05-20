Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819C351C2E
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265193; cv=none; b=VabdypmaeZD4ReQQvyVDUBPIhLQqOfZre/6ec+zVBjX4XPHHSDfHg3n7oOvz1+pmHknulPp4T3cKCGvDZI/CQpbJ+jkkG2ey3vGG+2U/PvXsdLmxvUciqG2Vn/aSerBq8vCPhje1yBjmXkL4zoeT8v42oJqbomgnB4WDwv8kO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265193; c=relaxed/simple;
	bh=cGlJCyHrFtIsKaGkJ63d49vDHuHKwYjkWL597O+/50s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIFW0555paQPL3rpcz7ruzguaUQsLZ1/gdVmpyiFc9/s3TSNbFNlAbLMhanRdm0NZGgOvxGBElrhdm4qGLtcvSEJ8wubtrVCgCt8AmzFVESOATF/A3KkTzfRPQtk9yYc/qaV2OJu8oou7qlmI8B6jjz1LLg18Lr6+WUd1bqLNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AHnRxIwj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHnRxIwj"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7ffe8eeaf2so1944428a12.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779265192; x=1779869992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Pt9zcFI2zmEpQSoCxo83POMe6NZPHtZXzDHHMIPQ8=;
        b=AHnRxIwj0X35AcztpSLdAhoofuxtgQOtbkJ+qzAFGeBi+tZK4O5pYVGun951/ZfcrU
         FPi9DXc/WKOff35QNK9hWkcmkm9pzeTvHSE9pOjBsvbryCGaRwrMlYW2j2iG4Jnnf+5s
         zYIeJn8kfHvY9G5jggkL7yT+paclpcKXPtsaCUPtpQLy8k41VrLCw08l1o6yc/SSpHAK
         uJBo54G+mL+71EdWt9i/eE/mLaIZIIlmvn/+rMjge2Ep42yndROcDlq1HORbxElhxybG
         pdFvNrlyg1LxMw4phnr/t2JkSnpDGfRLAZ8WqkFsTmPlSQUhJEqWFWzaegVhWDCYNtqk
         Dfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779265192; x=1779869992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0Pt9zcFI2zmEpQSoCxo83POMe6NZPHtZXzDHHMIPQ8=;
        b=QAaaOPulzdx3SbTyjUs/uSZ6FZKDlMVgJ+7Har9oBQJhX3zR96HNJ7uUpvHbBy4Y2E
         006xipIHRRUyG+Cyx96YUYcndefvZYE93D39vrVLlj9i3ayNgMf+GZXMMmHfYlhHCsUZ
         DGYC9o9XqjJsCeT1m1Zt6EBc1V6l28rI6emROuJ4A1rD9U70UooujeKRcqasxtDS/USy
         Y3Xe9Oi3usapXgBEn09xa35i16Grs0FOawKzxHcxkwWvbz+Vy8qKSjUrHL8/WZcTncNc
         hRpq1CAahnoQu+/67OWgAuYVHZeqkcB2EE9Lv5iE1/BCWmrkpnyWQF8CGV8w1v7yvqfI
         1BhA==
X-Forwarded-Encrypted: i=1; AFNElJ8xkGBpqiHrNF1VtVtit0HGcr+w0bD07k1xp6p7fZGNEIvUKd6VsYfD4BWFx4tEkdyVF8EWxhD6tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQoIweM9fY+ezr0JSo4V1bGAxIqkOrkgfZwoKrVXtQ2OwONTQ6
	vahaXHexDfSlZ5s3A7D02uck0rt0o9olZEAUtdZsO7AwBzdo8FZB+6J3SQmnrPsSY9c=
X-Gm-Gg: Acq92OG8Az/EwvsJFNJL6EerCS91n8XmtfnfB7H6Tio9ZHx6KRq+GqgWpWozclqNhze
	/AyIEVrw4nlM9lcXSh1tLMYDCWKHe3r+geawyd5cFkaYlbcl2fGeL4KvdSz54YBE+GGet7GCrWx
	xgZuByi+OiorG4eO1hnBFaE7MAWNuhgpjjXgKJkShSPBb73ljmxMoBLnkcIIdUQQVAR3SUcqhPz
	c3W6xfUZSuR1TInmyC98NbKDPBFNT/FZNnsCmruOaHq5xp5Q3FaIkbDo6ANzN+QdskjAc5ep5p3
	cmljrpOiF0IZYn+vO1hwin/fCpWcnYFkzGO1dRPswdelvC+AM7WKJT3ckbEwGQKDveLDapVk8h8
	PTg5g0XcsDyoqqP+LCUnDlB1XXkZ5mCQo/2VFzDzvY3vJ79FgEs7IxARo4ck7Bqem5AV1K0CasN
	8y1cp7h9934n53rET64dQZGzg=
X-Received: by 2002:a05:6a20:7f93:b0:3aa:60e0:b2ed with SMTP id adf61e73a8af0-3b22ebc68ddmr25480318637.27.1779265191771;
        Wed, 20 May 2026 01:19:51 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb06268asm17918841a12.1.2026.05.20.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:19:50 -0700 (PDT)
Date: Wed, 20 May 2026 13:49:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org, 
	stratosk@semaphore.gr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <kxluz43bkvqspji26x4hrh32j4ijpfjcbtoxawf2zvkpk7vw2h@yhj2jord4vpx>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
 <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
 <ddcad9ad-eb49-4e32-8b48-56a611758cde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcad9ad-eb49-4e32-8b48-56a611758cde@oss.qualcomm.com>

On 20-05-26, 16:04, Zhongqiu Han wrote:
> This approach looks good to me.

Lifeng, can you please send this as V2 ?

-- 
viresh
