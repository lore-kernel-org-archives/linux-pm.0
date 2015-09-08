From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Tue, 8 Sep 2015 10:40:53 +0530
Message-ID: <20150908051053.GA18554@linux>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux>
 <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux>
 <55EE6892.3010304@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36578 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbbIHFLK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 01:11:10 -0400
Received: by padhk3 with SMTP id hk3so28611934pad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 22:11:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55EE6892.3010304@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 08-09-15, 13:48, Krzysztof Kozlowski wrote:
> Somehow my mind stuck on solving Exynos4x12 cpufreq issues.
> 
> Right, it should go through Rafael's, probably except DTS patch (4/4)
> because it depends on previous DTS changes. These changes are still in
> arm-soc, not in Linus' tree [0].

That's bad :(

Anyway, 4/4 is kind of independent to this series, in the sense that
it wouldn't harm even if it gets applied separately.

So, go ahead and apply 4/4 to Samsung's tree and rest of this can be
picked by Rafael.

-- 
viresh
