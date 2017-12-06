From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] PM / devfreq: Fix potential NULL pointer dereference in
 governor_store
Date: Wed, 6 Dec 2017 14:20:15 -0600
Message-ID: <20171206202015.GA15636@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

df->governor is being dereferenced before it is null checked,
hence there is a potential null pointer dereference.

Notice that df->governor is being null checked at line 1004:
if (df->governor) {, which implies it might be null.

Fix this by null checking df->governor before dereferencing it.

Addresses-Coverity-ID: 1401988 ("Dereference before null check")
Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/devfreq/devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 78fb496..14fe76b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -996,7 +996,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if (df->governor->immutable || governor->immutable) {
+	} else if ((df->governor && df->governor->immutable) ||
+					governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.7.4
