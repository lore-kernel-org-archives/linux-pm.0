Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992609;
	b=Eo+l2eJG/rmma3s8PgEV2PzVIVc/r2hQIxXwTG8M94uM6ug+uabPvezkM5qMlUi5QEWS
	 Va4VJg4EJTNuR/iOEyLsuU4AQPYbqlLupCuU3I9Dfq7Tp0wUQ3zaxv9KHPGnx4V0W21dR
	 iflRtK0Zj0wbYJmiVp+quxIacuauFmwDSVBbRS8re1YozfTlsdIPcnEq3bGXBeXXeG7W7
	 JHz7eEQi8R3XooIaEVWIXVMFXkSTIDO2OGb2Ig4IyyayIXdCL8TGXT40bUZd7u6HmxEbi
	 pN+hLARFW37vrcm96ASvhxeMS8YhME7w5WIflsmHq25gLqTAWmVN8ATZ2ZejxlJRQKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6OD8mOSD4xUumfZoJOx4KZDALoWc84UxiNE2jvRNJ8o=;
	b=pfHu7GY6OSNXKklV2OMMw95iSDX8u+TXLsYqddVrcW2hpHbiWxjQuOTuyNsR7TsDbHcD
	 ETrbhOCG0t56y1fi4oTt5KTd9JvEty7oJI+HjX6URwA5OhOipt+PAGchXDmJrz5lpf9XP
	 l5OhQzjxKkh0bN0odMbJPKxSWs6Op/3u6bQZOu9EBjRcQ8lXffrpOV6KphPdNtAcypTmG
	 fN7IGU3UZ7IzQCa69F2mzAYUQQ7BMS/eN6hFB2zWR8Aj/RlmfuhUsM5SC0d2khT5DFQB2
	 /IN0jLU/wM78dsNT5PwPdRlWtOwZ4j+9YEYFN8xv0TY06oY6s9aEVY5YIBc6HpkQMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gthIh1AK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0503606A31F
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 05:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0503606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gthIh1AK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35d0be18c71so4428048eec.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792992608; x=1793597408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6OD8mOSD4xUumfZoJOx4KZDALoWc84UxiNE2jvRNJ8o=;
        b=gthIh1AKAU0A3AJJG069Cbtlgxlem6fGpkULCLsWK1TM7qt0L32vkm4SwAPpsVLD1a
         Zk8fsxIyOoL0yXA8LNGkT+UWyitP8Hdh3MUB2nhVWvwvTVwYxyfVMdGfYMdqf3Dz+EAl
         KyCQZM94tCvzVrcKCvLOvEEblmzKBU1nMInRbR4lFBmO3lXdK2Tn3/6U/HxOOm1TMQLp
         LSoS8W4imx/fQzIYVzdXoML4S/clFhy6X66qFSWkazQ/eFXqIZgWWWFJACbmdvCpl6to
         RDu0QmQB5lIHpCjEl0QCv1WQmBbWZkSqeD2c4QBmLATFw08ZlqSHWoSpHJ7R+tvJLnIQ
         SKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992608; x=1793597408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6OD8mOSD4xUumfZoJOx4KZDALoWc84UxiNE2jvRNJ8o=;
        b=2w90YkTlisfsC7DwSsFo39yAUV4W+4y2Bd3+aPOXcJR8/hyAWv4NP4wO85I1x3kyn5
         H+0xs31rh/d2YxGmzSCnZzZtY7oQOzDSbGUCvPW2gwwmYsXrlPEBrGyjAuCsU0C6piNL
         NXGSmnD+8nrMGZ71keJBxl8z+h3co8D4B+V0dQWsnYQUCTNVIWByv0gw6Rn+uaaSqJJH
         uq3bBLuyyoiKjhTMo5VIkAjfCx1oxhYzeRyiBIx8GhMaNpQnf10Mdwnb09fx6xqkuHrO
         TatG4yuzmdQX8wA+Q7kEvS6bmGKrhmdrAbSv5waQbLUF/r5cVYo97Zp2xHSB/LaFzcwn
         3z2w==
X-Forwarded-Encrypted: i=1; AKwUvBymYSs6abrQKV3zuyX12wVLpCehuw0RUtt29FCWjWM+lLI/ib8pywB7+odF/Pd1sPXL5Pt/VZyFyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKrDvOWIsUwr1mwgQCsMYvP7o2iv6pRKzW6acO/P0ghQ71KdSnn
	k+dRgHoAT8LD9qCdCPLFj4pJt75T+x4pFBq0k3QMb8KsVQfhyeNUHkZy/WYvYR7lRUs=
X-Gm-Gg: AYBFou3Nn0Q4nIiJacFXVoOPpovX17gPayq7ZV0zQYl/j/TA0TVDLaW4aPTbQ7hGdvl
	qeLkKJ+4Xd4iE0vZDZPbViW4MQADrKlHUKmTbYj0q8Ij3GnW2PK06JBV2oRuJ65edJ+RADXNNhp
	322c644GGFXr/V5mpLqIMqujb92zHnI2I+VFwhE1JdAYcFdivLKsRGvpCYX9UkYFKtNAE37cgPX
	AgsympjxR1UTKpEKgUggjPfTCFzvkNNVY1W/YdessaTcEHRTlGTf111wB8U2Jpp81TYVayNO7Yd
	yUZxF9OqMOK27PuScmRX1BUrkQR3kl6gOJ6ikMnFiP6PzeedhOFAW4gD+dJillP3L4AglD6SawK
	BOJ6whNnGahvFPEdVUQq3aDzY9uD5jGoEdWjLMiSCfE0pqySJ0fG+bCY5N0nmIu2KAGS60aHd6K
	P01Kmanuu5W8P7izF/Pgr0QGeecbQj3+XAoO1slwuxKH/Mch2DSb7FUOIEgqIoJeL19CNoJQMpQ
	OgMdXIMtrdZOZ7dayTPZAkfFcG6MivgFb5PPKksRXAfnvnZoAFZuEQ0SA==
X-Received: by 2002:a05:7300:c8c7:b0:369:f231:b98f with SMTP id 5a478bee46e88-369f231be73mr5481082eec.4.1792992607224;
        Sun, 25 Oct 2026 22:30:07 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm7075259eec.14.2026.10.25.22.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 22:30:06 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:00:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com, sboyd@kernel.org,
	bmasney+clk@redhat.com, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, rafael@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Christian Stefan =?iso-8859-1?Q?K=F6v=E9r-Draxl?= <ckoever@outlook.de>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
Message-ID: <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>

On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
> From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> 
> Every S4 speed bin runs the same CPU frequencies but needs its own
> voltage curve, and the bin can only be read through the secure monitor.
> 
> Read the bin from the firmware, select the matching
> "opp-microvolt-speed<bin>" property for all CPUs, then register
> cpufreq-dt. Bins outside the known range fall back to bin 0, which
> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
> on the SoC compatible and needs no node of its own, and S4 is added to
> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
> the bin has been applied.
> 
> Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/cpufreq/Kconfig.arm          |  14 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  5 files changed, 202 insertions(+)
>  create mode 100644 drivers/cpufreq/amlogic-cpufreq.c

Is it safe to apply just this one ? I can take this via the PM tree then.

-- 
viresh
