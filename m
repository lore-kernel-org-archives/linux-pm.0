From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
Date: Mon, 03 Aug 2015 12:47:57 +0200
Message-ID: <2295533.OBI6Q4a3b9@amdc1976>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <4532306.AVvo5hem3c@amdc1976> <20150803104044.GB21529@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150803104044.GB21529@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday, August 03, 2015 04:10:44 PM Viresh Kumar wrote:
> On 03-08-15, 12:36, Bartlomiej Zolnierkiewicz wrote:
> > I would really like it to be dependency not an option (+ I think
> > that ideally it should be checked at runtime, IOW we should be
> > checking from cpufreq-dt driver if the thermal support is enabled
> > before enabling boost support).
> 
> I don't think boost has any dependency on thermal support. Yeah, it
> may be true for your platform but we can't force it. People might have
> different algorithms to control boost modes, thermal is just one
> option they may look at. For few, enabling boost may not be a thermal
> issue, but power. So, they want to allow it only when they want, but
> that wouldn't burn their chip.

OK, I see your point (I have not thought about power being the boost
limitation previously).

> So, a platform can choose how it wants to have it. :)

I'll re-do this patch.  Thank you.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
