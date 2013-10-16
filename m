From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Wed, 16 Oct 2013 15:36:18 +0200
Message-ID: <525E9652.6060103@linaro.org>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org> <CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com> <52457F21.3030502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40146 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934280Ab3JPNgX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 09:36:23 -0400
Received: by mail-wi0-f171.google.com with SMTP id h11so2384032wiv.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 06:36:22 -0700 (PDT)
In-Reply-To: <52457F21.3030502@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09/27/2013 02:50 PM, Daniel Lezcano wrote:
> On 09/27/2013 02:29 PM, Rob Herring wrote:
>> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> As the ux500 and the kirkwood driver, make the calxeda driver a
>>> platform driver
>>>
>>> [Compiled only]
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>>   drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> Looks fine to me, but this will conflict with my series. Perhaps I c=
an
>> pick this up as part of that.
>
> Yes I agree, it makes sense.

Hi Rob,

were you able to take the patch ? Where is the higbank git tree where I=
=20
can see these patches ? I looked at=20
git://sources.calxeda.com/kernel/linux.git #fox-next but they don't=20
appear, is it the right one ?

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

