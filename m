From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 09 May 2014 18:05:56 +0100
Message-ID: <536D0AF4.1040705@arm.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org> <1399653631-4938-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48323 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779AbaEIRES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:04:18 -0400
In-Reply-To: <1399653631-4938-2-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mark,

On 09/05/14 17:40, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> without IKS support since it implements support for clusters with shared
> clocks (a common big.LITTLE configuration). In order to allow it to be
> built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> cores available.
>

I am in process of using this driver for ARM64 and hit the same issue.
I don't like this approach at all. I too did similar changes/hacks which are
good for quick testing but not for upstream.

I would like to move all the switcher code out of the driver as extension.
Also the core driver should be made to work with any multi-clsuter platform not
just big-little(bL). bL is one of them and bL switcher support should an
extension of it.

The main reason for this is I see some non-bL multi-cluster platform support
getting added, this driver should ideally support that.

> It may make sense to make an asm-generic version of these stubs instead but
> given that there's only likely to be these two architectures using the code
> and asm-generic stubs also need per architecture updates it's probably more
> trouble than it's worth.
>

I would not take this approach too. As mentioned above if we can resolve it in
that way we may not require this.

Regards,
Sudeep

