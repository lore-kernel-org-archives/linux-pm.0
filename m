From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Tue, 29 Mar 2016 19:32:08 +0530
Message-ID: <20160329140208.GK31619@vireshk-i7>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <4531000.a0G78BGFu1@wuerfel>
 <20160325044124.GN22062@vireshk-i7>
 <4279257.XRWOdgISPj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36079 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcC2OCM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 10:02:12 -0400
Received: by mail-pf0-f180.google.com with SMTP id u190so15019230pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 07:02:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4279257.XRWOdgISPj@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On 29-03-16, 15:22, Arnd Bergmann wrote:
> The platform already calls dev_pm_opp_add(), so it directly interacts
> with the cpufreq infrastructure. One way to do it would be to add
> another function call to set the independent_clocks flag in a static
> variable owned by that. Another way would be to have a separate
> function call for doing dev_pm_opp_add() with independent clocks.
> As far as I can tell, the two (dev_pm_opp_add and independent_clocks)
> are already tightly coupled interfaces, so it makes sense to
> combine them.

That looks like a good idea.

Apart from that I hope you don't have any issues with rest of the V2
series.

-- 
viresh
