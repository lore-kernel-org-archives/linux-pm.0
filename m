From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Date: Wed, 23 Dec 2015 18:19:27 +0100
Message-ID: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

RuntimePM for the logical adapter device should be handled in a central place
by the core, and not by drivers. This series does exactly that.

This is the first step of harmonizing RuntimePM handling in I2C.


Wolfram Sang (2):
  i2c: always enable RuntimePM for the adapter device
  i2c: s3c2410: remove superfluous runtime PM calls

 drivers/i2c/busses/i2c-s3c2410.c | 6 ------
 drivers/i2c/i2c-core.c           | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.1.4
