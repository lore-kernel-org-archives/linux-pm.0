From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] PM / devfreq: Send the DEVFREQ_POSTCHANGE notification
 when target() is failed
Date: Thu, 23 Jun 2016 23:24:34 +0900
Message-ID: <CAGTfZH2wb8bgXofW8AKHLXBrGAxyxE46J7mZSwyS_vQP-Q2bZw@mail.gmail.com>
References: <1466648323-776-1-git-send-email-cw00.choi@samsung.com> <CAJZ5v0h41W6SCpEOvwEW1Mj=C5ZyoC7gA4OpMi6cdECqM7oGZw@mail.gmail.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35579 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcFWOYl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 10:24:41 -0400
In-Reply-To: <CAJZ5v0h41W6SCpEOvwEW1Mj=C5ZyoC7gA4OpMi6cdECqM7oGZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

2016-06-23 22:40 GMT+09:00 Rafael J. Wysocki <rafael@kernel.org>:
> On Thu, Jun 23, 2016 at 4:18 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch sends the DEVFREQ_POSTCHANGE notification when
>> devfreq->profile->targer() is failed. The PRECHANGE/POSTCHANGE
>> should be paired.
>>
>> Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
>> Reported-by: Lin Huang <hl@rock-chips.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1d6c803804d5..387799fec4c3 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -268,8 +268,11 @@ int update_devfreq(struct devfreq *devfreq)
>>         devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>
>>         err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
>> -       if (err)
>> +       if (err) {
>> +               freqs.new = cur_freq;
>> +               devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>                 return err;
>> +       }
>>
>>         freqs.new = freq;
>>         devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> --
>
> This looks like a fix for a recent regression, so I can apply it directly.
>
> Do you want me to do that?

Yes. Thanks for picking this patch up.

Regards,
Chanwoo Choi
