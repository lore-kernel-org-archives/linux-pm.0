From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 15/19] PM / devfreq: tegra: Synchronize IRQ after
 masking it in hardware
Date: Tue, 16 Apr 2019 18:42:39 +0300
Message-ID: <a9e02e2e-ec93-53fd-5b50-b8566b7d3abb@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145717epcas4p1647551d3a4c7bb2a0d9698707fa03f43@epcas4p1.samsung.com>
 <20190415145505.18397-16-digetx@gmail.com>
 <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81db3a75-2d17-5268-fea5-8b6ed650056f@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

16.04.2019 10:41, Chanwoo Choi пишет:
> Hi,
> 
> In this patchset,
> the patch11 adds new 'disable_interrupt' goto statement
> and then patch15 removes 'disable_interrupt' goto statement again.
> Actually, it is inefficient.
> 
> If you change the order of patches,
> you could remove this stuff.

Okay, I'll change that in v3. Thanks.
