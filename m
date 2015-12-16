From: Wolfram Sang <wsa@the-dreams.de>
Subject: [RFC 0/3] i2c: rcar: adapt PM usage to multi master case
Date: Wed, 16 Dec 2015 19:44:17 +0100
Message-ID: <1450291460-10514-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56556 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbLPSoc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 13:44:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org

If we are in a multi-master scenario, we need to block runtime PM so the
arbitration circuit stays awake.

So, we define a new binding and adapt the i2c-rcar driver to have an example
implementation.

This series is RFC because I want to do some more regression testing. The
actual functionality works fine here on my Lager board.

Wolfram Sang (3):
  i2c: document binding for multi-master case
  i2c: rcar: remove macros dealing with flags
  i2c: rcar: disable PM in multi-master mode

 Documentation/devicetree/bindings/i2c/i2c.txt |  5 ++++
 drivers/i2c/busses/i2c-rcar.c                 | 39 ++++++++++++++++-----------
 2 files changed, 28 insertions(+), 16 deletions(-)

-- 
2.1.4

