From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] regulator: Take into account the requirements of
	all consumers
Date: Fri,  3 Dec 2010 11:31:07 +0100
Message-ID: <1291372267-23221-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1291372267-23221-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1291372267-23221-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Thomas Petazzoni <t-petazzoni@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-pm@vger.kernel.org

From: Thomas Petazzoni <t-petazzoni@ti.com>

Extend the regulator_set_voltage() function to take into account the
voltage requirements of all consumers of the regulator being changed,
in order to set the voltage to the minimum voltage acceptable to all
consumers. The existing behaviour was that the latest
regulator_set_voltage() call would win over previous
regulator_set_voltage() calls even if setting the voltage to a
non-acceptable level from other consumers.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/regulator/core.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f1d10c9..12a1cae 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -132,6 +132,28 @@ static int regulator_check_voltage(struct regulator_dev *rdev,
 	return 0;
 }
 
+/* Make sure we select a voltage that suits the needs of all
+ * regulator consumers
+ */
+static int regulator_check_consumers(struct regulator_dev *rdev,
+				     int *min_uV, int *max_uV)
+{
+	struct regulator *regulator;
+
+	list_for_each_entry(regulator, &rdev->consumer_list, list)
+	{
+		if (*max_uV > regulator->max_uV)
+			*max_uV = regulator->max_uV;
+		if (*min_uV < regulator->min_uV)
+			*min_uV = regulator->min_uV;
+	}
+
+	if (*min_uV > *max_uV)
+		return -EINVAL;
+
+	return 0;
+}
+
 /* current constraint check */
 static int regulator_check_current_limit(struct regulator_dev *rdev,
 					int *min_uA, int *max_uA)
@@ -1636,6 +1658,11 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 		goto out;
 	regulator->min_uV = min_uV;
 	regulator->max_uV = max_uV;
+
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
+	if (ret < 0)
+		goto out;
+
 	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV);
 
 out:
-- 
1.7.0.4
