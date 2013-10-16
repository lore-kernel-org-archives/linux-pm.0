From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: highbank: cpuidle: convert to platform driver
Date: Wed, 16 Oct 2013 10:56:09 -0500
Message-ID: <CAL_Jsq+8ykh6xcwbuS+5gCZHv6zEKU4yEW_us+w_1+BoTOuisQ@mail.gmail.com>
References: <1380278865-27457-1-git-send-email-daniel.lezcano@linaro.org>
	<CAL_Jsq+PoqWf5oAQosPg8N0WWHm-7c+JgDzpGD8OfMyKtvPJ0w@mail.gmail.com>
	<52457F21.3030502@linaro.org>
	<525E9652.6060103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:41935 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab3JPP4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2013 11:56:10 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so446603vbg.39
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2013 08:56:09 -0700 (PDT)
In-Reply-To: <525E9652.6060103@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Oct 16, 2013 at 8:36 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 09/27/2013 02:50 PM, Daniel Lezcano wrote:
>>
>> On 09/27/2013 02:29 PM, Rob Herring wrote:
>>>
>>> On Fri, Sep 27, 2013 at 5:47 AM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> As the ux500 and the kirkwood driver, make the calxeda driver a
>>>> platform driver
>>>>
>>>> [Compiled only]
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>   arch/arm/mach-highbank/highbank.c |    8 ++++++++
>>>>   drivers/cpuidle/cpuidle-calxeda.c |   18 ++++++++++++------
>>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>>
>>> Looks fine to me, but this will conflict with my series. Perhaps I can
>>> pick this up as part of that.
>>
>>
>> Yes I agree, it makes sense.
>
>
> Hi Rob,
>
> were you able to take the patch ? Where is the higbank git tree where I can
> see these patches ? I looked at git://sources.calxeda.com/kernel/linux.git
> #fox-next but they don't appear, is it the right one ?

I still need to send this series to arm-soc. I plan to do so this week.

Rob
