Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B034A796
	for <linux-pm@vger.kernel.org>; Sat,  4 Jul 2026 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783182782; cv=none; b=cdjhwaSJzKreiBorbY9/npyg4h9HeFG+ZWnnnFOI3TIKhjHicoNx5wZ+m4lF+qGehWVfUL3JQLcgHoMTvRCK5Ca4TbU9OGuQEH4Z+VKJdC707ZHeLp5Tz8LluGMJiLXPNeYSBI9HJMcXd8AcS2KY2r1VQWjyG9UTfBSsVYllEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783182782; c=relaxed/simple;
	bh=o7695jDKyMq7xnynJc0eqFcQgQBIOicch7QEm8hRGho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4Qia3eTHmqEW7nIUFPmJ93w+73zxBFYNFmSuo9C3U3ukSp5nhl3FUk4Op5qm+F84s8MvlMWsKXQLybWVI22ziQ9h9sku+gfbWma8OwL+6l+e2W4NHTCvco7JxHTwTay6pTJ7l6fOUQaiOqv0R5FcIwVrPDyUyY6XQ1TryOn5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cO9i80dR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO9i80dR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-845e47133c9so1352872b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 04 Jul 2026 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783182781; x=1783787581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KzATaNbDWxtQp3t6xK2HV+CqjPaaLtgjIX6Q2wphsE=;
        b=cO9i80dRgPVd1jIW1X0Fieke43KKaUOSYcGQ/xYdBu5QCFlSVMA+GwSI6YwyH0EGt5
         JIQjN/oDft6IT0wWyetmYsxZQpZ7MOQzxYQ16e8FpbrT7omqp3JOgyvAq/IGm5Imwia2
         D611slTOhb0Y8AAXtLg+z1gwytuDoH20zzg0vJ1G35DD2XZf3nF4vL9gOsz+U2eQmcpy
         geGgGbRTueZfNmw84JGjL0TIEqe4dRpLa08aEI4K8LGbN14Vwt1qi6aZFN9LQUyK+era
         6iXCSBc4llMMQopb2Ylt1s2iFZUQoN/ecIVKpf9M5Ek+g3iL0NXfncNoCIduA69WXNJ1
         /iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783182781; x=1783787581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KzATaNbDWxtQp3t6xK2HV+CqjPaaLtgjIX6Q2wphsE=;
        b=X/hUqVWRzoQDuVBqZZlh+/TsN0dofu5GnbDfOPTEavX/Y3oLJFnFqWQnq6Q4Ub2r9V
         bGPWCHYgRb1+jbAp3G0ozOnT7nvFIpbPBj/+Ll5THrP/A9P4ICKIHprnLPGsdpAvpg4E
         evkorPEs/MuHr+1CkAAaSC8JDfyzoKbN+aFYUaECOTsxypcw0UiXMfCjNlRmNFkC8HO6
         Z4TGcTgQ14sNvkoZysuJx5wNAJdoGliZzSmuYRMbpv6DCfRENNGUbqKJKUEppB//7oTH
         t9bykTJdDhUeCmyQrEJoZ83e06KLPRMK3PI6XUnxouNJxgsWpObhXc2U+RJf+qc/bIIK
         JZnw==
X-Forwarded-Encrypted: i=1; AFNElJ9RiGNHDJAfrTR+FP+lYtVVU6VrMUgVaufdTCrw6liFxTgSIP3LooaqlBqat4iv3k6sTCi2SBGqvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjP8lJ9s5HQTULg+pGbx9ax5mp7unV05FHBSplqfCuu8QBxrcV
	AGNsSUFXO5O/h0S3z2T8N8iGuai/xoOI8iuL7lQOpqGZ1V917WExx2pj
X-Gm-Gg: AfdE7cnoqIX32TuYvk30VBH4n/61DnK6wJ14Ay2J/bmD6BdMtAiikaeu3fh07+6bW5A
	gNwExs/KUZ4aNjN4QdFmMxmGmghS6ROWZl64Y7Ua9Cp2yDla5dv/b3kR3mT8/0Pn3DpxfK/DkTS
	3DAEwpJM0rkOZYGfDydbveXrwKcojxWWvGtkwVvcfRydMJkJJcX77xRl7aODjVii6B2AAUy1/zC
	vLUvrd+9iW6ZDmPNflYrVOAaMPiYAj8pyRXkTsETXn3zmhI1vI8qdV3DTP6VHhlUuk3hCJSCCeQ
	F2txbyhHrLFjkol5JeATWEGsu+ZF2ijyrzlG/xdZhb+RZdThAvf6ThH7WUaqvKbzD9JiU3wKAtd
	y77Gg9mXEF0hHNIGosF2Tkv+aB72gAd1oYufuOVyaYUKCv0RjAuKyRVutB7ZVSMv+zNTaRW4hUD
	7V0+VHDN06u2++ETPChV5VKXZvDaqosWwwp3/1OBZpWDFmzm3NPvBP2oKr9A==
X-Received: by 2002:a05:6a21:4c11:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c01c65ff4fmr8581665637.14.1783182780471;
        Sat, 04 Jul 2026 09:33:00 -0700 (PDT)
Received: from fedora.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm46750200c88.1.2026.07.04.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:32:59 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: mrout@redhat.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Kant Fan <kant@allwinnertech.com>
Subject: [PATCH] PM / devfreq: userspace: Fix memory leak in userspace_init()
Date: Sat,  4 Jul 2026 22:02:38 +0530
Message-ID: <20260704163238.115819-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a memory leak in the userspace_init() function where allocated
memory is not freed when sysfs_create_group() fails.

When sysfs_create_group() fails, the function returns without freeing
the memory allocated for 'data', leading to a memory leak. This patch
adds proper error handling to free the allocated memory and reset
governor_data to NULL on failure.

Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 drivers/devfreq/governor_userspace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 3906ebedbae8..b9fbcacdfba1 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -97,6 +97,12 @@ static int userspace_init(struct devfreq *devfreq)
 	devfreq->governor_data = data;
 
 	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
+
+	if (err) {
+		kfree(data);
+		devfreq->governor_data = NULL;
+	}
+
 out:
 	return err;
 }
-- 
2.54.0

