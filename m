From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] PM / Domains: Restrict "samsung,power-domain" checks to
 ARCH_EXYNOS
Date: Fri, 21 Oct 2016 16:14:56 +0200
Message-ID: <96efd5b7-5f62-8146-13de-44b5ff7dd496@samsung.com>
References: <1477049656-27535-1-git-send-email-geert+renesas@glider.be>
 <CAJZ5v0iOQyCwCuMBVcJjX1mMHFb=NkfXFf6yBNdswRw1HMYC=Q@mail.gmail.com>
 <CGME20161021135818eucas1p265318ff4b1c4c83b52162ee5e59e40a3@eucas1p2.samsung.com>
 <20161021135803.GB3289@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161021135803.GB3289@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, q@kozik-lap.samsung.com, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/21/2016 03:58 PM, Krzysztof Kozlowski wrote:
> The samsung,power-domain was made deprecated (although not explicitly)
> in January 2015 (0da658704136 ("ARM: dts: convert to generic power
> domain bindings for exynos DT")) so how about:
> 1. Printing a dev_warn() about usage of deprecated bindings.
> 2. Complete removal in January 2017?

I doubt anyone will ever use new mainline kernel with older dts/dtb
so IMHO it makes sense to queue a patch removing support for the
deprecated compatible just now and don't bother with a warning.

Documentation/devicetree/bindings/display/exynos/exynos7-decon.txt
arch/arm/boot/dts/exynos4415.dtsi
would just need to be updated in same release, I can prepare a patch
for these files.

--
Thanks,
Sylwester
