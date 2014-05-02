From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/2] sched: idle: Encapsulate the code to compile it
 out
Date: Fri, 02 May 2014 10:52:27 +0200
Message-ID: <53635CCB.9090301@linaro.org>
References: <1398859263-7632-1-git-send-email-daniel.lezcano@linaro.org> <2783362.8r7SvVhudq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:38318 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaEBIwZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 May 2014 04:52:25 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so4165336wes.25
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2014 01:52:24 -0700 (PDT)
In-Reply-To: <2783362.8r7SvVhudq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, mingo@elte.hu, amit.kucheria@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/01/2014 12:47 AM, Rafael J. Wysocki wrote:
> On Wednesday, April 30, 2014 02:01:02 PM Daniel Lezcano wrote:
>> Encapsulate the large portion of cpuidle_idle_call inside another
>> function so when CONFIG_CPU_IDLE=3Dn, the code will be compiled out.
>> Also that is benefitial for the clarity of the code as it removes
>> a nested indentation level.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Well, this conflicts with
>
> https://patchwork.kernel.org/patch/4071541/
>
> which you haven't commented on and I still want cpuidle_select() to b=
e able to
> return negative values because of
>
> https://patchwork.kernel.org/patch/4089631/
>
> (and I have one more patch on top of these two that requires this).
>
> Any ideas how to resolve that?

I don't think we have a big conflict. If Peter takes your patches befor=
e=20
than mines then I will refresh and resend them.

I am open to any other suggestion.


Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

