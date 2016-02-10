From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: next-20160210 build: 2 failures 4 warnings (next-20160210)
Date: Wed, 10 Feb 2016 16:04:23 +0100
Message-ID: <16562444.Cferkf96V2@wuerfel>
References: <E1aTQoy-0005cH-Tr@optimist> <20160210095252.GS13270@sirena.org.uk> <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kernel-build-reports@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 February 2016 15:27:48 Rafael J. Wysocki wrote:
> On Wed, Feb 10, 2016 at 10:52 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Feb 10, 2016 at 09:12:25AM +0000, Build bot for Mark Brown wrote:
> >
> > Today's -next fails to build on non-SMP configurations due to:
> >
> >>       arm-multi_v5_defconfig
> >> ../drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
> >
> > caused by 0144fa03ef4606ae (cpufreq: governor: Replace timers with
> > utilization update callbacks).  IS_ENABLED() in an if statement doesn't
> > do a good job of making things conditional here since the code still has
> > to compile cleanly in both cases and there is no definition at all of
> > irq_work_queue_on() for !SMP.
> 
> Thanks for the report!
> 
> OK, I'll change it to #ifdef/#else then.
> 

I have a better idea, patch follows.

	Arnd
