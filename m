Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B81FC4;
	Thu, 24 Sep 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245877; cv=none; b=uyqzlD0/WtqTHf5M5MPc6UWdNd35H5IK03muN5k+ELUO9N1CL0kF5thgPpmLcFcERc2ItiUePGMJpU450bS3OfCkmU9WORIdd6e0BnaHXehmiuiIs2oPqLrHYgFR3AHgq9s/u9o2yDTL5BgXZsB35wh5SQj6X/7hzjh5zSRIY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245877; c=relaxed/simple;
	bh=bP6zCwxqt29aWujkm2/dLX0XFEzt5IZ+l6v3WvFwcBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cC2YYVuyhQoRkIRXLi8Ght7FLpB/XPp4BS+LZqTq3eQBE9qvvQPNzyY3XmZgobxZL88LXfQpdi2BcJD0mOR//Tj1TvZpa5UykJRG5k84VJ7jhntdIT1MAXdfFYtta4aC5Gs52tF2pqMNZ5WH9oxllIfGoG9Ho8IUkjOgkfeCS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afSPn5aY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afSPn5aY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67E21F000FF;
	Thu, 24 Sep 2026 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245875;
	bh=MA/bi1t2NUDEfbYcs7CTGQlubR06QFxpdvCTjkXJYB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afSPn5aYsT/9O16kJmT+fRuGga606uf/lCkifkCmuA4/B+NXmq8/P9wfdV+nsBlLO
	 o85ezyD0+NhAeffoeR525BkLRj5D1pHKuZXyHvdTx8jW8M7UhYF9M+HW/p2yiinPVw
	 yX8hev3vmWa5HyWia35JJ+dHCMEeegan976Lad9KcuzDKd9OZyCf1FMjnGG7Rb6Gb3
	 U+6aAeOM6djD5Mbtj6asaTZrSy8htyG+rS6Duqk5107pHGImZ+PXeuC4kdeY49CrJ7
	 KwJkp/HbdwTyogwTCmYLUnzvLw6Lj/dJVs3VWNOPTso9A7e3Z9eJxGHq34iGYKD6mw
	 DLE6jZzzrLJ5g==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Oleg Keri <okerixx@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Thu, 24 Sep 2026 11:31:05 +0100
Message-ID: <179024159739.2601842.17914856161102135517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923125604.2482-1-okerixx@gmail.com>
References: <20260923125604.2482-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 14:56:04 +0200, Oleg Keri wrote:
> arch_freq_get_on_cpu() computes the product of the frequency scale and
> the reference frequency as a u64, but assigns it to an unsigned int
> before shifting it back down:
> 
> 	freq = scale * arch_scale_freq_ref(cpu);
> 	freq >>= SCHED_CAPACITY_SHIFT;
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
      https://git.kernel.org/arm64/c/3872cc6b9294

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
