From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: mt8173: move resources allocation into
 ->probe()
Date: Sun, 6 Dec 2015 07:54:46 +0530
Message-ID: <20151206022446.GV3430@ubuntu>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
 <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36566 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbLFCYv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2015 21:24:51 -0500
Received: by pfdd184 with SMTP id d184so45939712pfd.3
        for <linux-pm@vger.kernel.org>; Sat, 05 Dec 2015 18:24:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Ricky Liang <jcliang@chromium.org>, linux-mediatek@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 05-12-15, 14:01, Pi-Cheng Chen wrote:
> Since the return value of ->init() of cpufreq driver is not propagated
> to the device driver model now, move resources allocation into
> ->probe() to handle -EPROBE_DEFER properly.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
> v1->v2:
> - fix error handling path in ->probe()

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
