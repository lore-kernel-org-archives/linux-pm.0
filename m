From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 0/6] cpufreq: use generic cpufreq drivers
 forExynos4210platform
Date: Thu, 18 Jun 2015 19:55:07 +0200
Message-ID: <23922424.tdDENuLLcb@amdc1976>
References: <'@samsung.com> <556F8C1D.9050906@kernel.org>
 <1705390.i4bNz9zR7Y@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1705390.i4bNz9zR7Y@amdc1976>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 18, 2015 07:53:14 PM Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Mike, could you please take a look at patches #1 and #2 (#1 is a 4 line
> change to a Common Clock Framework and #2 is ARM Exynos specific)?

Oh, and patch #3 (which is also ARM Exynos specific).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> This series has been waiting on your feedback since 3rd of April. :(
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> On Thursday, June 04, 2015 08:22:05 AM Kukjin Kim wrote:
> > On 05/14/15 22:07, Kukjin Kim wrote:
> > > On 05/14/15 14:10, Viresh Kumar wrote:
> > >> On 14-05-15, 13:07, Kukjin Kim wrote:
> > >>> On 05/13/15 23:08, Bartlomiej Zolnierkiewicz wrote:
> > >>>>
> > >>>> Hi,
> > >>>>
> > >>> Hi Bart,
> > >>>
> > >>>> On Friday, April 03, 2015 06:43:43 PM Bartlomiej Zolnierkiewicz wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> This patch series removes the use of Exynos4210 specific support
> > >>>>> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
> > >>>>> for this platform.
> > >>>>
> > >>>> Gentle Ping.  Mike/Kukjin/Viresh could you please review/ack relevant
> > >>>> patches (patches #1-3 are for clock subsystem, patches #4-5 for Exynos
> > >>>> mach/dts and patch #6 is for cpufreq subsystem)?
> > >>
> > >> Sorry I thought I already Acked an older version of this set and so
> > >> didn't went for it again. Done now.
> > >>
> > >>> Yes, I totally agreed with this patches for arch side changes and this
> > >>> approach when Thomas posted.
> > >>>
> > >>>> Also what is your
> > >>>> preferred way to upstream them (patches are not independent so it would
> > >>>> be best to merge them through one tree, otherwise synchronization of
> > >>>> git pulls between different subsystem trees will be needed)?
> > >>>>
> > >>> I can provide topic branch for arch side changes even it is small. I
> > >>> think once Viresh and Mike make each topic branch based on -rc or the
> > >>> smallest changes from each subsystem then I could handle this series or
> > >>> Viresh or Mike need to handle this series with merging each topic
> > >>> branches in subsystem. I'm fine either way.
> > >>>
> > >>> Viresh and Mike, how do you think about that?
> > >>
> > >> For cpufreq subsystem changes, you can take them in your tree.
> > >>
> > > Hi Viresh, OK, I will take the cpufreq changes with your ack. Thanks for
> > > your confirmation.
> > > 
> > > Hi Mike and Sylwester,
> > > How can we handle this series well without any problems? hmm...
> > > 
> > Still I need to get clock guys' ack or any comments on this series...
> > 
> > - Kukjin
> > 
> > >>>> I'm still hoping that this patchset will make it into v4.2 as there are
> > >>>> no known issues with it (except minor coding nit for patch #5)...
> > >>>>
> > >>> Sure, why not :-)
