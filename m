From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v9 2/4] power: reset: add reboot mode driver
Date: Tue, 21 Jun 2016 14:16:43 +0800
Message-ID: <5768DBCB.4090903@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404696-3464-1-git-send-email-andy.yan@rock-chips.com>
 <5767A4C0.3080902@samsung.com> <5767A92E.5040602@rock-chips.com>
 <5767E22F.5030207@samsung.com> <20160620144002.GY12567@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620144002.GY12567@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at
List-Id: linux-pm@vger.kernel.org

Hi Paul:

On 2016=E5=B9=B406=E6=9C=8820=E6=97=A5 22:40, Paul Gortmaker wrote:
> [Re: [PATCH v9 2/4] power: reset: add reboot mode driver] On 20/06/20=
16 (Mon 14:31) Krzysztof Kozlowski wrote:
>
>> On 06/20/2016 10:28 AM, Andy Yan wrote:
>>> Hi Krzysztof:
>>>
>>> On 2016=E5=B9=B406=E6=9C=8820=E6=97=A5 16:09, Krzysztof Kozlowski w=
rote:
>>>> On 06/20/2016 08:38 AM, Andy Yan wrote:
> [...]
>
>>>>> +
>>>>> +config SYSCON_REBOOT_MODE
>>>>> +    bool "Generic SYSCON regmap reboot mode driver"
>>>> Why not tristate?
>>>     I see many reset drivers in this directories  use bool, so I fo=
llow
>>> them.
> Andy - understood, but mistakes done in the past do not justify
> repeating them again in the present.  OK, this is not strictly a mist=
ake
> in that it causes an error, but it isn't an ideal approach.
>
>> +Cc Paul,
>>
>> I don't mind that although I don't see any particular objections for
>> making it module-capable. In the same time I just reminded myself ab=
out
>> Paul Gortmaker's long effort (like [1] [2]) about removing module
>> capability from non-modular drivers.
> Thanks -- it is nice to see that people are starting to add this to
> their review checklist ; early on they were getting added faster than=
 I
> could remove them.  :-(   But I think we are making ground now.
>
> For this case, I don't have any bias for it being built-in vs. being
> modular, so long as the code is actually consistent with the Kconfig.
>
> For existing bool settings I just remove the modular references, sinc=
e I
> can't be extending the functionality to include a modular usage when =
I
> can't test it or even be sure if a module has a sensible use case.
>
> Paul.
> --

   I will remove the module related stuff in the next version.
>> Following his rationale, I think either this should be a tristate or=
 the
>> module stuff should be removed.
>>
>> Best regards,
>> Krzysztof
>>
>> [1] https://lkml.org/lkml/2016/2/21/180
>> [2] https://lkml.org/lkml/2016/6/13/682
>>
>>
>
>
