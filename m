From: qiaozhou <qiaozhou@asrmicro.com>
Subject: Re: [Question] about patch: don't use [delayed_]work_pending()
Date: Mon, 5 Sep 2016 13:34:46 +0800
Message-ID: <c8aca802-e681-8bc3-4ebc-e86cd9b7e2f4@asrmicro.com>
References: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
 <20160901184503.GD12660@htj.duckdns.org>
 <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
 <20160902135007.GF12660@htj.duckdns.org>
 <20160902142102.GG12660@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [140.206.112.110] ([140.206.112.110]:31249 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750720AbcIEFfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2016 01:35:14 -0400
In-Reply-To: <20160902142102.GG12660@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pm@vger.kernel.org, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, linux-kernel@vger.kernel.org


On 2016年09月02日 22:21, Tejun Heo wrote:
> On Fri, Sep 02, 2016 at 09:50:07AM -0400, Tejun Heo wrote:
>> Hello,
>>
>> On Fri, Sep 02, 2016 at 09:17:04AM +0800, qiaozhou wrote:
>>>>> I don't know whether it's meaningful to still check pending work here, or
>>>>> it's not suggested to use pm_qos_update_request in this early boot up phase.
>>>>> Could you help to share some opinions? (I can fix this issue by adding the
>>>>> current qos value directly instead of default value, though.)
>>>> Hmmm... but I suppose this is super-early in the boot.  Would it make
>>>> sense to have a static variable (e.g. bool clk_fully_initailized) to
>>>> gate the cancel_delayed_sync() call?
>>> You're right that it's indeed super-early stage. But currently we can't
>>> control the gate of can_delayed_work_sync, since it's inside
>>> pm_qos_update_request. Out of our control. We can choose to not call
>>> pm_qos_update_request to avoid this issue, and use pm_qos_add_request
>>> alternatively. Good to have it.
>> Ah sorry, didn't understand that the offending cancel_sync call is in
>> the generic part.  Hmm... but yeah, we should still be able to take
>> the same approach.  I'll see what's the right thing to gate the
>> operation there.
> Does the following patch work?
The patch can fix this issue. Thanks a lot.
>
> Subject: power: avoid calling cancel_delayed_work_sync() during early boot
>
> of_clk_init() ends up calling into pm_qos_update_request() very early
> during boot where irq is expected to stay disabled.
> pm_qos_update_request() uses cancel_delayed_work_sync() which
> correctly assumes that irq is enabled on invocation and
> unconditionally disables and re-enables it.
>
> Gate cancel_delayed_work_sync() invocation with kevented_up() to avoid
> enabling irq unexpectedly during early boot.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Qiao Zhou <qiaozhou@asrmicro.com>
> Link: http://lkml.kernel.org/r/d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com
> ---
>   kernel/power/qos.c |   11 ++++++++++-
>    1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 97b0df7..168ff44 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -482,7 +482,16 @@ void pm_qos_update_request(struct pm_qos_request *req,
>   		return;
>   	}
>   
> -	cancel_delayed_work_sync(&req->work);
> +	/*
> +	 * This function may be called very early during boot, for example,
> +	 * from of_clk_init(), where irq needs to stay disabled.
> +	 * cancel_delayed_work_sync() assumes that irq is enabled on
> +	 * invocation and re-enables it on return.  Avoid calling it until
> +	 * workqueue is initialized.
> +	 */
> +	if (keventd_up())
> +		cancel_delayed_work_sync(&req->work);
> +
>   	__pm_qos_update_request(req, new_value);
>   }
>   EXPORT_SYMBOL_GPL(pm_qos_update_request);

