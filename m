Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4945F2E888C
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996771; cv=none; b=A20r4Iqckc+fP8ccDFna/N1im4J35w1181AOve6OSisB+QmifMmhjyG1DQoqfELTS+LtD4kWvIqCHtkUuZ+I0e6sWeouuAkZ5H11n5zxNsWnD8FaxAUDhHQhb6DHylF5vJAMr3g9bnKZkYuUaw3vEh6ero0YDl5KW1w+l2NvOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996771; c=relaxed/simple;
	bh=EKElwWAbTDWthMpKF+ZWvr/9mi2EhJADPAtIsbWv5rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8HcgCVwpag8gPHB4ml18UjTIYOsiH6B1imlVtLlrSkR/+e8ngeDSwedcgUwkBRmjo3pp52MC5NaIsXMTB3g+lYN7uC+/WLL5qYpfQwJAI7vd3X6mS/lrnj3tNUZdPi1YHzevZjXMwFkw9OpE6TrL8ClDvTwh20bP26SrY2QaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R24qYjSO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R24qYjSO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc891373e0so22777325ad.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785996769; x=1786601569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N/Noaa1/5CoT0jOkbG3HQUWESYiE8Rvb0ack3Temr4U=;
        b=R24qYjSO0CfdN2Z/2b3A5l8PfFcvbQ2jgUjhAhl6QSizsGQqG0jw0rilOWZsf+aTSB
         v7kFnF/BkWR3bCmtFpZW8uSx+dsJcACZs18zpujI3InaceIN7vso+4PcLE/p/BjanCwC
         z3TljwtnPTiUeavbs53Jb8OvTAK602GRqKa0fzXC0aHC/gCaJLzhQq86HYePBzEpSlZj
         0y44ZWvKUqe7qTHqoECntgwzxc6xXsXfMQeYYz+a6l9aehj6pirGbTC3ZrvofnU8+Gvp
         /tDTNbpp9ebMY6vp9dMWT+i+Q4ufqLInSnVGfKZHBApNsjGIMxZZp8+MzGbxCRCfi8tr
         wtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785996769; x=1786601569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N/Noaa1/5CoT0jOkbG3HQUWESYiE8Rvb0ack3Temr4U=;
        b=ZZe5XfNLFUL/+4nA0+FfSg07pJXTNu4ZJeu7UXVH91S3grRmZ+m91ecoYerRNMDHz0
         XM7OnK7LaJj8KQ2T/r0mptfS4FhH3SNxhnSsHBbu73gv8xIeSB6wnzB5u6ZqOhk3gl09
         kdHCV0Y8A+q+KdGm1/tnTDthxAD2B/LY/B/LPR8J6iDr62jGZGdX+BhKuW/BOmu+kUL7
         5WtZ4jEMA7+KZv25AHuRUtbRGAO8e0IkUuyjUa1AfZMHirw6QNFlpRhOo6IoD2FjzorI
         h8nkSMlTZNgFh2MomTosAAdC6WJEN1jwdU3fB0WtMEwj0ascZ/HKn+7cJmqkhUpUexGx
         vq1A==
X-Forwarded-Encrypted: i=1; AHgh+RqzGtjT+6++n/4GkhqpW1xPIVNd7i1ms6E1Ftchssv/gbi6nwmLx5k2Yg9fBIEuLlOijLSXY1B9UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvOIMu/ICqfYWeEJLxznJmpLgr1RuNiF65AglsQ3+O2DkD6KUB
	OCoaWEu3yEBCAN2odfZvcFu4UXediqmDrWnQxV91UD5hH0SpxDcHxx+lyLf4+gp0R0k=
X-Gm-Gg: AR+sD13F7Ct9K3Dv6vHH4HEuEQntVXTZwv4YAk1wW+ZfIZr4jd9HVAZetkNgKpU2dSX
	2LxDsBJ+prb/RosONnngGJc0d9+0XzW4dRRc1+90P1HBN5fIxmUBNCEOXVPphNqpK1i0RiQoej+
	6ZAZL19povtOWuk2j9H0MsA47eKB6ASE1zHIHuN5VwWHfTwzDg6kcKcAN3xPdnqypugMyTco3P1
	B7E3i2jPEwHiM/5JVCPcJGnCnPpGBvqdP73SHs84G1J6OibezrnHEpe28Ioo5rR17g+0qdCSLyF
	QVoCKnYGnw0auJUXzEAdyypxXbonwVu0LlUsaGWw+oJFtRYfyw33SsuD6PYl6E7d0DbsDFDdJ1z
	7yqb2cBkbnHzOV9T6zoAUBvCZV28e35mStGDmRcCA0GR1czdXnKtLORcFECHLlbs2XCNkClllqc
	sR6vOIPxaotlkdAJ0UiyaSNwC2Q2XlYYB555zPPWDBQlNhSg3ThLpj2guGFkq9
X-Received: by 2002:a05:6a20:430b:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3cb85ee779fmr14662992637.16.1785996769547;
        Wed, 05 Aug 2026 23:12:49 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863fb350sm24210421eec.8.2026.08.05.23.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:12:48 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:42:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, 
	Fabio Estevam <festevam@gmail.com>, Anson Huang <b20788@freescale.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6q: fix devres accumulation across driver
 rebind
Message-ID: <xale3cobuizjnufkp2fkvxmq66dl2cmuoh6szd4d4vhwfcxizp@4kp2zcpu2ndw>
References: <20260806050902.90550-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806050902.90550-1-kmehltretter@gmail.com>

On 06-08-26, 07:09, Karl Mehltretter wrote:
> imx6_soc_volt is allocated with devm_kcalloc(cpu_dev, ...), where cpu_dev
> is the CPU device from get_cpu_device(0). That device is never unbound, so
> its devres list is never released, and imx6q_cpufreq_remove() does not free
> the array either. Every probe therefore adds an allocation that stays for
> the lifetime of the system.
> 
> Allocate against the platform device instead. Its devres is released when
> the driver is unbound, which is exactly the lifetime the array wants:
> imx6q_set_target() reads it, and nothing may reach that after
> cpufreq_unregister_driver().
> 
> That makes the array actually go away on unbind, so also clear the
> file-scope pointer in remove and on the failed-probe path, rather than
> leave it pointing at memory devres is about to release.
> 
> Tested by rebinding the driver on qemu's mcimx6ul-evk.
> 
> Fixes: b4573d1d657a ("cpufreq: imx6q: correct VDDSOC/PU voltage scaling when cpufreq is changed")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
