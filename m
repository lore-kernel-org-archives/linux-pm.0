From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.6-rc1
Date: Fri, 25 Mar 2016 23:08:51 +0100
Message-ID: <CAJZ5v0jMF=76ZvF3Er_iCt4hnOxf-b96Uy-PzsO=kQ7Dyy1FYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36014 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbcCYWIx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 18:08:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

One of commits in my previous pull request changed the permissions
of drivers/power/avs/rockchip-io-domain.c to executable by mistake.

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc1-3

to receive the fix as commit 8e653b654497350f9cb3d6c2088207bc503f2c7c

 Fix permissions of drivers/power/avs/rockchip-io-domain.c

on top of commit f447671b9e4fa4b0c9faf39455269d62d94218ae

 PM / AVS: rockchip-io: add io selectors and supplies for rk3399

This changes the file mode of drivers/power/avs/rockchip-io-domain.c
back to 644.

Thanks!


---------------

Rafael J. Wysocki (1):
      Fix permissions of drivers/power/avs/rockchip-io-domain.c

---------------

 drivers/power/avs/rockchip-io-domain.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
