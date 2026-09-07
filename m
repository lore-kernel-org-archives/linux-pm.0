Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF043546DE
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788755969; cv=none; b=ncj+1jirXx3//k4U7I5CBznFiz9sJI9j7LQPZZWhcsb7J/mdaymnNQmG2MSJ2//wiNmxyUlhUnEr6ygDtuTuDRxYVZ63vJMqbqgku5e34wgXrMK3x8HuhZMf50yTf7vjqm1o32G+KsfBaVHjofoL3KrY6CrKzdf/IDPdg4ssuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788755969; c=relaxed/simple;
	bh=SHkFjsUEK8BRAqvmfnv5vItChhZEKbXF3e++QGo0kBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vk8sbWk0JNZ/echlPDiLXt+H1AaDArOJ6Ls1D0/j3DgrNi86crHOVNLwBiZkkGb/zFVKG9CQ9EEFj2ujroqpx2FZ6/Lr6UZZ/IhyjwD27CBgeV8cfwGlAP9PGHqa4ehyQHrrBu6nAt5MM3QL1SZWhfmBRhrjG9I+ChhIqqyWAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIANc05N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIANc05N"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d91ded8174so23586675ad.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 21:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788755967; x=1789360767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZVd8AEPtHxGrM09Xmw7u8IpkGldFD91EALn5nG1tdA=;
        b=PIANc05N512QUTF5TjEtlbM4w7en9fL8O6BhtCA83roQ0jfUKukb//ho+6RXKySd9G
         FUTw3G0FVSbMNUtMYku3cZHHlvlWyfjjJU1OVIXHzVBQnjMwT2JBWDeHUDO1DzVMkcrq
         AxN6vpFP78ujLulq5uM1dTmRzi+LtC7nNUXT18TUw3Ahk1SOaot5RiQPSLJ/2M8AjXDY
         c4jOM5KGpPU8aUg5vTo0VaGJqfiJ5RwIZVKupuv/lHnbq48TMS7H+gvkXalZhIqrdyU4
         pndd0TNeuW9n0qkAm6pPJvKjOv5aq07RoZ4kaYjA9B1Lf1FeGycUCndnf8+V8OGsGPYn
         uAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788755967; x=1789360767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZVd8AEPtHxGrM09Xmw7u8IpkGldFD91EALn5nG1tdA=;
        b=ZksTC7mQ3K2ubJ3oLc0+hNIyNvQE3vu40CVr+ravZgG8928kVR7ycgSVgLuXTFLj1u
         DiDE1cdNMsl8FqLM3w4K36Ig8YavM6dRvwMnN6qZM73nTkekeBxMuglEmsQrOlBQ1GMu
         gM/aA4QE+j3Qg40Uh+BU9zd8GNaTiZBUKh1pihwZVIloWX0tiQi9DYB6/IkaXlcLeUrQ
         VW4roVSboxlbj8E6C2oHpZdCsbGWp1L6lHLYKf1XanHcBclOj+5QSABKQVtHfe8MqL07
         dwY8Zzv1Nplkp+DgKRGROKo78g8jlCC54vxxgD45/Xqm+L5KU29A2iYdAMBeN+Pr/zsF
         8rxg==
X-Forwarded-Encrypted: i=1; AKwUvBzgC0ZBtlxIOyAzyc1p3x7SfUbYV1HGMu1GSvDb80fZhJic028dQjd1pBcXLxYwH8KOPqfmwtp8Sg==@vger.kernel.org
X-Gm-Message-State: AFuF++nX2zHBo6eAhOeu9EB2O6KRS0NSpiZ7WNpDOreY5yV9EKJPshsR
	uzGZhhczbZUCEK+fGvEv4RnDfqMhzCLGJBtuU47vuIAtkqLh3OWGkeiq+9KIuK+uc80=
X-Gm-Gg: AYBFou3hKqAouL4gJaDyAXUixdGEJZvC6NbUBMvUdTOrlSfW1ib2sbciiAxjwHB7Eo+
	HB/Ojym+00aPKmkG8HPRlotBpNstl/6bySQ8sx+W+Cfbw8iWFI2wL30d3XZze6HPG/J54fGH/+B
	2yudCo7kUccUe1/FgKb7/wpha9+XUfAJxEgsF4D/W6uRogDRnsGfHBQBEo63ju2L/FEY6TkwW8j
	q6mFVOe33Ms4G8uFaceW3OytoPAcbCOvgOGdmXIWO+X+dTiz/l1iB/8/BQkAyJaHKTYqpS2+8Vw
	Mct27Tfq/N6b40ih9g89f4qSwnAuxtyHQKAeviE+UMqfRP4PT5Aynq/r/Z/xI/9q9+gWw02W5uK
	n9eHj1wg820g/BPzzXNO9+Bm1XEas5Mimld/iljhJ8CEWBYCeSFcvx4gbocSEU34hVPrbEUlUIf
	AZRMrcwLVYvvm4EhBFI2OrR0pKwVx4y6IjMbd9K7r+V5bofjXpY9LqU/QcKtPYVIY=
X-Received: by 2002:a17:903:37c8:b0:2d9:50:a91b with SMTP id d9443c01a7336-2db12667eeemr299920485ad.16.1788755966732;
        Sun, 06 Sep 2026 21:39:26 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm26643998eec.2.2026.09.06.21.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:39:25 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:09:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, amit.kachhap@gmail.com, daniel.lezcano@kernel.org,
	thara.gopinath@gmail.com, talel@amazon.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	mmayer@broadcom.com, sumitg@nvidia.com, krzk@kernel.org,
	peter.griffin@linaro.org, myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com, cw00.choi@samsung.com, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, sven@kernel.org,
	j@jannau.net, marcan@marcan.st, casey.connolly@linaro.org,
	sre@kernel.org, wens@kernel.org, t.schramm@manjaro.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] cpufreq: Use %pe to print error pointers symbolically
Message-ID: <ap4_-12ta7ThxEjc@vireshk-B250M-D3H>
References: <20260906061755.5103-1-sumeet4linux@gmail.com>
 <20260906061755.5103-4-sumeet4linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906061755.5103-4-sumeet4linux@gmail.com>

On 06-09-26, 11:47, Sumeet Pawnikar wrote:
> Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
> to pr_err() and pr_warn(). The %pe format specifier prints a symbolic error
> name (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it
> falls back gracefully and prints the raw integer value. This makes messages
> more readable without any functional change.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/cpufreq/bmips-cpufreq.c   | 4 ++--
>  drivers/cpufreq/cppc_cpufreq.c    | 4 ++--
>  drivers/cpufreq/qoriq-cpufreq.c   | 4 ++--
>  drivers/cpufreq/s3c64xx-cpufreq.c | 5 ++---
>  4 files changed, 8 insertions(+), 9 deletions(-)

Applied. Thanks.

-- 
viresh
