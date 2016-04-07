From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic
 code
Date: Thu, 7 Apr 2016 14:01:46 +0530
Message-ID: <20160407083146.GC3201@vireshk-i7>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33438 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbcDGIbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 04:31:50 -0400
Received: by mail-pa0-f50.google.com with SMTP id zm5so50809021pac.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 01:31:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com

On 30-03-16, 13:45, Viresh Kumar wrote:
> Multiple platforms are using the generic cpufreq-dt driver now, and all
> of them are required to create a platform device with name "cpufreq-dt",
> in order to get the cpufreq-dt probed.
> 
> Many of them do it from platform code, others have special drivers just
> to do that.
> 
> It would be more sensible to do this at a generic place, where all such
> platform can mark their entries.
> 
> The first patch fixes an issue that came up with an earlier version of
> patch 2/4, but its still worth fixing it.  The second one creates a new
> driver to create platform-device based on current platform and the last
> two converts exynos platform to use this common infrastructure.
> 
> I will migrate rest of the platforms after this is accepted as the right
> way ahead.
> 
> V2->V3:
> - 2/3 is very lightweight now and doesn't support cpufreq-dt
>   platform-data and an extra depends_on from Kconfig is dropped as well.
> - 3/3 is separated into two patches.

@Rafael: Can you please apply this series now, that will enable me
with converting rest of the users to use this.

-- 
viresh
