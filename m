From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 2/2] cpufreq: tegra20: Use PLL_C as intermediate clock
 source
Date: Thu, 24 May 2018 15:49:22 +0300
Message-ID: <e6ee8116-7f73-fa7a-3df4-b17ccd8dcb0e@gmail.com>
References: <20180523160020.15291-1-digetx@gmail.com>
 <20180523160020.15291-2-digetx@gmail.com>
 <20180524100413.GL6835@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524100413.GL6835@tbergstrom-lnx.Nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24.05.2018 13:04, Peter De Schrijver wrote:
> On Wed, May 23, 2018 at 07:00:20PM +0300, Dmitry Osipenko wrote:
>> PLL_C is running at 600MHz which is significantly higher than the 216MHz
>> of the PLL_P and it is known that PLL_C is always-ON because AHB BUS is
>> running on that PLL. Let's use PLL_C as intermediate clock source, making
>> CPU snappier a tad during of the frequency transition.
>>
> 
> pll_c isn't necessarily 600Mhz when used as a source for the second display
> head.

Hmm, indeed.

Even if PLL_C rate will be adjusted, it will be higher than the PLL_P.. won't
it? That's likely to be good enough.

Do you know if any of the available CCLK parents has a glitch-less rate
switching? I.e. CPU won't hang on the rate switch.

There is other possible 600MHz source, the PLL_M. Can we use it? This one also
may become dynamic if we'll consider implementing the memory scaling, but the
memory frequency probably will fit the transition role pretty well.
