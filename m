From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Sat, 05 Dec 2015 08:49:49 +0100
Message-ID: <3776700.7KBsWa2Q4V@amdc1976>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
 <20151205035444.GR3430@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151205035444.GR3430@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Saturday, December 05, 2015 09:24:44 AM Viresh Kumar wrote:
> On 04-12-15, 18:30, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> > 
> > This patch series adds generic arm_big_little_dt cpufreq driver
> > support for Exynos542x/5800 (using the new CPU clock type which
> > allows it).  It also:
> > - enhances arm_big_little[_dt] driver with CPU cluster regulator
> >   support
> > - adds CPU clock configuration data and CPU operating points
> >   setup for Exynos542x/5800
> > - adds CPU cluster regulator supplies for Exynos542x/5800 boards
> > 
> > This patch series has been tested on Exynos5422 based ODROID-XU3
> > Lite board.
> > 
> > Please note that this is not a final version of the patchset.
> > I just wanted to push out current work-in-progress patches that
> > integrate changes from Anand, Ben and me.
> 
> What's going on guys, Ben tried exactly same thing few days back:
> 
> http://marc.info/?l=linux-kernel&m=144909193925508&w=2

Why I appreciate Ben's work this not exactly the same thing as
the above patchset lacks critical CLK_RECALC_NEW_RATES bugfix and
few other minor fixes.

> And the comments given there applies to you as well.

Yes, sure.  That's why I wrote that this is work-in-progress
and put the TODO in the cover letter.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
