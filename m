From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM64: dts: mt8173: Add CPU OPP, clock and
 regulator supply properties
Date: Mon, 28 Dec 2015 08:43:40 +0530
Message-ID: <20151228031340.GD3598@ubuntu>
References: <1451197318-12418-1-git-send-email-pi-cheng.chen@linaro.org>
 <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35736 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbL1DNn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 22:13:43 -0500
Received: by mail-pf0-f180.google.com with SMTP id 78so105393146pfw.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2015 19:13:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451197318-12418-4-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 27-12-15, 14:21, Pi-Cheng Chen wrote:
> Add operating-points-v2, clock, and regulator supply properties
> required by mt8173-cpufreq driver to enable it.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> This patch is based on the patch[1] that adds underlying clock MUX for
> MT8173 which is needed by mt8173-cpufreq driver but not yet picked.
> 
> [1] http://article.gmane.org/gmane.linux.kernel.clk/325
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 18 ++++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 90 +++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
