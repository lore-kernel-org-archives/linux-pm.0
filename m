From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: exynos4x12: Use the common clock framework to
 set APLL clock rate
Date: Wed, 25 Sep 2013 16:03:22 +0200
Message-ID: <3068635.myUg9qMyJN@amdc1227>
References: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
 <1380108138-30402-2-git-send-email-l.majewski@samsung.com>
 <CAKew6eW9-QHL5NKHV8roER_yuoLEiCoS53Gby8zC841fr=whqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKew6eW9-QHL5NKHV8roER_yuoLEiCoS53Gby8zC841fr=whqQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Yadwinder Singh Brar <yadi.brar01@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Yadwinder,

[resending in plain text, as my mail client somehow reset message 
format from plain back to HTML...]

On Wednesday 25 of September 2013 19:25:54 Yadwinder Singh Brar wrote:
> Hi Lukasz,
> 
> On Wed, Sep 25, 2013 at 4:52 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > In the exynos4x12_set_apll() function, the APLL frequency is set with
> > direct register manipulation.
> >
> > Such approach is not allowed in the common clock framework. The frequency
> > is changed, but the corresponding clock value is not updated. This causes
> > wrong frequency read from cpufreq's cpuinfo_cur_freq sysfs attribute.
> >
> 
> This patch looks incomplete, leaving the driver in untidy state, perhaps its
> doesn't fix the above stated problem completely. what about
> if (!exynos4x12_pms_change(old_index, new_index)) becomes true?
> 
> IMHO, this driver needs lot more work in addition to this patch to cleanly and
> completely move the cpufreq driver to common clock framework.

I agree that the other case needs to be handled as well. Basically the
whole conditional block dependent on exynos4x12_pms_change() can be safely
dropped, because this condition is already handled in PLL driver.

Lukasz is already working on further rework of this driver to clean it up
from legacy code, but this will have to wait for 3.13, as 3.12 is already
in rc stage and only fixes can be accepted for it.

> For fixing this issue urgently, setting CLK_GET_RATE_NOCACHE for apll
> in clk driver can also be quicker fix.

Unfortunately this is not how this flag works. It only makes
clk_get_rate() call ->recalc_rate() operation of the clock instead of
instantly returning cached rate - it doesn't seem to work recursively.

Best regards,
Tomasz
