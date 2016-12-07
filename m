From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH v1 0/3] make kurobox-pro be able to shutdown after device-tree migration
Date: Thu,  8 Dec 2016 02:24:12 +0900
Message-ID: <20161207172415.9776-1-rogershimizu@gmail.com>
References: <20161206173420.GB18817@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35828 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcLGRZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 12:25:09 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so24070842pga.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 09:24:47 -0800 (PST)
In-Reply-To: <20161206173420.GB18817@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Cc: Roger Shimizu <rogershimizu@gmail.com>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

Dear Sebastian,

Kurobox-Pro (and variants) need more commands sending to UART1 to shutdown.
So here I make this patch series to let current qnap-poweroff implementation
be able to handle such case.

I already tested this change on Kurobox-Pro and Linkstation LS-GL devices,
with a modified device-tree file. (Previous device-tree of kurobox-pro invokes
restart-poweroff, so it simply restarts.)

Thank you and look forward to your feedback!


Dear Andrew,

Thanks for your review!

I split off most of kurobox-pro releated code into separated files.
Hope you can accept this series.

Changes:
  v0 => v1:
  - Update 0003 to split kuroboxpro related code into kuroboxpro-common.c

Cheers,
Roger

Roger Shimizu (3):
  power: reset: make qnap-poweroff flexible on hello magic command to
    uart1
  power: reset: make qnap-poweroff flexible on length of power-off
    command
  power: reset: make qnap-poweroff support kurobox-pro

 .../bindings/power/reset/qnap-poweroff.txt         |   8 +-
 drivers/power/reset/Makefile                       |   2 +-
 drivers/power/reset/kuroboxpro-common.c            | 128 +++++++++++++++++++++
 drivers/power/reset/kuroboxpro-common.h            |   8 ++
 drivers/power/reset/qnap-poweroff.c                |  82 +++++++++++--
 5 files changed, 216 insertions(+), 12 deletions(-)
 create mode 100644 drivers/power/reset/kuroboxpro-common.c
 create mode 100644 drivers/power/reset/kuroboxpro-common.h

-- 
2.10.2

