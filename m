From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [pm:bleeding-edge 148/162] drivers/base/power/wakeup.c:271:
 undefined reference to `pm_suspend_target_state'
Date: Thu, 11 Jan 2018 01:13:21 +0100
Message-ID: <CAJZ5v0i6AL7e9+=nXOV99OiWrsM4=g9=9RpMq9n58frnmLmfAw@mail.gmail.com>
References: <201801101147.W1FX9kS5%fengguang.wu@intel.com> <CAPDyKFpcwXjW6qs9OpGc8J3byFrtO1OcJzO-fVpocmSu6RraWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40188 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeAKANW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 19:13:22 -0500
Received: by mail-oi0-f68.google.com with SMTP id u83so549943oie.7
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 16:13:21 -0800 (PST)
In-Reply-To: <CAPDyKFpcwXjW6qs9OpGc8J3byFrtO1OcJzO-fVpocmSu6RraWw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Jan 10, 2018 at 3:08 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Rafael,
>
> On 10 January 2018 at 04:26, kbuild test robot <fengguang.wu@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
>> head:   b6c524b2e93b23a396a90031faa29350beeb95fc
>> commit: edd0afcd2eb853ee46a1509a1983b042a6b857f4 [148/162] PM / wakeup: Print warn if device gets enabled as wakeup source during sleep
>> config: i386-randconfig-s0-201801 (attached as .config)
>> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
>> reproduce:
>>         git checkout edd0afcd2eb853ee46a1509a1983b042a6b857f4
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/base/power/wakeup.o: In function `device_wakeup_enable':
>>>> drivers/base/power/wakeup.c:271: undefined reference to `pm_suspend_target_state'
>
> This error is because the .config has CONFIG_SUSPEND unset while
> CONFIG_PM_SLEEP is set.
>
> Adding below to drivers/base/power/wakeup.c fixes it, but perhaps
> there is a better option?

I would try

> #ifndef CONFIG_SUSPEND
> suspend_state_t pm_suspend_target_state;

#define pm_suspend_target_state    (PM_SUSPEND_ON)

> #endif

Thanks,
Rafael
