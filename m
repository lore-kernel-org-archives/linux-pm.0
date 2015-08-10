From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 6/9] ARM: domain: Add platform handlers for CPU PM domains
Date: Mon, 10 Aug 2015 09:36:24 -0600
Message-ID: <20150810153624.GD52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-7-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqKWekSGiFbZz6++3ibAzY_8Y6+0nOBQinFVw4cBk6JvEw@mail.gmail.com>
 <20150805192341.GB52339@linaro.org>
 <CAL_JsqJ_AK6M5WmyFrGVLtpGg=MdAafxX=1873Je_uB_sQkpiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33484 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbbHJPgD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 11:36:03 -0400
Received: by pdrh1 with SMTP id h1so54701864pdr.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2015 08:36:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ_AK6M5WmyFrGVLtpGg=MdAafxX=1873Je_uB_sQkpiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Wed, Aug 05 2015 at 21:01 -0600, Rob Herring wrote:
>On Wed, Aug 5, 2015 at 2:23 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> On Wed, Aug 05 2015 at 08:45 -0600, Rob Herring wrote:
>>>
>>> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>>
>>>> In addition to the common power up/down actions of CPU PM domain core,
>>>> platforms may have additional configuration before the CPU domain can be
>>>> powered off or considered active. Allow platform drivers to register
>>>> handlers for CPU PM domains.
>>>>
>>>> Platform drivers may register their callbacks against a compatible
>>>> string defined by their PM domain provider device node in the DT. At
>>>> domain init, the platform driver can initialize the platform specific
>>>> genpd attributes. The init callback would need to return successfully,
>>>> for the platform power_on/off handlers to be registered with the CPU PM
>>>> domain.
>>>>
>>>> The code uses __init section to reduce memory needed for platform
>>>> handlers and therefore can be freed after the driver is initialized, a
>>>> desirable outcome for single kernel image.
>>>
>>>
>>> [...]
>>>
>>>> diff --git a/arch/arm/include/asm/arm-pd.h
>>>> b/arch/arm/include/asm/arm-pd.h
>>>> new file mode 100644
>>>> index 0000000..fc44abf
>>
>>
>> [...]
>>
>>>> +#define ARM_PD_METHOD_OF_DECLARE(_name, _handle, _ops) \
>>>> +       static const struct of_arm_pd_method
>>>> __arm_pd_method_of_table_##_name \
>>>> +       __used __section(__arm_pd_method_of_table)              \
>>>> +       = { .handle = _handle, .ops = _ops }
>>>
>>>
>>> AFAICT, you are not using this in this series. You should add it when
>>> you have a user.
>>>
>>> Ideally, we keep some amount of uniformity across various *_OF_DECLARE
>>> which is why we have OF_DECLARE_1 and OF_DECLARE_2. This makes all the
>>> sections just arrays of struct of_device_id. Not all users follow
>>> this, but most do. So instead of putting the ops in here, platforms
>>> can provide a function callback which can then set the ops. Then you
>>> also don't need the .init() ops function as the callback function can
>>> do any initialization too.
>>>
>> I looked through these and I can switch over to _OF_DECLARE() without any
>> issues, but using OF_DECLARE_1 or OF_DECLARE_2 is pretty limiting.
>
>Well yes, but then we only want to use it for things that will never
>use the driver model.
>
>> If I could set up my own function type for the .data member, then its a
>> lot more easier on the code. Like this -
>>
>> typedef int (*arm_pd_init)(struct device_node *dn, struct
>>                 generic_pm_domain *genpd, struct of_arm_pd_ops *ops);
>
>You alloc the genpd struct just before calling init. You can just as
>easily have the platform specific code call an allocation function and
>a function to set the ops functions. This is more inline with how a
>driver would work when registering with a subsystem.
>
OK. That would mean I have a way of mapping the device_node to the
of_arm_pd_ops, which I currently dont. Was trying to avoid a list. But,
I was able to use list and use OF_DECLARE_1. The platform driver, shall
call up separate API to register the ops or ge the Genpd and modify it.

Will submit it in the next spin, following the discussion on arm,pd.

Thanks,
Lina


>I also don't
>think "arm,pd" is a good compatible string to be matching on. I'll
>comment on that more in patch 5.
>
>Rob
