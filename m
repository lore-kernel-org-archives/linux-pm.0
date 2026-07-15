Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6D3CC334
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104083; cv=none; b=YLNeAAB1/8rIUPMc0f4DkTAx80AKhOV7GLPwjrZPAdQbG52/WWaMTC/MlSBnhLvN8il1dagh7bO5SJWlx5ueQSXNieLUeS/aiNeunHPf/MO4p5uejjvLYB4zeKdeoeFju898/3jm83jZaBcv/jJpULvCIfe4NgSIcXEIjpL/SRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104083; c=relaxed/simple;
	bh=8al7AEBm44JnjPY44imFhtbV9p03EJiiJLwE5GGb06A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+4NXp7f3aY8w7YyBauxK0lRNZiyLusuIpELJNUwnNBgvnz6cis2ltz2vd68KCMo7X9KJKcQjRjj0hvKyxPx1b4mXHrVz0U/URCuXfexse2d41g+8Xxf1NSf8Zc+KNVb+hklQfGe73ose1IRV+si6TURjyatX1Ha2NXdgjQ8BfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHuN3BJX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHuN3BJX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso62288065ad.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784104081; x=1784708881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dtHazP2AVFZsodM9+Vpy3QDN5vuHH+4EUtzZcewi0GE=;
        b=lHuN3BJXNZFCQSW/nqgbh4srJW9gKBXX+UNu9h9k3WsamXZyc+KwmG9pszMo6wTHSL
         QKE6UfJvegMXeOQoDOKTJwPhapx+w25q1RVHky/dIJy8FKYUuUf1NQjfg6d6zH0a/SZZ
         v2a7ynjobeN/IhvOLH3wqPD2wL2zJfhWFWs2UvcgjUlbo1dc4r8n8TGOCCA8826s+ms6
         4kd1Odn69t+Qw2yMZZNhTBoPommGt8YXFPuqp4BGV/nv8KMFE5bC5RsiCZN8/Y/jcAIZ
         OMB/f1wuqNs1+7CaXE1PMtSU2izNGfaljwNiVxAPx73ph99QkDbFIL1MieL/2NFzUuIM
         H/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104081; x=1784708881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dtHazP2AVFZsodM9+Vpy3QDN5vuHH+4EUtzZcewi0GE=;
        b=j3Yq6OF9omVvDiE6LWGSrHffL4+Rv7APojsOxiDGOVitSihFCMBl2h7PF+kJ7d2G1C
         psp8AQyPBVbjgzFAMC9AA4olHwiLh8lXQz3QrmvVhNJHx5nmwB2ezrd0BTp4s6rOtkpC
         SfGwUP/Y7mhBSPvSwZHAXqq4flcSyevc937F4fOA64vjPp0hA9QlIslE/N6t/B3fbQzV
         pAafsbgGolcZa7RE5M8MVuanqmG14Edq4+a8xafJBZ/HF2TaByXeb5NBUdQuhspHvqEA
         cMr/KpcDbcN+dcRNk6RphrBh5THLRosEj1uTGsg2nHIZTpXtpQLu8v329cKWBDk3uvOR
         PgrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrZG7oW2DlDnEZsvf8dBQ9VH9AOiMzDRy2Fk+BeNFFeWKIzc0bI0RghVIlkBgbndLul4Hhi1sUBrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0cNcpd0VGnPfI92b+IPABZifKb3aWdOf7X4mwF4EFOLEptEen
	W+KBtKGOolzVOV4BEdhz+0OOib8TTc7oOXCMtjQT4WZzj7774bRKs2L52byXhKOwb2A=
X-Gm-Gg: AfdE7cnCtPwFmziSfbqryv8Xbb9M27mnAafm5LFBWcRQUajVuKqQuxbVj1zhEe6gI/o
	GCs9wjRXZDoBckNQgIe0fpxJkY32pnDeq2Y6hSL+LGVfTE+mwjLEaVv3Dv7QaBx2mGsCVuDS0bB
	UCL/Rk+9Y9eaZ20I3Z/mkXKTDBigTq+01rOh40teo0o5yT1uhbvi4ud5CDPxP8xpUdFs9LGvgZ5
	IAOC4TJoWGWgz/3HcOUauUKzquB0qLPVJpspcaJMWY3cFU7OsvRBGempIigkEWTBrk/lifCo0/w
	YY45vSwIftoy4nHM62LMNcfn5VqYduDyxhdc4xxuqT6keVmPx9OR9Zq8vZRjngPKsVX10UPdwaG
	OwqjGPWBCIFVqpogArIy7ke1kUvr2SYg3lQit2vXfMU4csaO1S+VTIgbDlNjJgYpNFFul4Fl9RJ
	gP8mEWJ3bIypMs
X-Received: by 2002:a05:6a21:62c6:b0:3bf:ab76:63d with SMTP id adf61e73a8af0-3c36c0e299cmr2172726637.11.1784104081351;
        Wed, 15 Jul 2026 01:28:01 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm37101098c88.3.2026.07.15.01.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:28:00 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:57:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix cleanup ordering
Message-ID: <ur3qqfmobaqe5lr4jmgj7rgmcfo6jqpcbxd6qyujqtjyp6bbze@mffnabd3rcrc>
References: <20260715-opp-fix-v1-1-a3098d80afd8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-opp-fix-v1-1-a3098d80afd8@linutronix.de>

On 15-07-26, 09:35, Gregor Herburger wrote:
> Commit 173e02d67494 ("OPP: Initialize scope-based pointers inline")
> added initialization for all pointers. In some cases, the ordering was
> changed so that *opp_table was initialized after *opp. This also changes
> the order of the registered cleanup functions.
> 
> When the cleanup happens, this can cause use-after-free errors when the
> last reference is released and the release function _opp_kref_release
> tries to access the already freed opp->opp_table.
> 
> Initialize *opp_table before *opp again to fix this and ensure the
> correct cleanup order.
> 
> Fixes: 173e02d67494 ("OPP: Initialize scope-based pointers inline")
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> ---
>  drivers/opp/core.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Applied. Thanks.

-- 
viresh
