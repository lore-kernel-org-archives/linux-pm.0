From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Mon, 16 Feb 2015 10:52:17 +0100
Message-ID: <20150216105217.79315ffd@amdc2363>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <CAMAWPa9fUJVjJ8V+93AkHy9DtEmUUnGs4MJDGcsoMdWwGmg5qg@mail.gmail.com>
 <CAJKOXPfyPH7tyce6YB=q4krSP078aJVAmqObg89qCnLrL_Nbhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJKOXPfyPH7tyce6YB=q4krSP078aJVAmqObg89qCnLrL_Nbhg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kevin Hilman <khilman@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof, Thomas,

> 2015-01-08 22:17 GMT+01:00 Kevin Hilman <khilman@kernel.org>:
> > On Fri, Nov 21, 2014 at 5:31 AM, Thomas Abraham
> > <thomas.ab@samsung.com> wrote:
> >> Changes since v11:
> >> - Rebased on top of git://linuxtv.org/snawrocki/samsung.git
> >> for-v3.19-exynos-clk
> >>
> >> This patch series removes the use of Exynos4210 and Exynos5250
> >> specific cpufreq drivers and enables the use of cpufreq-dt driver
> >> for these platforms. This series also enables cpufreq support for
> >> Exynos5420 using arm_big_little cpufreq driver.
> >>
> >> This series is based on the following branch.
> >> git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk
> >>
> >> This series depends on the following patch which can be picked from
> >> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> >> samsung/dt e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).
> >>
> >> This patch series has been tested on Exynos4210/5250/5420 based
> >> boards. Tomasz Figa had plans to take this in the Samsung clock
> >> tree for v3.19
> >> (http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
> >> Sylwester, could you consider to merge this in your tree?
> >
> > CPUfreq for exynos is still not upstream.  What's the status of this
> > series?  It's been ver a month since there's been any activity here
> > (or any responses to the issues I reported.)
> >
> > On a related note, this series only does frequency scaling. Is there
> > any work going on to also enable voltage scaling for the CPU rails
> > as well?
> 
> Hi Thomas,
> 
> Do you plan to continue with this work? It would be very helpful.

+1 from me.

> 
> I also wonder if Exynos 4412 could be re-added (without the boost if
> these bindings are not ready)?

I would prefer to have all platforms converted at once, since it might
happen that some parts of the work would get lost.

> 
> Best regards,
> Krzysztof

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
