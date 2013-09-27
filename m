From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 14:50:41 +0200
Message-ID: <52457F21.3030502@linaro.org>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org> <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43173 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab3I0Mup (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 08:50:45 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so2583480wgh.4
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 05:50:44 -0700 (PDT)
In-Reply-To: <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09/27/2013 02:29 PM, Rob Herring wrote:
> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> As the ux500 and the kirkwood driver, make the calxeda driver a plat=
form driver
>>
>> [Compiled only]
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>   drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> Looks fine to me, but this will conflict with my series. Perhaps I ca=
n
> pick this up as part of that.

Yes I agree, it makes sense.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

