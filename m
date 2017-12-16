From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] pm2301-charger: Adjustments for two function
 implementations
Date: Sat, 16 Dec 2017 21:10:32 +0100
Message-ID: <b11627bc-502d-b3af-ee96-ac2a693448a7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 16 Dec 2017 21:06:54 +0100

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in pm2xxx_wall_charger_probe()
  Improve a size determination in pm2xxx_wall_charger_probe()
  Combine substrings for three messages

 drivers/power/supply/pm2301_charger.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

-- 
2.15.1
