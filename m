Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE413BCD2F;
	Mon, 22 Jun 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142400; cv=none; b=q/3g6GbRd07/50ndv+qgrXAngZsSI3ejkAAgEsppas7Jn0cqNXTh+Dhz6Fq0zMPRDGREAM5gN9d+1jvhWQiT0VWKvXDQJuzzVhuf6/Fx3vMHWS+UzATPLIchmCSop/EyHOzyLjQNuC6mIbbpFwPW0KW30Ll05Ouguzk2eLXNAwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142400; c=relaxed/simple;
	bh=OZOwJ1P5aM/YvZb3GYlK/QryFTE7KdxVNDq/XKw/L74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ktlR0euHlL5Nokuxki7+eGrZiRHFgrINRF3gFoknJ4v91J3UqFBGub/iRbo3Fu2ahwibnaOEODSYGeSdBp4tmJgO3qdspEI0dRB7cXda2yKm3tutQ8ZTcEvjGzg46w3NVT9pUTnOtpdRTg9wWMuPBeWkRXkpSm3N+nvcNgUXpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXOtOzVTlqlsDBAg--.11361S2;
	Mon, 22 Jun 2026 23:33:08 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Kees Cook <kees@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	kernel test robot <lkp@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v2] thermal: intel: int3400: clean up ODVP files on probe failures
Date: Mon, 22 Jun 2026 23:33:06 +0800
Message-ID: <20260622153306.79258-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXOtOzVTlqlsDBAg--.11361S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryxCFW3uF1rAF1xGw13CFg_yoW5Gw15pa
	y5Ar1UGrWDWF10q34DA3W8Xa1Ut3WrKay5WFyfuay5J3WayrWftFyFyry5Xry0krWkKF4Y
	y34YqrWUursrGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

int3400_thermal_probe() creates ODVP sysfs files before several later
probe steps can still fail.  The late error paths unregister the thermal
zone and remove other sysfs groups, but they do not remove the ODVP files
or free the ODVP attribute storage.

Run the ODVP cleanup from the existing post-ODVP error path, and clear
the saved ODVP pointers after freeing them so the cleanup remains safe
when reached after the later sysfs cleanup path has already removed the
files.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606152042.8kTVDHYg-lkp@intel.com/
---
Changes since v1:
- Avoid adding new error labels; reuse the existing free_art_trt path so
  W=1 builds do not report unused labels.
- Clear ODVP and data_vault pointers after freeing them.
- Free data_vault directly when bin-file creation fails.

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 66db4b1effb4..5b59634bcc2e 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -357,7 +357,9 @@ static void cleanup_odvp(struct int3400_thermal_priv *priv)
 		}
 		kfree(priv->odvp_attrs);
+		priv->odvp_attrs = NULL;
 	}
 	kfree(priv->odvp);
+	priv->odvp = NULL;
 	priv->odvp_count = 0;
 }
 
@@ -620,6 +622,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		result = device_create_bin_file(&pdev->dev, &bin_attr_data_vault);
-		if (result)
+		if (result) {
+			kfree(priv->data_vault);
+			priv->data_vault = NULL;
 			goto free_uuid;
+		}
 	}
 
@@ -651,8 +656,9 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_sysfs:
 	cleanup_odvp(priv);
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
 		kfree(priv->data_vault);
+		priv->data_vault = NULL;
 	}
 free_uuid:
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
@@ -667,6 +674,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
+	cleanup_odvp(priv);
 free_art_trt:
 	kfree(priv->trts);
 	kfree(priv->arts);
-- 
2.50.1

