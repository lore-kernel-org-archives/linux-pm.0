From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Tue, 15 Jul 2014 13:00:30 +0200
Message-ID: <12227526.hKTn2dDzxP@amdc1032>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
 <CAD8Lp46mp-tHcwGpFd0YHRDE4pKWDoPpUvu-Y0QzxSi-jnYtWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD8Lp46mp-tHcwGpFd0YHRDE4pKWDoPpUvu-Y0QzxSi-jnYtWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 14, 2014 04:41:25 PM Daniel Drake wrote:
> Hi Bartlomiej,

Hi,

> On Wed, Jul 9, 2014 at 6:17 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > This patch series adds support for AFTR idle mode on boards with
> > secure firmware enabled and allows EXYNOS cpuidle driver usage on
> > Exynos4x12 SoCs.
> >
> > It has been tested on Trats2 board (using Exynos4412 SoC with secure
> > firmware enabled) on which AFTR mode reduces power consumption by ~12%
> > when EXYNOS cpuidle driver is enabled (in both cases the default
> > exynos_defconfig config is used and CPU1-3 are offlined).
> 
> Thanks for this, I have tested it on ODROID-U2.
> 
> I don't have any equipment to measure the power usage, but after
> offlining CPUs 1,2,3 via sysfs "online" file, a printk I added
> confirms that the system is going to enter aftr mode, and system
> stability seems as good as ever.

Thank you for testing!

> Is there any automatic way that the cpus should be offlined, or is the
> intention that it must be done "by hand" like this?

AFAIK Android kernel disables unused CPUs by itself.  There is also
ongoing work on Exynos coupled cpuidle driver for upstream kernels
which will handle offlining of CPUs for AFTR mode transparently to
the kernel (currently only Exynos4210 SoC is supported by the driver
posted by Daniel Lezcano, we are working on Exynos3250 SoC support
and once it is done we might try to also do Exynos4x12 SoCs version).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
