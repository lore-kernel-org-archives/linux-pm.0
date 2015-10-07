From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: As of kernel 4.3-rc1 system will not stay in S3 suspend [REGRESSION]
Date: Thu, 8 Oct 2015 01:40:57 +0200
Message-ID: <CAJZ5v0h=5UXgCzPKkraRUPxEumODC-kpQ5-j6oHoYZVinbFzHA@mail.gmail.com>
References: <001f01d10152$ab653de0$022fb9a0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34566 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbJGXk6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 19:40:58 -0400
Received: by lbbwt4 with SMTP id wt4so28781216lbb.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 16:40:57 -0700 (PDT)
In-Reply-To: <001f01d10152$ab653de0$022fb9a0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Vetter <daniel.vetter@intel.com>

On Thu, Oct 8, 2015 at 12:51 AM, Doug Smythies <dsmythies@telus.net> wrote:
> Hi,
>
> This started somewhere between Kernel 4.2 and 4.3-rc1,
> but I only noticed it now.
>
> The first S3 suspend after a fresh boot works fine.
> Thereafter, suspends simply resume again immediately.
>
> I get the following errors on my console:
>
> [  152.697247] i915 0000:00:02.0: GEM idle failed, resume might fail
> [  152.697258] pci_pm_suspend(): i915_pm_suspend+0x0/0x50 [i915] returns -11
> [  152.697262] dpm_run_callback(): pci_pm_suspend+0x0/0x140 returns -11
> [  152.697264] PM: Device 0000:00:02.0 failed to suspend async: error -11

This indicates some problems with the i915 graphics driver, so CCing
its maintainer Daniel Vetter.

> [  152.697306] PM: Some devices failed to suspend, or early wake event detected
>
> The issue is not limited to my normal way of doing suspend, using "pm-suspend".
> It also happens using the "echo mem > /sys/power/state" method that Rafael mentioned
> during the 4.2 cycle.
>
> I have searched the bug reports and such and didn't find a related bug, (which
> doesn't mean it doesn't exist, just that if it does I didn't find it).
>
> I am about to start bisecting the kernel, but thought to ask here first, just in case
> someone already knows the root issue.

You may try to restrict the bisection to the i915 commits to start with.

Thanks,
Rafael
