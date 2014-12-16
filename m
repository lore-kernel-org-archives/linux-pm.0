From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] cpufreq: imx6: prorect calls to dev_pm_opp_get_opp_count
 with RCU lock
Date: Mon, 15 Dec 2014 21:41:03 -0800
Message-ID: <CAE_wzQ_J088FOzBoq66irs4A=ShJ3rqzLmT2sEP6dmvPE6cB2w@mail.gmail.com>
References: <20141216005048.GA3802@dtor-ws>
	<CAKohpok+b36_7SAUZmgM6jdtiWNu01u_0U4zQqE1b3B4xh0Svw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:64039 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaLPFlF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 00:41:05 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so6452367igb.5
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:41:04 -0800 (PST)
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com. [209.85.223.176])
        by mx.google.com with ESMTPSA id jg3sm5951823igb.12.2014.12.15.21.41.03
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 21:41:03 -0800 (PST)
Received: by mail-ie0-f176.google.com with SMTP id tr6so12216335ieb.21
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:41:03 -0800 (PST)
In-Reply-To: <CAKohpok+b36_7SAUZmgM6jdtiWNu01u_0U4zQqE1b3B4xh0Svw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Torokhov <dtor@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@freescale.com>, Philipp Zabel <p.zabel@pengutronix.de>, Anson Huang <b20788@freescale.com>, John Tobias <john.tobias.ph@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 15, 2014 at 9:33 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16 December 2014 at 06:20, Dmitry Torokhov <dtor@chromium.org> wrote:
>> dev_pm_opp_get_opp_count() must be called with RCU lock held.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>> ---
>>
>> Not tested at all...
>>
>>  drivers/cpufreq/imx6q-cpufreq.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
>> index 380a90d..851d4fd 100644
>> --- a/drivers/cpufreq/imx6q-cpufreq.c
>> +++ b/drivers/cpufreq/imx6q-cpufreq.c
>> @@ -200,7 +200,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>>          * Just, incase the platform did not supply the OPP
>>          * table, it will try to get it.
>>          */
>> +       rcu_read_lock();
>>         num = dev_pm_opp_get_opp_count(cpu_dev);
>> +       rcu_read_unlock();
>>         if (num < 0) {
>>                 ret = of_init_opp_table(cpu_dev);
>>                 if (ret < 0) {
>> @@ -211,7 +213,9 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>>                 /* Because we have added the OPPs here, we must free them */
>>                 free_opp = true;
>>
>> +               rcu_read_lock();
>>                 num = dev_pm_opp_get_opp_count(cpu_dev);
>> +               rcu_read_unlock();
>>                 if (num < 0) {
>>                         ret = num;
>>                         dev_err(cpu_dev, "no OPP table is found: %d\n", ret);
>
> This one looks fine for sure but I was wondering for the users which just
> need to call opp-count from under the locks, what about something like:
>
> dev_pm_opp_get_opp_count_locked() ?

Yeah, for the majority of callers taking the lock won't hurt as they
call it in their init code.

Thanks,
Dmitry
