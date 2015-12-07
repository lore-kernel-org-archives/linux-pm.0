From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] ARM64: dts: mt8173: Add CPU OPP, clock and regulator
 supply properties
Date: Mon, 7 Dec 2015 15:37:00 +0530
Message-ID: <20151207100700.GH3294@ubuntu>
References: <1449305584-414-1-git-send-email-pi-cheng.chen@linaro.org>
 <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36571 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686AbbLGKHE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 05:07:04 -0500
Received: by pacdm15 with SMTP id dm15so122816865pac.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 02:07:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449305584-414-3-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 05-12-15, 16:53, Pi-Cheng Chen wrote:
> +	cluster0_opp: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +		opp00 {

These have to named like: opp@50700000, look at linux-next for this.

-- 
viresh
