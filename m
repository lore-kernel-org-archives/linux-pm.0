From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] arm: dts: rk3229: add a new cpu opp table
Date: Wed, 17 May 2017 11:00:47 +0530
Message-ID: <20170517053047.GA17481@vireshk-i7>
References: <1494996323-4678-1-git-send-email-frank.wang@rock-chips.com>
 <1494996323-4678-4-git-send-email-frank.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35284 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdEQFax (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 01:30:53 -0400
Received: by mail-pg0-f54.google.com with SMTP id q125so1538255pgq.2
        for <linux-pm@vger.kernel.org>; Tue, 16 May 2017 22:30:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494996323-4678-4-git-send-email-frank.wang@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frank Wang <frank.wang@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, rjw@rjwysocki.net, rui.zhang@intel.com, edubezval@gmail.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, charles.chen@rock-chips.com, cody.xie@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, rocky.hao@rock-chips.com, finley.xiao@rock-chips.com, zhangqing@rock-chips.com, wmc@rock-chips.com

On 17-05-17, 12:45, Frank Wang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch adds some new frequencies for rk3229 board.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3229-cpu-opp.dtsi | 85 +++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3229-cpu-opp.dtsi

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
