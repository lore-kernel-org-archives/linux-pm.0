From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 0/2] opp: ti-opp-supply: Fixes
Date: Wed, 7 Nov 2018 10:04:21 +0530
Message-ID: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gerlach@ti.com, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-pm@vger.kernel.org

The series brings in couple of fixes to the ti-opp-supply driver.
One of them updates u_volt_min dynamically and avoids hang due
to lesser static u_volt_min and the other fixes the supply in
_get_optimal_vdd_voltage.

Keerthy (2):
  power: opp: ti-opp-supply: Dynamically update u_volt_min
  power: opp: ti-opp-supply: Correct the supply in
    _get_optimal_vdd_voltage call

 drivers/opp/ti-opp-supply.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1
