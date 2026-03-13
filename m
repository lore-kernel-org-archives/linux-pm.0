Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626A92E093E
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415341; cv=none; b=HLE2iW5m8zJ5DtaM3zysKs+NeT0LXUBjUoVcrx0RAVOloDt3t86+FQCpdOnQ3Piz5kAEb3tPCEW5Uwk/gbp9vIjGtWuBLCxvr/8U82TKtGj4zikz7cAkLca7Xmmvpu3NhyP3l9ghhPOD3M9Wg5IX8hRyCOf41T7/3tbqHgEV1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415341; c=relaxed/simple;
	bh=Cm+jULF0sYcatM32YQ0xxhsMgKUWuj7BYwxyC7WTbCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7gpYL1dZV+vViOWRfPSxsPVnYejUI1PdWsDGiIXoeSKt3su3JkvKXLKvGxKJxm/L6kj4NtBXo/X4KhKczbeZE5PUlp2JTOsxuHDxwq8H90Nc961JtG/NJZDJ20Vrb80ZljXh2kU8fV27z9D9PMnePeQ5BJtG9LpHwoAaMt1VBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=iwr9BIWO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="iwr9BIWO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so21826415e9.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1773415337; x=1774020137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MOnhKkLzT8lboSu9u82dt1n1tMyjwwzl7YXv4nQ4Z/8=;
        b=iwr9BIWO2fH4U+Lo1xzAtmVjckgz4xM8iPEhC7ko5K39hS0V0yctLLs3TANiOo/zPR
         OFUD7n/M1jeEO9UODKI2dtTnT5topVBjYujMkmkLi23Fn0BBdGeJCSEAptE9zWOCG8Jo
         q7xHl06v2Z5mlkC20b5pyqdS1LTMMWn7zyvOW2Fm6EwXypE53f0zexFjPR6Rzjig4ISa
         kflQrkoH/K5NwwgD4kMDax8CpAwmTdkVFK1ypLpAvXpIEmRqN3xpEExxfNJxjxWpvVsr
         5KOPk+Ct30ZuBsjoS1j5NUdV1d6CZFGn7Hv1gU9FKwrBB9UsrMafffXaQLUw8EEr/bbu
         4pOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415337; x=1774020137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOnhKkLzT8lboSu9u82dt1n1tMyjwwzl7YXv4nQ4Z/8=;
        b=G8fgdC6VSTn9LQO4TJk6vf435gtJgP+wGPZgkBQ2HmXLnaIH8uURUKHQj89N+6tosZ
         2oiBc83gafx0Ue92/v+xR018VulR8s9Vae8TLz1avPo6KOXs/lurs1MmHubjbY4emyY+
         bScS+M75y9mP0IpEOnHhnKfgEPZAMOky5zkI/6awBlucXF3eLRZeyPmBQOTF/Vk0Vzqb
         JWBW8KxgneSsgp/xZ5Qc0Vs9rFks3fhG9eA18Buh7qdBuCSYeY8/hhdGMmg9ACMSdbUx
         sKABfV4eRLiJQ+qGF+BN2nIGpEyR1nSE3un8pd9I6tnJYoOr8shaGETya+WOQx25I96b
         MAcQ==
X-Gm-Message-State: AOJu0Yyryw9xyCHwh+si7L0C4vogqxG0BYUcdmjYD0OBt55QcSdRF847
	v1Fej51OEoIe6648cW3MF429/xhuWN3ttvxJwFF0qTZkdRQAVM1fC3qhb+y0xIlGIHc=
X-Gm-Gg: ATEYQzxjVID9xpt/SOGjQ2KFvA0o3ob9bFfdYdvfn5ZelwHDhivsvZ2/t1EOM1R3P3i
	+0ElKVxC1ak47yyNTiGURwdr7XKjPTws4Zb4apl7TvSRZbOoRgpoCNTNHRIkkFY2e/kfjee9qyX
	FZi6qtJ18n2sGmvNHZBauw27kRlorVaeOv8Gz5NshfgE6AK3zNI+s0CYWvqSazqJnVO5oHZ7kW3
	a3zgDjCx0BmX5QaBaVH9EcUycdOYqIAl0woIw6gBhWYmBoHDP/Ihq65YxnhYvf3VP5mJ23qMaPZ
	5doXS6uajzzHU9V/1Fqg0ePE3vCKQWTKa99QsJT8p0NQ14VPGRXMGBRtpmEdZLrN/iEzP7FOqxh
	2NqIKDykE+9vzqmlLE9O16ENlLboqtalyNCqTd5/KyQweNTTPMuPZt9UnPaVa6OkJ6lyyTkKKx1
	5bjOGAWXGvlc+v8jZS5q05rT6SI1g=
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id 5b1f17b1804b1-485566ca967mr58899545e9.3.1773415337391;
        Fri, 13 Mar 2026 08:22:17 -0700 (PDT)
Received: from airbuntu ([146.70.179.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19b936sm21225895f8f.5.2026.03.13.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:22:16 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:22:11 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special
 cases
Message-ID: <20260313152211.hs3esa6ls3objtit@airbuntu>
References: <4741364.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4741364.LvFx2qVVIh@rafael.j.wysocki>

On 03/13/26 13:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are two special cases in the idle loop that are handled
> inconsistently even though they are analogous.
> 
> The first one is when a cpuidle driver is absent and the default CPU
> idle time power management implemented by the architecture code is used.
> In that case, the scheduler tick is stopped every time before invoking
> default_idle_call().
> 
> The second one is when a cpuidle driver is present, but there is only
> one idle state in its table.  In that case, the scheduler tick is never
> stopped.
> 
> Since each of these approaches leads to suboptimal choices in some
> cases, reconcile them with the help of one simple heuristic.  Namely,
> stop the tick if the CPU has been woken up by it in the previous
> iteration of the idle loop, or let it tick otherwise.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Thanks for the comment!

Reviewed-by: Qais Yousef <qyousef@layalina.io>
