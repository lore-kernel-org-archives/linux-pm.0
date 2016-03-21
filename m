From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: rockchip: add driver
Date: Mon, 21 Mar 2016 20:43:00 +0530
Message-ID: <20160321151300.GK27778@vireshk-i7>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego>
 <20160321095049.GD27778@vireshk-i7>
 <1505152.fhSnu3pvDr@diego>
 <20160321095855.GE27778@vireshk-i7>
 <56EFF610.6040402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36175 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbcCUPNH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 11:13:07 -0400
Received: by mail-pf0-f180.google.com with SMTP id u190so268782356pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 08:13:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56EFF610.6040402@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Feng Xiao <xf@rock-chips.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>

On 21-03-16, 21:24, Feng Xiao wrote:
> Rockchip-cpufreq.c depends on ARM_ROCKCHIP_CPUFREQ, it will not be compiled
> on non-Rockchip platforms.
> The driver can support all Rockchip SoCs up to now, add
> of_machine_is_compatible may be redundant ?

Heard of Multi-platform kernels ?

-- 
viresh
