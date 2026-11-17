Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794887380;
	b=LnGMoDqP1VzDspVbuN/8cWd+nqsEh06+M6WlWRbRtkl0eGtBE+IeFbsO1TLBThzwDElE
	 i2qAbRTfBeemR1TwrsZvgaqMTLvcx7yCRSkDBbVJPcG9DME2TcXhKWFWhCnl6chGGqsEL
	 +pisKqkxuzQo3lhloldNsO/TlVvwM//F32LloyfWWeM/QZhF4b8iEdy7AnlQCfcdc8Rq7
	 qR7kNRDmSWgLVmBDTuLxKvaLLTCIJWJGuDoAs/edjRFOx3AkbIpCGtoP6uuwKveZWvGR9
	 5WcyN/bliuYwxMIj0x8RX6BYy0l5fp02UeZQ6AqUah36H3RGkEdyIGnBx2JNfc9D6ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794887380;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MN3C3MGCf8Imu8QLEA+7sVBZ3ldYiqOZRhR0QkEwU2Q=;
	b=qBj88mDS/o6MrpV29MCJXL6sPA2Zvjp6dad5d7QD0BjkMPWvn55AXfXoDp3A01oR+lXD
	 UFwFCyrm5sO2baomCwDLR3x1/2QGFdwFkwoFuiUfqA5/pFD8tAudQICiwlW+NIz0kQ0oT
	 gnDvWRuQOWofHJH+bXRWkoLDns80AyJVF6DGQxLrfpC46MiqFOybjCVQ8r1QdVC3e7LpA
	 x80Nt01+glnXou0Bw6ymlA2UpCdijtjXcjMkHtxx6luRoGBgjJgSBHl3o1JVq5CMwAQxp
	 hU7ofbvbXa6LLlm5AoFxE3R9fvoEkqVLJKjKChALvtmyY9TL0B1vX4MqNybm/GSvnvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItfBG9SK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB6606A31C;
	Tue, 17 Nov 2026 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItfBG9SK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794887379;
	b=qTocz3N1g+BGG3kKYWva9/onA7YmziyMiX7QTpRsj8wk8HVVBxgQgKFa0P09M9cbnYLc
	 brBD/jfThUl8B0uoDrAqO5/QLIGx4132HcBS8kqu+ZkhfHOO4b+gP2KIPptndJ8qGmA1C
	 h/jLcz8aMYU1tW/dneYyBQ9uYdWMWN181qlEjQ1My/rwuglHg6td5vdF7Q6/vw7fCREbO
	 o3UGy8mi74yh7kBQ/k7zWKWwQ5WP2ePIa5iLKqSazk/g0c3aWX+Zmza+o2TO5SCT3bA4S
	 0YedLphcvUBzAZRA8RlKpm7MEkyMDddhyW2L0rJFhELZ7qYzZn1veIzaoRNRMgsR/HQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794887379;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MN3C3MGCf8Imu8QLEA+7sVBZ3ldYiqOZRhR0QkEwU2Q=;
	b=PzzxxiBl9PU6QGgiQe5froXy6HIpiblNiij8hvtUF1rJL2jZv412qF6H9tlF47+88Quc
	 vv9qNsGSHvRNEwt1arsuxyA5ubj6DICM2vYATY7x3xfeI/gE2W4SXLyXvI2+80Rf6Dbfn
	 UaSZjzi0N6CsMv4K+rknmIxPjJp6N8TIEnS69zFT4m2oxnebxRc6knyP07JM2EM4T/rBd
	 Dy/cr4ikWbIfCw0H0VAQjReRO3TadY83/QYoPZec0GcmMdMs2eiujWclAMDiKHl2A26Bi
	 dikjh1p8qjyQTULQkadpwVHc7lvp4XSvdgL4srjJOq0ouMq7oAQol/8YEavOBRVjI3Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3F6031F000C4;
	Tue, 17 Nov 2026 03:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794887379;
	bh=MN3C3MGCf8Imu8QLEA+7sVBZ3ldYiqOZRhR0QkEwU2Q=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ItfBG9SKk8ZnV8XtlD3i6HWovB902rbC8pQ4bOG2hCV5GRxAP4BZ9/1Ptv+nUd6xy
	 Vtkao+8FWHP6wZ8W8XIEsSSJcxVD+kI7e24dvycOQgNJWxdBjpAP10SCk+YELVzmJ1
	 dsRmGG+FNfXaMGW1+S7ZptN8OXB81JeAfWIgs2p5uT/aFFeP1YkTkQrMINGeMpFchl
	 sbSm1qIRjebs9GvFaGE9HwORZmRAh2MyuOMbz9zvkOkblyVnu3S1s8JGxqAyCAqDOs
	 qtNc0NIyS/ADPfzakJFb0/AJoxiPeW0VkVUdUcN02ksTMoTNEyAeMJBlnrlkca9mmk
	 Vg5FuN51y8Xfg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9614E4A6AB;
	Tue, 17 Nov 2026 03:49:38 +0000 (UTC)
From: Ricky Sorrell via B4 Relay <devnull+rmsorrell.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 20:49:39 -0700
Subject: [PATCH] power: supply: surface_battery: Defer AC-triggered update
 across suspend
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-surface-battery-suspend-v1-1-71862c94435f@gmail.com>
X-B4-Tracking: v=1; b=H4sIANLO+2oC/yXMQQrCMBBG4auUWRtoChbxKuJikvzRcRHLTCqV0
 rs31eW3eG8lgwqMrt1Kio+YvEuDP3UUn1wecJKaaeiH0Xs/Ops1c4QLXCv022wTSnLhzCmEjEv
 PmVo9KbIsv/Pt/rfN4YVYjx1t2w5aWWcpewAAAA==
X-Change-ID: 20261116-surface-battery-suspend-b5adbbfe80af
To: Maximilian Luz <luzmaximilian@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricky Sorrell <rmsorrell@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794887378; l=3169;
 i=rmsorrell@gmail.com; s=20261117; h=from:subject:message-id;
 bh=Nm4oDrkT9c+zgZKLqwTPIM9uMxM/qKmEf83Eim2ZI+A=;
 b=Y/O3bQAP6wvKxqeZvxMj+O34ZAGKVr0Z9f4ZHmbJSD4q8f09awao2RXW0CsywUS10qWtfOPRh
 JXPLjkuhkpuA/ySi39H12X22FcsudwpHfdfxAS2dK2BdKJ3Ghv2iU29
X-Developer-Key: i=rmsorrell@gmail.com; a=ed25519;
 pk=iB5I4ZV9deYinB0dHWz2x12lFRsMIymvzUMBcvlbAKs=
X-Endpoint-Received: by B4 Relay for rmsorrell@gmail.com/20261117 with
 auth_id=1546
X-Original-From: Ricky Sorrell <rmsorrell@gmail.com>
Reply-To: rmsorrell@gmail.com
Content-Transfer-Encoding: 7bit

From: Ricky Sorrell <rmsorrell@gmail.com>

When the AC adapter is plugged in or removed, spwr_external_power_changed()
schedules a battery state update after five seconds, on system_wq. That
workqueue is not frozen for system suspend. If the system starts to
suspend within those five seconds, for example when the charger is
unplugged and the lid closed straight away, the work runs after the
Surface Aggregator controller has been suspended. The request then trips
the WARN_ON() in ssam_request_do_sync_with_buffer() and fails:

  WARNING: drivers/platform/surface/aggregator/controller.c:1703 at ssam_request_do_sync_with_buffer+0x15a/0x180 [surface_aggregator]
  Workqueue: events spwr_battery_update_bst_workfn [surface_battery]
  surface_battery 01:02:02:01:00: failed to update battery state: -19

Queue the work on system_freezable_wq instead. Freezable workqueues are
frozen before devices are suspended and thawed after they have resumed,
so a pending update now runs only once the controller is reachable again.
Nothing is lost by the delay: surface_battery_resume() already rechecks
the full battery state.

The problem was found, and this change written and tested, with the help
of an AI coding assistant (Claude Opus 5.5 in Claude Code). It was found
by reading the kernel log after suspend tests on a Surface Book 3, then
confirmed in the source. Reproduced and tested on a Surface Book 3 with
Linux 7.3.4: unplug the charger and close the lid within five seconds.
Before the change the warning above appeared; after it, the same test
gave no warning and correct battery state after resume.

Fixes: 167f77f7d0b3 ("power: supply: Add battery driver for Surface Aggregator Module")
Signed-off-by: Ricky Sorrell <rmsorrell@gmail.com>
---
Not done, so reviewers know: the change was built and tested against
Linux 7.3.4 only. Mainline's surface_battery.c differs from 7.3.4 only in
an unrelated devm_kzalloc_obj() line, and the patch applies to mainline,
but it was not built or run there.
---
 drivers/power/supply/surface_battery.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index dac19932c..a9b0cdfe3 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -417,9 +417,14 @@ static void spwr_external_power_changed(struct power_supply *psy)
 	 * event for the state (charging/discharging) change. Furthermore it
 	 * may take some time until the state is updated on the battery.
 	 * Schedule an update to solve this.
+	 *
+	 * Use the freezable workqueue so that the update does not run while
+	 * the system is suspending, when the EC can no longer be reached.
+	 * surface_battery_resume() rechecks the full state anyway.
 	 */
 
-	schedule_delayed_work(&bat->update_work, SPWR_AC_BAT_UPDATE_DELAY);
+	queue_delayed_work(system_freezable_wq, &bat->update_work,
+			   SPWR_AC_BAT_UPDATE_DELAY);
 }
 
 

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261116-surface-battery-suspend-b5adbbfe80af

Best regards,
--  
Ricky Sorrell <rmsorrell@gmail.com>


