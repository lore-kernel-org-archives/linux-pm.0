From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 08/21] cpuidle: use cpuidle_disabled() instead of "off"
Date: Thu, 26 Sep 2013 10:25:00 +0200
Message-ID: <5243EF5C.6060908@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<19979ce88726285c72dd6fe3d7b370d53669443c.1379779777.git.viresh.kumar@linaro.org>	<52435B05.9030201@linaro.org> <CAKohpon6fgCp2StW1=6JUua1xuZW8iS=0VLVCTsTD6JS027meg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:45352 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3IZIZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 04:25:03 -0400
Received: by mail-wi0-f180.google.com with SMTP id hj3so826186wib.7
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 01:25:02 -0700 (PDT)
In-Reply-To: <CAKohpon6fgCp2StW1=6JUua1xuZW8iS=0VLVCTsTD6JS027meg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/26/2013 07:06 AM, Viresh Kumar wrote:
> On 26 September 2013 03:22, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>>> We have a routine for getting value of "off", better call that inst=
ead of using
>>> "off" directly.
>>
>> We are in the fast path, I am not sure invoking a function here is
>> better than using directly the static variable.
>
> I only did it for consistency as we have this routine specifically fo=
r reading
> value of "off" and so we better don't use off directly..
>
> Probably we can make it static inline and move it into
> drivers/cpuidle/cpuidle.h?

If you move it to cpuidle.h, you will have to move the 'off' variable i=
n=20
the header hence increasing the scope of it.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

