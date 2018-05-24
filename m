From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
Date: Thu, 24 May 2018 15:18:42 +0300
Message-ID: <3276b3e4-08c1-51d0-0aef-e349c3a77f07@gmail.com>
References: <20180522211420.2006-1-digetx@gmail.com>
 <20180523055817.subrv6oeckfecpcp@vireshk-i7>
 <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
 <2304436.qRMBXhMGsN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2304436.qRMBXhMGsN@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24.05.2018 12:36, Rafael J. Wysocki wrote:
> On Wednesday, May 23, 2018 11:30:39 AM CEST Dmitry Osipenko wrote:
>> On 23.05.2018 08:58, Viresh Kumar wrote:
>>> On 23-05-18, 00:14, Dmitry Osipenko wrote:
>>>> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
>>>> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
>>>> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
>>>> on the driver probe.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>
>>>> CPUFreq maintainers,
>>>>
>>>> Please take into account that this patch is made on top of my recent
>>>> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
>>>> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
>>>> the [0], including this patch into the series.
>>>>
>>>> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321
>>>
>>> This is already picked by Rafael and is sitting in pm/bleeding-edge
>>> branch. Should get merged into linux-next in a day or two.
>>
>> Neat, thank you for letting me know.
> 
> It actually is there in my linux-next branch, but linux-next proper is not
> taking new material this week AFAICS.

I've found it in yours git repo, thank you.

> You'll see this in linux-next on Monday, most probably.
> 

Yes, I noticed that linux-next stopped updating for awhile.
