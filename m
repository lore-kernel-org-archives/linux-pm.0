From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH RFC 00/12] The Linux Kernel Thermal Framework Docbook
Date: Mon,  9 Feb 2015 17:34:01 -0400
Message-ID: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:42876 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbbBJAhi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 19:37:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

(sorry if you got this duplicated, this time I am copying the mailing lists)

Hello Rui, linux-pm,

It's been some time that I have started this documentation project. The target
is to organize the thermal code documentation, using the kernel docbook format.
In other words, the Linux kernel Documentation would be earning a new Docbook,
a thermal Docbook.

The work is in progress. I started a few chapters, but never got the chance to finish
what I initially intended. However, I decided to share already with you because
I would like to hear what people would like to see in the Docbook.

The whole idea is to consolidate what we have currently spread under Documentation,
in a single place, the new Docbook. So, we would be moving the Documentation/thermal/sysfs-api.txt
content to this Docbook (not done yet).

The overall content organization that I am envisioning is organized in the following Chapters:
1 - Introduction: Overall thermal problem statement and the Linux Kernel solution. In here we should also
give an overview of the framework design strategies and decisions. Under sysfs-api.txt we have something
talking about it, but I believe it got dated already. In this chapter, we also include a small dictionary.
Current status: In progress
2 - Governors: In here we would document all the existing governors and their implemented policies. Also,
I would like to have a simple example on how to write your own thermal governor.
Current status: In progress.
3 - Cooling Devices: I believe here we should include the documentation of the existing cooling devices in
the kernel tree. Also, we should include an example on how to implement a cooling device.
4 - Thermal zone drivers: An example on a simple thermal zone device driver code. Discussion on the multiple
ways of implementing one: standard, of-thermal support, etc.
5 - Generic code: Documentation of the design decision of our generic drivers: cpu cooling, clock cooling,
of-thermal, etc.
6 - User space ABI: Documentation of what we expose to userland.
7 - API Reference: A chapter with the documentation coming from in code comments.

The current code needs a couple of fixes to achieve Chapter 6, API Reference, though. I am
sending in this series a couple of examples of what needs to be fixed.

The content of Chapter 6 and Chapter 7 is more or less an overlap of what we have mostly
inside sysfs-api.txt. I believe it is easier to maintain code comments than maintaining a
separate file to talk about code documentation. Therefore the motivation to write the Docbook.
Besides, within this Docbook we should cover a better overview of the framework, that we currently lack.

I am not sure if we need to have specific thermal zone driver documentation. Probably not. But driver
authors, rise your voice if you would like to have one.

Comments are welcome.

BR,

Eduardo Valentin (12):
  Documentation: Introduce Linux Kernel Thermal Framework DocBook
  Documentation: thermal docbook: add glossary
  thermal: cpu_cooling: remove duplicate documentation entries
  thermal: of-thermal: remove kernel doc warn
  thermal: thermal.h: minor kernel doc fix
  thermal: thermal_core: correct kernel doc wording on
    thermal_zone_get_temp
  Documentation: thermal docbook: introduce API reference chapter
  thermal: fair share: fix kernel doc entry
  thermal: user space: fix kernel doc entry
  thermal: bang bang: fix kernel doc entry
  thermal: step wise: fix kernel doc entry
  Documentation: thermal docbook: introduce governor chapter

 Documentation/DocBook/Makefile     |   3 +-
 Documentation/DocBook/thermal.tmpl | 291 +++++++++++++++++++++++++++++++++++++
 drivers/thermal/fair_share.c       |   5 +-
 drivers/thermal/gov_bang_bang.c    |   5 +-
 drivers/thermal/of-thermal.c       |   2 +-
 drivers/thermal/step_wise.c        |  25 +++-
 drivers/thermal/thermal_core.c     |   2 +-
 drivers/thermal/user_space.c       |   5 +-
 include/linux/cpu_cooling.h        |  13 --
 include/linux/thermal.h            |   2 +-
 10 files changed, 326 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/DocBook/thermal.tmpl

-- 
2.1.3

