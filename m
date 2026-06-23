Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8C375ADE;
	Tue, 23 Jun 2026 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179515; cv=none; b=bN3Mb9mk0ZJAm7+JUmOe4CstcXDc4F8OrSJpZzK9iWLW7mq735F1CMaKCG/mGw+ZnWgXS73Q6r/X7AVy50ejyzKJRvjtAaORnSil/Xe3mWzPcy0JNcRGlgIdrul5IiBwPHuL/3rCUMY5akoiRUOIPaxdRni54a4eszXe82YjqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179515; c=relaxed/simple;
	bh=lYmVTef9CjW2x0xavnDPrlqi7eLIaeH6jnnrB8DuTps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm11RrOKuYiuvEbmfFR7BdjW5aj/35tD9URp28rLXc2XrF6+unzzVg9Nd7FkjFmrFqTcYKeSRMYaUIj0fc8srG1jov62u6iFnMp9ejPKiUDFc/DUkp3CGVe4UgLU83q6L0SrxDIFU9uOupTezQXo+B1iTE6/SEc+YCxEQDO2hLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAA3jhGu5jlqBajCFA--.9909S2;
	Tue, 23 Jun 2026 09:51:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Matthew Garrett <mjg59@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH v3] thermal: intel: int3400: clean up ODVP on probe failures
Date: Tue, 23 Jun 2026 09:51:40 +0800
Message-ID: <20260623015140.19300-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3jhGu5jlqBajCFA--.9909S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45AF1DWryUJw1DCFyxuFg_yoW5GFyUpw
	4UGFy3GrWkWF1Fgw1UA3WUJFZ0yw15Kay5uFyrCayYya13ArW3KFy0yry5Kry0kFWxKF4Y
	y3y5trWUZa1DJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUonmRUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

evaluate_odvp() creates per-ODVP sysfs files before the thermal zone
and later probe resources are registered. The current unwind path only
calls cleanup_odvp() from the late sysfs failure path, so failures after
evaluate_odvp() but before that label, including
thermal_tripless_zone_device_register() failures, leave the ODVP files
and storage behind.

Move the ODVP cleanup to the common ART/TRT unwind path so every failure
after evaluate_odvp() releases the ODVP state. Also clear the cached
ODVP pointers in cleanup_odvp(), because evaluate_odvp() can already call
it for partial setup failures while probe continues.

Fixes: 006f006f1e5c ("thermal/int340x_thermal: Export OEM vendor variables")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2: https://lore.kernel.org/all/20260622153306.79258-1-pengpeng@iscas.ac.cn/
- move cleanup_odvp() to the common free_art_trt unwind path so it also
  covers thermal_tripless_zone_device_register() failures
- drop the unrelated data_vault cleanup change from v2
- make cleanup_odvp() idempotent by clearing the cached ODVP pointers
  after freeing them

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index d200734625ee..5d70301d4a3d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -356,8 +356,10 @@ static void cleanup_odvp(struct int3400_thermal_priv *priv)
 			kfree(priv->odvp_attrs[i].attr.attr.name);
 		}
 		kfree(priv->odvp_attrs);
+		priv->odvp_attrs = NULL;
 	}
 	kfree(priv->odvp);
+	priv->odvp = NULL;
 	priv->odvp_count = 0;
 }
 
@@ -635,7 +637,6 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
 				   int3400_notify);
 free_sysfs:
-	cleanup_odvp(priv);
 	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		device_remove_bin_file(&pdev->dev, &bin_attr_data_vault);
 		kfree(priv->data_vault);
@@ -649,6 +650,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 	thermal_zone_device_unregister(priv->thermal);
 free_art_trt:
+	cleanup_odvp(priv);
 	kfree(priv->trts);
 	kfree(priv->arts);
 free_priv:
-- 
2.50.1 (Apple Git-155)

