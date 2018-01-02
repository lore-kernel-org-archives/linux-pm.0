From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 2 Jan 2018 12:21:43 +0100
Message-ID: <CAJZ5v0hvCuJbt8wtCJFcLRpCdkNu=vGEuA7_dCWhkXgvGxgizw@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <20180102105105.GA15376@wunner.de>
 <CAJZ5v0hYaEWPhqEuBkj7yusQiY1wfeJAn7QDfp-gmOYyNXatEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:45446 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeABLVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 06:21:44 -0500
In-Reply-To: <CAJZ5v0hYaEWPhqEuBkj7yusQiY1wfeJAn7QDfp-gmOYyNXatEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Jan 2, 2018 at 12:02 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 2, 2018 at 11:51 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> On Tue, Jan 02, 2018 at 01:56:28AM +0100, Rafael J. Wysocki wrote:

[cut]

>
>> One addition that would be really helpful:  pm_runtime_force_suspend()
>> should also force-suspend all children and consumers of the given
>> device.  Likewise, those should be resumed on pm_runtime_force_resume().
>> Then I could just add a device link from the audio PCI device on the GPU
>> to the graphics PCI device and just call pm_runtime_force_*() on the
>> graphics device (supplier) to magically power them both off and on.
>
> Actually, the assumption is that pm_runtime_force_suspend() must be
> called for the children before it is called for the parent even
> without my patch, so it is just not going to work this way.

Moreover, what if those devices have nonzero usage counters?  There
may be other reasons for that than just dependencies, like for example
user space might have written "on" to their "control" files in sysfs.

What you are looking for doesn't seem to match the runtime PM
framework's assumptions, I'm afraid.

Thanks,
Rafael
