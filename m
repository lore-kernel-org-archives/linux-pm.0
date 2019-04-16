From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 06/19] PM / devfreq: tegra: Fix missed error checking
 on devfreq initialization failure
Date: Tue, 16 Apr 2019 17:29:18 +0300
Message-ID: <7f187635-a42e-02cf-899f-996702602785@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145756epcas3p36a0597ca84dfbe079f9a453d8b28fea0@epcas3p3.samsung.com>
 <20190415145505.18397-7-digetx@gmail.com>
 <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b610cdf7-5ca7-0f29-f74d-fb7892796577@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

16.04.2019 5:32, Chanwoo Choi пишет:
> Hi,
> 
> patch6/7/8/9 are for handling of exception handling in probe() function.
> Actually, I'm not sure that there are special reason to split out
> the patches. I think that you can squash patch6/7/8/9 to only one patch.

Indeed, I was rebasing and reordering patches multiple times and looks like there is no reason not to squash these patches now.

> Also, even if patch6/7/8/9 handle the exception handling in probe(),
> the tegra_devfreq_probe() doesn't support the restoring sequence
> when fail happen. I think that if you want to fix the fail case of probe(),
> please add the restoring sequence about following function.
> - clk_disable_unprepare()
> - clk_notifier_unregister()
> - dev_pm_opp_remove()

When all of 6/7/8/9 patches are applied, the clk_notifier_register() becomes the last invocation of the probe function and clk_enable() is kept at the first place of the probe order. Hence the sequence you're suggesting is already incorrect because error-unwinding order usually should be opposite to the probe order. It looks to me that the current final result of these patches is already correct.
