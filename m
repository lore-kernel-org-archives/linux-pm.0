Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5333B38AA
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271029; cv=none; b=kpWgsYrgzTgsxhz8i/R1hC1aulPIwMFeTdQEMluoh+UORGNcjSoYcfBcsn+mVFIirCnG8tJ52PNpXMrgIxNUV3WAsbrxnaBVW1kGhcZGA65tAGhBjaXkFXhfsYP/zaIWYGqe/x7JljWMwl+UG2BM8ADRCKlzHF6o0XZKgLiXb4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271029; c=relaxed/simple;
	bh=5FSjDS8EwljyVy40QrriXsSJ4R0zWhCL9IplT/D+UDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpMpnBqp26iwiPOGR16/PMDcN8yBS1tMHru93ViLITJ2aeNFvmmo80YiendjT97k2baoBg/rSG0ex1XYJe7qywM5vYiqq8VW1yJcYTZLLDN/uIqGLfbOrXPvBw++FWclKs/QKbGWJawu0lq7T4xR3d4ea9t9GVnPlwD3InHTeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MTyKQphH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MTyKQphH"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748257f5fso3549943b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779271027; x=1779875827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYgT1pmb+bs6abLu6n8sXdHUeipWCAQ/ggwbouQ3Hpc=;
        b=MTyKQphHyhyNPWEb/0DfdFvTbbfNXCjG9XBLilKLadddfj7q1YfouPdQmIdOgzN+wD
         spZmB2ZGQNWHnadELNuqjXaFcoPG9ZMsMkXpHwLDf3RNMlciMMuus0OD0vLr3LiuFfKg
         iuD9p2rd9AQZRx58bbrmEtEHlWb+9d5hQZNZXksfOfJ2ZBx4kKfvaOKk6dWoVPCHOJcj
         OE6cShhtCqrSve0p0kNG62y3vSHxUNEQB2oR9XAm/4GqkKhIMpMqwtGZJftV9y5+dhXZ
         pFOCBYq5VRAcPh/JpL68AWFCqSTsxSxi7p855iW53KNtzXa2NxH2/l8FQqEPu+zKQWnR
         /ZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271027; x=1779875827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYgT1pmb+bs6abLu6n8sXdHUeipWCAQ/ggwbouQ3Hpc=;
        b=eh8IexFFxj9sk5/2PZyPtGelkG++6k5W35n7w8Q7/6Miy3wA9s+mtalrTabBM2ENhp
         RaiefKpMpNAmfsZIo6RmCIHDpmc0lVcUbGhnYAP1vwyGNmeqfC0jWcgY9pGWLJsYx/lY
         KEWF+v6c1jm2idTC82dqRuW16tEh/UoPfmeGO8B2ZacceXiyZxcBHJnFA8A3zBlxFmx+
         0w1plvzFVXfgSwGbWD0C4zIGXwdXaqUVR4D1SQ06D0apv+KUWIyhu1wdjP4U96NVJdRM
         BcFz4KoxfL7PRgKJc/9oARWQTGhVedol0j1Rf+pdb1qgljZm7SOZUXXIPGj9x3DKfULN
         Lccw==
X-Forwarded-Encrypted: i=1; AFNElJ/taDI2UF5hXPP72TM7evijLRlJE0zFFuupdR0Tu8g3xHnm0iWScgY98JNKmr148tIcTIDQJuXTCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wCvytS4+fq4Evw2M776wYYJTyWa8aIoLMK5k4a+ZASnIVj0O
	tLhbCLIgur3PTMC5z6kNBlUpjqeWruX5ZqjpyLZFXDdUGb4W6Zyu+cLGvwOeg84DFM4=
X-Gm-Gg: Acq92OGpAOycUEv95qGcCnSSSV6aHRNcPeEl1rooEidJV98kzUYj+ZOkebW3K/N0qWb
	rHIeTGK6CX/I1bGjpmMnX1A1DvuA5p6Ni2VxFKRXke4TJ1Ia78LijQ+n/3yLY2RP9HTJddniVBj
	ll3Ah0es4Xl34PJI+CQKZ43Horaxjw+2gfa5kr9kHXVw+FmGE4vwxzeqKbr6+2z+WSCd5ggGxQi
	23Q9faTNxU9tlKAJtQ8YjdaFfe2l0NU7mx5AbsUnqRZO/Bi87nRtms3zpM7yggP50Bd20Ttrwt/
	v23Ffe7rWaBGjE+7u6BsYoH/4l2ggOIwWavt642lqXcILybKv82hy8I8Jv3K6N5XU5etoOGF79P
	mlnUXj2ewnqZ+KFyjgrNLxTEDVpC0UIpiDkVctpXCW7KhbQpUeaxtR/CzWggKjEFR/u66rkpPtA
	uTMiGzAwAwTF8P365dgYcck8M=
X-Received: by 2002:a05:6a00:39a0:b0:829:8083:472b with SMTP id d2e1a72fcca58-83f33ada10cmr18137443b3a.4.1779271027329;
        Wed, 20 May 2026 02:57:07 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660easm20256744b3a.11.2026.05.20.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:57:06 -0700 (PDT)
Date: Wed, 20 May 2026 15:27:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org, 
	stratosk@semaphore.gr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <ygm5rfevkxzoaapktjhku35ajrkzu75ebbwva4o4spp6wqay4z@txtjcnbjhx63>
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
 <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
 <fc82e05b-db8b-4a15-b46d-332c9f2d95da@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc82e05b-db8b-4a15-b46d-332c9f2d95da@huawei.com>

On 20-05-26, 16:22, zhenglifeng (A) wrote:
> For CPUFREQ_NEED_UPDATE_LIMITS drivers, dropping this early-exit checks
> means cpufreq_driver->target() will always be called every time when
> cs_dbs_update() is called. Is it OK?

What about merging this change and implementing something like
limits_changed for the policy, which can be checked for
CPUFREQ_NEED_UPDATE_LIMITS drivers ? The variable will be updated
whenever policy min/max changes.

Rafael, that should be good for CPUFREQ_NEED_UPDATE_LIMITS drivers ?

-- 
viresh
