From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
Date: Wed, 25 Jun 2014 09:36:40 +0200
Message-ID: <1403681800.19087.8.camel@AMDC1943>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
 <1402476643.32147.6.camel@AMDC1943> <539B7E74.7000605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <539B7E74.7000605@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kgene.kim@samsung.com, t.figa@samsung.com, ccross@google.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On sob, 2014-06-14 at 00:43 +0200, Daniel Lezcano wrote:
> On 06/11/2014 10:50 AM, Krzysztof Kozlowski wrote:
(...)
> >
> > Hi,
> >
> > Shouldn't the exynos_idle_barrier be initialized here?
> 
> As it is a static data it will be initialized to zero.
> 
> > I know you sent the patch almost 2 months ago but I stomped on this
> > while testing it on Exynos3250.
> 
> No problem. And what results on exynos3250 ?

I had to change some of the ways for synchronization two cores (boot
vector behaves differently) so actually the driver is different except
the general idea. As for the results (on dual-core Exynos3250) - the
mode (AFTR+CPU1 off) consumes about 5% less energy than idle-WFI state.

I expect there will be much more savings in deeper mode (called here
W-AFTR).

Best regards,
Krzysztof
