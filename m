Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922C3BCD38
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363675; cv=none; b=ZG92iOeMA/Pe44QXO3UaGGv22KINzxXUcuvfYdHrihiFeEewIq/zrxqnnNjx/Zr1ek8Cpw0pEBI7HIhzw12IBjsNya/7/B9Z9awZb12ms2QxfC1JyWU2hIo7VdA/dMmjzN9QNp964A9+amo3K9dKCH1vOaoiEbFDuFmx64goWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363675; c=relaxed/simple;
	bh=+eKTSit/d3J+RmNjLbLukmpnlMw+4tXYgALzt3rMg10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOp+aK1Rqo8/Xk1XdrRDv1dcj01LyZPXAHuKf8XZbxvCOZRykNxsfNSplGCIeJjuY94a49V+LTiQxSByA+oJWTl3h3mtZnWZDi6cMvG2Oy2Jouz+MNHkiAZvJE7/bm5Dk0OqSKsH3CmNTz6kIxnJjmWFPpmVXvoef6l/BxnyZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtUH6st5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtUH6st5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so2587788b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779363673; x=1779968473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZx1R6hfxProX5ECpDeJnICw4UaZDpoo8JUsMZI8Uxw=;
        b=TtUH6st5PArkVqT8PXwdPV+LE0DAvTlBV87PCzNdvlkPoIgh3tE0Gr35DxCQv5Mt+H
         3pP7/u6oLAHq8R6jaO4hklZUlRAztUJALaq+4X6OqAyTL0gtrp/e+thbyCMuGDMo0L0Z
         6M6PkC75RDU70U3HKLx7ARH63lPSye4R0aDNYAO8lShe3D68t9vDRWe8G26aTUPlVby9
         82SMWM/n/Vl/4cS1Uw294abujR+2TKRNpE4PFW+4mH5vsbZJKtJjXA757AmDSXSGexWI
         gGrDYP9kUwpL1rtxRxROWJ+E6ml8GZ3HBgkbifs669yrpFXCPH66ozWFW+tLB9m750hl
         50EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779363673; x=1779968473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZx1R6hfxProX5ECpDeJnICw4UaZDpoo8JUsMZI8Uxw=;
        b=e52MOkBm3T0HgtAnrEmRjAZOQCGVgRFpRGQuu5u+n+Lmzirsq+wSc1eh5kKCF5NjtF
         aCDpvtEqBr2/12pQ8EDYFVCL60WapSbHP7Gox9BiAhSv4ilml5RM1zMxhw3ZJVakMyqG
         l3sRRJ/pC+K7TPrjvsFYOjgqwEnzvtHUvWkhDbS3HRVz4cbO7qK+zCfaagonrrQRH2Vx
         qFZ4dntZICLrkNpuJUZjoIn5xX7KzatGwWf+TXlMeXWCrxlxy0ppSM1WSZJBdGxhHax3
         k32eL5lrBM8kxqZ9gDu4h+T/2XjiODpKEnlE6JUrPWWeEws1h85VxZK9qg+90isI6BCY
         xYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LdQzfmbl7G9klT/dewM0UNuCNthmJ2yLIY6n4gt9zIxzuD0Ymme2o3ym2DpQhOvFxLSrDiLoOJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgR/6WrMFO2u/fhhu0cZSJCxYgcBON9Hc50Js60ePWzWDuspYh
	Zv+1aTFiiDgyE4hCyBIsC19c+n6kCyf//BTJceKhsZGL7UvkHXECdqasBD682P6mFYI=
X-Gm-Gg: Acq92OEohCsH1a/yOiwhkLK1GS8IiftCyrXJSl7l56HM77FlCUAwhm3SOA6yrX5gjOq
	CmBW7aaGtz9+61IqEXHwWLus77OXGHSjPTx0b2WLsld27s0jWUkzQM8gHU6evtn2Ud/EZLRXVzZ
	Le3KY5+/wy168pje4E83KAzja1VeiC0rOQBhcOMYh4B5vouoIuGDXYTCq07MFIJrtMTodT74cgl
	Q8gPfUIQWJ7ArAZQ9KmIcfRh1FrfzghsU35ca5/FcLLDD97t1jBJEUtspL8lj0Zzili5LxF4nIg
	Dnfy8wDYLLE62ieqnPLxuRS1ju8oeounVV/wiXN+dz3LnH9EqHubmnMbv+ikGsO9Pti5rb2ONzz
	8V9GYs9vZ4EWXB9CsXOMWQ6eozeCNFuv/LPCcBWpAYtT5T+V2OSRIzqw/2lND0pUYvC09GEcby7
	QDDNinfgfprfrUlJGeBGxh7Eo=
X-Received: by 2002:a05:6a00:a116:b0:829:7a62:6a with SMTP id d2e1a72fcca58-8414bad5a87mr2130886b3a.22.1779363672893;
        Thu, 21 May 2026 04:41:12 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e01d0dsm1364427b3a.33.2026.05.21.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:41:12 -0700 (PDT)
Date: Thu, 21 May 2026 17:11:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, stratosk@semaphore.gr, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
Message-ID: <xdxia5wmmxbcwq5ygdydohlqvswfenctfqo7rzpo2i7raddwah@ly3zdvrmbt5j>
References: <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
 <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
 <fc82e05b-db8b-4a15-b46d-332c9f2d95da@huawei.com>
 <ygm5rfevkxzoaapktjhku35ajrkzu75ebbwva4o4spp6wqay4z@txtjcnbjhx63>
 <CAJZ5v0i4_G+yzV0BSEOR=MVnV-9O-rXEAOLKWUKbMjgCvQuuQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i4_G+yzV0BSEOR=MVnV-9O-rXEAOLKWUKbMjgCvQuuQQ@mail.gmail.com>

On 20-05-26, 13:16, Rafael J. Wysocki wrote:
> On Wed, May 20, 2026 at 11:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 20-05-26, 16:22, zhenglifeng (A) wrote:
> > > For CPUFREQ_NEED_UPDATE_LIMITS drivers, dropping this early-exit checks
> > > means cpufreq_driver->target() will always be called every time when
> > > cs_dbs_update() is called. Is it OK?
> >
> > What about merging this change and implementing something like
> > limits_changed for the policy, which can be checked for
> > CPUFREQ_NEED_UPDATE_LIMITS drivers ? The variable will be updated
> > whenever policy min/max changes.
> >
> > Rafael, that should be good for CPUFREQ_NEED_UPDATE_LIMITS drivers ?
> 
> Yes, it should AFAICS.

Patches:

https://lore.kernel.org/all/6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org/

-- 
viresh
