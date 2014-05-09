From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 9 May 2014 18:47:38 +0100
Message-ID: <20140509174738.GP7950@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:14052 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755420AbaEIRsV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:48:21 -0400
Content-Disposition: inline
In-Reply-To: <1399653631-4938-2-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>

On Fri, May 09, 2014 at 05:40:30PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> without IKS support since it implements support for clusters with shared
> clocks (a common big.LITTLE configuration). In order to allow it to be
> built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> cores available.

Have you thought of patching the actual cpufreq driver? Are you adding
this code just to avoid compiler errors on arm64 with this driver?

> It may make sense to make an asm-generic version of these stubs instead

asm-generic/bL_switcher.h? I take it as a good joke ;)

> but
> given that there's only likely to be these two architectures using the code
> and asm-generic stubs also need per architecture updates it's probably more
> trouble than it's worth.

Exactly.

-- 
Catalin
