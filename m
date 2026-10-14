Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC55485929
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009191; cv=none; b=q3Ki1Qzpxl2p2ILQf1BeIKzLYPS59HbfA89IYF16IJVY7bgDEjDiLeUMYH+L9ZJXPALasXSlKvuYe5wh1dmxutRB6ZOfvFmSIEb79lUV0VXxSlp8XZcn93mlyaAzKp0+5/qZsM9zhRy4ySana+vRWJ0GzND1XJjcgGw8tO7zZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009191; c=relaxed/simple;
	bh=HSouUZ+8rRz8lfKNBcAhRF1paVy7OJ3RiDol7aAyrh8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GxSGek0T5nYog44X5/ZfKAeucvBZ21qhq2A3b+qxr9zm4CLCaWvr6N4AhYPA6676HqvpGZmtJ4hOr9doQuIb2EWcDikIohD8UXD1IxLBBDBSWvP2ZfMcF3QhJvmq17vj8dhoP9H+PI8dmQNDi8p3Djb1dM/50trqblCJgoS5OHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDPbKSMu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kG2dfeUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDPbKSMu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kG2dfeUt"
Date: Wed, 14 Oct 2026 20:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+qh78QJ7cm0efJV4b81dbLGIvSsAzD3lxuka7fbqGM=;
	b=hDPbKSMu3dP4ZUuxmVlqfkuO4hkH30yHdKhU00FFbrNp+rKsZ7wdIYvtfVp3yfkbGipVcR
	tg0Q/eZR3UJPrbKEb65ru/1f/UoAxk4r7g7Y8xFRr8/oofi2H+4Rk+rQkyHSvoHsis+yn2
	Hn3evPVjl6fJcnxkSrgLWsFOFUYN3h24dTT5VZJ48cx+kdu5oUZWHV+WhS4pJLm2q/RZAj
	ANaKdl3n2zZCWv7eoLIW7L3WCuNNwTylYSf5kvN71goCz//esaiM7o/StrWUl4887wWHfF
	9uoLVi/JION+rk/DB+1kr+lV5mYVTjBlhYPC0R39H2zBxNhpWzbBPRhiJZivcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+qh78QJ7cm0efJV4b81dbLGIvSsAzD3lxuka7fbqGM=;
	b=kG2dfeUt5IDCThjIXMzEHRrR2Ho3DDHjc9RBLQis4N8qZDuYkvk4ea9/wXakw9Bo8F6W3k
	xPBU5h7aFn1Ku4Aw==
From: "thermal-bot for Georgi Djakov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom-spmi-temp-alarm:
 Fix temp_map indexing
Cc: Georgi Djakov <djakov@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260928132823.1426513-1-djakov@kernel.org>
References: <20260928132823.1426513-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918647.2666337.12941098385745745487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     51c262cf2aa9dfd97591e570d4e82af493ad1689
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//51c262cf2aa9dfd97591e570d4e82af493ad1689
Author:        Georgi Djakov <djakov@kernel.org>
AuthorDate:    Mon, 28 Sep 2026 16:28:23 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:37 +02:00

thermal/drivers/qcom-spmi-temp-alarm: Fix temp_map indexing

Fix the following issue noticed when booting on the db845c-dragonboard:

BUG: KASAN: global-out-of-bounds in qpnp_tm_sync_thresholds+0x11c/0x180 [qcom=
_spmi_temp_alarm]
Read of size 24 at addr ffffdd2495f01200 by task (udev-worker)/371

CPU: 3 UID: 0 PID: 371 Comm: (udev-worker) Not tainted 7.3.0-rc3 #116 PREEMPT
Hardware name: Thundercomm Dragonboard 845c (DT)
Call trace:
 show_stack+0x18/0x24 (C)
 dump_stack_lvl+0xa4/0xf4
 print_report+0x1f4/0x5ac
 kasan_report+0x84/0xcc
 kasan_check_range+0xf0/0x1a4
 memcpy+0x3c/0xa4
 qpnp_tm_sync_thresholds+0x11c/0x180 [qcom_spmi_temp_alarm]
 qpnp_tm_probe+0x3dc/0xae8 [qcom_spmi_temp_alarm]
 platform_probe+0xc4/0x18c
 really_probe+0x17c/0x4fc
 ...

The buggy address belongs to the variable:
 temp_map_gen1+0x60/0xc4 [qcom_spmi_temp_alarm]

It looks like temp_map is a pointer to the complete temperature map.
Indexing it directly advances the entire map, rather than selecting a
threshold row.

Fix this by dereferencing the temp_map before indexing it to select the
requested threshold row.

Fixes: 703f13285a6c ("thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm da=
ta struct based on HW subtype")
Fixes: 1f835c6a4c84 ("thermal/drivers/qcom-spmi-temp-alarm: Prepare to suppor=
t additional Temp Alarm subtypes")
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260928132823.1426513-1-djakov@kernel.org
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qc=
om/qcom-spmi-temp-alarm.c
index fb003ca..911ebfd 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -345,8 +345,8 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_=
tm_chip *chip,
 	}
=20
 skip:
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
+	       sizeof(chip->temp_thresh_map));
 	reg |=3D threshold;
 	if (disable_stage2_shutdown && !chip->require_stage2_shutdown)
 		reg |=3D SHUTDOWN_CTRL1_OVERRIDE_STAGE2;
@@ -535,8 +535,8 @@ static int qpnp_tm_sync_thresholds(struct qpnp_tm_chip *c=
hip)
 		return ret;
=20
 	threshold =3D reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
-	memcpy(chip->temp_thresh_map, chip->data->temp_map[threshold],
-		sizeof(chip->temp_thresh_map));
+	memcpy(chip->temp_thresh_map, (*chip->data->temp_map)[threshold],
+	       sizeof(chip->temp_thresh_map));
=20
 	return ret;
 }
