From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: mvebu cpuidle and cpufreq branch handling for v3.17
Date: Sat, 19 Jul 2014 01:36:23 +0200
Message-ID: <53C9AF77.3030104@linaro.org>
References: <20140718230740.GR24496@titan.lakedaemon.net> <4295346.6091tevmKX@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47284 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932995AbaGRXg0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 19:36:26 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so4103205wgh.23
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2014 16:36:25 -0700 (PDT)
In-Reply-To: <4295346.6091tevmKX@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>, arm@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On 07/19/2014 01:51 AM, Rafael J. Wysocki wrote:
> On Friday, July 18, 2014 07:07:40 PM Jason Cooper wrote:
>> Arnd, Olof, Kevin,
>>
>> I have two branches with the remaining mvebu SoC changes for v3.17.
>> They are mvebu/soc-cpuidle and mvebu/soc-cpufreq.  Each branch is
>> slightly problematic because both contain changes to their respectiv=
e
>> code in drivers/.  To send the driver changes through the appropriat=
e
>> subsystems would be a garish nightmare of branch on branch on branch=
=2E
>> Thankfully, the changes are isolated to drivers only mvebu uses, so
>> keeping it all together should cause minimal, if any, conflicts.
>>
>> I've requested Acks from the appropriate maintainers but as it's sum=
mer
>> I'm not confident that we'll receive those Acks in time for the arm-=
soc
>> cutoff (-rc6 -ish).
>>
>> As I see it, I could send arm-soc two topic branch pull requests, wh=
ich
>> arm-soc would keep out separate on the remote chance of an objection=
=2E
>>
>> Or, I could wait for the Acks (the code has already been in -next fo=
r
>> several days), merge it into mvebu/soc, and send a, most likely, lat=
e
>> pull request for it.
>>
>> Which would you guys prefer?
>>
>> The cpuidle branch and ML link:
>>
>>    git://git.infradead.org/linux-mvebu.git mvebu/soc-cpuidle
>>
>>    https://lkml.kernel.org/r/1404913221-17343-1-git-send-email-thoma=
s.petazzoni@free-electrons.com
>>
>> The cpufreq branch and ML link:
>>
>>    git://git.infradead.org/linux-mvebu.git mvebu/soc-cpufreq
>>
>>    https://lkml.kernel.org/r/1404920715-19834-1-git-send-email-thoma=
s.petazzoni@free-electrons.com
>
> I'm generally OK with the cpufreq/cpuidle changes here in drivers/, b=
ut as I
> said in response to the cpuidle series, I'd like someone from the ARM=
 side of
> things to look at those changes too.

I am currently in vacation. I will be back Monday and look at this patc=
hset.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

