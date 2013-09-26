From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 20/21] cpuidle: don't calculate time-diff if entered_state
 == 0
Date: Thu, 26 Sep 2013 10:25:35 +0200
Message-ID: <5243EF7F.4000606@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<acd1cc837f969a50582d2b25a73c5e247f40f843.1379779777.git.viresh.kumar@linaro.org>	<524365FA.4090108@linaro.org> <CAKohpong15qzFg_sZVB77wVm4gu-4Se1E=eqvJOv96fgnyMXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:43795 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab3IZIZj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 04:25:39 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so787866wgg.22
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 01:25:37 -0700 (PDT)
In-Reply-To: <CAKohpong15qzFg_sZVB77wVm4gu-4Se1E=eqvJOv96fgnyMXDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/26/2013 08:24 AM, Viresh Kumar wrote:
> On 26 September 2013 04:08, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>>> If entered_state =3D=3D 0, we don't need to set dev->last_residency=
 to 'diff' as we
>>> will be setting it to zero without using its new value.
>>
>> I don't get it, can you elaborate.
>
> Sure.. We have following code in cpuidle_enter_state():
>
> ---------
>          diff =3D ktime_to_us(ktime_sub(time_end, time_start));
>          if (diff > INT_MAX)
>                  diff =3D INT_MAX;
>
>          dev->last_residency =3D (int) diff;
>
>          if (entered_state >=3D 0) {
>                  /* Update cpuidle counters */
>                  /* This can be moved to within driver enter routine
>                   * but that results in multiple copies of same code.
>                   */
>                  dev->states_usage[entered_state].time +=3D dev->last=
_residency;
>                  dev->states_usage[entered_state].usage++;
>          } else {
>                  dev->last_residency =3D 0;
>          }
> -------
>
> We are setting last_residency to 0 when (entered_state < 0) and aren'=
t using
> the value of "diff". So, we can actually skip calculations of time_en=
d, diff and
> last_residency when (entered_state < 0).. Makes sense?

Yes I agree, but why are you saying "If entered_state =3D=3D 0, we don'=
t=20
need to ..." ?

>> We can be a long time in this state
>> (eg. if the prediction is false).
>
> Okay.. I didn't get it :)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

