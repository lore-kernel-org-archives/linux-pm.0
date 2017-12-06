From: Hareesh Gundu <hareeshg@codeaurora.org>
Subject: Re: [PATCH] power: qos: Export pm_qos_update_request_timeout()
Date: Wed, 6 Dec 2017 21:05:39 +0530
Message-ID: <38aa8cac-3e7b-8406-a8d0-ee13b35d4811@codeaurora.org>
References: <1512470739-21960-1-git-send-email-hareeshg@codeaurora.org>
 <CAJZ5v0hwFo2hake52oGqrLt09ivfNCmw8pJY6uwqXVQ97FchkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdLFPfq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 10:35:46 -0500
In-Reply-To: <CAJZ5v0hwFo2hake52oGqrLt09ivfNCmw8pJY6uwqXVQ97FchkA@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, jcrouse@codeaurora.org, hareeshg@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>


On 12/5/2017 8:54 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 5, 2017 at 11:45 AM, Hareesh Gundu <hareeshg@codeaurora.org> wrote:
>> Add EXPORT_SYMBOL_GPL to pm_qos_update_request_timeout,
>> so that it can be usable from modules similar to the
>> pm_qos_update_request().
>>
>> Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
There is no in-tree kernel module using it. It's required for modules 
built out-tree kernel.
Does it really required show out tree kernel module uses this symbol ?
> I'd rather see a modular user of this along with the export.
>
>> ---
>>   kernel/power/qos.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
>> index 9d75039..3f501b4 100644
>> --- a/kernel/power/qos.c
>> +++ b/kernel/power/qos.c
>> @@ -515,6 +515,7 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
>>
>>          schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
>>   }
>> +EXPORT_SYMBOL_GPL(pm_qos_update_request_timeout);
>>
>>   /**
>>    * pm_qos_remove_request - modifies an existing qos request
>> --
>> 1.9.1
>>
