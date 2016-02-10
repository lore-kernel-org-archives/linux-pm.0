From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: next-20160210 build: 2 failures 4 warnings (next-20160210)
Date: Wed, 10 Feb 2016 15:27:48 +0100
Message-ID: <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
References: <E1aTQoy-0005cH-Tr@optimist>
	<20160210095252.GS13270@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160210095252.GS13270@sirena.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kernel-build-reports@lists.linaro.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, linux-next@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2016 at 10:52 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Feb 10, 2016 at 09:12:25AM +0000, Build bot for Mark Brown wrote:
>
> Today's -next fails to build on non-SMP configurations due to:
>
>>       arm-multi_v5_defconfig
>> ../drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
>
> caused by 0144fa03ef4606ae (cpufreq: governor: Replace timers with
> utilization update callbacks).  IS_ENABLED() in an if statement doesn't
> do a good job of making things conditional here since the code still has
> to compile cleanly in both cases and there is no definition at all of
> irq_work_queue_on() for !SMP.

Thanks for the report!

OK, I'll change it to #ifdef/#else then.

Thanks,
Rafael
