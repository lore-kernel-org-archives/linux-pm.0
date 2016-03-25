From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: rockchip: add driver
Date: Fri, 25 Mar 2016 10:12:02 +0530
Message-ID: <20160325044202.GO22062@vireshk-i7>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7>
 <56F35894.3020106@rock-chips.com>
 <20160324064324.GG22062@vireshk-i7>
 <56F40328.5090001@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33932 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbcCYEmG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 00:42:06 -0400
Received: by mail-pf0-f169.google.com with SMTP id x3so74512960pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 21:42:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56F40328.5090001@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Finley Xiao <finley.xiao@rock-chips.com>
Cc: Feng Xiao <xf@rock-chips.com>, linux@arm.linux.org.uk, heiko@sntech.de, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.com

On 24-03-16, 23:09, Finley Xiao wrote:
> --- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
> +       cpufreq {
> +               compatible = "***,***";
> +       }
> 
> Does it create a DT node for a dummy device too ?

Yes, its not allowed.

-- 
viresh
