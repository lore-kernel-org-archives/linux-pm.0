From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [pm:bleeding-edge 148/162] drivers/base/power/wakeup.c:271:
 undefined reference to `pm_suspend_target_state'
Date: Wed, 10 Jan 2018 15:08:02 +0100
Message-ID: <CAPDyKFpcwXjW6qs9OpGc8J3byFrtO1OcJzO-fVpocmSu6RraWw@mail.gmail.com>
References: <201801101147.W1FX9kS5%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:45327 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752108AbeAJOID (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 09:08:03 -0500
Received: by mail-io0-f196.google.com with SMTP id e20so22528173iof.12
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 06:08:03 -0800 (PST)
In-Reply-To: <201801101147.W1FX9kS5%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>

Rafael,

On 10 January 2018 at 04:26, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   b6c524b2e93b23a396a90031faa29350beeb95fc
> commit: edd0afcd2eb853ee46a1509a1983b042a6b857f4 [148/162] PM / wakeup: Print warn if device gets enabled as wakeup source during sleep
> config: i386-randconfig-s0-201801 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout edd0afcd2eb853ee46a1509a1983b042a6b857f4
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/base/power/wakeup.o: In function `device_wakeup_enable':
>>> drivers/base/power/wakeup.c:271: undefined reference to `pm_suspend_target_state'

This error is because the .config has CONFIG_SUSPEND unset while
CONFIG_PM_SLEEP is set.

Adding below to drivers/base/power/wakeup.c fixes it, but perhaps
there is a better option?

#ifndef CONFIG_SUSPEND
suspend_state_t pm_suspend_target_state;
#endif

Kind regards
Uffe

>
> vim +271 drivers/base/power/wakeup.c
>
>    256
>    257  /**
>    258   * device_wakeup_enable - Enable given device to be a wakeup source.
>    259   * @dev: Device to handle.
>    260   *
>    261   * Create a wakeup source object, register it and attach it to @dev.
>    262   */
>    263  int device_wakeup_enable(struct device *dev)
>    264  {
>    265          struct wakeup_source *ws;
>    266          int ret;
>    267
>    268          if (!dev || !dev->power.can_wakeup)
>    269                  return -EINVAL;
>    270
>  > 271          if (pm_suspend_target_state != PM_SUSPEND_ON)
>    272                  dev_dbg(dev, "Suspicious %s() during system transition\n", __func__);
>    273
>    274          ws = wakeup_source_register(dev_name(dev));
>    275          if (!ws)
>    276                  return -ENOMEM;
>    277
>    278          ret = device_wakeup_attach(dev, ws);
>    279          if (ret)
>    280                  wakeup_source_unregister(ws);
>    281
>    282          return ret;
>    283  }
>    284  EXPORT_SYMBOL_GPL(device_wakeup_enable);
>    285
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
