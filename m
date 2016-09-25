From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 0/2] power: supply: max17042_battery: Improve properties
Date: Sun, 25 Sep 2016 23:10:09 +0200
Message-ID: <1474837811-9413-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
List-Id: linux-pm@vger.kernel.org

These two patches fix the capacity property and add the technology
property.

Wolfgang Wiedmeyer (2):
  power: supply: max17042_battery: use VF SOC register for capacity
    property
  power: supply: max17042_battery: add technology property support

 drivers/power/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
Website: https://fossencdi.org
OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
Key download: https://wiedmeyer.de/keys/ww.asc
