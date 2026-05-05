Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5072DEA7B
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020387; cv=none; b=LGEDg3/oc14pve0ylvamcBygxcEn67/mE+WBIBqblQHL5xe1VsjZ1B1GMdYMwUkxhc3Spt7PBqJ1glVMUS5dkclSnGYEFmcAq1DIG/Pu81yZpQzH0jU1bKEnP036SeLxvUjcy4gfCd8ToWgbRhvOrrjVw0WeBVrtqmqmc5m54zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020387; c=relaxed/simple;
	bh=QG4+v9HWXFG1GRswUr//AO+jT/MDyrnxE+RlC0mz04E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAWA9dpeEd40M20Sym/oaIdoX6MTVpKTzZvPyguvKIROB+GYa67kNZD7R6+zciNIm3IF77tuiwduAyWCenAZ0spXl30uDuzpR8GYd+XlVKVthgqckH+hg5v0ZxsIKv+1mdbWk8QHuygMgJKFew9exzrjJxjEv/fMd9RysCFKBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGrTNu4i; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGrTNu4i"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38ea6a5a0b3so57299811fa.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778020384; x=1778625184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWmXw1Ld65p4SM1p3E/vhOe4lxBprGFlawGmgtaD0cI=;
        b=AGrTNu4iHFGBJYUK7MHp1Evg24HvhgvUcf3Ofz4E90vKDZu67gcXSszILOddT1IX3g
         paMM+7l7fXkv+JAuaQmT9CyCTANz35jwUzS4DFSrxTylxpo3aSI3k/eiKLZT6Ehh5d1/
         VSVl9vxYob0WQ095v6nHxgLfzLd5tdWTHLa4BtXhYGtAuSpA7QwGEGfIczC+/a5+2s5k
         k/THggprYid+iEz5mwLuB/JkxX4e+DD0TMr07NzbLTpW2LGphtyVplDGaYvah2UUihkO
         NWPGJS83iOnInuLD46HB2bRCx2V3ImykQKf1quioc0811DQje3NgqV3uPmRhZVzg1Wj2
         aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020384; x=1778625184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWmXw1Ld65p4SM1p3E/vhOe4lxBprGFlawGmgtaD0cI=;
        b=cndNEXHbMRKc6nlgaU7Bl98lCUsT19HE2bzMrKd44uUDaCutCwB0sENFdgn4ZVd67V
         HCud4kuR+nc6fxR2IY4DBDNaCA3+inCaeg8IOSI/rvy1jCBZAqcdFCKvN2Xoq1R3GjET
         BmTUXsHCtgzPCjEsq3n0JYFmvPliI5D4/Eq7O6nIKwrkbytcKSZYQBOPZBacm9GubJUW
         jgC1oTCwKMWqJ6J/dkxF36zB53p9bnuNkDqNJztACQoI71XF7fi6nYQyqhWqlX5RNQ1L
         cYPxGBo1Ct+s1PB+8IeQ9d7+dNltZXOjFfvc57vaIZKG5ZTb1sA8RcIjCdyVsz15XuHG
         Hsbw==
X-Gm-Message-State: AOJu0YwVYqZhXhy+vGRrssarA5D/67DRbtTZcULHBspHtR7YINKYK2R7
	WDfr/n2JLTgOOtKKMdtq4lOKn/Ncnf9+9HIxLmq12yWn9f30HtDoe2t1cFCw6rWJ
X-Gm-Gg: AeBDietKO/oJWH2VDJqp2p3dmHnaqqdnVlHGud08KR8mw0AlRHP06XQ+TtMjzGsxupv
	songVYNmOfRysVwRWGasT1ibwoqKYnc6vqlvYFxGkIeADbkhlaGa/ATxlxBo6yiWf9lZbVhbDmc
	aCeO5UEgEFthaXAI6JHwJt7zvwitFfIYFV6sUvTYn/SNqqNO+UqXrHX41deTqRYmXJTpc4iE2V+
	fp+6AReQss+tfKFsJQVrK0MJBzG3yraZk2G5EQKwdBMFoF21dT3z/nG6lTWOZIki7Kbc4TFyblC
	LPFlls9/4kdRK2qpCYEp7UxFtdNhoYZvcnP+IFuj6hGq6pSvZOFFnfjHGelLlKP23Fx0e2XvL0Q
	luU2YwyzHNSTbXSbRwpHOaTI5gSWj4VW84xSrD+svEj2NpIMRwWb02W9DKN6U9yluvd1x9M0Fct
	cKZgGSRGgavzvLmwnffWj4pOARPagJbzLnTAVAgMZ0rUQOwo8M2qzDOWyCrUuxd4HMfUo=
X-Received: by 2002:a2e:838b:0:b0:38e:83a6:d37 with SMTP id 38308e7fff4ca-393c4136104mr3238681fa.13.1778020384115;
        Tue, 05 May 2026 15:33:04 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3936108fb8bsm43321321fa.2.2026.05.05.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:33:03 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] power: supply: Fix typos in comments
Date: Wed,  6 May 2026 01:33:02 +0300
Message-ID: <20260505223302.5628-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in comments:
 - occured -> occurred (twice)
---
 drivers/power/supply/ab8500_fg.c      | 2 +-
 drivers/power/supply/smb347-charger.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 9dd997226..eb5c1ae68 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2037,7 +2037,7 @@ static irqreturn_t ab8500_fg_cc_convend_handler(int irq, void *_di)
 }
 
 /**
- * ab8500_fg_batt_ovv_handler() - Battery OVV occured
+ * ab8500_fg_batt_ovv_handler() - Battery OVV occurred
  * @irq:       interrupt number
  * @_di:       pointer to the ab8500_fg structure
  *
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 8b95f7e87..fc3f90ef2 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1083,7 +1083,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb,
 		} else {
 			/*
 			 * in this case no charger error or termination
-			 * occured but charging is not in progress!!!
+			 * occurred but charging is not in progress!!!
 			 */
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		}
-- 
2.51.1

