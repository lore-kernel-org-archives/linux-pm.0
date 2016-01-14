From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Thu, 14 Jan 2016 17:16:18 +0000
Message-ID: <5697D7E2.3030209@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <8579242.omBpg1aLr2@wuerfel>
 <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
 <11122786.kKumQ3Dhls@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11122786.kKumQ3Dhls@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


On 14/01/16 09:21, Arnd Bergmann wrote:
> On Thursday 14 January 2016 09:57:14 Ulf Hansson wrote:
>> On 13 January 2016 at 21:43, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
>>>> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
>>>>> Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
>>>>> dependent upon a particular power-domain are only probed when that power
>>>>> domain has been powered up, requires that PM is made mandatory for tegra
>>>>> 64-bit devices and so select this option for tegra as well.
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>>  arch/arm64/Kconfig.platforms | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>>>> index 9806324fa215..e0b5bd0aff0f 100644
>>>>> --- a/arch/arm64/Kconfig.platforms
>>>>> +++ b/arch/arm64/Kconfig.platforms
>>>>> @@ -93,6 +93,8 @@ config ARCH_TEGRA
>>>>>       select GENERIC_CLOCKEVENTS
>>>>>       select HAVE_CLK
>>>>>       select PINCTRL
>>>>> +     select PM
>>>>> +     select PM_GENERIC_DOMAINS
>>>>>       select RESET_CONTROLLER
>>>>>       help
>>>>>         This enables support for the NVIDIA Tegra SoC family.
>>>>
>>>> This has potential consequences for multi-platform builds, doesn't it?
>>>> All of a sudden any combination of builds that includes Tegra won't be
>>>> possible to build without PM support.
>>>>
>>>> Adding linux-arm-kernel@lists.infradead.org for visibility.
>>>>
>>>>
>>>
>>> Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
>>> dependencies in the drivers that require it.
>>>
>>
>> The problem with that approach is that if those drivers are cross SoC
>> drivers. In some cases PM isn't needed and it is.
>>
>> Of course I don't have the in depth knowledge about the drivers being
>> used in Tegra which may need PM, perhaps it's not that many?
>>
>> Anyway, to me it seems like ARCH_TEGRA should depend on PM instead.
>> Would that work?
> 
> That seems a little over-restrictive, as it prevents you from
> building a tegra kernel even if none of the drivers that rely
> on the pm domains are used, but it would work.
> 
> I've looked again at how other platforms (on arm32) do it, and
> a lot of them use "select PM_GENERIC_DOMAINS if PM", so they don't
> automatically enable PM, but they enable the pmdomain code if
> PM is already set. No driver really "depends on PM_GENERIC_DOMAINS",
> so we shouldn't really start that now or we end up with circular
> dependencies in the long run.

What I am not a fan of in the current gen-pd implementation, is if we
have !PM but the platform has power-domains, then there is no way to
determine if a device within a power-domain can be probed safely. Some
arm platforms force all the power-domains on during early init in the
case of !PM. IMO this is still not ideal, because if a power-domain
failed to turn on during early init, then you should probably call
BUG(). Ideally the kernel should be able to boot and only probe the
devices you know that can be probed safely.

So for platforms have use PM_GENERIC_DOMAINS, I think really they should
select PM and not "select PM_GENERIC_DOMAINS if PM". IMO, "select
PM_GENERIC_DOMAINS if PM" seems fragile.

Cheers
Jon
