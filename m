From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 16 Dec 2015 13:51:46 +0100
Message-ID: <CAPDyKFq=AWtranL2uifgO5TuTW5ykt+X8NkGpg7UDBpEivDxjA@mail.gmail.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
	<1449241037-22193-17-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFrcuK4iCo7Tg1Q_XjB7Y-+=s-ax1vzK4UEu9FfPnuProw@mail.gmail.com>
	<567131A2.6030303@nvidia.com>
	<CAPDyKFpZoZZapqanFyUzT_jZ6DLBnGXOXEyDHosWpphAjzhy7A@mail.gmail.com>
	<56714DA3.80707@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34256 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934011AbbLPMvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 07:51:46 -0500
Received: by mail-qk0-f176.google.com with SMTP id p187so61130331qkd.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2015 04:51:46 -0800 (PST)
In-Reply-To: <56714DA3.80707@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 16 December 2015 at 12:40, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 16/12/15 09:47, Ulf Hansson wrote:
>> On 16 December 2015 at 10:40, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Hi Ulf,
>>>
>>> On 15/12/15 19:54, Ulf Hansson wrote:
>>>> On 4 December 2015 at 15:57, Jon Hunter <jonathanh@nvidia.com> wrote:
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
>>>>>         select GENERIC_CLOCKEVENTS
>>>>>         select HAVE_CLK
>>>>>         select PINCTRL
>>>>> +       select PM
>>>>> +       select PM_GENERIC_DOMAINS
>>>>
>>>> If you still want to allow ARCH_TEGRA to run without PM, you should
>>>> probably change to:
>>>>
>>>> select PM_GENERIC_DOMAINS if PM
>>>
>>> Per the changelog this is deliberate. If we allow !PM, then there is a
>>> potential that you could probe a device when the power domain is not
>>> powered on. I understand that some SoCs turn on all the power-domains
>>> when !PM but this will not work for tegra because we don't register the
>>> power domain until later in the boot and so we are relying upon probe
>>> deferral to defer the probe of devices that use power-domains.
>>
>> So what you are saying is that adding the PM domain support, will fix
>> some devices to become successfully probed as they were broken before?
>
> Not exactly. There is a legacy tegra_powergate_sequence_power_up() that
> has been used to date to get around this. However, by migrating to GENPD
> we really need to make PM mandatory, otherwise you could attempt to
> probe a device in a power domain that is not powered. In other words,
> you are probing blindly. I know some SoCs do this, but that does not
> seem very robust.

Thank for the clarification. I agree.

You may add my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
