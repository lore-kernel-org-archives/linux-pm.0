From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] ARM: dts: Add CPU OPPs for Exynos4412 Prime
Date: Thu, 29 Dec 2016 16:06:20 +0100
Message-ID: <1840714.lHhVv9oNko@amdc3058>
References: <1483018611-27998-1-git-send-email-b.zolnierkie@samsung.com>
 <1483018611-27998-3-git-send-email-b.zolnierkie@samsung.com>
 <20161229144908.6gkvjpso7ikdmfp7@kozik-lap>
 <CGME20161229150623epcas1p2b2f0fbb6f9ddd11caffdc93487e2cf77@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20161229144908.6gkvjpso7ikdmfp7@kozik-lap>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, linux-clk@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Ben Gamari <ben@smart-cactus.org>, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Andreas Faerber <afaerber@suse.de>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Thursday, December 29, 2016 04:49:08 PM Krzysztof Kozlowski wrote:
> On Thu, Dec 29, 2016 at 02:36:51PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Add CPU operating points for Exynos4412 Prime (it supports
> > additional 1704MHz & 1600MHz OPPs and 1500MHz OPP is just
> > a regular non-turbo OPP on this SoC).  Also update relevant
> > cooling maps to account for new OPPs.
> > 
> > ODROID-X2/U2/U3 boards use Exynos4412 Prime SoC version so
> > update their board files accordingly.
> > 
> > Based on Hardkernel's kernel for ODROID-X2/U2/U3 boards.
> > 
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Andreas Faerber <afaerber@suse.de>
> > Cc: Thomas Abraham <thomas.ab@samsung.com>
> > Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > Cc: Ben Gamari <ben@smart-cactus.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 +--
> >  arch/arm/boot/dts/exynos4412-odroidu3.dts       |  5 +--
> >  arch/arm/boot/dts/exynos4412-odroidx2.dts       |  1 +
> >  arch/arm/boot/dts/exynos4412-prime.dtsi         | 41 +++++++++++++++++++++++++
> >  arch/arm/boot/dts/exynos4412.dtsi               |  2 +-
> >  5 files changed, 48 insertions(+), 5 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/exynos4412-prime.dtsi
> > 
> 
> Looks okay. Is the clock patch needed for this?

Yep.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
