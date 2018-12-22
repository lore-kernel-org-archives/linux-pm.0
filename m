From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/9] i2c: reject new transfers when adapters are suspended
Date: Sat, 22 Dec 2018 21:26:16 +0100
Message-ID: <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

Using the 'is_suspended' flag from the PM core, we now reject new
transfers if the parent of the adapter is already marked suspended.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/fault-codes | 4 ++++
 drivers/i2c/i2c-core-base.c   | 3 +++
 drivers/i2c/i2c-core-smbus.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
index 47c25abb7d52..0cee0fc545b4 100644
--- a/Documentation/i2c/fault-codes
+++ b/Documentation/i2c/fault-codes
@@ -112,6 +112,10 @@ EPROTO
 	case is when the length of an SMBus block data response
 	(from the SMBus slave) is outside the range 1-32 bytes.
 
+ESHUTDOWN
+	Returned when a transfer was requested using an adapter
+	which is already suspended.
+
 ETIMEDOUT
 	This is returned by drivers when an operation took too much
 	time, and was aborted before it completed.
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..3ce238b782f3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1865,6 +1865,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
+	if (WARN(device_is_suspended(adap->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
 
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..e0f7f22feabd 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,6 +547,10 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	int try;
 	s32 res;
 
+	if (WARN(device_is_suspended(adapter->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.19.1
