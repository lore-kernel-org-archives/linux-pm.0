From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 03/15] Platform: OLPC: Remove an unused include
Date: Tue,  8 Jan 2019 18:58:06 +0100
Message-ID: <20190108175818.705110-4-lkundrak@v3.sk>
References: <20190108175818.705110-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190108175818.705110-1-lkundrak@v3.sk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Also, the header is x86 specific, while there are non-x86 OLPC machines.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/platform/olpc/olpc-ec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
index 374a8028fec7..981955dce926 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/olpc-ec.h>
-#include <asm/olpc.h>
 
 struct ec_cmd_desc {
 	u8 cmd;
-- 
2.20.1
