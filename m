From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 1/4] PM / Domains: Remove pm_genpd_dev_need_restore() API
Date: Wed, 01 Oct 2014 18:36:47 +0200
Message-ID: <542C2D9F.8060005@samsung.com>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1412174494-15346-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Beata Michalska <b.michalska@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 01/10/14 16:41, Ulf Hansson wrote:
> There are currently no users of this API, let's remove it.

The sad fact is that removal of pm_genpd_dev_need_restore() calls
from arch/arm/mach-exynos/pm_domains.c introduces regressions in
multiple exynos drivers (I'm sure it breaks media drivers).
I think before doing such changes all relevant drivers should be
updated first. I need to take a closer look again, but it seems
after dropping the pm_genpd_dev_need_restore() calls, client
driver's runtime_resume() callback is not being called in response
to first pm_runtime_get(_sync) call, even if a device is runtime
pm active.

More details can be found in commit ebc35c726298ba3fdebba316a
'ARM: EXYNOS: register devices in 'need_restore' state for pm_domains'.

The above only happens when devices are added to an inactive power
domain, then I guess patch 2/4 is also an attempt to address this
issue ?

--
Thanks,
Sylwester
