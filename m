Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862927;
	b=NTI9f+Z3dSr19np7Goubd9QFtOCN17CL82D7+euwjmM/cSCdM1foJqonz24cOcvz4atF
	 siS02u3MnORPcDTmtvXQqrvXMwj7ZwXCmd3n0lj8zW5ErZ9HwJSkbdb3uUOT5b0Wt8v2B
	 94BGvI+KgJ7mtVwlgpWSzKL76SOhdjJ8jhreQxbMmLNj++Jl33YhZSWatq8zBf0okebpC
	 FWEA/FKxDKajsvI3HRBqaoYSl2BQId57x7cR6nQ62qjtyUb2ytIzv7I+WzlD8jLnxu0bw
	 yEePD3lb5/JbS2+OjlWTSqeQSErAbH2F3UM4tOEmCK02weAJZD28uE7qj7V+RymG/sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=GHXsA+/24vMWukf4k0zEIYWnEpjWZCZ9P7eSBTXuVYs=;
	b=gdcKFZZGLv331XGS2ces0vI0/F21H/JWo8S7t1Wu/i98HcYCtum2kuUtsTnCavdm7NFZ
	 JVTytJhe97bCZXKUuAjIpXvzrlc/GwGnVVTdt0mEH+eSw4l4qkROX9UImatpR4U63I1un
	 4ieLlMIb040P6XQscVg0kdlD+fKJNqBrxK51h6u5ruG06DP8VgKCZDzFOFOGQbYOtj18o
	 QsNPkmBZGmNYqXPukMJHwjSrWy0iOQBGc92o/BOskqHG42Xp4uM16+Le6Cg04bNvxxb6e
	 rzhtMi+xhJ6P1aY6tnt4Ahr7P1ibtSnoyMR/wbBdJwodkjxqYi/KRkZGmGb1IR92qJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jg6hNPsW;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F5606A33E
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 07:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B19F5606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jg6hNPsW
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so3168546c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 23:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793862926; x=1794467726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GHXsA+/24vMWukf4k0zEIYWnEpjWZCZ9P7eSBTXuVYs=;
        b=Jg6hNPsWfQtb68lkQTTdn3GPhmyaj2vwepCZvOw0LfGRHGXHlr2bd5thdcqX5ayDek
         9WSZDNQ6TYB3XJVu58SMO/1k6ZcZB/LrHW+s+/LyjqKeXcvWEGtc+Mphlo50SKBcHDyA
         /MFETxN16RuJ6vDSSzfAJ+cCmw+GNWEWxxQr9YY42oGZTVFE1uxB5JHMt+BC53i4LuL+
         ZKQ3EhB9Wd2TS9v4EI57NbnTzVZ4eeQU+/t0IU6S1aU8+g4B/mrQVn7CSkLQysqJcMOY
         rSAhGrnWHFqXQWLPfqK3DiklRqkgXs1/Uc8qjycmQamOqt/8Ddcxh09nHS9pf521P20T
         pGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862926; x=1794467726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GHXsA+/24vMWukf4k0zEIYWnEpjWZCZ9P7eSBTXuVYs=;
        b=SKBRbQoSFPvwjiZai3y7sloqSjRDtHhRfil/uTStrnymZ6+aGviEkNlrrvsVS/Djhv
         WdmUctG/HigMQwnvlA2yGJo33yDpAPEp4XlhgS92kTApTAsGz0E4kj2u4GLqZdXdZbr2
         uq2YqAAV+v0HZkA+atzN0A+LPm6PqbrPHiJYPC49khSjbfRC6BvjihuLnUBTL8VFXB+f
         Dp14w9EZ4BkhXExc94Na4amWwA+f0Yhib/omMGHEpgmvUhnpH43XSfBm/aVXKao4OQgm
         Mm/+2sQYiL9v88DGmmU6ktCyqINdrYYbWa5WumVMjzIzW9U47Pube85xClb7/SaZGT6a
         YpRg==
X-Forwarded-Encrypted: i=1; AKwUvBzMEYp5FwyysFnnIco2Y0b6r9SPPm/F4zN9I2jHofzZMCNgSO6zsjdJRO+bDDyfaOmH3hCEYKbaqQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8JjWeXPDPORPNF9+/oKbZI6k7HC2R7LTPa1bQlxL8wqwIA8DOA
	AfRmdeKlyyyuQp114FBYUJOQupwr9C7hGUMKRVAqypxffHx+LQxxz8In/iYkVImazPH0AjMeube
	aaYcdj3avLafNDWETYDBqpg==
X-Received: from dlan7-n2.prod.google.com ([2002:a05:7022:eb47:20b0:1b2:4da6:71c1])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2522:b0:1a9:c9fe:12c7 with SMTP id a92af1059eb24-1ac5bbb4b85mr35767434c88.9.1793862925107;
 Wed, 04 Nov 2026 23:15:25 -0800 (PST)
Date: Thu,  5 Nov 2026 15:15:18 +0800
In-Reply-To: <20261105071518.1458428-1-stanleyjhu@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105071518.1458428-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261105071518.1458428-3-stanleyjhu@google.com>
Subject: [PATCH 2/2] scsi: ufs: core: Wake consumer queues on suspended W-LUN recovery
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Brian Norris <briannorris@chromium.org>, 
	Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	John Garry <john.garry@linux.dev>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), a failed W-LUN runtime resume leaves
ufs_device_wlun in RPM_SUSPENDED with power.runtime_error == 0. When
error recovery resets and restores the host, ufshcd_recover_pm_error()
misses consumer queue recovery and leaves waking I/O stuck:

1. Consumer I/O on a runtime-suspended logical unit blocks in
   __bio_queue_enter() with pm_only set, queues pm_request_resume(), and
   resumes supplier ufs_device_wlun, whose START STOP UNIT fails.
2. Consumer runtime resume aborts with pm_only still set while
   ufshcd_err_handler() resets and restores the host and link, then
   calls ufshcd_recover_pm_error().
3. ufshcd_recover_pm_error() checks only power.runtime_error and skips
   consumer queue recovery, leaving waking I/O blocked in
   __bio_queue_enter() until another request touches the same queue.

Set resume_sdev_queues when ufs_device_wlun is runtime-suspended in
ufshcd_recover_pm_error() so consumer pm_request_resume() resumes
ufs_device_wlun via the runtime PM device link and clears consumer
pm_only through sdev_runtime_resume().

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
Prerequisite patches (for mainline and stable backports):
- Message-ID: <20261104112744.1630864-1-stanleyjhu@google.com>
  ("block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already
  active")
- Message-ID: <20261029040002.2100002-1-stanleyjhu@google.com>
  ("scsi: ufs: core: Keep clock-gating hold on failed W-LUN runtime
  resume")

 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4f0301d2a5d4..880a14a2c5a4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6953,7 +6953,9 @@ static void ufshcd_recover_pm_error(struct ufs_hba *hba)
 		resume_sdev_queues = true;
 	}
 
-	if (hba->ufs_device_wlun->sdev_gendev.power.runtime_error) {
+	if (pm_runtime_status_suspended(&hba->ufs_device_wlun->sdev_gendev)) {
+		resume_sdev_queues = true;
+	} else if (hba->ufs_device_wlun->sdev_gendev.power.runtime_error) {
 		/*
 		 * starget, parent of wlun, might be suspended if wlun resume failed.
 		 * Make sure parent is resumed before set child (wlun) active.
-- 
2.56.0.385.gac671c819a-goog

