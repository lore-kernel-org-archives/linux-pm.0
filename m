From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 0/3] sched/idle : find the idlest cpu with cpuidle
 info
Date: Fri, 04 Apr 2014 10:16:58 +0200
Message-ID: <533E6A7A.4070400@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <CAJvTdKk9AJUfCKGDS1RGDNJwP-Q9gTYswBEHHji6L6Lq3yd8JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:58347 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaDDIQn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Apr 2014 04:16:43 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so3042782wes.9
        for <linux-pm@vger.kernel.org>; Fri, 04 Apr 2014 01:16:42 -0700 (PDT)
In-Reply-To: <CAJvTdKk9AJUfCKGDS1RGDNJwP-Q9gTYswBEHHji6L6Lq3yd8JA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, nicolas.pitre@linaro.org, Linux PM list <linux-pm@vger.kernel.org>, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/04/2014 08:29 AM, Len Brown wrote:
> Hi Daniel,
>
> Interesting idea.
>
> The benefit of this patch is to reduce power.
> Have you been able to measure a power reduction, via power meter, or
> via built-in RAPL power meter?
> (turbostat will show RAPL watts, or if you have constant quantity of
> work, use turbostat -J)

Hi Len,

thanks for looking the patches.

I will tweak, respin the patchset and do some more measurements.

I don't have a power meter but may be the RAPL could help to test on x8=
6.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

