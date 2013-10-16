From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Wed, 16 Oct 2013 18:01:04 +0200
Message-ID: <525EB840.5050607@linaro.org>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>	<CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>	<52457F21.3030502@linaro.org>	<525E9652.6060103@linaro.org> <CAL_Jsq+8ykh6xcwbuS+5gCZHv6zEKU4yEW_us+w_1+BoTOuisQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:55452 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018Ab3JPQBH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 12:01:07 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so461458eek.22
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 09:01:06 -0700 (PDT)
In-Reply-To: <CAL_Jsq+8ykh6xcwbuS+5gCZHv6zEKU4yEW_us+w_1+BoTOuisQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10/16/2013 05:56 PM, Rob Herring wrote:
> On Wed, Oct 16, 2013 at 8:36 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 09/27/2013 02:50 PM, Daniel Lezcano wrote:
>>>
>>> On 09/27/2013 02:29 PM, Rob Herring wrote:
>>>>
>>>> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> As the ux500 and the kirkwood driver, make the calxeda driver a
>>>>> platform driver
>>>>>
>>>>> [Compiled only]
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>>    arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>>>>    drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>>>>    2 files changed, 20 insertions(+), 6 deletions(-)
>>>>
>>>>
>>>> Looks fine to me, but this will conflict with my series. Perhaps I=
 can
>>>> pick this up as part of that.
>>>
>>>
>>> Yes I agree, it makes sense.
>>
>>
>> Hi Rob,
>>
>> were you able to take the patch ? Where is the higbank git tree wher=
e I can
>> see these patches ? I looked at git://sources.calxeda.com/kernel/lin=
ux.git
>> #fox-next but they don't appear, is it the right one ?
>
> I still need to send this series to arm-soc. I plan to do so this wee=
k.

Ok, thanks.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

