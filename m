From: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Subject: [query] sleep introduced by invoking kernel API during runtime_resume
Date: Tue, 19 Jul 2016 15:03:03 +0800
Message-ID: <CAN2waFsgenQK50_+akz25X0DgVdz6w-zok59hwmE3hLoODZw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34896 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbcGSHDE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 03:03:04 -0400
Received: by mail-yw0-f172.google.com with SMTP id j12so1090601ywb.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2016 00:03:04 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Dear folks,
We run across a warning as 'BUG: sleeping function called from invalid
context at' during rpm resume one device[1]. However, the
device(kbase_device_resume) is unaware of sleeping which introduced by
invoking kernel function. I would like to ask that how to avoid such
kind of warning? It seems that 'RPM_ASYNC' also can not handle, for
there is spin_lock_irq at beginning of pm_runtime_work.


[1]
__pm_runtime_resume
{
      spin_lock_irqsave(&dev->power.lock, flags);      ---> irqs_disabled

      kbase_device_resume->
--->rpm_resume function for device
                 devfreq_resume_device->
                      devfreq_simple_ondemand_handler->
                             devfreq_monitor_resume----->
                                    {
                                       mutex_lock(&devfreq->lock)
    ----> check might_sleep here
                                        ......
                                       mutex_unlock(&devfreq->lock)
                                    }
}

thanks
