From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v3 0/6] ARM: berlin: add cpufreq support
Date: Sun, 20 Sep 2015 20:23:19 +0200
Message-ID: <55FEF997.8030002@gmail.com>
References: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442484905-15656-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17.09.2015 12:14, Antoine Tenart wrote:
> This series adds the cpufreq support to the Berlin SoCs, using
> cpufreq-dt.
[...]
> Antoine Tenart (6):
>    clk: berlin: move MAX_CLKS out of drivers/clk/berlin
>    clk: berlin: add cpuclk
>    ARM: berlin: dts: add the cpufreq-dt bindings on the BG2Q
>    ARM: berlin: dts: add the cpufreq-dt bindings on the BG2
>    ARM: berlin: dts: add the cpufreq-dt bindings on the BG2CD
>    ARM: berlin: register cpufreq-dt

Applied 1, 2 with Mike's and Stephen's Acked-by to berlin/driver.

Applied 3, 4, 5 to berlin/dt.

Applied 6 to berlin/driver again.

Sebastian

>   arch/arm/boot/dts/berlin2.dtsi       | 10 ++++++++++
>   arch/arm/boot/dts/berlin2cd.dtsi     |  8 ++++++++
>   arch/arm/boot/dts/berlin2q.dtsi      | 11 +++++++++++
>   arch/arm/mach-berlin/berlin.c        |  6 ++++++
>   drivers/clk/berlin/bg2.c             |  1 -
>   drivers/clk/berlin/bg2q.c            | 13 ++++++-------
>   include/dt-bindings/clock/berlin2.h  |  2 ++
>   include/dt-bindings/clock/berlin2q.h |  3 +++
>   8 files changed, 46 insertions(+), 8 deletions(-)
>
