Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CC838C422
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262510; cv=none; b=TWTNVgG/0MG32Z/SPbmlA9Kg0LH+Oe6MDspjZoySHRllZ2v9IritR4LHzf64Ybo5N87XdedMMs79VF7RcWD9J483qFG4uNXWyxvaprFYXn/dF3yi97Imjt3NsAq5qTWfdLf0lWc7VnpHHazZWag/Xn/+Pqu0sTCw+wE97pmyXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262510; c=relaxed/simple;
	bh=5P8c0gla61uwDkiL+0VNPmk/aCIxKNPDrkZKJVgWMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eipdmMlH8vYBsQMzGmFsYkMvrONffQ3JZZaVwGuHnIxoZ0kVr5LfJZn81V8sDDXwNduPvLoI7ueDJUw6rZ9XKC9FdMQyFu0wepregOBtHS54v3PskRla47/F65gAzOs7p8XDevEven+wf33VbKcxhbO+0lqv+5k0VZmcAZsRQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWq7uJug; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWq7uJug"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so3564168a91.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774262508; x=1774867308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiZ7i6qaNlN8nrZChDvWwwA7CAYB/H0k32ljODyK9ac=;
        b=DWq7uJugsIau3/gZZ8QvDFtzDNzwRRkWO7UbaVD9lAnfCgbn4MujXRP2Sns9SlNX/G
         0pV7TuWtPoIrpSgsl8DrpJr+mQGoHzbLFGcUKF81bu+pG34V9v0jXKwv7UKuO5rcdTmL
         c+wj16zUYW8sxB8FLFDep9Fp/ByxwvKeqVr2VPiNSs+gR90JCh6vOWR2AKkqYa3gJ8N5
         t1hrda5M04WCrCK+pzoNCXQ1FWzrqiqZCcIwMFrEjrrBqNrxY0TSDgfA33vK1c5JP2pM
         +SIydQ833/oZNkhZXMaIO76coP2WM651Dc6suWR++yAPxdPbs/sZ4L424BjNnDNOKX5W
         0F5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262508; x=1774867308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiZ7i6qaNlN8nrZChDvWwwA7CAYB/H0k32ljODyK9ac=;
        b=lzIxBXhMnTZvmv0HwsLqk/zhEXcqM4JHpeEnUxtdHeTr3zuksOqKO9FFTvuizLBsJH
         l25f1fHRIok5S8Mh1SjKCzS7I7iknfRnKn2tUUsmFe6RtqacfWPwkXsRTBOCknXB1jQo
         9TAPR6n0V0HXaAcvNeXatD2WwbZXvV+Y0rwDSFDXMHtBwBmwiS1EYK5O8yAcZ/ODaLId
         UwCwdId1HewFoqWW8eFWy3Eo+QAASHzqFdxRbtyQtD4hhala6R7yV7z+Ep3xNe7CcFSe
         bHN0HjsyISa0o+7Lr129OYsZSzNm/fLNZ34HUcjWJz8OyeupYC1VyJcP9xCsBYqQvifh
         CrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu1pg/R9x3TZqYAkxObeNiQ5ndjNvtfEeJyMEajMIiFmfXPQ3vbeHgUyMYyguWABlgtDafQhn6aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjX/OFnc4ePbRnq+soytclC0Ljy0cFx5r4E+KfccMX7BOc9pkC
	kXoKd5dGDnJKJAVg5EbgyDJrlUNCDaY0MSVUtROKcXVSu9TcmmNAqgk42Af+TUS5ulM=
X-Gm-Gg: ATEYQzyf//hSx19cA45FtyZPBXMKLWftwfjTVrAQa0Cs10xPE+oHOFERgsrf6sIHOGf
	dUFPIGegcqKFgzTDeqOQ8DPLat8xGSwSc18NYrE627z8qetDXB6p+L0CahyZm0BcDFhnzFHw+gS
	FAPqMAc2PzH9OqouOVtlIh10nlmVydXvrkURCSNriXV8U3Hydt2fDO7NGmx3uGKIwUXJCs/T46V
	XEaZ9eiQ3AbO2VIc7qvq8JzgJNGlW4Ziq3GpVaKtqJVVoojckvM+EU0JYoaEWpxECwK+z2KfZ4v
	touEvJYqfgTd/wz6BIp4OGErwWaAlFh1rVVRWZaWveTiGtrsBGZgH3xfc7k6Ncxm+mLxewuNOG3
	LxuQ7uOCxm1R0ihd3br5GuKNqci2BmiwHilpCCL9EOrWhDs8x61tgwOLvkaZvVAeCH3sftKgCvd
	bLtHkZWgDxgpcbJIa75xEKvLdsJX7BxWQztF4=
X-Received: by 2002:a17:90b:3fcc:b0:359:fd9a:c513 with SMTP id 98e67ed59e1d1-35bd2d404a7mr9589383a91.24.1774262508059;
        Mon, 23 Mar 2026 03:41:48 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3d8c462sm9147825a91.0.2026.03.23.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:41:47 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:11:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com, xuewen.yan94@gmail.com
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx
 in get_load()
Message-ID: <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
References: <20260320113148.7308-1-xuewen.yan@unisoc.com>
 <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com>

On 23-03-26, 09:20, Lukasz Luba wrote:
> Thanks for monitoring the development (it's always good
> to have extra engineer opinion)!
> 
> I've checked the commit that you referred to and the 'i++' there.
> It's safe. That commit removed the heavy operation for only
> tracing purpose, namely:
> - allocate buffer for N CPUs for 'load_cpu' pointer
> - populate CPUs' load from the idle fwk
> - put that info into the trace
> - free the 'load_cpu' buffer
> 
> That has been redesigned since it was just for tracing
> and introducing extra time spent for code run in the
> throttling phase.
> 
> The code in get_load() is OK with the commit that you
> mentioned.

The code

        load = get_load(cpufreq_cdev, cpu, i);

depends on `i` being incremented in the loop to get the correct
`cpu_idx`. But the said commit removed it and left `i` to be set to 0
for ever.

How is that okay ? What am I missing ?

-- 
viresh
