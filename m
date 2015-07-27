From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
Date: Mon, 27 Jul 2015 17:31:37 +0530
Message-ID: <20150727120137.GD10181@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <15810554.2OjPyuYJBt@amdc1976>
 <20150727113340.GA10181@linux>
 <2522396.6jWphaZxGp@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33618 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbG0MBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 08:01:45 -0400
Received: by padck2 with SMTP id ck2so50744354pad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 05:01:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2522396.6jWphaZxGp@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 27-07-15, 13:58, Bartlomiej Zolnierkiewicz wrote:
> Thank you.  This is exactly the case here (I would like to get
> Exynos4x12 conversion to use cpufreq-dt + exynos-cpufreq removal
> in v4.3 if possible and adding new DT bindings will most likely
> slow down the process considerably).

Heh, I never asked you to add new DT bindings, I said we can solve it
with DT. We already have turbo properties in DT.

-- 
viresh
