From: Kukjin Kim <kgene@kernel.org>
Subject: Re: [PATCH 0/6] cpufreq: use generic cpufreq drivers forExynos4210platform
Date: Thu, 04 Jun 2015 08:22:05 +0900
Message-ID: <556F8C1D.9050906@kernel.org>
References: <'@samsung.com> <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com> <2036292.PZC6aPyUyX@amdc1976> <55541F92.4020404@kernel.org> <20150514051046.GB9887@linux> <55549E03.6040105@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55549E03.6040105@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, linux-arm-kernel@lists.infradead.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/14/15 22:07, Kukjin Kim wrote:
> On 05/14/15 14:10, Viresh Kumar wrote:
>> On 14-05-15, 13:07, Kukjin Kim wrote:
>>> On 05/13/15 23:08, Bartlomiej Zolnierkiewicz wrote:
>>>>
>>>> Hi,
>>>>
>>> Hi Bart,
>>>
>>>> On Friday, April 03, 2015 06:43:43 PM Bartlomiej Zolnierkiewicz wrote:
>>>>> Hi,
>>>>>
>>>>> This patch series removes the use of Exynos4210 specific support
>>>>> from cpufreq-exynos driver and enables the use of cpufreq-dt driver
>>>>> for this platform.
>>>>
>>>> Gentle Ping.  Mike/Kukjin/Viresh could you please review/ack relevant
>>>> patches (patches #1-3 are for clock subsystem, patches #4-5 for Exynos
>>>> mach/dts and patch #6 is for cpufreq subsystem)?
>>
>> Sorry I thought I already Acked an older version of this set and so
>> didn't went for it again. Done now.
>>
>>> Yes, I totally agreed with this patches for arch side changes and this
>>> approach when Thomas posted.
>>>
>>>> Also what is your
>>>> preferred way to upstream them (patches are not independent so it would
>>>> be best to merge them through one tree, otherwise synchronization of
>>>> git pulls between different subsystem trees will be needed)?
>>>>
>>> I can provide topic branch for arch side changes even it is small. I
>>> think once Viresh and Mike make each topic branch based on -rc or the
>>> smallest changes from each subsystem then I could handle this series or
>>> Viresh or Mike need to handle this series with merging each topic
>>> branches in subsystem. I'm fine either way.
>>>
>>> Viresh and Mike, how do you think about that?
>>
>> For cpufreq subsystem changes, you can take them in your tree.
>>
> Hi Viresh, OK, I will take the cpufreq changes with your ack. Thanks for
> your confirmation.
> 
> Hi Mike and Sylwester,
> How can we handle this series well without any problems? hmm...
> 
Still I need to get clock guys' ack or any comments on this series...

- Kukjin

>>>> I'm still hoping that this patchset will make it into v4.2 as there are
>>>> no known issues with it (except minor coding nit for patch #5)...
>>>>
>>> Sure, why not :-)
