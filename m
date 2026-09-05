Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255693812FB;
	Sat,  5 Sep 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615920; cv=none; b=e6GfM34CsS/Cl36H348BRe9M8NO+ryRohgHqHpDRJG4JiI/IGvUybAtUqJIyLCy58+61f3REWn6l8obh5fCr5YFQy2+6PJqw5SAGmBCKAipBWPdf05EVeihw+/GhVwtNmliiucAJoiBYQk77mdCGOzKOPkzTMCA6htsBjhsUASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615920; c=relaxed/simple;
	bh=PRAWGIO1FNOf+KlF9pTX/3NHB0KG3781A4zBw0x3KmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEJLBpHXNrqCz7dFU0vxfcTlMp5umA8O4QEcXfn1+c7b15YqvbFZ1Ov76eGUxr5p1sBr23+NkV7cjzkwfcJHoAwRB3P4Wyqcs6pNb3ZKzcUlPH9yI7QgB2115pZUFoZxgP55dWWiOQDYntupNkTmbSJVSrjrTZfvUbf6UhJQHdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HMJCRf5Z; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HMJCRf5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0g
	BxbcgNgF22Cgt1a8bFnERUP4ec+O9F4Z9b0aef2hs=; b=HMJCRf5ZKjsN1S4WBe
	nCzTdDQMqNuaJcLsowDfixTZK4Zy2Y6axTZpduomrPbgBEAYD1EVzDpgh62cGr5Z
	m/Lv1+1Zzr9dMGJpNwFMjlsSBMMPS5lxW+4Ag7qlXg4MJgtl0aUvFsSLM6yhGsy/
	wLljy/XRnTexBXyAmdnpduTgw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3R87eHJxqtoNqAw--.58162S2;
	Sat, 05 Sep 2026 21:45:03 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: mm8013: Publish the OF module alias
Date: Sat,  5 Sep 2026 21:45:00 +0800
Message-ID: <20260905134500.67832-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wD3R87eHJxqtoNqAw--.58162S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1rXr15WF4xKw4ktF43ZFb_yoWfCrg_C3
	y8Zr9aqry5ur1jvryvkr1ruryIkFyxZrZ5Xa4vgry3CFWjgwnYvr1kWa4DXF18WryUCFn8
	WF98XayrCF9xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU3xhJUUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxh8AyGqcHN81DwAA3e

The MM8013 driver matches mitsumi,mm8013 Device Tree clients, but=0D
exports only its legacy I2C ID table. The I2C core emits an OF modalias=0D
for these clients rather than i2c:mm8013.=0D
=0D
Publish the existing OF match table without changing gauge operations.=0D
=0D
Fixes: c75f4bf6800b ("power: supply: Introduce MM8013 fuel gauge driver")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/power/supply/mm8013.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c=
=0D
index 819667a..c38f483 100644=0D
--- a/drivers/power/supply/mm8013.c=0D
+++ b/drivers/power/supply/mm8013.c=0D
@@ -293,6 +293,7 @@ static const struct of_device_id mm8013_match_table[] =
=3D {=0D
 	{ .compatible =3D "mitsumi,mm8013" },=0D
 	{}=0D
 };=0D
+MODULE_DEVICE_TABLE(of, mm8013_match_table);=0D
 =0D
 static struct i2c_driver mm8013_i2c_driver =3D {=0D
 	.probe =3D mm8013_probe,=0D

