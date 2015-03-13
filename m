From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Fri, 13 Mar 2015 18:08:12 +0100
Message-ID: <5503197C.8030105@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org> <7hfv98vnhn.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36327 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbbCMRIP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 13:08:15 -0400
Received: by wghk14 with SMTP id k14so24660873wgh.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 10:08:14 -0700 (PDT)
In-Reply-To: <7hfv98vnhn.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lina.iyer@linaro.org, "keita.kobayashi.ym@renesas.com >> Keita Kobayashi" <keita.kobayashi.ym@renesas.com>

On 03/13/2015 06:03 PM, Kevin Hilman wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>
>> There is a big number of cpuidle drivers for the ARM architecture.
>>
>> These drivers have been cleaned up and grouped into the drivers/cpui=
dle
>> directory to keep track of the changes more easily and ensure the co=
de
>> is following the same scheme across the drivers.
>>
>> That had the benefit of simplifying the code and factor out a lot of=
 common
>> parts. Beside that, as the drivers belong to the 'drivers' directory=
, we had
>> to split the arch specific bits and the generic code in order to kee=
p
>> everything self contained. The platform driver paradigm was used for=
 this
>> purpose.
>>
>> Unfortunately, this approach is now no longer accepted and a differe=
nt solution
>> must be provided to reach the same goal: one example is the Qualcomm=
 cpuidle
>> driver upstreaming attempt [1].
>>
>> In the meantime, ARM64 developed a generic cpuidle driver based on D=
T definition.
>>
>> The DT definition provides an 'enable-method' to specify one of the =
cpu
>> operations (PSCI, ...).
>>
>> This patchset unify this driver with ARM32, using the same DT defini=
tion.
>>
>> Thanks with this patchset we can use the 'enable-method' to specify =
a cpu
>> operations, hence get rid of the platform driver approach and go fur=
ther in the
>> cpuidle driver flexibility via the DT.
>
> I really like that these two are unified now.
>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks for reviewing the patchset.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

