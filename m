From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
Date: Tue, 18 Jun 2013 15:02:52 +0200
Message-ID: <201306181502.52589.arnd@arndb.de>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com> <201306172159.15352.arnd@arndb.de> <51BF9D0A.6050706@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <51BF9D0A.6050706@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Tomasz Figa <t.figa@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 18 June 2013, Eduardo Valentin wrote:
> The driver will work on supported exynos variants. Those that have the
> need for thermal sensing. And each of them have specific thermal needs
> (trigger points, thresholds, etc). That is what this file tries to
> isolate. And there is specific data structures for each soc version.

Correct. My point is that the driver itself is much larger than the
SoC-specific data sets in it. There is no reason to conditionally
build a 108 byte data structure, making it more maintainably by removing
all the #ifdef far outweighs the cost.

You can also change the driver to work only for DT based booting,
that will simplify it further and save you more in terms of object
code size than the exynos_tmu_platform_data instances.

	Arnd
