From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Mon, 1 Dec 2014 13:36:00 +0530
Message-ID: <CAKohpo=YGGGTdX+5VELG62-nOkpH8qSyNv41RiuXS8=1UkVJLQ@mail.gmail.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>
	<5476071B.1060705@arm.com>
	<CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>
	<5476F4ED.6040206@arm.com>
	<CAKohpok+M+HuuQBJ3EJ_3e+Uv-Me5za7EO2TVguU_tCXNtahvQ@mail.gmail.com>
	<547707C8.3080108@arm.com>
	<CAKohpokwKzJ1TJQu2YGS+veDPuGFKehWWbdYKrHyPz6vK-Vy3A@mail.gmail.com>
	<547861C1.4040904@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbaLAIGB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 03:06:01 -0500
Received: by mail-ob0-f174.google.com with SMTP id nt9so365833obb.33
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 00:06:00 -0800 (PST)
In-Reply-To: <547861C1.4040904@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>

On 28 November 2014 at 17:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> - Update those platforms to check if DT has "compatible" string in CPU
>> node.
>> If yes, don't create a device as this will be created by cpufreq-dt.
>>
>
> This fixes how it will work with new DTs, how about old DTs ?
> IMO we still need the blacklist kind of logic I sent before.

Yes..

> I don't think this is something acceptable, why will someone want to
> lose a working feature with new kernel.

If some platform maintainers care for cleaner/simpler code instead
of backward compatibility ..

For example, exynos has just started to use cpufreq-dt. Probably
in 3.18 or may be 19 as well.. So, they might not care about
backward compatibility at all.. Let me see if I can come up with
a solution that looks reasonably clean.

--
viresh
