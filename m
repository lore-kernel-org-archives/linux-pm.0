From: qiaozhou <qiaozhou@asrmicro.com>
Subject: [Question] about patch: don't use [delayed_]work_pending()
Date: Thu, 1 Sep 2016 17:09:36 +0800
Message-ID: <d2501c4c-8e7b-bea3-1b01-000b36b5dfe9@asrmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [140.206.112.110] ([140.206.112.110]:7021 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751080AbcIAJZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 05:25:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tj@kernel.org, linux-pm@vger.kernel.org, Wang Wilbur <wilburwang@asrmicro.com>, Wu Gang <gangwu@asrmicro.com>, linux-kernel@vger.kernel.org

Hi Tejun,

I have a question related with below patch, and need your suggestion.

In our system, we do cpu clock init in of_clk_init path, and use pm qos 
to maintain cpu/cci clock. Firstly we init a CCI_CLK_QOS and set a 
default value, then update CCI_CLK_QOS to limit CCI min frequency 
according to current cpu frequency. Before calling 
pm_qos_update_request, irq is disabled, but after the calling, irq is 
enabled in cancel_delayed_work_sync, which causes some inconvenience 
before Before this patch is applied, it checks pending work and won't do 
cancel_delayed_work_sync in this boot up phase.

The simple calling sequence is like this:

start_kernel -> of_clk_init -> cpu_clk_init -> pm_qos_add_request(xx, 
default_value),

then pm_qos_update_request.

I don't know whether it's meaningful to still check pending work here, 
or it's not suggested to use pm_qos_update_request in this early boot up 
phase. Could you help to share some opinions? (I can fix this issue by 
adding the current qos value directly instead of default value, though.)

Thanks a lot.

commit ed1ac6e91a3ff7c561008ba57747cd6cbc49385e
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Jan 11 13:37:33 2013 +0100

     PM: don't use [delayed_]work_pending()

     There's no need to test whether a (delayed) work item is pending
     before queueing, flushing or cancelling it, so remove work_pending()
     tests used in those cases.

     Signed-off-by: Tejun Heo <tj@kernel.org>
     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

...

@@ -359,8 +359,7 @@ void pm_qos_update_request(struct pm_qos_request *req,
                 return;
         }

-       if (delayed_work_pending(&req->work))
-               cancel_delayed_work_sync(&req->work);
+       cancel_delayed_work_sync(&req->work);
...

Best Regards

Qiao

