From: andi@etezian.org
Subject: Re: [RFC 01/10] ARM: dts: exynos: Remove Exynos5440
Date: Thu, 26 Apr 2018 13:31:11 +0900
Message-ID: <66d27b987846172e290cbc587b9909ac@etezian.org>
References: <20180424203239.21885-1-krzk@kernel.org>
 <20180424203239.21885-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180424203239.21885-2-krzk@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, linux-ide@vger.kernel.org, linux-i2c@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Olof Johansson <olof@lixom.net>, Zhang Rui <rui.zhang@intel.com>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Rob
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 25.04.2018 05:32, Krzysztof Kozlowski wrote:
> The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
> server platforms but it did not make it to the market really.  There 
> are
> no development boards with it and probably there are no real products
> neither.  The development for Exynos5440 ended in 2013 and since then
> the platform is in maintenance mode.
> 
> Remove all Device Tree sources for Exynos5440, as first step of removal
> of the platform to simplify the code and drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

makes sense, please feel free to add:

Reviewed-by: Andi Shyti <andi@etezian.org>

Thanks,
Andi
