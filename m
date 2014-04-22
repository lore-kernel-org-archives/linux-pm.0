From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH] cpuidle: governor: menu: move repeated correction factor
 check to init
Date: Tue, 22 Apr 2014 17:56:39 +0530
Message-ID: <CANuQgHFdYhTc8YZ2MbQv0r_CsJGDLwHOqy9NuVDEfVUOTsbRpA@mail.gmail.com>
References: <1397137433-19106-1-git-send-email-chander.kashyap@linaro.org>
	<2870361.ixyW1GZfvF@vostro.rjw.lan>
	<CANuQgHGieSC1poZvu906MTHk71akFge_JdSnqyvTd3-Ac-Pd2g@mail.gmail.com>
	<2942005.cg9fS5oSJO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38201 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413AbaDVM0k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 08:26:40 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so3202620obc.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 05:26:39 -0700 (PDT)
In-Reply-To: <2942005.cg9fS5oSJO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rafael.j.wysocki@intel.com, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

On 22 April 2014 16:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, April 22, 2014 03:24:21 PM Chander Kashyap wrote:
>> +cc
>> linux-pm@vger.kernel.org.
>
> And can you please resend the patch?  So that it shows up in Patchwork,
> for example?
>

Yes i will resend it again.

>
>> On 22 April 2014 15:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Tuesday, April 22, 2014 08:27:53 AM Chander Kashyap wrote:
>> >> ping
>> >
>> > Please CC cpuidle patches to linux-pm@vger.kernel.org.
>>
>> +cc to linux-pm@vger.kernel.org.
>> Thanks Rafael
>>
>> >
>> > Thanks!
>> >
>> >> On 10 April 2014 19:57, Tuukka Tikkanen <tuukka.tikkanen@linaro.org> wrote:
>> >> > On 10 April 2014 16:43, Chander Kashyap <chander.kashyap@linaro.org> wrote:
>> >> >> In menu_select function we check for correction factor every time.
>> >> >> If it is zero we are initializing to unity. Hence move it to init function
>> >> >> and initialise by unity, hence avoid repeated comparisons.
>> >> >>
>> >> >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
>> >> >> ---
>> >> >>  drivers/cpuidle/governors/menu.c |   15 ++++++++-------
>> >> >>  1 file changed, 8 insertions(+), 7 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> >> >> index cf7f2f0..048f6d9 100644
>> >> >> --- a/drivers/cpuidle/governors/menu.c
>> >> >> +++ b/drivers/cpuidle/governors/menu.c
>> >> >> @@ -315,13 +315,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>> >> >>         multiplier = performance_multiplier();
>> >> >>
>> >> >>         /*
>> >> >> -        * if the correction factor is 0 (eg first time init or cpu hotplug
>> >> >> -        * etc), we actually want to start out with a unity factor.
>> >> >> -        */
>> >> >> -       if (data->correction_factor[data->bucket] == 0)
>> >> >> -               data->correction_factor[data->bucket] = RESOLUTION * DECAY;
>> >> >> -
>> >> >> -       /*
>> >> >>          * Force the result of multiplication to be 64 bits even if both
>> >> >>          * operands are 32 bits.
>> >> >>          * Make sure to round up for half microseconds.
>> >> >> @@ -453,9 +446,17 @@ static int menu_enable_device(struct cpuidle_driver *drv,
>> >> >>                                 struct cpuidle_device *dev)
>> >> >>  {
>> >> >>         struct menu_device *data = &per_cpu(menu_devices, dev->cpu);
>> >> >> +       int i;
>> >> >>
>> >> >>         memset(data, 0, sizeof(struct menu_device));
>> >> >>
>> >> >> +       /*
>> >> >> +        * if the correction factor is 0 (eg first time init or cpu hotplug
>> >> >> +        * etc), we actually want to start out with a unity factor.
>> >> >> +        */
>> >> >> +       for(i = 0; i < BUCKETS; i++)
>> >> >> +               data->correction_factor[i] = RESOLUTION * DECAY;
>> >> >> +
>> >> >>         return 0;
>> >> >>  }
>> >> >>
>> >> >> --
>> >> >> 1.7.9.5
>> >> >>
>> >> >
>> >> > Reviewed-by: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
>> >>
>> >>
>> >>
>> >>
>> >
>> > --
>> > I speak only for myself.
>> > Rafael J. Wysocki, Intel Open Source Technology Center.
>>
>>
>>
>>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.



-- 
with warm regards,
Chander Kashyap
