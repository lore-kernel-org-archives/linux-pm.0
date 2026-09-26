Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551E30F95C
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396885; cv=none; b=f95oXUgYqF5nVNv5Qu2BvU/O1sJNMLMjgzmGGFXLT7Y2nKBYrRh9Qd+WfPrvklxD1W8m3CbwDtS89qu9Eh50OirQ5v/BEvxBJratB/J5LnfwJACAhw0lIN1ZSB+nxSgdyyNk5Ip3PmSIUweAdNkkjDUKgrrrNwSbpLQPxx0NJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396885; c=relaxed/simple;
	bh=zDWRznreaCj9pwq4xoxCFPqmAgk2FFcPqeo4LAIzOII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqPj9ajJdSu4cl5wI+Xtd1KTSDxCYMo3GAj/Vl2LJrcl7wkfn5HADZYKI+09vcUEc+LAYa2Z7Mj9YAXoSeAls3H7uvmeohVzq4AJAOmhhOQQwnyBqfyaLS3oeHhsEuTTmbEb74UglKeOqVD2hSPrZFC8TgxwUt05mW8lurWrYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDmQtY33; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDmQtY33"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso945711a91.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396884; x=1791001684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jBdH+3CimcIocBItRqRUNlkXd/F1gm5vjU+KHPvU30=;
        b=kDmQtY33uk1muvuEoQAwaHHWThlOr9705WM1jBXsU6JUWOJyAXN4gVNL/v5ZlGumor
         ugv/IWgrGCpQhHVWpJF9sVA0Mc1qY2mZJvZMW4s8kubYA6IN2eWBChK9ZnaXQuU7qehe
         tF5SFShrK+9NYsR4Sh4Iv9WwjH4hTUYjKS6h+MN95Rb6ao+9MD18rUqp7i6vzj3YoX4R
         WxpEy2+savqk3DSMmzzdV02QKtYHiwZfIsIxubwcA8BTtn22MrJLX4ieGahXncxdoX2w
         f5fSEJMqMBhV2Awd6z80OUgpXnzz7V5621kESkUGTrMN84OrzcZgEFEppvRecSWFHdGe
         vrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396884; x=1791001684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jBdH+3CimcIocBItRqRUNlkXd/F1gm5vjU+KHPvU30=;
        b=kUnipcGr8jzzPb78AbvPWXv7a7lpdtZp/nYGOuZqHoHhgZuAkfJ3GkJoKVVCZgRbDC
         EcmqF7O7VDUZdCS1MHauqn2vBcH0ixRiD/o1scTB4blsFTPk3bRWmuK+H7mwQ0jghZFP
         /W6EpdAC5MRO9hLaXHjXR7QCn+ngWI8Mr7/1gsKdnU6nQMFA9K2dQ4DdOX/AdUUmjyQY
         sZgC+dy2hLe9DRITWZ/UsY0HxU6ObtgqpMjx5ALtWJmTUxVmsmSy+A4wJ8/tDjvLegSa
         oa5i+/AZ7YJxULkEDootcOdKL8QLnAhAvV+/wqPfJGPRt8Vr2riS3Dv0O6daZXXFwyuI
         Rx3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw1zRdETXKEVUunDVvJDXXs0ci4BYLkRqrlX588Nlv/xd/2VllXYm2HzjAdGJxIqux6gsEvKQhAtg==@vger.kernel.org
X-Gm-Message-State: AFuF++n/VdlwFbuHV9CIIcwhQD5nJKQEp+2NbtFKIreDpVRCYY0PJd5b
	Cy9Bq7LoGVq5nFYMjdMKK3VlvkRvRs7ledNcAVNYgs8eZrdQeAXGmnG+
X-Gm-Gg: AYBFou0t3V9qxQTgtZje9yP+DOjWEh0KJJEGUdZMN9sjt7mA74NNcG3mKu+Pl7PbFry
	Mb8/+UedjSY9NLhg8XGtj02jZpF/RCf9C1Q2E9xbDo9eoQU4WaPtFOrUpUJUuUVdaC/pzots5Dy
	xZUwMsi4TGdxc0jgHWXkALrwG2MXuta5wsakDHCKHFhcZYJtwaYTuGGwPEDi4J3/AiP05Vd5rCB
	olEwMTcDHMPEIPlgcQne+MMxGlF61davZQ+MJHS+zrLcBHx9rh8Q9g2l4tKitdSCaxQMdSDjcTF
	xl1nT3d136Wy9YC9hImv2JgmjKbvXqyLNL0MiN2M4cf3GNrwDAFzeXmTU1OWBbm/KOE0g8WvY/w
	VzFpH5ciVQKMUXcp7vAgqjVl+Vmeq1euMJzTM1EwX83Rmk4ly3qhmEnS6xSizfBgq+bFUmhdTYa
	VZuQ8NX9ykj4IQsrAOZhdJUFEGNf4OL6aglzy3pT2K2DYkBDGU7LBqzZr8uqBEM00hmuUCy1GN1
	raA7f257BZOWn9m7f8TiIERzcFnuD/5QLtpb2BpyLzXf9Kr0Ep/vADsRXYBE7qr1354bMHirUkt
	az4mpKcBQ5KTBtk6MW1ZoxtgGWx0CKjzwYUrQg==
X-Received: by 2002:a17:90b:2d81:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3a0bb552feamr3228577a91.9.1790396883522;
        Fri, 25 Sep 2026 21:28:03 -0700 (PDT)
Received: from dell-pro-max-tower-t2.cse.unsw.EDU.AU (pag-t2-pc.cse.unsw.EDU.AU. [129.94.173.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm8034535a91.1.2026.09.25.21.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:28:02 -0700 (PDT)
From: Weigang He <geoffreyhe2@gmail.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] thermal/drivers/sprd: validate the sensor id from the device tree
Date: Sat, 26 Sep 2026 14:27:57 +1000
Message-ID: <20260926042757.2109927-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprd_thm_probe() reads each sensor child node's "reg" property into
sen->id and uses it without validation: to compute the sensor's
register offsets in sprd_thm_sensor_init(), as the thermal zone id, and
finally as an index into thm->sensor[], which has SPRD_THM_MAX_SENSOR
(8) entries:

	ret = of_property_read_u32(sen_child, "reg", &sen->id);
	...
	thm->sensor[sen->id] = sen;

Only the number of sensor nodes is checked against SPRD_THM_MAX_SENSOR.
A "reg" value of 8 or more, or one that is negative once stored in the
int sen->id, makes the register offsets point outside the sensor range
and the final store land outside thm->sensor[], overwriting the fields
that follow it in struct sprd_thermal_data or other memory.

Reject an out-of-range id right after reading it, before it is used.

This does not address sparse ids, such as a single sensor with id 7:
they leave holes in thm->sensor[] that the later loops over
0..nr_sensors-1 dereference. That needs a separate fix.

Found by static analysis tool CodeQL.

Fixes: 554fdbaf19b1 ("thermal: sprd: Add Spreadtrum thermal driver support")
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---

Notes:
    Compile-tested only (ARCH=arm64 allmodconfig, W=1). Not tested on
    hardware, and there is no reproducer.
    
    The CodeQL query behind this report was synthesized with LLM assistance,
    and the fix and changelog were drafted with LLM assistance; I have
    reviewed them.

 drivers/thermal/sprd_thermal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
index d683fcb0f8ab8..b57277e2eac01 100644
--- a/drivers/thermal/sprd_thermal.c
+++ b/drivers/thermal/sprd_thermal.c
@@ -396,6 +396,12 @@ static int sprd_thm_probe(struct platform_device *pdev)
 			goto of_put;
 		}
 
+		if (sen->id < 0 || sen->id >= SPRD_THM_MAX_SENSOR) {
+			dev_err(&pdev->dev, "invalid sensor id %d\n", sen->id);
+			ret = -EINVAL;
+			goto of_put;
+		}
+
 		ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
 		if (ret) {
 			dev_err(&pdev->dev, "efuse cal analysis failed");

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
prerequisite-patch-id: c5a3be8688fd8e88a00352acb1374e91fcb52a03
prerequisite-patch-id: 67693e2c08624df0841619cc085ce9200f4385fc
prerequisite-patch-id: f3d73f7c19be7e952aa8061303f53f9a08576a88
prerequisite-patch-id: 541e578709d048f4c8115f1d926be2f2c03ecb0e
prerequisite-patch-id: f23f8e0693435497645805822d98a92e57fb46f3
prerequisite-patch-id: eae82895db8ba67018a777a91a283ad6bc4a55b2
-- 
2.43.0

