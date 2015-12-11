From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Fri, 11 Dec 2015 11:11:19 +0530
Message-ID: <20151211054119.GS3612@ubuntu>
References: <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu>
 <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu>
 <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu>
 <566A4E82.3040203@samsung.com>
 <20151211043802.GP3612@ubuntu>
 <566A56DF.5040001@osg.samsung.com>
 <566A5F0B.8040609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566A5F0B.8040609@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>
List-Id: linux-pm@vger.kernel.org

On 11-12-15, 14:28, Krzysztof Kozlowski wrote:
> Actually I think there is no nice way of making this as separate paths.
> As Javier's mentioned, there aren't many differences. Currently the CPU
> ordering is the only difference in DT.
> 
> Making it as separate path would create hierarchy like:
>  - exynos5420-based-board.dts
>    \- include: exynos5420.dtsi
>       \- include: exynos5.dtsi
>    \- include: exynos5420-cpu.dtsi (the cpus are not in exynos5420.dtsi)
> 
>  - exynos5422-based-board.dts
>    \- include: exynos5420.dtsi
>       \- include: exynos5.dtsi
>    \- include: exynos5422-cpu.dtsi (the cpus are not in exynos5420.dtsi)
> 
> which of course is okay... except we keep the definition of CPUs
> completely outside of main Exynos5420 DTSI. Then we have to include both
> DTSI for each new DTS.

So what? There isn't anything wrong in this case and is just the right
thing to do, IMHO. We have just kept the CPU devices separately,
simple.

-- 
viresh
