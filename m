Return-Path: <SRS0=OBSp=4U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1617AC3F2D1
	for <linux-pm@archiver.kernel.org>; Tue,  3 Mar 2020 02:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CC1217F4
	for <linux-pm@archiver.kernel.org>; Tue,  3 Mar 2020 02:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgCCC1H (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:27:07 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11135 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbgCCC1H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 21:27:07 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1CA85A9F2E78C2E8C79E;
        Tue,  3 Mar 2020 10:27:02 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.207) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 10:26:56 +0800
Subject: Re: [PATCH -next] drivers/base/power: fix build error without SYSFS
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <christian.brauner@ubuntu.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <chenzhou10@huawei.com>,
        <rjw@rjwysocki.net>, <pavel@ucw.cz>
References: <20200302092918.40163-1-yaohongbo@huawei.com>
 <20200302092308.GA1997164@kroah.com>
From:   Hongbo Yao <yaohongbo@huawei.com>
Message-ID: <1b1e850f-18e1-4410-672c-4e010bae46e6@huawei.com>
Date:   Tue, 3 Mar 2020 10:26:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200302092308.GA1997164@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.207]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2020/3/2 17:23, Greg KH wrote:
> On Mon, Mar 02, 2020 at 05:29:18PM +0800, Hongbo Yao wrote:
>> If CONFIG_SYSFS=n, the following error is seen while building 
>> drivers/base/power/sysfs.c:
>>
>> drivers/base/power/sysfs.c: In function dpm_sysfs_change_owner:
>> drivers/base/power/sysfs.c:708:44: error: passing argument 2 of
>> sysfs_group_change_owner from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>   rc = sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
>>                                             ^
>> In file included from ./include/linux/kobject.h:20:0,
>>                  from ./include/linux/device.h:17,
>>                  from drivers/base/power/sysfs.c:3:
>> ./include/linux/sysfs.h:564:19: note: expected const struct
>> attribute_group ** but argument is of type const struct attribute_group *
>>
>> dpm_sysfs_change_owner() should only used when CONFIG_SYSFS is
>> defined.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 3b52fc5d7876 ("drivers/base/power: add dpm_sysfs_change_owner()")
>> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
>> ---
>>  drivers/base/power/power.h | 10 +++++++++-
>>  drivers/base/power/sysfs.c |  2 ++
> 
> You shouldn't have to add #ifdefs to a .c file here, it should all be
> able to be fixed in the .h file by putting proper "empty" functions.

  I think it's a little difficult to fix this without changing the .c file,
  unless changing the Kconfig.

  This function was implemeted when CONFIG_PM=y, and if CONFIG_PM=n, this
  function would be "empty".

  However, I found this function should depends on CONFIG_SYSFS, if
  CONFIG_SYSFS=n, this function should also be empty, so only changing the
  dependency of the header file will cause redefinition.

  thanks,
  Hongbo.

> thanks,
> 
> greg k-h
> 
> .
> 

