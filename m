From: Roger Shimizu <rogershimizu@gmail.com>
Subject: [PATCH 0/3] make kurobox-pro be able to shutdown after device-tree migration
Date: Mon,  5 Dec 2016 21:45:25 +0900
Message-ID: <20161205124528.2999-1-rogershimizu@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33907 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbcLEMps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2016 07:45:48 -0500
Received: by mail-pf0-f196.google.com with SMTP id y68so17062792pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2016 04:45:47 -0800 (PST)
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

Cheers,
Roger

Roger Shimizu (3):
  power: reset: make qnap-poweroff flexible on hello magic command to
    uart1
  power: reset: make qnap-poweroff flexible on length of power-off
    command
  power: reset: make qnap-poweroff support kurobox-pro

 .../bindings/power/reset/qnap-poweroff.txt         |   8 +-
 drivers/power/reset/qnap-poweroff.c                | 186 ++++++++++++++++++++-
 2 files changed, 184 insertions(+), 10 deletions(-)

-- 
2.10.2

