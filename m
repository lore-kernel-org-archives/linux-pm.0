From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/21] cpuidle: make __cpuidle_driver_init() return void
Date: Mon, 23 Sep 2013 15:32:12 +0530
Message-ID: <CAKohpomDFvxnR7x8qdDGqvrkJB9eRBU0RVGijRfLAdOgEPwdqg@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<70ae3eb991bded7c9768ae7934973943c2a1bf05.1379779777.git.viresh.kumar@linaro.org>
	<524010CF.6030605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:52430 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472Ab3IWKCN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2013 06:02:13 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so3185863obc.6
        for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2013 03:02:12 -0700 (PDT)
In-Reply-To: <524010CF.6030605@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patch Tracking <patches@linaro.org>

On 23 September 2013 15:28, Hongbo Zhang <hongbo.zhang@freescale.com> wrote:
> On 09/22/2013 09:20 AM, Viresh Kumar wrote:
>>
>> __cpuidle_driver_init() doesn't return anything except zero and so doesn't
>> really need a return type other than void.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpuidle/driver.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> index 25455e8..8df66c8 100644
>> --- a/drivers/cpuidle/driver.c
>> +++ b/drivers/cpuidle/driver.c
>> @@ -152,7 +152,7 @@ static void cpuidle_setup_broadcast_timer(void *arg)
>>    *
>>    * Returns 0 on success, a negative error code otherwise.
>
> If you want to make it return void, you should also update the above
> comment.

Thanks for the correction..
