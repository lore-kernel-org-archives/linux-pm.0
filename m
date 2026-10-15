Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F664C67F9
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068316; cv=none; b=pIWbb/f55Eq8fP4WuEIRRi5AFr1CNP2peU2Od/g73Zmt1Rx5YlZqVlyt2q2+N08ojxhyB5oH4L9qhTbHe0DD5NfnBA+cXKfxBbq0wens+LdC4tH20J/GmJ9YDULJJVq7LNA/TzIzgNd/RtDVF6B0ZKwNgCjkj5OBfajPy9KKWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068316; c=relaxed/simple;
	bh=j4bWdL2KdzuWTN7mQcdzbBE3anUhrJg5Qh62aTSfhog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eeLOAtj+7NsCzhFdxfbSN4+DOAzBW3BBvHWil1+huUlYBXYxp6vhH2rnO8PoG/AliXvLYqlSWKMIA5MQJoqwjXdSVvPr8WQZPitgIn66J1jr+EfMzEbJJuqkGgEHNU418l9PUoKOP/3fYDHILwryouWGEfruT63b8gnifV5Jjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=gkEMpKuu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="gkEMpKuu"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4649b35bso384830f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792068313; x=1792673113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Il+ddCvnfoN5BE2PTqdZxQP835L2JzCkXFfKNhKcR0=;
        b=gkEMpKuuiZju3dY3nJTJkhpwyWzd0DF21vBLece/CRWwY/ho1cjniWk0xPech7HhOv
         qxVoaavz4VhMF2Z4HUncGzoJlE8FfWIh0Nn1/HQnid1xpDEVcRIJWHeYN23bf4BNgevY
         vd22S4b8aQVSGXzX8akUHu+yDokTc5RGRBapK+JXDNly8s/6U7QcxG/W7Mh6Y/Qzw5OP
         2OwkZcI9V8gsCr6cfKPRJS5xCAcv729qwlhL/FOiaijiPqR34YB5UvYAEw7zD9O3saVp
         HADZLtA91EbIAi+vrF/FX4D4DkG5dnYkjwPQ30WcoZgkF5aIHVJm6BlF3RtrP3Sqrjrn
         jb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792068313; x=1792673113;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5Il+ddCvnfoN5BE2PTqdZxQP835L2JzCkXFfKNhKcR0=;
        b=0WF+FYfsr+Hpx8Qb7+c0mJisJV5EV9L8LdkGze/3c0eU9j4qiHIospNRNVvzqN/qZt
         +uIq9JWiGRYyXJfC41Q2o3yr2Bd+oCGBQKeTYETdupiKfFQFrv8LNu8d6EMJluZogPmo
         /M57oqYIrO4VOuNYkbsZY2sNpQgING1vihKqUr9ILuDwSTfgui/2vWFoI2nL0fRo2Vag
         KS4tQfnq533FH8kZe5k5YndOa4OPoWkW/gkb3TJaIPyapRKoHCtfPerREFp0oJRWmye8
         TdSjYNKWap2wKZgUt2SiofVJ3R4ldzNdRGR0e4/77yHvkb7BKckKObAON0r00QsvLjac
         p10w==
X-Gm-Message-State: AFq9FYLOIXUQ66FiuoC7JfJRPpePFqGtxFxkPin0hWu3XFigi6pyT4dB
	1pnVfOWO9o3V6N0AO3CzoVFTsrEpUQ3OkNF7Cd0M6shci3ppwmIQixEi5btu64LZziI=
X-Gm-Gg: AYBFou3a4stLv9OgUDeq4Rf8uySbLF3gau86ZU7Q7iyWzbE3gDpGFRYePwTh5o2SdaB
	//gdJcH0vVIRiLZGCskxFMoQr+cUwjU1763zY75R2JtSmpke5k67OonofLZUMg85VzV+uLJLR7S
	lpacf0azys/z4fmVuvHpNSaS5AgQh0G5iKqmNifl/Uc3Rg0HbPzftgg7zce3CugM5WRUwN7GBXK
	39yUwouuqOY5UEgaiQVFtTVkhbqbc/VA7mLCJrj3RlttPelSVdB8Xq6A1ZNqI8lE87YB7RJ+5Yu
	SxxjTv1sd1M8AH0vL5w9bBtlxmOgaCruyQL0GSGZfY3eWG9IUDI03KpEkXWD+zUofSSAyxRYuRx
	EdfCcbApMYOkfc4AU0di1tcMyvT3An9Ry8wLYyORcIOG/+MtO3kWiNr/TbBCf+Vx+EFX07r/7dR
	CevmVm4XuqQeC6aew1P648KVcmPKKQKkVhkKlt9O5xGD9raRrbNA6NBTBeNjv+JIb9caOvoPJ8u
	Jv3evA6aMsHyKh8JmKlrAV+EANI3bLQqBr1ck0K1sVmrGB1KDnYSSo=
X-Received: by 2002:a05:6000:41cd:b0:48d:f14a:9179 with SMTP id ffacd0b85a97d-48df14a92cdmr7027218f8f.48.1792068313379;
        Thu, 15 Oct 2026 05:45:13 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4edfsm19586102f8f.26.2026.10.15.05.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:45:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 15 Oct 2026 16:45:03 +0400
Subject: [PATCH] power: supply: bq257xx: Describe the dev field in the
 driver data structure
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-bq257xx-dev-comment-v1-1-c87ee6a3b251@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTMJLbQ1XoWwsMOoY0LRFkkTw
 t0punyL/zdIHIUTXKsNIq+SZA4Fqq6AnrfwYJSxGHSjrWqUQf/RxuWMI69I8zRxWPDiyGiyru2
 sh1K+I98l/6798Hf6+hfTcq5g3w/p9fQrdwAAAA==
X-Change-ID: 20261015-bq257xx-dev-comment-87c52c67346b
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=alchark@flipper.net;
 h=from:subject:message-id; bh=j4bWdL2KdzuWTN7mQcdzbBE3anUhrJg5Qh62aTSfhog=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRdOHX5enzCpVxpoxlqoj8LFIK3MvYU2b3RbHNf8FPEc
 efc9Sk5HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1hDXDf1eTI48Ujh1TtdnJKW0k+T2Ip+3lD+/JX6tCLfIZdiTUCjH8M/LsecA
 94XzGzPCne7xU4l425k4SN7+2rZRJSe0k370DrAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The commit moving the device initialization to the new .init callback
missed the description of the newly introduced dev field in the driver
data structure - add an entry to the kerneldoc.

No code changes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610120726.XkN50Smh-lkp@intel.com/
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 2177cee29a4f..569608bc0d6a 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -54,6 +54,7 @@ struct bq257xx_chip_info {
  * @chip: hw specific functions
  * @bq: parent MFD device
  * @charger: power supply device
+ * @dev: charger platform device
  * @online: charger input is present
  * @charging: charger is actively charging the battery
  * @fast_charge: charger is in fast charge mode

---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261015-bq257xx-dev-comment-87c52c67346b

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

