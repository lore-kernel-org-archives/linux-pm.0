Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AD3DE451
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373777; cv=none; b=UZ6tpYB4S5pgqvqwDgAd+QketDDPRWGX1x1B6a7Y3190hJopax00hu47glfcC64TqeSA+dASAnBssnQOg3liHqUxvfx1JZ9oBfWYsbhQXNbOaReX21vQxObfi9zPg2e6362BahANJ3xmGYyJOx53tHQr6Zs8YLpRtPIMke4LCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373777; c=relaxed/simple;
	bh=Mk2LCPN3psen2VzXcgHHW7CRI83HZxaWBLyB5tTPCFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knvbYErosdhyrtHCxtdW8BKtDvRWrJR/nuE7LIVHgtRBuRyqTwXaWDnHIB6eQOTsZdZoBzmz5f8hV60cq/8E4x2q8nzkFSnsThEfl8vXfmTsp6sw5O/UYC2wZcbQGxYMf1ir46b01j0nqOSl1aeUeFkQ2sW+SRoazMkKhGjC6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/wHu61e; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/wHu61e"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366375c4076so2441751a91.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779373774; x=1779978574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFkBMqLOt6DYztD5Hr4pn9GMJfbWtYg3EQT3vbtMey4=;
        b=D/wHu61e3Lt5L/JDJ7K1eG8Igxr+o91eQx/DoFj3cDi3KStzrDLJlToSqxKvdN5bWd
         LIkuXlExrzqwirfD8UDwtjSg5QjmR6HbgO9HiUV/Mp47zdbOnrUBOo/nk/zBQYVTWFet
         KI0z6Koy1a80Df3vPXh9no5wGag/JEjKQOjRtC579PrtmnxTcRf8GcfnQKPBjE6i7op7
         gHPS8vZlxRIuTWPHv43dfxOqFmbhlEzdgQP5b29r0UT5H1HVkzVDrgVXTv6OC+TFP6R3
         tFM9Q3vYy32E2PnQUry/GFZ/XO28vXmo1wjcrbPXtgL+PNiynVMU9cv8kCLU4GO0JIN3
         xRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373774; x=1779978574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFkBMqLOt6DYztD5Hr4pn9GMJfbWtYg3EQT3vbtMey4=;
        b=O5Tg3qzGYC3X9g90sltU20XLIzrkTr6kFRzMaqeGohLZDm6IhVLLe2Kl+1YK1Ai857
         +2halsvEsWL58+ewE/FkkgthMoSMJXXFkv8Vtr9iYSSHqolNUws4Btj1zGUhuQBrq/+m
         Q4zc0dXPqvEOGOifg0aOurF3XRUdNAcnONlOps4Ny1mUw7HQHo30HoHjqxGZ5x3Q9M/y
         uUKUbnAgBJH1YPdrIwC14D0uLaIQvxZHZ3g8VprudHSw5RGKd5CGhj7cc9SF45KW5n+Z
         xu3swQko1lw3uv/DytBkC/yqmRbL7q8oiL5We10GE4qLzmvV1pSjZMSA+plTlUswfXcU
         4SAg==
X-Forwarded-Encrypted: i=1; AFNElJ9MuzRqv/0pP7eNjSkU8Dv7F0FFVbCiQBbdERqlzFDW47ygzug5k1Hf4lHOEo0lcQ+ayqzldWKMZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzapEZt1AN973CFVOrBnk89u03A6qAomWu5dVv+aHl4yjf5c6K1
	HzxqU1HvqxHlAoZDnj440AY7APNiD3IdpkIonUd5Rn4FN7sMv062C0gQCBsiHL/McwQ=
X-Gm-Gg: Acq92OG9r0AUIJLX8zZ3qtE65NTqhCbSFIspYifsPY4jUZeKkNWu0BJxztVi2bGJOPo
	qtuF78+751lWY9Lnj/ATETwTx4PrOlGpfUk5x/KiP8NoOg3kFbKFdQJm1dWQoepkIebqJACY53s
	pHs4MNALMy7XVbdNDhgrdguyVs6EU5mLzKEV6MFug16tBGRsrgHe3wq3muIYFpglqVevAQHteEq
	Azimn4/bWiPL7plfBEd+Alb9AHMpqsDRdYT+lqZ/lTLP+++WDkpsDM5XT+2Sa45PTUuEBYaN3ck
	avf6/IrICIKmw4VbL4y5dGq5cW/vuSVwljdLOtqUdq+n0sBpuK56kdTYOpq2w2URgWTr6EpYq0W
	Of6D1NJ0wPnf1V5HaZPT7k9CxqnA1AGcxKBEIxUr9ggZ7C7pfxXS/pZKw5plaKUiu14kkDJ9xSB
	HED/9noo68Tv2HSulU1hgRFzw=
X-Received: by 2002:a17:90a:d644:b0:369:bddb:79bd with SMTP id 98e67ed59e1d1-36a45779371mr3311513a91.25.1779373774447;
        Thu, 21 May 2026 07:29:34 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a45c5decesm1728817a91.1.2026.05.21.07.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:29:33 -0700 (PDT)
Date: Thu, 21 May 2026 19:59:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Fix typo in comment
Message-ID: <tdebxnfufzvhhor5h733ics5png2xkfd6j6wyv7lepy2d3j4vg@qysw3hpqwohu>
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
 <88b19c68-2a0e-4a65-948c-9c535b75620a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88b19c68-2a0e-4a65-948c-9c535b75620a@huawei.com>

On 21-05-26, 20:22, zhenglifeng (A) wrote:
> On 5/21/2026 7:39 PM, Viresh Kumar wrote:
> > Replace "diver" with "driver" in the comment describing
> > CPUFREQ_NEED_UPDATE_LIMITS.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/linux/cpufreq.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index 2ab691828e48..4d4b4ed24b30 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -434,7 +434,7 @@ struct cpufreq_driver {
> >  /*
> >   * Set by drivers that need to update internal upper and lower boundaries along
> >   * with the target frequency and so the core and governors should also invoke
> > - * the diver if the target frequency does not change, but the policy min or max
> > + * the driver if the target frequency does not change, but the policy min or max
> >   * may have changed.
> >   */
> >  #define CPUFREQ_NEED_UPDATE_LIMITS		BIT(0)
> 
> For all three patches:
> 
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> Thanks for always doing things so fast.

Thanks.

-- 
viresh
