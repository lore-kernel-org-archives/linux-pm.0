From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC v2 0/7] PM / devfreq: draft for OPP suspend impl (even draftier)
Date: Mon, 19 Dec 2016 03:16:20 +0100
Message-ID: <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:43801 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1762087AbcLSCQi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Dec 2016 21:16:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hello everyone,

this is v2 of the RFC. You can find the first version here:
https://www.spinics.net/lists/linux-samsung-soc/msg56331.html

I'm still unhappy with this approach, for multiple reasons:
- the global boolean -- cpufreq also has it, but I have the feeling that we don't need it here.
- keeping track of which device was suspended looks convoluted -- some reference counting would definitely help here.
- the bus driver (here exynos_bus) sets suspend_freq, but devfreq core actually uses it.
- returning -EBUSY from devfreq_{suspend,resume}_device() requires handling this in the device drivers -- again refcounting could solve this.
- rather a question: do we need the restore on resume -- or should be just wait for the next update through the governor?
- like Chanwoo already suggested, move setting suspend freq to devfreq_suspend_device().

Concerning refcounting, I'm a bit unsure what we wanna count here? Usually we count usage. If usage goes from zero to one, we do something (alloc), and when it goes back from one to zero (free).
If we keep the current semantics however we have to count number of suspends. That's kinda unintuitive if you ask me.

With best wishes,
Tobias

Tobias Jakobi (7):
  PM / devfreq: Replace 'stop_polling' boolean with flags
  PM / devfreq: Track suspend state of DevFreq devices
  PM / devfreq: Add DevFreq subsystem suspend/resume
  PM / devfreq: Suspend subsystem on system suspend/hibernate
  PM / devfreq: exynos-bus: add support for suspend OPP
  ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus
  ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus for Prime

 arch/arm/boot/dts/exynos4412-prime.dtsi |   2 +
 arch/arm/boot/dts/exynos4x12.dtsi       |   2 +
 drivers/base/power/main.c               |   3 +
 drivers/devfreq/devfreq.c               | 170 ++++++++++++++++++++++++++++++--
 drivers/devfreq/exynos-bus.c            |   8 ++
 include/linux/devfreq.h                 |  14 ++-
 6 files changed, 188 insertions(+), 11 deletions(-)

-- 
2.7.3

