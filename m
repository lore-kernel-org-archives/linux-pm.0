Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073345A285
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247808; cv=none; b=gygQD2y4b0OHLyw0LJiHhMkrWugplwJ3oezyU02uX8m+R+eIk9lJjviJTXRliX4hYyG1wo0nivGUlCHAVdpMJPB/508/nKh4HldkSmz8uCx1JmUfMMORW0L5J/8Qyw+L8EAUYkJaoeZKWmCZsfhNPFTHYv3pC0moTth8RXFLXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247808; c=relaxed/simple;
	bh=xzO/aTJ4wURncskDhP1d2t60dg5jb51TSe9AjD2syII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCMLn/vtr4siuPOk1XcdgGQ9RMu7t4CsfcabTE3g0ZCyoyvtisV/EX4QNo+puMBXSPUM3uEjF1rQF/nd6yqGD/Re2J8O1Ow+GLfEpGIbtniiCzGUIi5YcDA90Xhm5LH1tvXbnnHYL1dREqTKKhEA8m6r1aDhs0rmbN5t2KuCnZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2cf5e516e67so18083175ad.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 00:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788247805; x=1788852605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KhflzhJIt+7USEYgr5u9E8oq972mOC3DKuLj0M4QHx8=;
        b=DLtX6VuO5RHAdOgT4IeKqK2Y4l6Xl3o2af+X3e/nSC2cajbR3pfXRVTOMNVDWCdEiP
         kRW+sPLlw+uBrFm5ET8htdkXwzQXYYSjxEnGdFHYHKSO1FGmGDy9op/7mkKsQT7jCsVl
         AEpmb/z2DT/M4Llyvdzr37FC48CaxM2J1F0mLGlfxhEI4YMLL0wX4wPS+hNOx9LO1ARD
         5ZdOosu2rZ3QipmKZmUqytyQRRcITgAVVFTPFN68KD/WaTDw4eWOxJHKYrO+hIAwsBpG
         2gpUBquyG8aiSDbvCO9Walqf9JVwoRi0f4Sf8yToToqWKhoI1nkqj5IHgpd+STAGRD1z
         +hAg==
X-Gm-Message-State: AFuF++kGpcB6RmY/WSMYUEVpr/3J/BOLEd7Tq72kaZ/qfgJXHhC3QXZz
	XzQ1108flD5UsEadN9njFxnM4wV8bsRBbnjj6qNGE25EuPdAYvghfGkzUhFGvx+4
X-Gm-Gg: AR+sD13z1Lefw8k5XpiMPkO73VYeb3aPqP2jhSI4Y8ICkN4ZmWlCtHrw0KFaGHLmley
	Tfjunz8Fw9XizVLUgGercwXePGDcutw1f5JO0HargQ3XnggUyAl68uglDpM86r3yqct69eS9nqd
	5nwOBMo/LYLEm+e6l2Fv90XfQD6p6HH4Ka1P7dIaGhtE+yPo/uzn7ww4h/LTbMQKUAdMblOlwJu
	1O8DTTuJMKp7kC39CO0fH0MKiIuslHzIEB6UIQ3ztUj+zBOUk8tE5/X2rbdlU1++a6oRwKOparl
	1i/k55S4eGs8bWlFgdgpuEAKL0aeZI8k39oYuigz17cqTy7D5Y3b/z2WlA8gY7uBeYkEgthJDcd
	Gp8+8E9MuKE62/OiDOapI2TFePZICxxCeH5oLuuQQHSMCRbpdt7thgz4MzIB1iL8+hfP45wOQcN
	GS+HnMYpdU8KWPFomgwusle40A2gDSZMOQhUCyuUBQOlc/OKE2AFnnfKnJ4iMOUmjiuDaXpK1HH
	O46MyjAiQ==
X-Received: by 2002:a05:6a20:a11d:b0:3c4:46ca:3347 with SMTP id adf61e73a8af0-3d265e3f806mr43132472637.2.1788247804882;
        Tue, 01 Sep 2026 00:30:04 -0700 (PDT)
Received: from kylin-XiaoXinPro-16-AHP9.. ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f330f85fsm5656758a12.9.2026.09.01.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:30:04 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cabarnes@indesign-llc.com,
	akpm@linux-foundation.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH] power: supply: ds2780: Fix ds2780_get_capacity() returning raw value
Date: Tue,  1 Sep 2026 15:29:54 +0800
Message-ID: <20260901072954.1953121-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ds2780_get_capacity() returns the raw register value instead of 0 on
success.  The capacity is already stored in *capacity, so the function
should return 0 to indicate success.

Fixes: 275ac74629c4 ("w1: add Maxim/Dallas DS2780 Stand-Alone Fuel Gauge IC support")
Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 drivers/power/supply/ds2780_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 5b57bbba79d4..ef2446386c2a 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -304,7 +304,7 @@ static int ds2780_get_capacity(struct ds2780_device_info *dev_info,
 		return ret;
 
 	*capacity = raw;
-	return raw;
+	return 0;
 }
 
 static int ds2780_get_status(struct ds2780_device_info *dev_info, int *status)
-- 
2.43.0

