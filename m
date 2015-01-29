From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Pull Request of PM / Devfreq (for next)
Date: Thu, 29 Jan 2015 23:08:08 +0900
Message-ID: <CAJ0PZbTSbjSKFH8Q=F1umscTMijO2W4_DioiQCUFFjEtnc08Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:59662 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbA2OIJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 09:08:09 -0500
Received: by mail-vc0-f172.google.com with SMTP id le20so8861620vcb.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2015 06:08:08 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, Linux PM list <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Dear Rafael,


Here goes a pull request from PM / devfreq to Linux-PM, for-next.
(linux-3.20 rc-X)



Cheers,
MyungJoo



-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 26bc420b59a38e4e6685a73345a0def461136dce:

  Linux 3.19-rc6 (2015-01-25 20:04:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
tags/pull_req_20150129

for you to fetch changes up to 846d4ee701e883f3e4647662e1f4069d0cd2694b:

  PM / devfreq: event: Add documentation for exynos-ppmu devfreq-event
driver (2015-01-29 21:52:53 +0900)

- ----------------------------------------------------------------
Pull Request of Devfreq, 2015-01-29.

- ----------------------------------------------------------------
Chanwoo Choi (3):
      PM / devfreq: event: Add devfreq_event class
      PM / devfreq: event: Add Exynos-ppmu devfreq-event driver
      PM / devfreq: event: Add documentation for exynos-ppmu
devfreq-event driver

Tomeu Vizoso (1):
      PM / devfreq: tegra: add devfreq driver for Tegra Activity Monitor

 .../bindings/devfreq/event/exynos-ppmu.txt         | 110 ++++
 drivers/devfreq/Kconfig                            |  12 +
 drivers/devfreq/Makefile                           |   4 +
 drivers/devfreq/devfreq-event.c                    | 494 ++++++++++++++
 drivers/devfreq/event/Kconfig                      |  25 +
 drivers/devfreq/event/Makefile                     |   2 +
 drivers/devfreq/event/exynos-ppmu.c                | 374 +++++++++++
 drivers/devfreq/event/exynos-ppmu.h                |  93 +++
 drivers/devfreq/tegra-devfreq.c                    | 718 +++++++++++++++++++++
 include/linux/devfreq-event.h                      | 196 ++++++
 10 files changed, 2028 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
 create mode 100644 drivers/devfreq/devfreq-event.c
 create mode 100644 drivers/devfreq/event/Kconfig
 create mode 100644 drivers/devfreq/event/Makefile
 create mode 100644 drivers/devfreq/event/exynos-ppmu.c
 create mode 100644 drivers/devfreq/event/exynos-ppmu.h
 create mode 100644 drivers/devfreq/tegra-devfreq.c
 create mode 100644 include/linux/devfreq-event.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyj0BAAoJEBOhurvWBoCKHrAP/jCkj81SQEDB4PPF3w3JFfVj
6GA2zVpunAeHAYq3klh41f9YyyyFxW1zp9nCfobcI9JO5IDsyCmNDOv5rla+yx/G
XNlS4w+/tT5tXZjPR6b4irto6YsZN1Ro8AMH37UOqiOqB3t5nXjpZT64kWKNB9CF
w7xPhTF6VhYlyT/wajqXDMzpMvSGt5YAIUJlpYLg7rD00rAatEbhfl5j7/bGkc/c
X8X91j9I7Mc1mJ6hFkrtMJzYZAVPRbpVJuKNvMUru+DWCHMXOtv2fBfYEQFaQFTS
V3/dVTvhhkW5ftgflDtWnUJIJVm8tavrtURLsOkw/6d0TuD0GMtcf0KNRnwdiR6D
mznu3/l+3mg3XCUc5ydVYRProkj9CCpM5I5NVWsrJ1I5bj7E7kcF1jYKgNSr13j5
9DFUheYJGY3953W1kAowRjqM+/ZMHxpsboRDTfxdl2Gfi3XLrhhjhKWNxNb2nsg4
JdIFDbRnY4NHD8LXSlb8oJP/RfTgKc/wWYfqlETSeOZV4J7L6/DoHDM/jHzsVMU9
j8zbE4f1LqAU0p5jP2RIt2ZTTXoNnIgObmXp/orhcoKRj9gm1qFb862U3IPrF+Jf
W1lS/Casqc4gXYwqrYZ2Jjm87OujA3XqN4sxZAZbKbv8HI04mmzZRO6tXlnF62C+
FVXiTktWShTIkMNyiXOu
=BFS1
-----END PGP SIGNATURE-----
