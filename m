From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
Date: Mon, 7 Jan 2019 18:34:54 +0200
Message-ID: <08d15fa8-7e53-518c-54bb-8050b0e4aabd@linaro.org>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <154655603153.15366.7761694381359713995@swboyd.mtv.corp.google.com>
 <1546859080.6818.128.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546859080.6818.128.camel@mtksdaap41>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Chen <henryc.chen@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Henry,

On 1/7/19 13:04, Henry Chen wrote:
> On Thu, 2019-01-03 at 14:53 -0800, Stephen Boyd wrote:
>> Quoting Henry Chen (2019-01-02 06:09:51)
>>> The patchsets add support for MediaTek hardware module named DVFSRC
>>> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
>>> a HW module which is used to collect all the requests from both software
>>> and hardware and turn into the decision of minimum operating voltage and
>>> minimum DRAM frequency to fulfill those requests.
>>>
>>> So, This series is to implement the dvfsrc driver to collect all the
>>> requests of operating voltage or DRAM bandwidth from other device drivers
>>> likes GPU/Camera through 2 frameworks basically:
>>>
>>> 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
>>>    requirements from different clients
>>
>> Have you looked at using the interconnect framework for this instead of
>> using PM_QOS_MEMORY_BANDWIDTH? Qcom is pushing an interconnect framework
>> to do DRAM bandwidth requirement aggregation.
> 
> Sorry, I haven't heard that before. Do you mean is following series
> patch?
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=53775
> 

Yes, this one. The idea is that consumer drivers like GPU, camera, video
encoder etc. report their bandwidth needs by using the interconnect API.
The framework does the aggregation and configures the hardware. In order
to use it you need to implement a platform-specific dvfsrc interconnect
provider driver that understands the SoC topology and knows how to
configure the hardware. I am not familiar with DVFSRC, but it seems to
me that it can fit as interconnect provider.
Does this HW module support any QoS priority/latency configuration or is
it only bandwidth and voltage?

Thanks,
Georgi
