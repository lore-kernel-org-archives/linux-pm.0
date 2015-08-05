From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v3] thermal: Fix thermal_zone_of_sensor_register to match documentation
Date: Wed,  5 Aug 2015 10:57:48 +0100
Message-ID: <1438768668-15225-1-git-send-email-punit.agrawal@arm.com>
References: <9hha8u7mi7a.fsf@e105922-lin.cambridge.arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9hha8u7mi7a.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux@roeck-us.net
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, liviu.dudau@arm.com, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

thermal_zone_of_sensor_register is documented as returning a pointer
to either a valid thermal_zone_device on success, or a corresponding
ERR_PTR() value.

In contrast, the function returns NULL when THERMAL_OF is configured
off. Fix this.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
---
Hi Guenter,

It was pointed out that ENOSYS is frowned upon for anything other than
indicating lack of support for a syscall. The rest of the functions in
the file use ENODEV. Updating thermal_zone_of_sensor_register to do
the same.

Could you please re-ack if you're ok with this change?

Thanks,
Punit

 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 037e9df..f344e51 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -364,7 +364,7 @@ static inline struct thermal_zone_device *
 thermal_zone_of_sensor_register(struct device *dev, int id, void *data,
 				const struct thermal_zone_of_device_ops *ops)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
 static inline
-- 
2.1.4
