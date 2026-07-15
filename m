Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A02F5A0E
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094347; cv=none; b=gWvUB7lnt3Yz+/L7V9XYMospMNfZrSG2V9Moz5R1E8l4J7DwJTx6Voq0qqTjCgHddj0P3u8BghnON1rzf0/DreV36HyFq+rvULsbx09Jxiff2imJ3VSMQXu3cDonpnSLz0ReMZd4JGRUu4XlsZbBeA9qcukHSheHUHzU4wexoH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094347; c=relaxed/simple;
	bh=VeiS/HQ0/A//WgU8Q9019LQBqEPCs8FiGuXfWIXsHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUvCmhd1pcB6gHcWUNG+UOSzk8hR4r4vL/lpUM2GxYl0V3TQnGoDrCmKH+x7zN/X53EZfgdi7B39MevtSLPj3cEbIssJItyp8HrFpVDcpENq4hgzpIdTAk+1dJ28jc3aJTlxkGfkmGrqUD0IY68UrYzi43Is0lwZ2YIPYL53lx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mN8uYx40; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mN8uYx40"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1911337a91.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 22:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784094345; x=1784699145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d7JQLilasvtiBi3KqJRPfjtcOsV3KOV9/MjPpoDKsyw=;
        b=mN8uYx40nB/KtBAJBjXVm/VLX863WeNtfzqg+4ZdGA5xVHb0BoTNplarvZlkt6f9aY
         I1E6bQKqbrPpNcHCRF1aKixJWGkI9phhlTd+0hSrJCf9KXCea5n35KH4GwWkyn8PMnhl
         1658vLg32+Me+Bpvn74X6hA0nxYENDP6I+aQzOufXi0EIkPWC2G/zypqE09yziCSoAEN
         1xjKU/IgUh4gQPKSIYJsJ8EC62MxJ0wMbi5leQR4cCcOuuqtLCtGL3ls1iY1+5O19NoE
         hstX2RjUZtfdS0gI4PxmDRWXixMjAl04EGQS0moHTs/EbRpGo3z5yWfnnms54sJp26Nc
         eYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094345; x=1784699145;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d7JQLilasvtiBi3KqJRPfjtcOsV3KOV9/MjPpoDKsyw=;
        b=VaK9zkRxqSIRDNFWmP9r8O9d5jBxNZW4xtLx3h/i4Fd0I/I85FR3D+NTpkPGofEuOa
         IYOt3/SbG8309SI70j1NqzRVkbm1LXaSqQGoFmCOXP/od+MI6rEaNJ69NCwlL/X2Z3FF
         Wf0b8fcGrHNjLXPfJbor/oZYcc5OqdIR0gtX3VmFmnSTDppHBD1KXFmiDRpD3bbvgWi8
         fT+GeI1/2cH/4ebFwv5XxG2F55DjWbwDut2EwjhU4VvXM/a3J109zYpFsGmzYBC+GMZb
         buG5SizWM5mzLgVgEc4ue86+cxPf2blYjT4n1+GAPCVGHUbUD5Y0Ox66fFOpnRIjM2wL
         VTyg==
X-Forwarded-Encrypted: i=1; AHgh+Rra/ZZpWKehL2jSAYf6EnlGIPNYUun4wS/8NB7p1f6zbxJgGOyrCrzpuxym+Gum7XuD5GqL58MNUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtybf2v38PVt9mK8JKuvK6u6o7+yj+z+SIzeX3zb8QW63tUIC
	veU23p1Jr5OVkFoNe9fPjumMwMbAL5TyhNHdBhoUzdYHct58Cc+KctnvWew2WVOiKck=
X-Gm-Gg: AfdE7cn3wD0ewY+w6qlPzoxADMMX5wsjYERt2CCxaJL4+y1trog3FsWeGtvPDvHEuEq
	bcWpioOJM5lFjkogeTnWjmCt/Rf/sp1Dg7CN8fd6XwDKkdbg46aBqBn+KIHau2L5vTlk2FLBH7V
	p5WkskKDD9S+PKBY85KWwjxG1n9DYjt8YwVCTdz86VhL0B9urHgnBBB7HXD1/b1kqfq4RR2TkoU
	DldDoIF50U3K0IbpCsGIoiHfbvfmNZovtJlb2T6YUXDn/gAu0tyypPidu14tsbrVl7CJZnk76O5
	ZuJpDhkIQ5NwB0LmYPDLOATPmLyTj8zu3JkrVsHO5Hs/cs3PQntx9qVshk9wGHkB/Zv/xFiYhAS
	9ip0nAnrOyvfqt3ChF44PnxLz2XOh5IaT1sKi/F5AWNUSihkp1oq0hqn0Vsgokx3wlHC04w/yZI
	crGnQiq3aplNjs
X-Received: by 2002:a17:90b:3a81:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38dc782ab92mr15243246a91.6.1784094345259;
        Tue, 14 Jul 2026 22:45:45 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm88482627eec.18.2026.07.14.22.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:45:44 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:15:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Dan Carpenter <error27@gmail.com>, Deepak Sikri <deepak.sikri@st.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: spear: Fix an IS_ERR() vs NULL bug in
 spear1340_set_cpu_rate()
Message-ID: <mfnihs23xwn6l5r626p7aunrxw34bizbaoka3zwromilg2znpl@jvjj3uxtwovt>
References: <alZZzlY9rfdAvWac@stanley.mountain>
 <a32691c8-e48d-472a-91bc-a3f4e9edb00a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32691c8-e48d-472a-91bc-a3f4e9edb00a@oss.qualcomm.com>

On 15-07-26, 08:10, Zhongqiu Han wrote:
> On 7/14/2026 11:46 PM, Dan Carpenter wrote:
> > The clk_get_parent() function doesn't return error pointers, it returns
> > NULL on error.  Update the error checking to match.
> > 
> > Fixes: 420993221175 ("cpufreq: SPEAr: Add CPUFreq driver")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> > v2: fix subsystem prefix in subject
> 
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied. Thanks.

-- 
viresh
