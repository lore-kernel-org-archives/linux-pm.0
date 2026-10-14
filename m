Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76F48EBFE
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009190; cv=none; b=JGm6cxND0yRYL2HJpfROSriDmNt4tRG2srMJI1zKLnD7qLwuiL64c0AB+Ar0Rua8H4i5TBAFNqOq6e82OvpS23oIXdarKcFZWWzS8M+F/xaVTLmMd3k+FKeNl2vr70gOYnZQ8zb/Xy3jpXjlPjqquP73BAYMmTDBSBFqkDBHzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009190; c=relaxed/simple;
	bh=OpGrcsA/HsRUMRzEQYbHM06uUTR7QVz9RIxJ7yBpdaM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GaqB/Tk7bmZ6x3euRVDpbSTXaQlSdOg4BsJuqMOorUDHEI3+BrPbeXlp4+6Px/1/iFwkMcZI6pxd2gpBajxKXtkfQy/ATEJsE4mGGOaAkc68kFDplRrss5UlyOH4ypU5IE+x5VBTWkomESvMlC5QuFlcF8mrf5nL9UIqRPlj698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xBzrrxT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dqiXO5Aa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xBzrrxT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dqiXO5Aa"
Date: Wed, 14 Oct 2026 20:19:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzqI9u0xR4Uo91YL5bOH+9kF2FtrV8uzKy0StD1a2KI=;
	b=4xBzrrxT9QMN96mAVTWUCaS4I/egJMzafdFSFEAp7meTz3tRDxm5Wrd/8su+8d/lpfta+k
	LY05vh6tfC+J9MGBAhJfoLQ3Q1Ofm5OC8oepReJtrrRgRgPjzzrXY24x36ZygjV8a72+CT
	RHXOb6cbe+LFZ2JPaPf9p9c84MsWomtJP4z0h7rX87IerQzX5fQkpj7OrQ+LaZjI4w77o3
	F0m6TAD5mWUaJ0RZzXseCfT9Rb5X3h1LEvfQerqoLzj157qGXIANM8ErPj+4LBQ+IzLgeb
	663jwIn1UdXmOTubzvVp4dePtJz/c90fNdDICBerDwMU1VkQw1MavkEgY3Djug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzqI9u0xR4Uo91YL5bOH+9kF2FtrV8uzKy0StD1a2KI=;
	b=dqiXO5Aax+4oiXstm417L99+EfDF1Wn50uhBrDRegivo0Vqw/aDFR1NfCrAobihwdMAU5a
	NzVddZTa2ZwifyBQ==
From: "thermal-bot for Weigang He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/ti-soc-thermal: Cancel
 pending alert work on remove
Cc: Weigang He <geoffreyhe2@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Keerthy <j-keerthy@ti.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
References: <20260926124931.3599746-1-geoffreyhe2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918489.2666337.17645444922741409145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     aaa6c8dec49339710f9fd2a2af5646cf4111dbd4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//aaa6c8dec49339710f9fd2a2af5646cf4111dbd4
Author:        Weigang He <geoffreyhe2@gmail.com>
AuthorDate:    Sat, 26 Sep 2026 22:49:31 +10:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 13 Oct 2026 16:26:37 +02:00

thermal/drivers/ti-soc-thermal: Cancel pending alert work on remove

On a threshold crossing, the talert IRQ handler calls
ti_thermal_report_sensor_temperature(), which queues the work embedded
in the sensor's ti_thermal_data on the system workqueue. Nothing ever
cancels or flushes that work.

ti_bandgap_remove() frees the talert IRQ last. free_irq() waits for a
running handler, but not for the work the handler has queued. When
remove returns, devres unregisters and frees the thermal zones and then
frees the devm-allocated ti_thermal_data, so a work item that is still
pending runs ti_thermal_work() on freed memory:

	ti_thermal_work()
	  data =3D container_of(work, struct ti_thermal_data, thermal_wq);
	  thermal_zone_device_update(data->ti_thermal, ...);

Free the talert IRQ before removing the sensors, so that no new work
can be queued, and cancel the work in ti_thermal_remove_sensor().

This needs an OMAP4460/4470 or OMAP5 SoC (DRA7 has TALERT but no
->report_temperature, so it never queues the work), a threshold crossing
just before the driver is unbound or unloaded, and the work still
pending when devres frees the data.

Found by static analysis tool CodeQL.

Fixes: 445eaf871bf9 ("staging: omap-thermal: common code to expose driver to =
thermal framework")
Assisted-by: LLM codeql
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Acked-by: Keerthy <j-keerthy@ti.com>
Link: https://patch.msgid.link/20260926124931.3599746-1-geoffreyhe2@gmail.com
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 7 ++++---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti=
-soc-thermal/ti-bandgap.c
index ba43399..507fe67 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1077,6 +1077,10 @@ void ti_bandgap_remove(struct platform_device *pdev)
 	if (!soc_device_match(soc_no_cpu_notifier))
 		cpu_pm_unregister_notifier(&bgp->nb);
=20
+	/* Stop the alerts first: they queue work on the sensors' data */
+	if (TI_BANDGAP_HAS(bgp, TALERT))
+		free_irq(bgp->irq, bgp);
+
 	/* Remove sensor interfaces */
 	for (i =3D 0; i < bgp->conf->sensor_count; i++) {
 		if (bgp->conf->sensors[i].unregister_cooling)
@@ -1093,9 +1097,6 @@ void ti_bandgap_remove(struct platform_device *pdev)
 	clk_put(bgp->fclock);
 	clk_put(bgp->div_clk);
=20
-	if (TI_BANDGAP_HAS(bgp, TALERT))
-		free_irq(bgp->irq, bgp);
-
 	if (TI_BANDGAP_HAS(bgp, TSHUT))
 		free_irq(gpiod_to_irq(bgp->tshut_gpiod), NULL);
 }
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/the=
rmal/ti-soc-thermal/ti-thermal-common.c
index 0cf0826..4bf3b2e 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -195,6 +195,10 @@ int ti_thermal_remove_sensor(struct ti_bandgap *bgp, int=
 id)
=20
 	data =3D ti_bandgap_get_sensor_data(bgp, id);
=20
+	/* Work queued by the talert IRQ must not outlive the data */
+	if (!IS_ERR_OR_NULL(data))
+		cancel_work_sync(&data->thermal_wq);
+
 	if (!IS_ERR_OR_NULL(data) && data->ti_thermal) {
 		if (data->our_zone)
 			thermal_zone_device_unregister(data->ti_thermal);
