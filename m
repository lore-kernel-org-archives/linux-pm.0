Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72123B47CF
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597952; cv=none; b=HT7Il9oOyaT6qUILa28FG5Gd3WpphhFXYqcDerO0/mZFE/DvL+Jdu6T6dzWlNs28DbDk7o+vZer7qm+k2g5W22esqQwOpq224LgoPLvmxtKG0Dta8PKt8IuSdOE9yMACXmznoaYlvb1VzzNSiUAk2CNah890SGUP14DZfMSYXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597952; c=relaxed/simple;
	bh=xYc99uvXLsYWScO0EmNoWIRKvKiJpOTShn+ZEKrkN1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwXhdlKPCCuMNZgnykXdOmSW92qB/45HWNZn7HatDhR2yDY+ioRFR7KgzcneO7VkUwHK2aq5GTUkP05DYVM65wMTrA/lk3rt0TuaXy2CgCrUIUp/54o1PxKG+qwxxjDYcnhIJ+153/D8KuhdGtFzcILGjVfDXbuLdCC3YPmhsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmruZcyp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmruZcyp"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c2d792c8so26935705ad.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 01:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781597951; x=1782202751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhNt6MHC4AegleV/WbvHUk1ZYZMA3NIq1ay5U/dxpKQ=;
        b=NmruZcypNSsJastH8Y2pS4jNwmS1sFI7xh8KKStePYGaHsHMlpTy6v6t5pyvxbe19E
         o5f1t/nmgV3dIew3YjJNkQfJ6YdAMQGArhvN0Hab5K00Os1cbmNRtVvMt4jPr2nTEVHv
         RNv2HumhiaOqDsQ1HN2Oo18kjXc8PmAtWk3PqeObcBcgAqxYB5TC/4BLKRw8RymqUs7O
         e48kt2+42I3OboijgOcNVXJZ+dbqWSArZWmZ1xb02L1NSoLWHvdM4rNBCu011Dk8gpzx
         yN9SQLVUXLb1U2HayVyFb09WXlIjNmScGnRL+l5w6UazerL+7e4oxMkL1/W2RIgnB1db
         J8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781597951; x=1782202751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhNt6MHC4AegleV/WbvHUk1ZYZMA3NIq1ay5U/dxpKQ=;
        b=TTTexIULRdCv5OEOllUN9aa9Ie7scBwHkMZ4BhqPeeoutUsZ7vKS0KqyNGVPsnnJf7
         3DCTBL3etYqeURMqwZmJjQisrUdfkZUuhXZKdQQtcNWXvLsDNUaE8xMpbUJmRiavDrSy
         VOBuuiLt9i8kAgtUrDRqyEqADvP504u9bw8/VEMT2ktg882Hg3xPE284EdT5GdkdaVC2
         +Ux4wbvu9Pz1bHXtgTNHTgceK9txz830oKxep0Pi5t6Y7llo5LojFdewarrFLhqqIRs6
         2PpmOdXaoSQhAhSML+5+umZKxpHgggfdY9GzMAKqEAWhrxwO2wSu1Pwct6yyeUtSscWT
         rhCw==
X-Forwarded-Encrypted: i=1; AFNElJ9orG/MhXx+2VDXOTtQc6E0H+pI+VKEqnuA+GMeGmlyZhQ4ks+YjGlDflQjUjYe0LCSI1UGYTcipA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQM0XUQpZowzArdvTPRsEaNEE94Z14b6kj6Tcxf0GMmM+ueJT9
	40hHA8L4uQxVQmlk1AMdqAEk7dyZ9zWRzj3kvzLYBpUz9pb9TiDmLAUwHNvGpE0otK4=
X-Gm-Gg: Acq92OGSOXSW1CK6QTBCUEPd6HybnXcf+VMXfAiYB96myaTDisLuVqiNgJ0kT+V8y8i
	s3kPPTzsIctesKBFe5+ar2i/iZDmSAiMWyTVRZm77nOlF5iGncEABbGsVMAogUdE/fuk2ZZKaOV
	hVExkKPyHQ/JGm+s+OsJJ03a3D2M9NKYYlPbfRK17GYlbsdMCEq2oHDp0aCY+P27wYeEK4H4alD
	wFXRIk1MMt1vnq5V0LuHZaJs2ZaBerrbGwcZEeWST+JeflJ0Ec2xP0UwuM+sry88GDudIVYa9eu
	1JhpgWWfYMCHW0Jv7hZJmj1m/606zejSUSS3B1G2NnajGMoa94U8yIXMVSOlpeEaoNjC7bzdr9c
	0lWOnul9J/jsO+u07WVPwHmZaPXP5B8ObJBVE7aX+A1NdHRrRUl34dze21zCMcErzGjeSx639b+
	BbB2kCCAFDBUKgcgjqr4gq8OA=
X-Received: by 2002:a17:903:3890:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2c69a1965ddmr27832715ad.25.1781597950906;
        Tue, 16 Jun 2026 01:19:10 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac631sm124267105ad.44.2026.06.16.01.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:19:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:49:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] cpufreq: spacemit: Add K1 cpufreq driver
Message-ID: <nffvtnb765pa72xcfhmxe3wepxpld3e6265s7imvldbwounkzk@jmrrhtrwau34>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
 <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>
 <bd4s2icqgusnuujvrpoag4cniy3g2e4bumecqxt5yffl77aqpq@kxg4dj4c2wk3>
 <DJ9EFPG561VZ.1WGRYYHJ2W9J9@mailbox.org>
 <wjwkykv555gkeqxabsqcdfn4lomcopawsv7bgm4bydc5likhjs@p3ca3p7wbri5>
 <DJ9M2IDYE6XZ.20RN5AFBYNB9Y@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ9M2IDYE6XZ.20RN5AFBYNB9Y@mailbox.org>

On 15-06-26, 20:11, Shuwei Wu wrote:
> With two cpufreq-dt policies (one per cluster) and these ranges, neither cluster
> blocks the other. Tested on BPI-F3 and OrangePi Rv2 boards, works as expected.
> 
> Does this look good to you, or would you prefer a different approach?

Looks correct.

-- 
viresh
