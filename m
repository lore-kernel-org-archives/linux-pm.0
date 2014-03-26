From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: clps711x: Switch CLPS711X subarch to use cpuidle
 driver
Date: Wed, 26 Mar 2014 12:23:16 +0100
Message-ID: <5332B8A4.2010802@linaro.org>
References: <1395467076-29462-1-git-send-email-shc_work@mail.ru> <1395467076-29462-2-git-send-email-shc_work@mail.ru> <5332B3F4.4010408@linaro.org> <1395832171.565939937@f148.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:63732 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939AbaCZLXH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 07:23:07 -0400
Received: by mail-bk0-f42.google.com with SMTP id mx12so485716bkb.29
        for <linux-pm@vger.kernel.org>; Wed, 26 Mar 2014 04:23:05 -0700 (PDT)
In-Reply-To: <1395832171.565939937@f148.i.mail.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org

On 03/26/2014 12:09 PM, Alexander Shiyan wrote:
> Wed, 26 Mar 2014 12:03:16 +0100 =D0=BE=D1=82 Daniel Lezcano <daniel.l=
ezcano@linaro.org>:
>> On 03/22/2014 06:44 AM, Alexander Shiyan wrote:
>>> This patch removes old support for cpuidle and switches all current
>>> users to use new cpuidle driver.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>
>> Hi Alexander,
>>
>> this patch does not apply. Could you respin it against 3.14-rc8.
>
> This part (2/2) can be applied later, I can resend this one part thro=
ugh arm-soc tree.

Ok, I applied the patch 1/2 for 3.16 on my tree.

Thanks

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

