From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 21/21] cpuidle: change governor from within cpuidle_replace_governor()
Date: Thu, 26 Sep 2013 10:20:11 +0200
Message-ID: <5243EE3B.1050600@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<5b758e21eeb97f5f68191819c0820673692b6b75.1379779777.git.viresh.kumar@linaro.org>	<524368CF.4030803@linaro.org> <CAKohpom_BTYC4DZLP93VzFqfnCudPb9whugPigh-jO0MpHurtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34073 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab3IZIUP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 04:20:15 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so758338wgh.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 01:20:14 -0700 (PDT)
In-Reply-To: <CAKohpom_BTYC4DZLP93VzFqfnCudPb9whugPigh-jO0MpHurtw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/26/2013 08:37 AM, Viresh Kumar wrote:
> On 26 September 2013 04:20, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> Actually I am wondering if all this stuff is not over-engineered.
>>
>> There are 2 governors, each of them suits for a specific kernel conf=
ig,
>> periodic tick or tickless system.
>>
>> menu     =3D> tickless system
>> periodic =3D> periodic tick system
>>
>> IMHO, all the code with rating checking and so do not really makes
>> sense. Wouldn't make sense to remove this code ?
>
> I am a newbie here, really can't think of all side effects of this :)

Rafael is pretty busy ATM but may be he can give his feedback on this l=
ater.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

