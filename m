From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/8] PM / devfreq: event: Find the instance of devfreq-event
 device by using phandle
Date: Fri, 15 Apr 2016 15:32:49 +0900
Message-ID: <1460701975-24178-3-git-send-email-cw00.choi@samsung.com>
References: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: mark.rutland@arm.com, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, cw00.choi@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux.amoon@gmail.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, inki.dae@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch use the phandle to find the instance of devfreq-event device in
Device Tree when calling the devfreq_event_get_edev_by_phandle() because there
is two type devfreq-event devices as following:

First case, exynos-ppmu.c driver provides the maximum four event of each PPMU.
So, when getting the instance of devfreq-event device, using the unique name of
struct devfreq_event_desc.

Second case, exynos-nocp.c driver provide the only one event of each NoC Probe
device. So, when getting the instance of devfreq-event device, using the
phandle of each NoC probe device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq-event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 38bf144ca147..39b048eda2ce 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -235,6 +235,11 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 
 	mutex_lock(&devfreq_event_list_lock);
 	list_for_each_entry(edev, &devfreq_event_list, node) {
+		if (edev->dev.parent && edev->dev.parent->of_node == node)
+			goto out;
+	}
+
+	list_for_each_entry(edev, &devfreq_event_list, node) {
 		if (!strcmp(edev->desc->name, node->name))
 			goto out;
 	}
-- 
1.9.1
