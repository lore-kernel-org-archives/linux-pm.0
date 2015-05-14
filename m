From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4210platform
Date: Thu, 14 May 2015 10:40:46 +0530
Message-ID: <20150514051046.GB9887@linux>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <2036292.PZC6aPyUyX@amdc1976>
 <55541F92.4020404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55541F92.4020404@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-05-15, 13:07, Kukjin Kim wrote:
> On 05/13/15 23:08, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> Hi Bart,
> 
> > On Friday, April 03, 2015 06:43:43 PM Bartlomiej Zolnierkiewicz wrote:
> >> Hi,
> >>
> >> This patch series removes the use of Exynos4210 specific support
> >> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> >> for this platform.
> > 
> > Gentle Ping.  Mike/Kukjin/Viresh could you please review/ack relevant
> > patches (patches #1-3 are for clock subsystem, patches #4-5 for Exynos
> > mach/dts and patch #6 is for cpufreq subsystem)?

Sorry I thought I already Acked an older version of this set and so
didn't went for it again. Done now.

> Yes, I totally agreed with this patches for arch side changes and this
> approach when Thomas posted.
> 
> > Also what is your
> > preferred way to upstream them (patches are not independent so it would
> > be best to merge them through one tree, otherwise synchronization of
> > git pulls between different subsystem trees will be needed)?
> > 
> I can provide topic branch for arch side changes even it is small. I
> think once Viresh and Mike make each topic branch based on -rc or the
> smallest changes from each subsystem then I could handle this series or
> Viresh or Mike need to handle this series with merging each topic
> branches in subsystem. I'm fine either way.
> 
> Viresh and Mike, how do you think about that?

For cpufreq subsystem changes, you can take them in your tree.

> > I'm still hoping that this patchset will make it into v4.2 as there are
> > no known issues with it (except minor coding nit for patch #5)...
> > 
> Sure, why not :-)

One thing that looked wrong to me is the email id of Thomas..
I believe he has already left Samsung and his id wouldn't exist
anymore. Right ?

Then I wouldn't recommend something that doesn't exist to get merged
now. Probably use another email id of his.
