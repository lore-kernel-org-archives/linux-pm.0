Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188643;
	b=CBLbs1LxSeEK0w1jzH9iGBQstFxwmzipQk04zNfry6XFOc2uFiesV2pfq3Cs1oO5k03q
	 CDQNbGhLQhHGQMVU7A/xZef70vbKMZeQmXelGJ6pIHZ5HW36P4TXyh5mIIm79OoJiCwkB
	 GIxaXM8ap7nkPadFa7qky77q1BP6xG+OgtqiTcMoBLzoNxBr9GD/QNeB6PzoHxOgIi9fP
	 gieuLLdVktOcy0sfd6PLqNPts6gjvZIcgYxCOWKjg2uIg7kDhIKOQ5b10SenT8h8OtIMZ
	 mQn+LL9nQrI4zJQWABr/0F044CX+kLKyqW2sxw/VcUWGz3igKpyLIbXsjGnshwBVFKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jTqVdXyVPgGlZkcXdomYHRmtjKpXsH0l1uVxUwEI6Cc=;
	b=pj8g05lUrvCi5BhSQNusIIA+89HoxYwrsol6mLAIRTtK/kCrMsn/JDb4aC9lVOhvxrFl
	 So6Eo97/vuPh9/PVrrJsaHMh+BUuBlrHf+rKGfe0glC6MiR/81eZ3NxK5kGMYcO7/CKO3
	 RbgFbfmFSmOKM0uWcjWEo0rXY03q2K8poX+2D1u7uTRpp0/vzGBjFY15DhFALjlY6hCtP
	 By/xQ1O4/XkB5pZhsloQG11iSSi/1FuthV4MpiRlKsAx8VpHlXevHXOeGOfaEZYLq2kiz
	 KXLUycF4uUwd3GwfPmkg9/Ut9BR2qxnaP5//s1ej45nYOwPYR8f8xY4OrxcAW2aifew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sebastien-wald.fr;
	spf=pass smtp.mailfrom=sebastien-wald.fr;
	dkim=pass header.d=sebastien-wald-fr.20260707.gappssmtp.com header.i=@sebastien-wald-fr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VGAHHOYB;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F3A606A330
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 15:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34F3A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sebastien-wald.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sebastien-wald.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sebastien-wald-fr.20260707.gappssmtp.com header.i=@sebastien-wald-fr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VGAHHOYB
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso9552235e9.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sebastien-wald-fr.20260707.gappssmtp.com; s=20260707; t=1795188641; x=1795793441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTqVdXyVPgGlZkcXdomYHRmtjKpXsH0l1uVxUwEI6Cc=;
        b=VGAHHOYBdbuRzDOycvsgTVxfsD43dpou3bOcLeYuHwXGQUHTgnKSAO3PjaUEwagjsw
         lVQcIvZ/uHhtZXUZql212MLmH94ESw5VfrtWR2iCGbT2c8hanCzjTrDtTthRdrHiShVb
         xun1UKs6zNLCCGdonPBiuWKbxszmqBbPDTDu0WPXb8afADFzQOqu1ywM4pSD9V41GP42
         8w4md4ffiduDp4Ry+hnceWyg5jBpt95H4BcwGvN1y1mT6Gz0xa1vJRNrknMh2VTiBt8b
         QNSWhKyCTX1Ctc5Lcmo6DljkkJeAzdPhdXtwhsv7rT7gbc5dmcIGgCNYeYm8C2mMS0N/
         iDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188641; x=1795793441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTqVdXyVPgGlZkcXdomYHRmtjKpXsH0l1uVxUwEI6Cc=;
        b=Od05wepv4hi3pdDMSEglW80gqtnx8H4iHODN5xmYZ2YcYhNSx2ORcHYDfOjIZzNMU7
         +zch+LuKpQ7zzdCEYUgFAhh38zSTCDq06HBUHnYeCkzREyvoqNeY/U9hg/896woCdtoz
         2rL5hgo0GGPDd/ZGqA5pcoTm/vTdpu1HImRzAyjBXH23IC3cFnKmY2zISTyrKYpy+Hqb
         1xGYqtJjee/A2l9En7L4s6ShYh6Z+96DOJkMh2br8conBYLwUTr5HRDAuvtpvYTMldUA
         SbY6S4zw8tppy04xWpVm9I0ECv6pAsybfwTGibcQpzPT3AqqL6o5rDxkph1SQAcQTfHE
         f/2w==
X-Forwarded-Encrypted: i=1; AL+hErFNe3lUSZbA3lTWuYGi7b4W5JgAu0R/e+895tFaYR1Ti7DypzTNR0+zqni1fUksC3HjMMv5iGF+SQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1ruV1DT2g0FirBWjsZEMAgbmLH2YqTirj228Pq8j61xZ0CsjU
	Rnb/CJxTLNi+/i46u1avxBNuL52AnVUxdbJj8ufXyUjLhLycwSiVWBajwR7b1h7MXQX8QdkiJRp
	7AX+4xDsh
X-Gm-Gg: AYBFou1y7OXDucONAc+DFGb1XaFQeaFmizuYtKzqrjyRAFFSlO3XLf0hN7g5XgMmyyd
	GN7Jbwo3918SOoIoOcBcIgdVkg60KQdZfvPV+9Pxcs1yuJk5+bfLucA/2Gvirjvzmzy3d306FsL
	GbKlCgiiZ8ulsZUkeBW3TOQWhTTauEKAAfyPBd0EABkCFDILYHI/2ctSOaQW9n1zRbFJjURZAcQ
	y8dQT0kbN4yJpp8ROjBWN/B7Q9BvCE5Wh2Y/Garzs3Xgvkfauf8WE4j87ACrdRXKG9DKblJOmeG
	zdfZ5bYHyyTCudv21Z9oZcKQ8o7m6vjohEmCkwChwP1Td1CptGHpdj+k6+iPzLEY76G9QnfOMcr
	2HseGXbfaAqU/zukUU6WlDShdwd50IckgLPnjein3ZgKsN7xCDSPeKZGOeJAvKJ/3/ViGcBpD1U
	UfKFIWZ8C9WDXxzmPieM7UgefB+PjzYEYT030/itkD0J9O4bpCjCGDMq+eNQ8kCPt9bKZImYw19
	HQtSG0V5jgwonAUUcGqHr39l9m6G8qFGFPAvZMLbFlQwXOHE2rAu76hfz0lclDad83aI/Yplt35
	cUW7QWblTu+vrTMOzger1FnlfqiRtaV+jcELuWJY7Jo/SMyBicSyKs6z9tGK813tYOscX7zxzCJ
	m6x2u2Et0HoEcBjzfkpNut0lTtsGpaeVjLEmuXmH8NuVwS7m4zbrezV+JRCjUzsRT2QmdT6DPBX
	V7ZV68DJr/AZSD465Pi+uY
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr79669215e9.29.1795188641463;
        Fri, 20 Nov 2026 07:30:41 -0800 (PST)
Received: from omarchy ([2001:861:39d1:56e0:72f0:5499:af72:41c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm30328535e9.2.2026.11.20.07.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:30:40 -0800 (PST)
From: Sebastien WALD <contact@sebastien-wald.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: Restore power limits after hibernation
Date: Fri, 20 Nov 2026 16:30:39 +0100
Message-ID: <20261120153039.33744-1-contact@sebastien-wald.fr>
X-Mailer: git-send-email 2.56.1
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

rapl_pm_callback() saves the package power limits on PM_SUSPEND_PREPARE
and restores them on PM_POST_SUSPEND, but does nothing for hibernation.

When the system resumes from hibernation, the boot that loads the image
goes through the firmware again, which reprograms its default power
limits. The values set from user space before hibernating are lost.

On an MSI GS76 Stealth 11UH (Core i9-11900H), thermald sets PL1/PL2 to
45 W/64 W. After resume from hibernation, PL2 reads 120 W, the firmware
default, and stays there; thermald does not re-apply an unchanged
target. Suspend-to-RAM is not affected, because of the existing
save/restore.

Handle PM_HIBERNATION_PREPARE and PM_POST_HIBERNATION in the same way as
their suspend counterparts. The saved values live in kernel memory, so
they are part of the hibernation image and available when
PM_POST_HIBERNATION is delivered after the image has been restored.

The problem was analysed, and this change written, with the help of an
AI coding assistant (Claude); the analysis was checked against the
driver source and against the behaviour of the machine above.

Fixes: 52b3672c1354 ("powercap: add suspend and resume mechanism for SOC power limit")
Signed-off-by: Sebastien WALD <contact@sebastien-wald.fr>
---
Notes (not for the changelog):

Reported first to thermald, where Srinivas asked to take it to the kernel:
https://github.com/intel/thermal_daemon/issues/621

Testing, on 7.3.5 (CachyOS build, clang/ThinLTO):

- Without the patch, PL2 of intel-rapl:0 reads 120 W after resume from
  hibernation instead of 64 W (observed with thermald running; it does
  not re-apply an unchanged target).
- With the patch applied to the 7.3.5 driver, built out of tree (no
  warnings with W=1) and loaded in place of the stock module, thermald
  stopped and the limits written by hand:
    before hibernation: intel-rapl:0 PL1=45 W PL2=64 W
    after resume:       intel-rapl:0 PL1=45 W PL2=64 W
  The intel-rapl-mmio:0 limits were also unchanged across the cycle.
- I have not run a control with the stock module and thermald stopped;
  the "without" case above comes from the original thermald report.
- checkpatch.pl reports no problem (apart from an unknown commit id,
  since it was run outside a kernel tree).

The machine runs an ACPI SSDT override for an unrelated firmware bug
(\_SB.IETM._OSC references an undefined \_TZ.ETMD) and the out-of-tree
nvidia and msi-ec modules, so the kernel is tainted (A, O, E). None of
these touches the RAPL MSRs as far as I can tell.

 drivers/powercap/intel_rapl_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index f58649f..eb8c02a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1878,9 +1878,11 @@ static int rapl_pm_callback(struct notifier_block *nb,
 {
 	switch (mode) {
 	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
 		power_limit_state_save();
 		break;
 	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
 		power_limit_state_restore();
 		break;
 	}
-- 
2.56.1

