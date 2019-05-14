From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Date: Tue, 14 May 2019 09:33:32 +0300
Message-ID: <8f757d89-5df2-04e4-b1cf-e6d8971a8881@linaro.org>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAJKOXPeOnrgnX=onMeX1izS2kYKAkD8TvFVykYTyW-v4NOv3vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPeOnrgnX=onMeX1izS2kYKAkD8TvFVykYTyW-v4NOv3vA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Bailon <abailon@baylibre.com>
Cc: linux-pm@vger.kernel.org, mturquette@baylibre.com, ptitiano@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zening.wang@nxp.com, aisheng.dong@nxp.com, khilman@baylibre.com, ccaione@baylibre.com, Viresh Kumar <viresh.kumar@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 5/3/19 14:19, Krzysztof Kozlowski wrote:
> On Wed, 13 Mar 2019 at 20:35, Alexandre Bailon <abailon@baylibre.com> wrote:
>>
>> This series implements busfreq, a framework used in MXP's
>> tree to scale the interconnect and dram frequencies.
>> In the vendor tree, device's driver request for a
>> performance level, which is used to scale the frequencies.
>> This series implements it using the interconnect framework.
>> Devices' driver request for bandwidth which is use by busfreq
>> to determine a performance level, and then scale the frequency.
>>
>> Busfreq is quite generic. It could be used for any i.MX SoC.
>> A busfreq platform driver just have to define a list of
>> interconnect nodes, and some OPPs.
>>
>> This series is sent as RFC mostly because the current support
>> of i.MX SoC won't benefit of busfreq framework, because the
>> clocks' driver don't support interconnect / dram frequency
>> scaling.
>> As exemple, this series implements busfreq for i.MX8MM whose
>> upstreaming is in progress. Because this relies on ATF to
>> do the frequency scaling, it won't be hard make it work.
>>
>> As exemple, this series implements busfreq for
>> Alexandre Bailon (3):
>>   drivers: interconnect: Add a driver for i.MX SoC
>>   drivers: interconnect: imx: Add support of i.MX8MM
>>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
> 
> Hi Alexandre,
> 
> I am quite late but I just found your email.
> 
> This looks very similar to existing framework - devfreq, which purpose
> is to scale the system busses based on performance counters/events. It
> would be nice if we could avoid duplication of existing subsystems.

Hi Krzysztof,

Scaling buses based on performance counters is suboptimal and sometimes might
not work well. In contrast with devfreq, the interconnect API is allowing
drivers to express their needs in advance and be proactive. It is also designed
to deal with multi-tiered bus topologies and to aggregate the requests from the
different consumer drivers.

Thanks,
Georgi

> 
> Best regards,
> Krzysztof
> 
