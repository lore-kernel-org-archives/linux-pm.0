From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 20/21] cpuidle: don't calculate time-diff if entered_state
 == 0
Date: Thu, 26 Sep 2013 10:33:00 +0200
Message-ID: <5243F13C.7020409@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<acd1cc837f969a50582d2b25a73c5e247f40f843.1379779777.git.viresh.kumar@linaro.org>	<524365FA.4090108@linaro.org>	<CAKohpong15qzFg_sZVB77wVm4gu-4Se1E=eqvJOv96fgnyMXDA@mail.gmail.com>	<5243EF7F.4000606@linaro.org> <CAKohpongU4GpoEp5-WQJwxSbVFgAyWWcRDWo2zD+C8CGNhWwYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57171 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab3IZIdE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 04:33:04 -0400
Received: by mail-we0-f174.google.com with SMTP id q58so779290wes.19
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 01:33:03 -0700 (PDT)
In-Reply-To: <CAKohpongU4GpoEp5-WQJwxSbVFgAyWWcRDWo2zD+C8CGNhWwYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/26/2013 10:28 AM, Viresh Kumar wrote:
> On 26 September 2013 13:55, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> Yes I agree, but why are you saying "If entered_state =3D=3D 0, we d=
on't need to
>> ..." ?
>
> Ahh.. that's a mistake.. s/=3D=3D/< :)

Ah ok.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

