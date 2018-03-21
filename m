From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] ARM: EXYNOS: Fix coupled CPU idle freeze on Exynos4210
Date: Wed, 21 Mar 2018 11:18:26 +0100
Message-ID: <52224d23-e90a-ce1d-3b4d-add7876eb682@samsung.com>
References: <CGME20180321094523eucas1p1a87d146d65d4191ccdb37f1723977011@eucas1p1.samsung.com>
        <20180321094505.25494-1-m.szyprowski@samsung.com>
        <f1d38d39-59b8-715f-15b3-1933b0971793@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <f1d38d39-59b8-715f-15b3-1933b0971793@arm.com>
Content-language: en-US
Sender: stable-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Marc,

On 2018-03-21 11:05, Marc Zyngier wrote:
> On 21/03/18 09:45, Marek Szyprowski wrote:
>> Since commit 04c8b0f82c7d ("irqchip/gic: Make locking a BL_SWITCHER only
>> feature") coupled CPU idle freezes from time to time on Exynos4210. Later
>> commit 313c8c16ee62 ("PM / CPU: replace raw_notifier with atomic_notifier")
>> changed the context in which the CPU idle code is executed, what results
>> in fully reproducible freeze all the time. However, almost the same coupled
>> CPU idle code works fine on Exynos3250 regarless of the changes made in
>> the mentioned commits.
>>
>> It turned out that the IPI call used on Exynos4210 is conflicting with the
>> change done in the first mentioned commit in GIC. Fix this by using the
>> same code path as for Exynos3250, instead of the IPI call for
>> synchronization with second CPU core, call dsb_sev() directly.
>>
>> Tested on Exynos4210-based Trats and Origen boards.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> CC: stable@vger.kernel.org # v4.13+
>> ---
>>   arch/arm/mach-exynos/pm.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index dc4346ecf16d..a1055a2b8d54 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -271,11 +271,7 @@ static int exynos_cpu0_enter_aftr(void)
>>   				goto fail;
>>   
>>   			call_firmware_op(cpu_boot, 1);
>> -
>> -			if (soc_is_exynos3250())
>> -				dsb_sev();
>> -			else
>> -				arch_send_wakeup_ipi_mask(cpumask_of(1));
>> +			dsb_sev();
>>   		}
>>   	}
>>   fail:
>>
> I'm a bit puzzled here.
>
> If the GIC change broke something on your platform, it probably also
> broke something for all other users of arch_send_wakeup_ipi_mask. But
> nobody reported anything until now. Also, it doesn't look like 4210 is a
> big-little platform, so it is unlikely to use the big-little switcher.
>
> What is specific to this system that makes misbehave? Were you
> implicitly relying on the BL lock to perform some serialization?

My hypothesis, after some internal discussion, is that dsb_sev() should be
there from the beginning, but instead there was an 
arch_send_wakeup_ipi_mask()
call, which indirectly called dsb_sev() as a part of GIC spinlock internals.
When spinlock has been removed from GIC, there is no dsb_sev() call anymore,
what causes synchronization issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
