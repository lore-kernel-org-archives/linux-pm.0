Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FC2D2495;
	Thu, 27 Aug 2026 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787796372; cv=none; b=Ee0DRRytVNTjnfTgce65RO/+gtJajJR/Ks7Y7dwDywycq9ZgSaFzXOv2x92FE+kgzyd97BakxsXvM1qjsAo97AjddxDnEI877RL7m6MwmBKtcfWtrSozOYYAnse3Rf/c0W2q2SvPWGEGbhqaUxzXBwisjV+Rh4kvx2tDm28EhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787796372; c=relaxed/simple;
	bh=VZ5/h+OKGYtSt7nA8HoLz+GDwC6ooxjuvt+K5hlEEWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCIrxVvlqrK6wNKidO2rX32fRbhZ60/wpIwD5mmyag9rD3/Sh+Ej3PSksCCpLbkJAqkG8ZtmMn2fBv9mkROGd1g1WKyWMhLyYvmAKVHU2fZdjFvp7UlJtgd/famm4HpOiDYsBJ6FtLlfHZjLoFppxhkgCft3rKuGKighezzBNhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CAZn1vN3; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CAZn1vN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8w
	Ng58/e4SmTV+utYuoymEekmbcLwiJQlcALOeoJzs4=; b=CAZn1vN3jvsQo2+V7I
	GuM3jCvFnyrCwp4ecy9xmnOy2+1Nsw1RIk88s44IcX9iXXtvLO9HVr0RZtn9Lqx9
	9BRVTNX/6byDBvIg/2/nE3AxtrabC5wuWWKEU+i55TcYkUc1GHuaAB5QuxGzfkuF
	vgGxfaTne8AGELMkEkwLt3FWU=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXAMd1m49qooVCQQ--.18551S2;
	Thu, 27 Aug 2026 10:05:41 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: sre@kernel.org,
	kauschluss@disroot.org,
	y.oudjana@protonmail.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: s2mu005-battery: return errors from dev_err_probe() in probe
Date: Thu, 27 Aug 2026 10:05:39 +0800
Message-Id: <20260827020539.22837-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXAMd1m49qooVCQQ--.18551S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWfXFy5ZF4xtrWxuF45KFg_yoW8CF1xpa
	95uF4Ykr1UWr1UZ3yYyFyDXry2gay3AFW5Gr9Fyw1xAr97Jryqqr13trW3KF18CFWFka15
	tay0q3y7Aa13A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwl1kUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0RWCLmqPm3VCzAAA3t

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

s2mu005_fg_i2c_probe() calls dev_err_probe() when devm_mutex_init() or
devm_request_threaded_irq() fails, but drops the return value and
carries on, finally returning 0. A failed probe is then reported as a
success: the device stays registered with an uninitialized mutex and
without its IRQ handler installed.

Return the error from dev_err_probe() in both places so that the probe
fails and the driver core logs the error state properly.

Fixes: aa2132799817 ("power: supply: add support for S2MU005 battery fuel gauge device")
Cc: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 drivers/power/supply/s2mu005-battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/s2mu005-battery.c b/drivers/power/supply/s2mu005-battery.c
index 53de660..a76154e 100644
--- a/drivers/power/supply/s2mu005-battery.c
+++ b/drivers/power/supply/s2mu005-battery.c
@@ -262,7 +262,7 @@ static int s2mu005_fg_i2c_probe(struct i2c_client *client)
 
 	ret = devm_mutex_init(dev, &priv->monout_mutex);
 	if (ret)
-		dev_err_probe(dev, ret, "failed to initialize MONOUT mutex\n");
+		return dev_err_probe(dev, ret, "failed to initialize MONOUT mutex\n");
 
 	psy_desc = device_get_match_data(dev);
 
@@ -277,7 +277,7 @@ static int s2mu005_fg_i2c_probe(struct i2c_client *client)
 					s2mu005_handle_irq, IRQF_ONESHOT,
 					psy_desc->name, priv);
 	if (ret)
-		dev_err_probe(dev, ret, "failed to request IRQ\n");
+		return dev_err_probe(dev, ret, "failed to request IRQ\n");
 
 	return 0;
 }
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

