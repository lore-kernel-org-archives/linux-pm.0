From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC/RFT 03/10] i2c: synquacer: remove unused is_suspended flag
Date: Mon, 10 Dec 2018 22:03:01 +0100
Message-ID: <20181210210310.12677-4-wsa+renesas@sang-engineering.com>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This flag was defined and checked but never set a value. Remove it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-synquacer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index 2184b7c3580e..d18b0941b71a 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -144,8 +144,6 @@ struct synquacer_i2c {
 	u32			timeout_ms;
 	enum i2c_state		state;
 	struct i2c_adapter	adapter;
-
-	bool			is_suspended;
 };
 
 static inline int is_lastmsg(struct synquacer_i2c *i2c)
@@ -316,9 +314,6 @@ static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
 	unsigned long timeout;
 	int ret;
 
-	if (i2c->is_suspended)
-		return -EBUSY;
-
 	synquacer_i2c_hw_init(i2c);
 	bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
 	if (bsr & SYNQUACER_I2C_BSR_BB) {
-- 
2.11.0
