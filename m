Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BAE3AFB14;
	Mon, 31 Aug 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149330; cv=none; b=t+99LxNqROQfiLYvjG1+URlzUkSHcBsBprX96Cl6wAEDgP7o5L7fj5Z6m9L4r8NkgeYQGOUqefYHwlZGuYL0mwcd/MDT7fj6SdVW/0t2EP2nA0FWUQpVgBj9ZcJSUbV83R8LdznQxVW4C3NLNhnn8gZtnsECchPHDmiDXRtT4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149330; c=relaxed/simple;
	bh=vZnl+SVwuYDa7p+OKu3BmFsZ3d9XjM1VhDHTaTiOnfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FunxiDhkXhNxtIz+zlG2HHSZYxZLMGn6qguqPIlZVvLX38f8ePp9+unshb9VsroITAkejkV5ACrsVeVJpASF5YR95+PDGC+2ZGhjG6a8OovZSNwvheAEgStyP3Vw9cpUB4VfZX58QfcWbh7wlB00AGgVljqKRxvN+2h+u8MM158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=PyO/VlkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hXQuQoOh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="PyO/VlkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hXQuQoOh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E92BB1D000E2;
	Mon, 31 Aug 2026 00:08:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 00:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788149327; x=
	1788235727; bh=mJzKMlAoFsqTCOtfDur8Zx+vsisRMUUea0lzAQccblM=; b=P
	yO/VlkCAWYltgm6jpgfbVYWlcIRf+VsCaFlRtSMG9ePiS8S3T8VtMooiM7ZvXUBE
	hbssO0iYzagvE+ImRJk8gWP10T/FE+FVvzME7DOKJL8xRdaEC3qmoi2wF0f+eZEY
	+c2V1PL1cKe0U/Ns+CprCB1q0oSuqB0B24MX3UwkL6g3xG0Gk3DGo7cjkM3cHnF1
	+ZdcK/IF6rWzdmwdMQBa+LON12qR1g/TlxGk0+moedksSiWAhGJ/hsLtOHzbdXG8
	CEtQ+DBKErVLCFNTE1vyje2kATzhU8emCDBhTppergJdtEmwNfZRNMbbp1UiQk+b
	5bz6A8fzT3g6pjCba7AgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788149327; x=1788235727; bh=m
	JzKMlAoFsqTCOtfDur8Zx+vsisRMUUea0lzAQccblM=; b=hXQuQoOhL0WDVb1NK
	UI3AyzXO21WfeAdTzC5qb3AWiO1ItmnZUziuibEBfuUsyK6Xj+YgfoRC2GD8/u45
	aU070xl4GyEyxUeA3sVI1CvIjuvh0Koop07zzlgGK7z1ouCS1x4Y0mrqatKAfC2s
	O0BxNzGeTMPbs7xH9rdR1weEu3A9F1icsB9cGopAT3lOG+hy0pXaRMl06aCVvDFq
	WCA6HaGG7DRMdievn4xoousiUy4p/bOhmECPntAHpiQtroY3/o20iUVPhpqWOJv7
	qPVeT9B4fsVcDUwKUXIuzRioL8FwI0Tt8TlnHHYgb+FMjNVcmSIXA0iVJ1cDfvhm
	W02IQ==
X-ME-Sender: <xms:T_6Uas1kPr545Wl2QmQH6ssrUianvd782O9cunlQKm4XrpxFWPMcFg>
    <xme:T_6Uam-Y_-Ie7nluJXJ0pzeIgImBVRmG_Bpo2oP7wCzlKNeWLiJ172G7ekziuDyGu
    w2zS1f35Z-s-JSx9V45yPS6fHh8YNAWb3_IACoUsIiFEEFgvdb6GCSt>
X-ME-Received: <xmr:T_6UaiOo82hpEr3kEGVM_8WNKSrlKq4CmeyWGzdpLaZdVUSHoQQlHy_2Okmvgm-Ia0t1-nIYdw>
X-ME-Proxy-Cause: dmFkZTFGCPamv6oRH3KhaKjOaG9C3GQzwemq2u6uZF5eAURY+Aiclj2PLp9zXqcRZfN4Qj
    yVrLJuJp7yNUfXYsB3o4kyoqmZa7oX6YNK+a7D9mNr2IV2R2Zxqed4htEnQDOkIeYjvE6X
    zULIkXWqs6onkG/L35H1DMrSL3Gvv88U209p5c1NEmXOsKJrHUoL0d61G5Gu+uKRVseYYi
    JE8g2myTTc7B5rtVovd/PA7H22b/mQbmp/tjcZbUC2MNfyFDzqFJmOynuTzkVEQPoH+k8h
    H/mNaxcP5Fgzpm4Ctdmz/l4yUtH11nWlOMDhOrZ8s108a+j2n7zWWB7mi3BDpIr/Rm0yST
    oM1a/ftRTPrqesTCqvuSQlwHwVVV2ui7AYEURluYedyyA/QfCbQH8UldSXNKKj4ilvusmp
    kVHVg/SdkgwKUBkmWQhpZTSSgDrA1927Anv5LzHiZlukGzFqzRFbF7e2OkO668eYxIJD6I
    u5Abb3YlVJbSAEz6U3Q8hvujc2Bemzdb5lYnCCim/WCn5wD2A5atf6mUq3gc6r4H7bZ0UI
    acDbxGXjKKjswkUsDj+y1JxqscUNnx78WE0c+re7wGWK52KmPjdLSV6ibrCMywdfcZ54hP
    3fJMeu/PmuxfJ45Ga7PhZa1HyR+dcDTnp3owxyuluSPMtJgjf3sDO6AdBi9g
X-ME-Proxy: <xmx:T_6UaiDAwtrfTHR_7vinB6IVdpVvLKcn2m7OfzH2Q55GXkLMZyL4RQ>
    <xmx:T_6UasNikDF99pVViO8THdH99TUFTcYfYKeD0kOZYjOcoL_8YQxdkA>
    <xmx:T_6UagaF00voEjyEPozF9QxWg0VkB2ethd1mXEw96q3w9rtbdIIJVQ>
    <xmx:T_6UajPDa0bRfQORBkWOOPmoCP7Us4P3OXQX0tfmcPB6GaeTWXCtwA>
    <xmx:T_6UagkdrRrUSY1NtxSbFtmYhxZHpdt4QxlFG2wmtE7cQ183Yct_WcMg>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:08:41 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v10 03/13] accel/rocket: let the core suspend after a reset
Date: Mon, 31 Aug 2026 16:07:54 +1200
Message-ID: <20260831040804.24111-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rocket_reset() drops the in-flight job's runtime PM reference with
pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
is left at usage_count 0 but still runtime-active with no idle request
pending, so it does not suspend until something else asks, and on a
platform whose power domain does work on power-on that work never happens.

On RK3576 that work is a bus interface reset the domain cycles when it
comes up. Without it the NPU's IOMMU stops answering, and the job after a
timeout returns a surface of the output zero point with rk_iommu reporting
that MMU_DTE_ADDR is not functioning.

Measured on a ROCK 4D in one boot, three runs, one variable between them.
With the bare put the core reads runtime-active with its rail still up
after the reset, the IOMMU reports the failure on the next attach and the
inference returns 0 of 128 channels. With the reference put back through
pm_runtime_put_autosuspend() the core reads suspended with the rail down,
there is no IOMMU message, and the same inference returns 128 of 128. A
third run repeating the first failed the same way.

It also matches the put in the completion path a few lines away, so the
reset path no longer leaves the device in a state the rest of the driver
never produces. The remaining put, on the error path in rocket_job_run(),
is a plain pm_runtime_put() and is left alone here: it unwinds a
get_sync() that never reached the hardware, and changing it belongs in
its own patch.

Igor Paunovic ran the differential on RK3588: 45 induced resets across
three cores, with and without the two preceding patches, and the domain
dropped every single time with no MMU message on either kernel. So this
is not rocket-wide. His conditions cross a healthy block with a lowered
timeout rather than a hung one, which he was careful to say his protocol
cannot settle, but it is what scopes the change to RK3576.

Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail.com/
Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 3c0ed4605..a89ab49e1 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	/*
 	 * No handler is running now, but we might still have stuck jobs. Let's
-	 * make sure the PM counters stay balanced by manually calling
-	 * pm_runtime_put_noidle().
+	 * make sure the PM counters stay balanced by putting the reference the
+	 * job took, and request idle while doing it so the core can suspend.
 	 */
 	scoped_guard(mutex, &core->job_lock) {
 		if (core->in_flight_job)
-			pm_runtime_put_noidle(core->dev);
+			pm_runtime_put_autosuspend(core->dev);
 
 		iommu_detach_group(NULL, core->iommu_group);
 
-- 
2.43.0

