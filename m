From: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/5] iio: light: us5182d: Add functions for selectively enabling als and proximity
Date: Tue, 24 Nov 2015 12:59:50 +0200
Message-ID: <1448362792-5181-4-git-send-email-adriana.reus@intel.com>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448362792-5181-1-git-send-email-adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Keep track of the als and px enabled/disabled status in
order to enable them selectively.

Signed-off-by: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iio/light/us5182d.c | 64 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 7993014..3d959f3 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -119,6 +119,9 @@ struct us5182d_data {
 	u8 opmode;
 	u8 power_mode;
 
+	bool als_enabled;
+	bool px_enabled;
+
 	bool default_continuous;
 };
 
@@ -227,6 +230,48 @@ static int us5182d_set_opmode(struct us5182d_data *data, u8 mode)
 	return 0;
 }
 
+static int us5182d_als_enable(struct us5182d_data *data)
+{
+	int ret;
+	u8 mode;
+
+	if (data->power_mode == US5182D_ONESHOT)
+		return us5182d_set_opmode(data, US5182D_ALS_ONLY);
+
+	if (data->als_enabled)
+		return 0;
+
+	mode = data->px_enabled ? US5182D_ALS_PX : US5182D_ALS_ONLY;
+
+	ret = us5182d_set_opmode(data, mode);
+	if (ret < 0)
+		return ret;
+
+	data->als_enabled = true;
+	return 0;
+}
+
+static int us5182d_px_enable(struct us5182d_data *data)
+{
+	int ret;
+	u8 mode;
+
+	if (data->power_mode == US5182D_ONESHOT)
+		return us5182d_set_opmode(data, US5182D_PX_ONLY);
+
+	if (data->px_enabled)
+		return 0;
+
+	mode = data->als_enabled ? US5182D_ALS_PX : US5182D_PX_ONLY;
+
+	ret = us5182d_set_opmode(data, mode);
+	if (ret < 0)
+		return ret;
+
+	data->px_enabled = true;
+	return 0;
+}
+
 static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
 {
 	int ret;
@@ -241,7 +286,16 @@ static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
 	ret = ret & ~US5182D_CFG0_SHUTDOWN_EN;
 	ret = ret | state;
 
-	return i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
+	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
+	if (ret < 0)
+		return ret;
+
+	if (state & US5182D_CFG0_SHUTDOWN_EN) {
+		data->als_enabled = false;
+		data->px_enabled = false;
+	}
+
+	return ret;
 }
 
 static int us5182d_read_raw(struct iio_dev *indio_dev,
@@ -261,7 +315,7 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 				if (ret < 0)
 					goto out_err;
 			}
-			ret = us5182d_set_opmode(data, US5182D_OPMODE_ALS);
+			ret = us5182d_als_enable(data);
 			if (ret < 0)
 				goto out_err;
 
@@ -278,7 +332,7 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 				if (ret < 0)
 					goto out_err;
 			}
-			ret = us5182d_set_opmode(data, US5182D_OPMODE_PX);
+			ret = us5182d_px_enable(data);
 			if (ret < 0)
 				goto out_err;
 
@@ -421,6 +475,9 @@ static int us5182d_init(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	data->als_enabled = true;
+	data->px_enabled = true;
+
 	if (!data->default_continuous) {
 		ret = us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 		if (ret < 0)
@@ -428,7 +485,6 @@ static int us5182d_init(struct iio_dev *indio_dev)
 		data->power_mode = US5182D_ONESHOT;
 	}
 
-
 	return ret;
 }
 
-- 
1.9.1
