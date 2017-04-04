From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Mon, 3 Apr 2017 19:55:10 -0700
Message-ID: <CALAqxLV7Er9kq-E97zG=U1tLTBqDFyYqC8BdofHNjtU=uo_uvw@mail.gmail.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33195 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdDDCzM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 22:55:12 -0400
Received: by mail-wr0-f171.google.com with SMTP id w43so194113324wrb.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 19:55:11 -0700 (PDT)
In-Reply-To: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Mar 30, 2017 at 5:04 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> There is possibility to enter dw_i2c_plat_suspend() callback twice
> during system suspend under certain cases which is causing here warnings
> from clk_core_disable() and clk_core_unprepare() as well as accessing the
> registers that can be power gated.
>
> Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
> system suspend") implemented a prepare callback that checks for runtime
> suspended device which allow PM core to set direct_complete flag and
> skip system suspend and resume callbacks.
>
> However it can still happen if nothing resumes the device prior system
> syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
> unsets the direct_complete flag of the parent in __device_suspend() thus
> causing PM code to not skip the system suspend/resume callbacks.
>
> Avoid this by checking runtime status in suspend and resume callbacks
> and return directly if device is runtime suspended. This affects only
> system suspend/resume since during runtime suspend/resume runtime status
> is suspending (not suspended) or resuming.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

This works for me on my HiKey board!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
