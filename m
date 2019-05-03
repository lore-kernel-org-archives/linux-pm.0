From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Fri, 3 May 2019 13:19:08 +0200
Message-ID: <CAJKOXPeOnrgnX=onMeX1izS2kYKAkD8TvFVykYTyW-v4NOv3vA@mail.gmail.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, georgi.djakov@linaro.org, mturquette@baylibre.com, ptitiano@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com, ccaione@baylibre.com, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Mar 2019 at 20:35, Alexandre Bailon <abailon@baylibre.com> wrote:
>
> This series implements busfreq, a framework used in MXP's
> tree to scale the interconnect and dram frequencies.
> In the vendor tree, device's driver request for a
> performance level, which is used to scale the frequencies.
> This series implements it using the interconnect framework.
> Devices' driver request for bandwidth which is use by busfreq
> to determine a performance level, and then scale the frequency.
>
> Busfreq is quite generic. It could be used for any i.MX SoC.
> A busfreq platform driver just have to define a list of
> interconnect nodes, and some OPPs.
>
> This series is sent as RFC mostly because the current support
> of i.MX SoC won't benefit of busfreq framework, because the
> clocks' driver don't support interconnect / dram frequency
> scaling.
> As exemple, this series implements busfreq for i.MX8MM whose
> upstreaming is in progress. Because this relies on ATF to
> do the frequency scaling, it won't be hard make it work.
>
> As exemple, this series implements busfreq for
> Alexandre Bailon (3):
>   drivers: interconnect: Add a driver for i.MX SoC
>   drivers: interconnect: imx: Add support of i.MX8MM
>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings

Hi Alexandre,

I am quite late but I just found your email.

This looks very similar to existing framework - devfreq, which purpose
is to scale the system busses based on performance counters/events. It
would be nice if we could avoid duplication of existing subsystems.

Best regards,
Krzysztof
