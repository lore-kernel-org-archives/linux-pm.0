From: qiaozhou <qiaozhou@asrmicro.com>
Subject: Re: [Question] about patch: don't use [delayed_]work_pending()
Date: Fri, 2 Sep 2016 09:17:04 +0800
Message-ID: <6b2fc72b-f99f-f7f1-3221-093943de0950@asrmicro.com>
References: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
 <20160901184503.GD12660@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [140.206.112.110] ([140.206.112.110]:63423 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750737AbcIBBRi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 21:17:38 -0400
In-Reply-To: <20160901184503.GD12660@htj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pm@vger.kernel.org, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, linux-kernel@vger.kernel.org



On 2016年09月02日 02:45, Tejun Heo wrote:
> Hello,
>
> On Thu, Sep 01, 2016 at 05:09:36PM +0800, qiaozhou wrote:
>> In our system, we do cpu clock init in of_clk_init path, and use pm qos to
>> maintain cpu/cci clock. Firstly we init a CCI_CLK_QOS and set a default
>> value, then update CCI_CLK_QOS to limit CCI min frequency according to
>> current cpu frequency. Before calling pm_qos_update_request, irq is
>> disabled, but after the calling, irq is enabled in cancel_delayed_work_sync,
>> which causes some inconvenience before Before this patch is applied, it
>> checks pending work and won't do cancel_delayed_work_sync in this boot up
>> phase.
> So, cancel_delayed_work_sync() usually shouldn't be called with irq
> disabled as it's a possibly blocking call.
Agree.
>
>> The simple calling sequence is like this:
>>
>> start_kernel -> of_clk_init -> cpu_clk_init -> pm_qos_add_request(xx,
>> default_value),
>>
>> then pm_qos_update_request.
>>
>> I don't know whether it's meaningful to still check pending work here, or
>> it's not suggested to use pm_qos_update_request in this early boot up phase.
>> Could you help to share some opinions? (I can fix this issue by adding the
>> current qos value directly instead of default value, though.)
> Hmmm... but I suppose this is super-early in the boot.  Would it make
> sense to have a static variable (e.g. bool clk_fully_initailized) to
> gate the cancel_delayed_sync() call?
You're right that it's indeed super-early stage. But currently we can't 
control the gate of can_delayed_work_sync, since it's inside 
pm_qos_update_request. Out of our control. We can choose to not call 
pm_qos_update_request to avoid this issue, and use pm_qos_add_request 
alternatively. Good to have it.
Thanks a lot.
