From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Tue, 23 Jun 2015 07:35:05 +0530
Message-ID: <20150623020505.GA408@linux>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, rob.herring@linaro.org
Cc: Thomas Abraham <thomas.ab@samsung.com>, rjw@rjwysocki.net, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Bartlomiej,

[Adding Rafael & Rob to cc list. Please don't forget for any PM
specific patches :)]

First of all, really sorry for missing this mail thread. Don't know
how I missed it though. And please please please, do send a ping
reminder (to me at least), if you think the mail thread is
missed/ignored by the Maintainers.

Its been two months, and not a single reminder :).. And I wouldn't
have seen this email if you wouldn't have pinged me on IRC ..

On 10-04-15, 19:58, Bartlomiej Zolnierkiewicz wrote:
> This patch series removes the use of Exynos4x12 specific support
> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> for this platform.

Excellent.

> In order to preserve support for Exynos4x12 'boost' mode cpufreq-dt
> driver is made aware of 'boost' mode frequencies and boost-opps
> binding is provided.

That's good too..

> boost-opps binding is currently limited to cpufreq-dt but once there is
> a need for cpufreq wide and/or generic Linux device support for 'boost'
> mode cpufreq-dt can be updated to handle the new code without changing
> the binding itself.

You already know that operating-points-v2 bindings are already
accepted and applied by Rafael. Its not that the earlier bindings are
discarded or obsolete now, but are only present for simple use cases.

There are NO plans for extending the earlier OPP bindings Unless its
really required. And what you are trying to do in cpufreq-dt's
bindings, really belongs to OPP bindings.

As the new bindings will be present in 4.2, getting the code (at least
the basic code) for them into 4.3 wouldn't be that difficult. Anyway,
your stuff isn't going out in 4.2 either and so you *shall* adopt
to opp-v2 bindings in your next version.

Migrating platforms to opp-v2 wouldn't be that difficult, mostly
changes required only in dts files, unless you are using a driver of
your own.

I would be updating cpufreq-dt at the earlier to support basic
features of opp-v2 for 4.3. Some code is already posted:

http://permalink.gmane.org/gmane.linux.power-management.general/61326

-- 
viresh
