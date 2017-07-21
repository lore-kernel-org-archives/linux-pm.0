From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM / suspend: Messaging updates
Date: Fri, 21 Jul 2017 14:48:12 +0200
Message-ID: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55315 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751670AbdGUM6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 08:58:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Hi,

The first patch addresses a potential confusion regarding messages printed by
the suspend core code to the kernel log and the second one adds a pr_fmt() to
kernel/power/suspend.c.

The patches are on top of the series I posted yesterday:

http://marc.info/?l=linux-pm&m=150059650805506&w=2

Thanks,
Rafael
