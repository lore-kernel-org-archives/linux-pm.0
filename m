Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511649;
	b=lAC18/S1HQobV8VMOtJ2uQ4aG9Go7xACD+M4wDbuNiUEGspA6bjtmAEnYJWhpU7ZzYUF
	 qWY7xLJta0JhRgKdaubj6o/gL7FMATC2+58wTkL72tnl0htsRd5K38vnVXA0Jx9chMVtO
	 fesW/eR9QGH4SmjmBDNtI776Q0RcTHvarJEuHCBf0EM7/SwhXyflzqLZ2reEZvj8SpW8t
	 mFSZN2MpRNBofbENISGr6+61LAIuDg79QbawS/uiSapv0n9YoV+uc9qPsaF/Npg605xnd
	 +jQi41G8VDkUzin8Y/9vjR6B+yq93lHrEBW/qLOVPiJj2DWdmdqrAwTz4+VmOV2LLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WK76SX0nrcCBNXP9LIGbyNxGyxl1rLl1GLyCozITqPY=;
	b=xkSUp1pMvKE2ZJati2YpOroKkk1N9C+rhsCQHrNxz4eBh5gBm+JxgBnMz60pznwy7vMO
	 Jka7Bz5Lc/Bej01DfxILcP9k/5AYzi3J40yM2S+f7gJT1YZ9p1g6Y5CtiUHINrDtXeID4
	 QcKCwNkn0ufo0SIxJBf663NQeOJkoUSkKnRgL2JFyJ5E7EZAZZXVJ4IMGi+lbnV3AwcAO
	 +osvE59wzn6eL7cnxWYZhVHrBhPssI/QECBAu71PTm+sOFAphRwyJTARA6jFhlewNDJaN
	 9V1L122zh01xHdmI/U36ceWqVHaX/3dXiNAC/Hla83JQJ3HzDvB5Rs+D43MxmuXDDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WG5ACeJA;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1EB606A321
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB1EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WG5ACeJA
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so99989c88.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511648; x=1795116448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WK76SX0nrcCBNXP9LIGbyNxGyxl1rLl1GLyCozITqPY=;
        b=WG5ACeJAfsAqI/SNo4EQzMNroNtqgr9YtZsBgMQPriWcH3f0MVw5r34UoB/ls3CUCi
         0AINdQ6584CpYLZwc6rxWtc2SykkFLUSRQ8b19368uBwvvXS3rvFLB6wIQXXm0MOuc75
         RyXvi3kaJ2XdVHBEH3p8FNm6KFDkv60AA6ftw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511648; x=1795116448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WK76SX0nrcCBNXP9LIGbyNxGyxl1rLl1GLyCozITqPY=;
        b=mnqSX7uWkJUeK8FGc5oxX3cW9cGrjqvEE+bDxKF4dygnqZl6n5/KMWupfqZtpm7H4d
         6rg7wa0t9iq1eX2tKHsp/YVu8u6eFsgrZ1MP8IxDh16pzNIIHJms2IUMws2gW7VTEWDb
         HDK8HSpi9KU+IrVAZqz19El4w/gFtWK7FWTycxQn7qghRjBt98/TKjvreArUHLbMjsDm
         3THCn4N/mXEEVk8wz5BSvPn2t9pKtrJV1h0slPC6G3cIuCgFx6Frf67RsDSkspRs1YeC
         9ujywyYmMgMgnGjgJ41GDrAI/4mT61Rxz1W2z8vWMLmQU3QoGPjKPjJi+XdpXqbh8r34
         61Cg==
X-Forwarded-Encrypted: i=1; AL+hErFGazaBUotXa8DhQfxKypveUkUOZEpBaCbahWf+eYNHlS+2FtYPqeyx5B6bYwJnul6YNYM7B+Nxjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+joi8i6PdDT1Mkxsr3JKmQcV3kE4hOYsWfclY8MzfKXDoe5Jpy
	X8YcWq3TmnxqN+2+KgsDhRsV2PrbIG/us21CE8UlHsL+0tEXj8cVvyt49feHoAFMUw==
X-Gm-Gg: AYBFou10R3c9LVflFGDGmxMEllfoWHTScUDTQABGOibr6NaOH3w7fW0Fr9AlgyHd52o
	Wd0QaXgYupwA62QZNjC2PC3nz4txa69cxU/KKmc1fzsEbi/nyZ551Dsh/IH4gEDwWPSTaJM522x
	/Zd2uVJThiGYTjbx2p1dUbR0ZsEnGX1OiBFUl7Q4L0ntAAnwktjy2VumdEYJon/j/kFCuLytaWV
	sds1iBNCKsIOOnKMqAdtIxYEu+cCbRaOZuDdID+2iSy3sNuH/ggVqov7Nh8ULTd39JG76KcJVZN
	ExfN0/esMfIB4RZSWJap+9Y1+uKvGA7YabbHvFhlXin7bneE+SoiqE/w3jsygqS3xZ7/ZE/M1nX
	i1p7Nvq0mYD/rjEKf0lVjMhUwVTG+C3blbdqGsVVMXuKjYJdG+L0mas4zdz3DJb9Kq8k2fY8AUd
	MtiW/oLG7JL99u9BWwIVwpm9sRj6t6u/D85i0wtT6nI642w7e0NZJsZz1vawUYnOrsmNjQjCqhB
	g2e4nLlHlakSA9Uk72Ot/nwCP1GcbU/EpRYX/59GxD+sguD8EIyrEvJpIgv16/6YOn5vip65Qml
	lAdlLgcRRL6+uDuK/Q2l5BPoNs4nGiewONUnlXSr2f4ZqqXhnEBHqUF6YFdGkDDsmNyalje+0M7
	dt/adwlYWywE0fjs=
X-Received: by 2002:a05:7022:3704:b0:189:d6bf:7eaa with SMTP id a92af1059eb24-1b5030d404cmr428948c88.16.1794511647718;
        Thu, 12 Nov 2026 11:27:27 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5031bc518sm886774c88.15.2026.11.12.11.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:27:27 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	"Bryan O'Donoghue" <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] media: venus: Discard pm_runtime_put_autosuspend() return values
Date: Thu, 12 Nov 2026 11:26:50 -0800
Message-ID: <20261112112650.1.I574fc3def9965f603755a968ae88309aafdfa285@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagating the pm_runtime_put_autosuspend() return value to callers is
not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update the Venus vdec and venc drivers to simply discard
the return value of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.4.I574fc3def9965f603755a968ae88309aafdfa285@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

 drivers/media/platform/qcom/venus/vdec.c | 10 ++++------
 drivers/media/platform/qcom/venus/venc.c | 10 ++++------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6a43ea191da1..35c1b6ec1f9f 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -644,12 +644,12 @@ static int vdec_pm_put(struct venus_inst *inst, bool autosuspend)
 {
 	struct venus_core *core = inst->core;
 	struct device *dev = core->dev_dec;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&core->pm_lock);
 
 	if (autosuspend)
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	else
 		ret = pm_runtime_put_sync(dev);
 
@@ -671,7 +671,7 @@ static int vdec_pm_get_put(struct venus_inst *inst)
 		if (ret < 0)
 			goto error;
 
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 error:
@@ -1200,9 +1200,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		if (ret)
 			goto put_power;
 
-		ret = vdec_pm_put(inst, true);
-		if (ret)
-			goto error;
+		vdec_pm_put(inst, true);
 
 		ret = vdec_start_output(inst);
 	}
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 79acf7c1ec9a..3c7c24dd7159 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -617,12 +617,12 @@ static int venc_pm_put(struct venus_inst *inst, bool autosuspend)
 {
 	struct venus_core *core = inst->core;
 	struct device *dev = core->dev_enc;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&core->pm_lock);
 
 	if (autosuspend)
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	else
 		ret = pm_runtime_put_sync(dev);
 
@@ -644,7 +644,7 @@ static int venc_pm_get_put(struct venus_inst *inst)
 		if (ret < 0)
 			goto error;
 
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 error:
@@ -1275,9 +1275,7 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto put_power;
 
-	ret = venc_pm_put(inst, true);
-	if (ret)
-		goto error;
+	venc_pm_put(inst, true);
 
 	ret = venc_set_properties(inst);
 	if (ret)
-- 
2.56.0.611.g1030f0b940-goog

