From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
Date: Fri, 7 Aug 2015 10:48:26 +0530
Message-ID: <20150807051826.GJ6325@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org>
 <20150807035018.GF6325@linux>
 <20150807035156.GG6325@linux>
 <55C43085.8090506@samsung.com>
 <20150807043037.GH6325@linux>
 <55C43971.5010504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33879 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbbHGFTD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 01:19:03 -0400
Received: by pawu10 with SMTP id u10so79886703paw.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2015 22:19:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55C43971.5010504@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Michael Turquette' <mturquette@baylibre.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Javier Martinez Canillas' <javier@dowhile0.org>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, 'Anand Moon' <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 07-08-15, 13:52, Krzysztof Kozlowski wrote:
> Thanks for explanation. As fair as I understand, Bartlomiej wanted to
> merge this in a way which would avoid loosing the boost mode. Kukjin
> prepared topic branches for previous cpu-freq/clk stuff so maybe
> everything could go through PM?

We aren't loosing anything at all. There can be two cases here:

1. Patch 1/6 and 6/6 make it to 4.3 (with suggested changes) via PM tree:
- All will work fine in this case, no issues at all..

2. They don't make it:
- Even in this case, nothing will break. Users can just enable a
  config option and that's all..

So, no need to divert things into another tree this late.

Over that, Rafael will not be around for 2 weeks now (Plumbers and
other stuff) ..

So, just target the cpufreq core changes via PM tree.. rest is just
fine.

I hope that makes sense :)

-- 
viresh
