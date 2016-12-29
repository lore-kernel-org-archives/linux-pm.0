From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add CPU OPPs for Exynos4412 Prime
Date: Thu, 29 Dec 2016 17:23:34 +0100
Message-ID: <6892749a-a8bd-cfb3-551c-f0b1ca6d2b84@samsung.com>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
 <20161229144908.6gkvjpso7ikdmfp7@kozik-lap>
 <CGME20161229150623epcas1p2b2f0fbb6f9ddd11caffdc93487e2cf77@epcas1p2.samsung.com>
 <1840714.lHhVv9oNko@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1840714.lHhVv9oNko@amdc3058>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Ben Gamari <ben@smart-cactus.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/29/2016 04:06 PM, Bartlomiej Zolnierkiewicz wrote:
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
>>>  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
>>>  arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
>>>  arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
>>>  arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
>>>  5 files changed, 48 insertions(+), 5 deletions(-)
>>>  create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
>>>
>> Looks okay. Is the clock patch needed for this?
> Yep.

I applied the clock patch and here is a stable tag if it needs
to be pulled as a dependency.


The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://linuxtv.org/snawrocki/samsung.git tags/clk-v4.11-exynos4-pll

for you to fetch changes up to c369596f895be88d09f4165b223fa31c64aaefd4:

  clk: samsung: Add CPU clk configuration data for Exynos4412 Prime (2016-12-29
16:34:06 +0100)

----------------------------------------------------------------
Addition of the CPU clock configuration data for Exynos4412
Prime SoC variant.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      clk: samsung: Add CPU clk configuration data for Exynos4412 Prime

 drivers/clk/samsung/clk-exynos4.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Regards,
Sylwester
