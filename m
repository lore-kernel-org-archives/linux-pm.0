From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Mon, 28 Apr 2014 12:09:20 +0200
Message-ID: <535E28D0.7050502@linaro.org>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <535911DC.9050109@linaro.org> <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com> <2713863.BLQTYQm2Oa@vostro.rjw.lan> <20140425132055.GC11096@twins.programming.kicks-ass.net> <535A94E3.5080004@linaro.org> <20140425184327.GH26782@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:63231 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbaD1KJW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Apr 2014 06:09:22 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so1288257wes.25
        for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2014 03:09:21 -0700 (PDT)
In-Reply-To: <20140425184327.GH26782@laptop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Kucheria <amit.kucheria@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 04/25/2014 08:43 PM, Peter Zijlstra wrote:
> On Fri, Apr 25, 2014 at 07:01:23PM +0200, Daniel Lezcano wrote:
>> As the sysctl is some kind of ABI, I would like to make sure we reac=
h a
>> consensus and discuss a bit about that.
>
> We could make it a sysfs file, like /sys/power/state, which when read
> provides the words it takes.
>
> That is more flexible than a numeric sysctl for which we have to keep=
 an
> enumeration.

I agree a numerical value is not flexible. But it sounds weird to put a=
=20
scheduler option in the sysfs and maybe more options will follow.

I am wondering if we shouldn't create a new cgroup for 'energy' and put=
=20
everything in there. So we will have more flexibility for extension and=
=20
we will be able to create a group of tasks for performance and a group=20
of tasks for energy saving.

Does it make sense ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

