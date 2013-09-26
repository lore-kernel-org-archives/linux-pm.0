From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 19/21] cpuidle: create list of registered drivers
Date: Thu, 26 Sep 2013 10:19:14 +0200
Message-ID: <5243EE02.9020207@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<7e9565e323c1e065eeb2a2a1075967bd21ee6066.1379779777.git.viresh.kumar@linaro.org>	<5243641B.6050604@linaro.org> <CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57624 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab3IZITT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 04:19:19 -0400
Received: by mail-wg0-f53.google.com with SMTP id x12so221362wgg.32
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2013 01:19:18 -0700 (PDT)
In-Reply-To: <CAKohpo=3qFQ+gD+3u__NtZEL4xu51FBN+og+_UE7aTR26XvRng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 09/26/2013 08:17 AM, Viresh Kumar wrote:
> On 26 September 2013 04:00, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> If you introduce a list, you will have to introduce a lock to protec=
t
>> it.
>
> I missed it, should have added that :)
>
>> This lock will be in the fast path cpuidle_idle_call with the
>> get_driver function and conforming to the comment: "NOTE: no locks o=
r
>> semaphores should be used here".
>>
>> A lock has been introduced in this function already and the system h=
angs
>> with 1024 cpus.
>
> Hmm... I see.. I didn't knew about this expectation.. What about a rc=
u
> read/write lock? As far as I know its too lightweight... Can we have =
that
> in fast path?

Nope, we can't use rcu in the idle path :)

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/083=
054.html


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

