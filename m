From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Hibernation or S2R doesn't cover entire
 power directory
Date: Mon, 25 Sep 2017 00:44:20 +0200
Message-ID: <CAJZ5v0hv3T7L0c5URrVHC=H5V3h+W7OLRXVMVXLQf-VuTT-E+Q@mail.gmail.com>
References: <18e729501c1ebe4798d17b8d8a60ba102ebc2837.1505922834.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36801 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdIXWoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Sep 2017 18:44:21 -0400
In-Reply-To: <18e729501c1ebe4798d17b8d8a60ba102ebc2837.1505922834.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Sep 20, 2017 at 5:58 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The command:
>
>  $ scripts/get_maintainer.pl -f drivers/base/power/opp/core.c
>
> is incorrectly picking maintainers from Hibernation and Suspend to RAM
> as well, simply because the entries in MAINTAINERS file contains the
> entire power directory. Though the only concerning file is main.c
> really.

No, it is not the only one.  The others are common.c, trace.c,
wakeup.c, wakeirq.c, sysfs.c, generic_ops.c and power.h (if I have not
overlooked any).

I'm not actually sure how to fix this issue other than by listing all
of the files in question directly in there.

Thanks,
Rafael
