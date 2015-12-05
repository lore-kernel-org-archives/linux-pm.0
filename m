From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Sat, 5 Dec 2015 09:24:44 +0530
Message-ID: <20151205035444.GR3430@ubuntu>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04-12-15, 18:30, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds generic arm_big_little_dt cpufreq driver
> support for Exynos542x/5800 (using the new CPU clock type which
> allows it).  It also:
> - enhances arm_big_little[_dt] driver with CPU cluster regulator
>   support
> - adds CPU clock configuration data and CPU operating points
>   setup for Exynos542x/5800
> - adds CPU cluster regulator supplies for Exynos542x/5800 boards
> 
> This patch series has been tested on Exynos5422 based ODROID-XU3
> Lite board.
> 
> Please note that this is not a final version of the patchset.
> I just wanted to push out current work-in-progress patches that
> integrate changes from Anand, Ben and me.

What's going on guys, Ben tried exactly same thing few days back:

http://marc.info/?l=linux-kernel&m=144909193925508&w=2

And the comments given there applies to you as well.

-- 
viresh
