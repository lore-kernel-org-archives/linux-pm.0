From: Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio:dac:ad5686: Style fixes no functional changes
Date: Fri, 30 Mar 2018 16:55:17 +0300
Message-ID: <1522418118-11810-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stefan.popa@analog.com
List-Id: linux-pm@vger.kernel.org

This patch fixes some indentation issues and does not modify the
functionality of the driver.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/dac/ad5686.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 20254df..f7f975c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -24,7 +24,7 @@
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
-#define AD5686_ADDR_DAC(chan)		(0x1 << (chan))
+#define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
 #define AD5686_ADDR_ALL_DAC			0xF
 
 #define AD5686_CMD_NOOP				0x0
@@ -137,7 +137,7 @@ static const char * const ad5686_powerdown_modes[] = {
 };
 
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -145,7 +145,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int mode)
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
@@ -163,17 +164,19 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 };
 
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
-	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
+		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
-			(0x3 << (chan->channel * 2))));
+				       (0x3 << (chan->channel * 2))));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
-	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
-	 size_t len)
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf,
+					  size_t len)
 {
 	bool readin;
 	int ret;
@@ -221,10 +224,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5686_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 	int ret;
-- 
2.7.4
