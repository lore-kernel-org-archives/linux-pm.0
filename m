From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 0/8] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Fri, 20 Mar 2015 19:39:23 +0100
Message-ID: <550C695B.7080200@linaro.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org> <20150320183111.GA8891@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33714 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbbCTSj2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 14:39:28 -0400
Received: by wgbcc7 with SMTP id cc7so96353280wgb.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2015 11:39:26 -0700 (PDT)
In-Reply-To: <20150320183111.GA8891@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On 03/20/2015 07:31 PM, Lorenzo Pieralisi wrote:
> Hi Daniel,
>
> On Fri, Mar 20, 2015 at 11:43:53AM +0000, Daniel Lezcano wrote:
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
>> driver upstreaming attempt.
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
> I had a look and the series seems fine, if you have a branch I can pu=
ll from
> I will test on arm64 and add the required tags.

Yes, sure.

http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpuidle/4.=
1

Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

