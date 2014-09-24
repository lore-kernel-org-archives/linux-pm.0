From: Kevin Hilman <khilman@kernel.org>
Subject: [GIT PULL] PM / AVS changes for v3.18
Date: Wed, 24 Sep 2014 16:51:37 -0700
Message-ID: <7hk34sk25y.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44759 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbaIXXvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 19:51:39 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, dianders@chromium.org, heiko@sntech.de

Hi Rafael,

The following changes since commit 0f33be009b89d2268e94194dc4fd01a7851b=
6d51:

  Linux 3.17-rc6 (2014-09-21 15:43:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git tags/=
avs-for-3.18

for you to fetch changes up to a99e8f1df57f28d77774d50c94154b4ff1031f27=
:

  MAINTAINERS: update entry for drivers/power/avs (2014-09-24 16:30:32 =
-0700)

----------------------------------------------------------------
PM / AVS changes for v3.18

- Add new driver for Rockchip IO voltage domains
- update MAINTAINERS to reflect maintenance of drivers/power/avs/*

----------------------------------------------------------------
Heiko St=C3=BCbner (1):
      PM / AVS: rockchip-io: add driver handling Rockchip io domains

Kevin Hilman (1):
      MAINTAINERS: update entry for drivers/power/avs

 Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  83 +=
++++++++++++++++++
 MAINTAINERS                                                    |   4 +=
-
 drivers/power/avs/Kconfig                                      |   8 +=
+
 drivers/power/avs/Makefile                                     |   1 +
 drivers/power/avs/rockchip-io-domain.c                         | 351 +=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 5 files changed, 445 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip-io=
-domain.txt
 create mode 100644 drivers/power/avs/rockchip-io-domain.c
