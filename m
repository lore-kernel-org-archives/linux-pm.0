Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED738CFE8;
	Fri,  5 Jun 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662062; cv=none; b=opdR4m4kRhaJu7/iH6bXamWMN4c8NpOYzK+QGTNpYo+o0f0YcBKTto2feAQ0lJWGqgaSQ12I9OW2uDUKMSOceI++NCYNpqLmSOi3YGJJZWH29A6+gURMr9E5n/QdfH5DKmVybcNNElpdkoXQ2MVUlCRtu4pSS31owlMySWK0l90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662062; c=relaxed/simple;
	bh=DdkU4J6CGSWH5oVXiBeiOcrg0UBFFqfhLg365Ae2r6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKZ2emkaAiFQ29OCu4UffetCdNev2wh6ms1dRKUQrxVErr8wozKOfp9iKJRz64f++jyAslmU2oHnaNfVNl5bbEP1nDsfCFJZFsENER0YMWC4AFGl3F6v7Ul/YKiHkR+6b9+VXmP93rEV5ASuA4uYhLGAFUmCk2HOwvV30yViOGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNHDQVsK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNHDQVsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28081F00893;
	Fri,  5 Jun 2026 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662061;
	bh=ARFvRlU8LRgcpA99afWuXaVaqoKC+pBjYKPboVY44N8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hNHDQVsKcPTmFNcbnHFx5RacfgbDjEci+cBLGxyoHrmLxr5uaFaPPatG4k72d8Hsh
	 8phMGhwHFuBXdQh3b2fAuPwMd4mD2Ds9s7IWDFWrxTOP/0awIk5MIVP321tIK04yFU
	 dXuZyDsPUZzgrUgjELYG7AI1PbP9LTXYALm7dsWB7hwTbFljUFPhTDq0kTDHAAI1SB
	 /BnNpBQP1EvYFHQ/i+LyU4Q/cYVnKH80RXgtKL6d5dwrA6Czda4laRLTagjVmzpcwA
	 EYWrqFvXawMe4hmRwQysF5Y5oYkJszIuD7cGlnh1Yfr6V0kljj28ywuMiZWYbWV9YG
	 3d2JWVVYKEwmw==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Sneh Mankad
 <sneh.mankad@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown
 <lenb@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] kernel/cpu: Disallow offlining boot CPU based on config
In-Reply-To: <20260605104330.GX3102624@noisy.programming.kicks-ass.net>
References: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
 <20260605104330.GX3102624@noisy.programming.kicks-ass.net>
Date: Fri, 05 Jun 2026 14:20:57 +0200
Message-ID: <87ik7x5gba.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 05 2026 at 12:43, Peter Zijlstra wrote:

> On Fri, Jun 05, 2026 at 04:00:46PM +0530, Sneh Mankad wrote:
>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>> retained.
>> The hardware design on these SoCs forces a constraint to suspend and
>> resume the system on boot CPU / CPU0.
>> 
>> If CPU0 is already offline before starting suspend to ram the
>> freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
>> proceed further to invoke PSCI SYSTEM_SUSPEND.
>> This leads to a system crash.
>> 
>> In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
>> config and when enabled prohibit the CPU0 to be offline.
>
> Why do this in generic code? Why can't this live in arch code.
> Specifically, x86 can't typically unplug CPU0 at all either.

arch_cpu_is_hotpluggable(cpu) provides that info to the cpu device core.

No hackery in cpu.c required at all.

Thanks,

        tglx
