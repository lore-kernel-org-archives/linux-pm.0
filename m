From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/2] max8997_charger: Fine-tuning for max8997_battery_probe()
Date: Mon, 30 Oct 2017 22:34:27 +0100
Message-ID: <286b1fea-ccff-5fed-5e2d-fc3b0064cd4d@users.sourceforge.net>
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
Date: Mon, 30 Oct 2017 22:30:22 +0100

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use common error handling code
  Improve a size determination

 drivers/power/supply/max8997_charger.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

-- 
2.14.3
