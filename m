From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM / hibernate: Two hibernate.c cleanups
Date: Fri, 24 Feb 2017 00:08:27 +0100
Message-ID: <1897611.guix8xla9k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47822 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751306AbdBWXdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Feb 2017 18:33:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Hi,

These are two cleanups for hibernate.c, one to untangle power_down() and the
other related to printing messages.

Thanks,
Rafael
