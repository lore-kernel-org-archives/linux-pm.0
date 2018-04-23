From: <sean.wang@mediatek.com>
Subject: [PATCH v2 1/2] regmap: include <linux/ktime.h> from include/linux/regmap.h
Date: Mon, 23 Apr 2018 14:42:44 +0800
Message-ID: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Similar to the readx_poll_timeout() macro calling ktime_* and using
ktime_t type, which is declared in <linux/ktime.h>. So, make
include/linux/regmap.h explicitly include <linux/ktime.h>, like
include/linux/iopoll.h does.  Otherwise, users of the macro will see
below errors.

error: implicit declaration of function ‘ktime_add_us’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_get’
[-Werror=implicit-function-declaration]

error: implicit declaration of function ‘ktime_compare’
[-Werror=implicit-function-declaration]

include/linux/regmap.h:128:2: error: unknown type name ‘ktime_t’
  ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 5f7ad05..b6865f0 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -15,6 +15,7 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
+#include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/bug.h>
-- 
2.7.4
