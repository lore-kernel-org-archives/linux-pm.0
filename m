From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] cpuidle: 4.0-rc3 fixes
Date: Fri, 13 Mar 2015 22:38:47 +0100
Message-ID: <550358E7.702@linaro.org>
References: <55032186.3000306@linaro.org> <2429393.iDkfxR0R07@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35163 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbCMVit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 17:38:49 -0400
Received: by wibbs8 with SMTP id bs8so131181wib.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 14:38:48 -0700 (PDT)
In-Reply-To: <2429393.iDkfxR0R07@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sebastien Rannou <mxs@sbrk.org>, Gregory Clement <gregory.clement@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 03/13/2015 10:56 PM, Rafael J. Wysocki wrote:
> On Friday, March 13, 2015 06:42:30 PM Daniel Lezcano wrote:
>>
>> Hi Rafael,
>>
>> this pull request contains a couple of fixes:
>>
>>    - Fix the cpu_pm_enter/exit symmetry in the mvebu driver (Gregory=
 Clement)
>>
>>    - Fix the mvebu drivers latency/residency values to reach an
>> acceptable tradeoff between perf / power (Sebastian Rannou)
>>
>> Thanks !
>
> Pulled, but this is a bit too late for 4.0-rc4, so I'll queue it up f=
or -rc5.

Ok, no problem.

>> ps: I took the opportunity to double check the other drivers have th=
eir
>> cpu_pm_entry/exit symmetry correct (everything ok).
>
> OK, thanks!
>
> BTW, please update the dead linux-pm address you have in your scripts=
=2E

=46ixed. Thanks for the head up.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

