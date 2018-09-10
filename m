From: Fieah Lim <kw@fieahl.im>
Subject: Re: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
Date: Tue, 11 Sep 2018 05:24:37 +0800
Message-ID: <CACXwQcBUZkHDy3HZTPYR8+hsa3GZ=Ogyuimdow=y_8trbALNeA@mail.gmail.com>
References: <20180910173953.10113-1-kw@fieahl.im> <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 11, 2018 at 4:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Sep 10, 2018 at 7:40 PM Fieah Lim <kw@fieahl.im> wrote:
>>
>> Currently we use ktime_us_delta() to calculate last residency and
>> state usage unconditionally, it makes no sense to do this calculation
>> when we fails to enter any idle state.
>> It can be optimize by moving the calculation after entered_state >= 0
>>
>> While at it, merge those comment blocks into one and remove a
>> space between type casting of diff.
>>
>> This patch has no functional changes.
>>
>> Signed-off-by: Fieah Lim <kw@fieahl.im>
>> ---
>> Changes from v1:
>>  - Rewrite changelog as Rafael J. Wysocki suggested
>> ---
>>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 6df894d65d9e..5f6b2c9b6555 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>>         if (!cpuidle_state_is_coupled(drv, index))
>>                 local_irq_enable();
>>
>> -       diff = ktime_us_delta(time_end, time_start);
>> -       if (diff > INT_MAX)
>> -               diff = INT_MAX;
>> -
>> -       dev->last_residency = (int) diff;
>> +       dev->last_residency = 0;
>
> You don't need this line if you retain the "else" branch below, do you?
>
You are right, should I make a v3?

Please bear with me if anything wrong in this reply.
I'm not sure if I doing this right. This is my first reply to a mailing list.
Thank you.
>>
>>         if (entered_state >= 0) {
>> -               /* Update cpuidle counters */
>> -               /* This can be moved to within driver enter routine
>> +               /* Update cpuidle counters
>> +                * This can be moved to within driver enter routine,
>>                  * but that results in multiple copies of same code.
>>                  */
>> +               diff = ktime_us_delta(time_end, time_start);
>> +               if (diff > INT_MAX)
>> +                       diff = INT_MAX;
>> +
>> +               dev->last_residency = (int)diff;
>>                 dev->states_usage[entered_state].time += dev->last_residency;
>>                 dev->states_usage[entered_state].usage++;
>> -       } else {
>> -               dev->last_residency = 0;
>>         }
>>
>>         return entered_state;
>> --
>> 2.18.0
>>
