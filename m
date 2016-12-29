From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/2] ARM: add Exynos4412 Prime SoC support
Date: Thu, 29 Dec 2016 14:36:49 +0100
Message-ID: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20161229133722epcas5p1e138af585fea93a42962f3a7414a081f@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Thomas Abraham <thomas.ab@samsung.com>, Andreas Faerber <afaerber@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset adds support for Exynos4412 Prime SoC (it supports
additional 1704MHz & 1600MHz CPU OPPs and 1500MHz CPU OPP is just
a regular non-turbo OPP on this SoC).

ODROID-X2/U2/U3 boards use Exynos4412 Prime SoC version so their
board files are updated accordingly.

This patchset brings 21% CPU performance increase on affected
boards (as tested on ODROID-U3 board).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (2):
  clk: samsung: exynos4412: add cpu clock configuration data for
    Exynos4412 Prime
  ARM: dts: Add CPU OPPs for Exynos4412 Prime

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
 arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
 arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
 drivers/clk/samsung/clk-exynos4.c               |  4 +++
 6 files changed, 52 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi

-- 
1.9.1
