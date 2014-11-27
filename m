From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Thu, 27 Nov 2014 11:15:20 +0000
Message-ID: <547707C8.3080108@arm.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>	<5476071B.1060705@arm.com>	<CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>	<5476F4ED.6040206@arm.com> <CAKohpok+M+HuuQBJ3EJ_3e+Uv-Me5za7EO2TVguU_tCXNtahvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40784 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbaK0LPV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 06:15:21 -0500
In-Reply-To: <CAKohpok+M+HuuQBJ3EJ_3e+Uv-Me5za7EO2TVguU_tCXNtahvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>



On 27/11/14 10:22, Viresh Kumar wrote:
> On 27 November 2014 at 15:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> No that won't suffice. You can't modify the DTs of the platforms using
>> cpufreq-dt.c as of today. They should continue to work, so either you
>> retain all the existing platform device creation in platform code as is
>> or do something like below with the blacklist for those platforms.
>
> Is the meaning of "backward compatibility" for DTs mentioned somewhere?
> I am not sure if we have to *always* follow the compatibility you are talking
> about.
>

It's the general understanding, I am not sure if it's specified anywhere
in the kernel Documentation, but I could find the below excerpts from [1]:

"The compatibility rules say that new kernels must work with older
device trees. If changes are required, they should be put into new
properties; the old ones can then be deprecated but not removed. New
properties should be optional, so that device trees lacking those
properties continue to work. The device tree developers will provide a
set of guidelines for the creation of future-proof bindings."

> Probably we want new DTs to continue supporting older version of kernels.
> Not that older DTs should work with new kernel changes.
>

It's *exactly opposite* as DTs are considered as part of firmware that
gets shipped with the boards and any kernel should work with that DT if
it is compliance with the DT bindings(even old, as the DT bindings
should never get changed only gets extended)

> So, even with another field in cpuX node, we wouldn't break older kernels
> as they will anyway get the device from platform code.
>

Yes, but that's not what we want.

>> OK, in this way you still continue to work on existing platforms with
>> *old DT*.
>
> Probably not.
>

No, you *must* :). That's backward compatibility. Just consider a simple
case where the bootloader is generating DT and we don't want to upgrade it.

Regards,
Sudeep

[1] http://lwn.net/Articles/572114/

