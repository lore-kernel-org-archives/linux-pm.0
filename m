From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 06/13] thermal/drivers/hisi: Remove pointless lock
Date: Fri, 8 Sep 2017 11:31:00 +0200
Message-ID: <51bcc9ba-513f-ea7f-6780-6c3c703f63ab@linaro.org>
References: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
 <1504554972-2624-6-git-send-email-daniel.lezcano@linaro.org>
 <20170908031641.GD2755@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:46747 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbdIHJbE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Sep 2017 05:31:04 -0400
Received: by mail-wm0-f51.google.com with SMTP id i189so1297261wmf.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Sep 2017 02:31:03 -0700 (PDT)
In-Reply-To: <20170908031641.GD2755@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org

On 08/09/2017 05:16, Eduardo Valentin wrote:
> On Mon, Sep 04, 2017 at 09:56:05PM +0200, Daniel Lezcano wrote:
>> The threaded interrupt inspect the sensors structure to look in the temp
>> threshold field, but this field is read-only in all the code, except in the
>> probe function before the threaded interrupt is set. In other words there
>> is not race window in the threaded interrupt when reading the field value.
> 
> 
> Sure? Not even if you have a userspace process read the zone temp via
> sysfs and the polling workqueue reading the temp too?

They are both read-only operations. There is no write-read race.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
