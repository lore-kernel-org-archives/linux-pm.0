From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V4 00/20] Tegra210 DFLL support
Date: Fri, 1 Feb 2019 10:49:38 +0800
Message-ID: <a2cf3ccd-658a-e004-1e66-d4f9cf1026f1@nvidia.com>
References: <20190104030702.8684-1-josephl@nvidia.com>
 <20190125134617.GE22565@ulmo>
 <0a7abeee-1b78-4f90-e94f-43c19eddb9b1@nvidia.com>
 <20190128075442.GA18124@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190128075442.GA18124@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 1/28/19 3:54 PM, Thierry Reding wrote:
> On Mon, Jan 28, 2019 at 09:43:00AM +0800, Joseph Lo wrote:
>> On 1/25/19 9:46 PM, Thierry Reding wrote:
>>> On Fri, Jan 04, 2019 at 11:06:42AM +0800, Joseph Lo wrote:
>>>> This series introduces support for the DFLL as a CPU clock source
>>>> on Tegra210. As Jetson TX1 uses a PWM controlled regulator IC which
>>>> is driven directly by the DFLLs PWM output, we also introduce support
>>>> for PWM regulators next to I2C controlled regulators. The DFLL output
>>>> frequency is directly controlled by the regulator voltage. The registers
>>>> for controlling the PWM are part of the DFLL IP block, so there's no
>>>> separate linux regulator object involved because the regulator IC only
>>>> supplies the rail powering the CPUs. It doesn't have any other controls.
[snip]
>>> Joseph,
>>>
>>> can you detail the dependencies between the various patches. From a
>>> brief look the CPU frequency driver changes are completely separate
>>> bits and it should be possible to apply them to the cpufreq tree.
>>>
>>> The clock changes also seem independent of the rest.
>>>
>>> Are there any dependencies at all that we need to be mindful about?
>>> Or can individual maintainers just pick up the subseries directly?
>>>
>>
>> Yes, no dependence with each other. We can apply them separately.
>> Please let me know if I need to inform cpufreq or clk maintainer to pick
>> them up.
> 
> Rafael,
> 
> the three CPU frequency patches in this series were acked by Viresh
> already, but unfortunately you don't seem to be Cc'ed on these. Are
> you okay with me picking these up into the Tegra tree and send you
> a pull request in a couple of days? That way we can get the whole
> set tested a bit in linux-next. If you'd prefer to pick these up in
> the PM tree, here are the corresponding patchwork links:
> 
> 	https://patchwork.kernel.org/patch/10747943/
> 	https://patchwork.kernel.org/patch/10747947/
> 	https://patchwork.kernel.org/patch/10747953/
> 
> I'll go and give my Acked-by on these patches if the latter is the
> way you prefer.
> 
> 
> Stephen, Mike,
> 
> the same applies for clk patches. Stephen's acked all of them and I
> think all of the series is good to go. How about if I pick up these
> up in the Tegra tree and let this all cook in linux-next for a week
> or so and then send you a pull request with these? Stephen already
> picked up a couple of fixes for clk/tegra, but I don't think any of
> those would conflict with this series.
> 
> All of that said, Joseph confirmed that there are no dependencies
> between these subsystem subseries, so if you'd prefer to pick up the
> patches into your respective trees, I have no objections to that.
> 
> Thierry
> 

Hi Rafael, Stephen,

Gental ping. Please let Thierry know if the cpufreq and DFLL clock 
related changes can go through Tegra tree.

I know Rafael did say [1] it's okay to go through Tegra tree in earlier 
comment.

Thanks,
Joseph

[1]: http://patchwork.ozlabs.org/patch/1015181/
