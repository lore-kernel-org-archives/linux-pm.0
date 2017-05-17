From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] arm: dts: rk322x: add operating-points-v2 property
 for cpu
Date: Wed, 17 May 2017 11:01:22 +0530
Message-ID: <20170517053122.GB17481@vireshk-i7>
References: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
 <1494996323-4678-3-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36377 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbdEQFbZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 01:31:25 -0400
Received: by mail-pg0-f46.google.com with SMTP id x64so1521557pgd.3
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 22:31:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494996323-4678-3-git-send-email-frank.wang@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, rui.zhang@intel.com, edubezval@gmail.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com

On 17-05-17, 12:45, Frank Wang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch adds a new opp table for cpu on rk322x SoC.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk322x.dtsi | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
