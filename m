From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [RFC 08/10] spi: s3c64xx: samsung: Remove support for
 Exynos5440
Date: Wed, 25 Apr 2018 14:49:41 +0200
Message-ID: <066e917b-7207-9c10-4d6c-07273c6f49d9@samsung.com>
References: <20180424203239.21885-1-krzk@kernel.org>
        <CGME20180424203409epcas2p45f55e5a5d211e78d4cadc3c4ffa5a9c0@epcas2p4.samsung.com>
        <20180424203239.21885-9-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180424203239.21885-9-krzk@kernel.org>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tejun Heo <tj@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Russell King <linux@armlinux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/24/2018 10:32 PM, Krzysztof Kozlowski wrote:
> The Exynos5440 is not actively developed, there are no development
> boards available and probably there are no real products with it.
> Remove wide-tree support for Exynos5440.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It's good you didn't remove S3C64XX_SPI_QUIRK_POLL entirely as it will
be needed for Exynos5433 ISP SPI controllers.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
