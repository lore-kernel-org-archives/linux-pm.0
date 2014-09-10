From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 4/4] cpufreq: cpufreq-dt: adjust message related to regulators
Date: Wed, 10 Sep 2014 14:08:28 +0200
Message-ID: <1410350908-11316-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
 <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36837 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbaIJMIf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 08:08:35 -0400
In-Reply-To: <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The cpufreq-dt driver tries to get a regulator for each CPU. This
regulator is optional, but when not present, a scary message "failed
to get cpuX regulator" is displayed. To solve this, we reduce the
severity of the message from dev_warn() to dev_dbg() and we reword the
message to not be as scary.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/cpufreq/cpufreq-dt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 987bbfa..b14628f 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -147,8 +147,8 @@ try_again:
 			goto try_again;
 		}
 
-		dev_warn(cpu_dev, "failed to get cpu%d regulator: %ld\n",
-			 cpu, PTR_ERR(cpu_reg));
+		dev_dbg(cpu_dev, "no regulator for cpu%d: %ld\n",
+			cpu, PTR_ERR(cpu_reg));
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
-- 
2.0.0

