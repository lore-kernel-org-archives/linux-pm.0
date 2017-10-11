From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v3 6/8] PM / devfreq: Remove unneeded conditional statement
Date: Wed, 11 Oct 2017 22:45:57 +0900
Message-ID: <CAGTfZH2xTWo99mRugnnN9RHYWPZ-8pwHkG7YVWkMUAjxcgs7=g@mail.gmail.com>
References: <1507691364-3899-1-git-send-email-cw00.choi@samsung.com>
 <CGME20171011030947epcas1p3172d6bb79615a17e08164a150031262e@epcms1p5>
 <1507691364-3899-7-git-send-email-cw00.choi@samsung.com> <20171011113635epcms1p5d6597fdf6a6091737f43adba5c5daf50@epcms1p5>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011113635epcms1p5d6597fdf6a6091737f43adba5c5daf50@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 11, 2017 at 8:36 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> The commit 0ec09ac2cebe9 ("PM / devfreq: Set the freq_table of devfreq
>> device") initializes the freq_table array of each devfreq device always.
>> In result, it is unneeded to check whether profile->freq_table is NULL
>> or not.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 3b9662ffe603..b28810cae7ee 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -315,10 +315,9 @@ int update_devfreq(struct devfreq *devfreq)
>>       freqs.new = freq;
>>       devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>
>> -     if (devfreq->profile->freq_table)
>> -             if (devfreq_update_status(devfreq, freq))
>> -                     dev_err(&devfreq->dev,
>> -                             "Couldn't update frequency transition information.\n");
>> +     if (devfreq_update_status(devfreq, freq))
>> +             dev_err(&devfreq->dev,
>> +                     "Couldn't update frequency transition information.\n");
>
> To make this commit really safe,
> in this commit, please make devfreq_set_freq_table to return error
> and let add_device fails when it returns error.
>
> In the current code, we cannot guarantee that there will be
> freq_table and trans_table available when it hits this line.

You're right. The devfreq_set_freq_table() should return error if fail.
I'll modify them on v4.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
