From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v8 1/4] mfd: rt5033: Add Richtek RT5033 driver core.
Date: Wed, 10 Dec 2014 21:34:44 +0900
Message-ID: <54883DE4.5000907@samsung.com>
References: <1418126634-4781-1-git-send-email-beomho.seo@samsung.com>
 <1418126634-4781-2-git-send-email-beomho.seo@samsung.com>
 <20141209140102.GZ3951@x1> <54882255.9060303@samsung.com>
 <20141210121331.GD23481@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141210121331.GD23481@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sameo@linux.intel.com, lee.jone@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, cw00.choi@samsung.com, geunsik.lim@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com
List-Id: linux-pm@vger.kernel.org

On 12/10/2014 09:13 PM, Lee Jones wrote:
> On Wed, 10 Dec 2014, Beomho Seo wrote:
> 
>> On 12/09/2014 11:01 PM, Lee Jones wrote:
>>> On Tue, 09 Dec 2014, Beomho Seo wrote:
>>>
>>>> This patch adds a new driver for Richtek RT5033 driver.
>>>> RT5033 is a Multifunction device which includes battery charger, fuel gauge,
>>>> flash LED current source, LDO and synchronous Buck converter. It is interfaced
>>>> to host controller using I2C interface.
>>>>
>>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>>> Cc: Lee Jones <lee.jone@linaro.org>
>>>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/mfd/Kconfig                |   12 ++
>>>>  drivers/mfd/Makefile               |    1 +
>>>>  drivers/mfd/rt5033.c               |  142 ++++++++++++++++++++
>>>>  include/linux/mfd/rt5033-private.h |  260 ++++++++++++++++++++++++++++++++++++
>>>>  include/linux/mfd/rt5033.h         |   62 +++++++++
>>>>  5 files changed, 477 insertions(+)
>>>>  create mode 100644 drivers/mfd/rt5033.c
>>>>  create mode 100644 include/linux/mfd/rt5033-private.h
>>>>  create mode 100644 include/linux/mfd/rt5033.h
>>>
>>> Much better.
>>>
>>> For my own reference:
>>>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>>
>>> So what's the plan with this set?
>>>
>>
>> This patch have been made on for-next-mfd branch of your git repository.
>> So I hope this patch to be merged at your git repository.
>> Another patch set(RT5033 regulator driver) have been merged on for-next branch of regulator git repository.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=b1917578fd5d8efa67afa05a0d6d7e323f2802da
>>
>> Other patches(about charger, fuelgague and devicetree doc) will be re-sent to each maintainers.
> 
> Okay, so all patches are indipendant/othognal of each other for sure?
> 

Yes, rt5033 core driver merge before other patches with no problem.
It is do not have dependency other patches.


Best regards,
Beomho Seo
