From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic
 code
Date: Wed, 20 Apr 2016 15:25:57 +0530
Message-ID: <20160420095557.GF12019@vireshk-i7>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34184 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbcDTJ4B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 05:56:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id y69so1036886pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 02:56:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1459325515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: slash.tmp@free.fr, mmcclint@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, k.kozlowski@samsung.com

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

@Matthew and @Mason,

Now that this is present in linux-next, you guys can send patches for
your platforms cpufreq support.

-- 
viresh
