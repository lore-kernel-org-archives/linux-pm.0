From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Fri, 28 Nov 2014 11:51:29 +0000
Message-ID: <547861C1.4040904@arm.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>	<5476071B.1060705@arm.com>	<CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>	<5476F4ED.6040206@arm.com>	<CAKohpok+M+HuuQBJ3EJ_3e+Uv-Me5za7EO2TVguU_tCXNtahvQ@mail.gmail.com>	<547707C8.3080108@arm.com> <CAKohpokwKzJ1TJQu2YGS+veDPuGFKehWWbdYKrHyPz6vK-Vy3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38980 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaK1Lv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 06:51:27 -0500
In-Reply-To: <CAKohpokwKzJ1TJQu2YGS+veDPuGFKehWWbdYKrHyPz6vK-Vy3A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>



On 28/11/14 06:31, Viresh Kumar wrote:
> On 27 November 2014 at 16:45, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> It's the general understanding, I am not sure if it's specified anywhere
>> in the kernel Documentation, but I could find the below excerpts from [1]:
>>
>> "The compatibility rules say that new kernels must work with older
>> device trees. If changes are required, they should be put into new
>> properties; the old ones can then be deprecated but not removed. New
>> properties should be optional, so that device trees lacking those
>> properties continue to work. The device tree developers will provide a
>> set of guidelines for the creation of future-proof bindings."
>>
>> It's *exactly opposite* as DTs are considered as part of firmware that
>> gets shipped with the boards and any kernel should work with that DT if
>> it is compliance with the DT bindings(even old, as the DT bindings
>> should never get changed only gets extended)
>
> Okay, I was completely wrong. :)
>
>> No, you *must* :). That's backward compatibility. Just consider a simple
>> case where the bootloader is generating DT and we don't want to upgrade it.
>
> Now these are the options we have for existing platforms:
>
> - Update those platforms to check if DT has "compatible" string in CPU node.
> If yes, don't create a device as this will be created by cpufreq-dt.
>

This fixes how it will work with new DTs, how about old DTs ?
IMO we still need the blacklist kind of logic I sent before.
Do you see any issues with that ?

> - Just remove the device creation from those paths if the Maintainers of
> those platforms want to cleanup their code, accepting the loss of backward
> compatibility..
>

I don't think this is something acceptable, why will someone want to
lose a working feature with new kernel.

Regards,
Sudeep

