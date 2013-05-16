From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/6] Thermal: armada_thermal: Remove redundant platform_set_drvdata()
Date: Thu, 16 May 2013 14:21:53 +0530
Message-ID: <CAK9yfHxFbm1k2+GZ3vCk4bdhX7q1pANweOFhZdBa2Ww+5h1fuA@mail.gmail.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org>
	<5183B1B0.5030806@ti.com>
	<CAK9yfHy0fjYt3h4-E5rspARJGAfA1rtvGGiHrNhhbWuQ-fbkwg@mail.gmail.com>
	<1368693986.2063.40.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42884 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3EPIvy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2013 04:51:54 -0400
Received: by mail-ob0-f170.google.com with SMTP id er7so3138916obc.15
        for <linux-pm@vger.kernel.org>; Thu, 16 May 2013 01:51:54 -0700 (PDT)
In-Reply-To: <1368693986.2063.40.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

On 16 May 2013 14:16, Zhang Rui <rui.zhang@intel.com> wrote:
> On Thu, 2013-05-16 at 13:39 +0530, Sachin Kamat wrote:
>> On 3 May 2013 18:16, Eduardo Valentin <eduardo.valentin@ti.com> wrote:
>> > On 03-05-2013 05:57, Sachin Kamat wrote:
>> >> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> >> driver is bound) removes the need to set driver data field to
>> >> NULL.
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> >
>> > I am fine with this patch.
>> >
>> > Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>
>> Ping on this series Rui :)
>>
> I think I've applied this patch set.
> sorry that I did not reply the email.

No problem :)

> all patches are in thermal -next tree now.

Thanks Rui.



-- 
With warm regards,
Sachin
