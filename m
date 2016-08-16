From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/7] cpufreq: dt: Add exynos5433 compatible to use
 generic cpufreq driver
Date: Tue, 16 Aug 2016 14:19:03 +0530
Message-ID: <20160816084903.GC21099@ubuntu>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-4-git-send-email-cw00.choi@samsung.com>
 <1476eab3-48e2-2894-cc2a-e5a201b107cf@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476eab3-48e2-2894-cc2a-e5a201b107cf@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org, jh80.chung@samsung.com, sw0312.kim@samsung.com, jy0922.shim@samsung.com, inki.dae@samsung.com, jonghwa3.lee@samsung.com, beomho.seo@samsung.com, jaewon02.kim@samsung.com, human.hwang@samsung.com, ideal.song@samsung.com, ingi2.kim@samsung.com, m.szyprowski@samsung.com, a.hajda@samsung.com, s.nawrocki@samsung.com, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-08-16, 09:47, Krzysztof Kozlowski wrote:
> On 08/16/2016 08:27 AM, Chanwoo Choi wrote:
> > This patch adds the exynos5433 compatible string for supporting
> > the generic cpufreq driver on Exynos5433.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> I guess this does not depend on the rest and can go through PM/cpufreq tree?
> 
> Viresh, Rafael,
> If you wish me to take it, let me know.

I will prefer it going through PM tree.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
