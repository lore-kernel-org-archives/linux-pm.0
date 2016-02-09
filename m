From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement
 init_cpu_capacity_default()
Date: Tue, 9 Feb 2016 15:54:50 +0000
Message-ID: <56BA0BCA.6090903@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
 <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
 <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw@mail.gmail.com>
 <20160204121620.GB29586@e106622-lin>
 <CAKfTPtDVasamRtG2kLxP0HsohmVQTPrXRgx36e+jb3gozDoo6g@mail.gmail.com>
 <20160204141345.GD29586@e106622-lin>
 <CAKfTPtDWP-AgqXsSuxCfVj33dh+i7oqDTkL=gUy7n-AB1anoow@mail.gmail.com>
 <CAKfTPtD4jTmUZoShGBm3oAFywizjp8jsEukmkeZU+x+zk-KZRA@mail.gmail.com>
 <20160205093040.GG29586@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41227 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbcBIPyy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Feb 2016 10:54:54 -0500
In-Reply-To: <20160205093040.GG29586@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 05/02/16 09:30, Juri Lelli wrote:
> On 04/02/16 16:46, Vincent Guittot wrote:
>> On 4 February 2016 at 16:44, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>> On 4 February 2016 at 15:13, Juri Lelli <juri.lelli@arm.com> wrote:
>>>> On 04/02/16 13:35, Vincent Guittot wrote:
>>>>> On 4 February 2016 at 13:16, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>>> Hi Vincent,
>>>>>>
>>>>>> On 04/02/16 13:03, Vincent Guittot wrote:
>>>>>>> On 4 February 2016 at 10:36, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>>>>>>>> On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
>>>>>>>>> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

>>>
>>> AFAICT, They don't have a dedicated cpufreq driver.
>>>
>>> More generally speaking, it can take time before having
>>
>> email sent before the ne d of the sentence ...
>>
>> More generally speaking, it can take time before having a cpufreq
>> driver whereas we want to run and test scheduler behavior of these
>> heterogenous platform
>>
> 
> I'm not familiar with this platform, but from what you are saying and
> what I could find online, it looks like full Linux support is not
> finished yet. Can we consider that as still in development? And if we
> can do that, maybe is fair enough that we use the sysfs interface to
> play with that platform until support is complete.
> 
> Do others have any opinion on this point?

IMHO, the solution should work for all of heterogeneous systems, (a) w/
cpufreq and driver, (b) w/ cpufreq and no driver loaded (yet) or (c) w/o
cpufreq.

That means that you can't put the benchmarking only into
cpufreq_register_driver() and rely on cpufreq policy topology.

Maybe you could do this for (b) and (c) inside an initcall and use
topology_core_cpumask() to figure out which cpu to profile?

This would then happen w/ the cpu frequency set by the fw.

But this then has to be synchronized somehow with the benchmarking
approach in cpufreq_register_driver().

[...]
