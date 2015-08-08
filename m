From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq-dt: make scaling_boost_freqs sysfs attr
 available when boost is enabled
Date: Sat, 8 Aug 2015 07:39:00 +0530
Message-ID: <20150808020900.GN6939@linux>
References: <2130756.euuUs9t9I5@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34127 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946746AbbHHCJH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 22:09:07 -0400
Received: by pawu10 with SMTP id u10so100151548paw.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 19:09:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2130756.euuUs9t9I5@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On 07-08-15, 13:59, Bartlomiej Zolnierkiewicz wrote:
> Make scaling_boost_freqs sysfs attribute is available when
> cpufreq-dt driver is used and boost support is enabled.
> 
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2: Removed leftover prototype.
> v3: added missing Acked-by
> Sorry for two resends, this is not my day..
> Rafael, please apply for v4.3.

Yeah, please apply only this patch from the series.

-- 
viresh
