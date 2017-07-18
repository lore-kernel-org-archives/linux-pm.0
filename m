From: Rob Herring <robh@kernel.org>
Subject: [PATCH] devfreq: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:42:57 -0500
Message-ID: <20170718214339.7774-17-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/devfreq/devfreq-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 8648b32ebc89..d67242d87744 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -277,8 +277,8 @@ int devfreq_event_get_edev_count(struct device *dev)
 						sizeof(u32));
 	if (count < 0) {
 		dev_err(dev,
-			"failed to get the count of devfreq-event in %s node\n",
-			dev->of_node->full_name);
+			"failed to get the count of devfreq-event in %pOF node\n",
+			dev->of_node);
 		return count;
 	}

--
2.11.0
