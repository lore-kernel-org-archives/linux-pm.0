From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v4 7/8] ARM: dts: Exynos5422: fix OPP tables
Date: Thu, 10 Dec 2015 16:57:22 +0100
Message-ID: <2192451.zF6EhNeeQc@amdc1976>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
 <1449512300-17230-8-git-send-email-b.zolnierkie@samsung.com>
 <56669126.7050803@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <56669126.7050803@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Tuesday, December 08, 2015 05:13:26 PM Krzysztof Kozlowski wrote:
> On 08.12.2015 03:18, Bartlomiej Zolnierkiewicz wrote:
> > From: Ben Gamari <ben@smart-cactus.org>
> > 
> > The Exynos 5422 is identical to the 5800 except for the fact that it
> > boots from the A7 cores. Consequently, the core numbering is different:
> > cores 0-3 are A7s whereas 4-7 are A15s.
> > 
> > We can reuse the device tree of the 5800 for the 5422 but we must take
> > care to override the OPP tables and CPU clocks.  These are otherwise
> > inherited from the exynos5800 devicetree, which has the CPU clusters
> > reversed compared to the 5422. This results in the A15 cores only
> > reaching 1.4GHz, the maximum rate of the KFC clock.
> > 
> > Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5422-cpus.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> 
> This looks like a very-non-atomic way of handling a change. You added
> opp tables to exynos5420 before so at that time they will be applied to
> Odroid XU3 family which uses different CPU order. After that you are
> fixing the tables to proper CPU order. Direct bisectability probably
> won't be an issue because all of DTS would go to separate branch... but
> the logic behind confuses.

It was done this way to preserve original authorship of changes and
bisectability should not be affected unless patch #8 is merged before
patch #7.

> I think this should be squashed into 3/8.

OK.

> Best regards,
> Krzysztof

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
