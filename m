From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC 0/4] PM / devfreq: draft for OPP suspend impl
Date: Wed, 23 Nov 2016 14:51:23 +0100
Message-ID: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

Hello everyone,

this is a (rought) draft for the idea discussed here:
http://www.spinics.net/lists/linux-samsung-soc/msg56311.html

The series is not tested, I don't know if it's even doing what it's supposed to. It's just to show what I have in mind.

Code is obviously inspired by CPUFreq.

With best wishes,
Tobias

Tobias Jakobi (4):
  PM / devfreq: Add DevFreq subsystem suspend/resume
  PM / devfreq: suspend subsystem on system suspend/hibernate
  PM / devfreq: exynos-bus: add support for suspend OPP
  ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus

 arch/arm/boot/dts/exynos4x12.dtsi |  2 ++
 drivers/base/power/main.c         |  3 ++
 drivers/devfreq/devfreq.c         | 75 +++++++++++++++++++++++++++++++++++++++
 drivers/devfreq/exynos-bus.c      |  8 +++++
 include/linux/devfreq.h           | 10 ++++++
 5 files changed, 98 insertions(+)

-- 
2.7.3
