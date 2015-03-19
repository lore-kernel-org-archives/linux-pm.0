From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Disabling power management firmware decisions
Date: Thu, 19 Mar 2015 16:34:52 +0100
Message-ID: <550AEC9C.5030308@linaro.org>
References: <550AD02E.2080507@linaro.org> <4773622.DqM2RS9PPh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38351 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCSPe4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 11:34:56 -0400
Received: by wifj2 with SMTP id j2so72565128wif.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2015 08:34:55 -0700 (PDT)
In-Reply-To: <4773622.DqM2RS9PPh@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 03/19/2015 03:08 PM, Rafael J. Wysocki wrote:
> On Thursday, March 19, 2015 02:33:34 PM Daniel Lezcano wrote:
>>
>> Hi,
>>
>> I would like to do some experiments with the x86 platform but I am
>> facing one big issue.
>>
>> When I use the rapl register to measure the energy consumption with
>> turbostat and another tool written by me. I see no differences betwe=
en
>> my kernel changes while using the idlestat tool, I see big differenc=
es
>> in the idle state durations with the traces.
>>
>> I remember on x86 the firmware overrides all kernel decisions to do =
the
>> power management. So I assume, it is possible my changes are not
>> measurable because of that.
>>
>> Is there a way to tell the firmware to stop overriding the kernel
>> decisions in order to let the kernel handle idle/dvfs on its own ?
>
> The short answer to that is no, there isn't.  It also may not be firm=
ware,
> but hardware.

mmrfh, that's not funny :(

Thanks for the answer.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

