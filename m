From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the
 tsensors
Date: Mon, 15 Oct 2018 20:01:56 +0200
Message-ID: <9f9650d9-cae9-9dfb-ded3-4ba5834a6ffe@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
 <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
 <20181015163115.GA25282@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015163115.GA25282@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, leo.yan@linaro.org, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/HISILICON SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 15/10/2018 18:31, Rob Herring wrote:
> On Tue, Sep 25, 2018 at 11:03:08AM +0200, Daniel Lezcano wrote:
>> Add the missing interrupts for the temperature sensors as well as
>> their names.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--
> 
> Combine this and the previous binding change to 1 patch.

Ok.

>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
>>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> And more checkpatch whitespace errors in this.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
