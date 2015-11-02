From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/3] Fixes for twl4030 charger
Date: Mon,  2 Nov 2015 12:27:33 +0100
Message-ID: <cover.1446463652.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

Changes V2:
* worked in comments by Nishanth Menon <nm@ti.com>
* added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)

V1:
4.3-rc1 introduced a new charger driver for the twl4030.

While making it operable and testing on GTA04 and OpenPandora
we have found some issues.


H. Nikolaus Schaller (3):
  drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
  drivers:power:twl4030-charger: don't return after allocating irq
  drivers:power:twl4030-charger: don't check if battery is present

 drivers/power/twl4030_charger.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

-- 
2.5.1
